package com.soeasy.controller.shopController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.ProductBean;
import com.soeasy.model.ShopBean;
import com.soeasy.service.mallService.ProductCategoryService;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.service.shopService.ShopService;
import com.soeasy.validator.mallValidator.ProductBeanValidator;
import com.soeasy.validator.mallValidator.ProductUpdateBeanValidator;

@Controller
@RequestMapping("/shop")
@SessionAttributes({ "shopSignInSuccess" })
public class ShopProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	ServletContext context;

	@Autowired
	private ProductCategoryService productCategoryService;

	@Autowired
	private ShopService shopService;

//	// 頁面跳轉
//	@RequestMapping("/shoplist")
//	public String viewshopPage(Model model) {
//
//		String keyword = null;
//		return ListByPage(model, 1, "productId", "asc", keyword);
//	}
//
//	// showProduct
//	@GetMapping("/shoplist/{pageNo}")
//	public String ListByPage(Model model, @PathVariable("pageNo") int currentPage, @Param("sortField") String sortField,
//			@Param("sortDir") String sortDir, @Param("keyword") String keyword) {
//
//		// 登入攔截
//		ShopBean shopBean = (ShopBean) model.getAttribute("shopSignInSuccess");
//		if (shopBean == null) {
//			return "redirect:/shopController/shopSignIn";
//		}
//		
//
//		Page<ProductBean> page = productService.findAllByPage(currentPage, sortField, sortDir, keyword);
//
//		System.out.println("印出來all products");
//		// 分頁參數
//		model.addAttribute("currentPage", currentPage);
//		model.addAttribute("totalPages", page.getTotalPages());
//		model.addAttribute("totalItems", page.getTotalElements());
//		// 羅列產品
//		
//		List<ProductBean> list = page.getContent();
//		
//		
//		model.addAttribute("product", list);
//		// 用各類別進去排序&
//		model.addAttribute("sortField", sortField);
//		model.addAttribute("sortDir", sortDir);
//		model.addAttribute("keyword", keyword);
//
//		String reverseSortDir = sortDir.equals("asc") ? "desc" : "asc";
//		model.addAttribute("reverSortDir", reverseSortDir);
//
//		return "/shop/shoplist";
//	}
	
	
	//建立跳轉 (消費者訂單)
		@GetMapping("/shoplist")
		public String history(ShopBean shopBean,Model model,HttpSession session) {
			
			//登入攔截
			shopBean = (ShopBean) model.getAttribute("shopSignInSuccess");
			if (shopBean == null) {
				return "redirect:/shopController/shopSignIn";
			}
			
			System.out.println("ID:"+shopService.findAllwithProduct(shopBean.getShopId()));
			model.addAttribute("product",shopService.findAllwithProduct(shopBean.getShopId()));
			return "/shop/shoplist";
			

		}
	
	
	
	
	
	

	// 使用ID查詢單一產品
	@GetMapping("/productdetail/{productId}")
	public String getOne(@PathVariable Integer productId, Model model) {
		ProductBean product = productService.findProductById(productId);
		model.addAttribute("product", product);
		System.out.println("印出來單一產品了");
		return "/shop/getOneProduct";

	}

	// 新增產品 使用product請求
	// 跳轉add提交頁 於新增時，送出空白的表單讓使用者輸入資料

	@GetMapping("/add")
	public String add(Model model) {
		ProductBean product = new ProductBean();
		product.setProductName("匈牙利紅椒烘烤雞腿");
		product.setProductDescription("農夫彼得X健康餐盒\r\n" + "外送-外帶-內用(皆須預訂)\r\n" + "  吃得少不如吃得好，起初清淡，\r\n" + "回歸清爽無負擔。\r\n"
				+ "細嚼慢品，菜根清香，肉味鮮甜。\r\n" + "食材鮮甜×簡單烹調×新鮮現做=營養滿分堅持新鮮現做，選購當季的食材，無隔夜菜，採預約制拒絕食材耗費。");
		product.setCategory(2);
		product.setProductAmount(7);
		product.setProductCalories("450/份");
		product.setProductPrice(120);
		product.setProductCost(90);

		// product.setProductDate(java.sql.Date.valueOf("2021-07-20"));
		model.addAttribute("product", product);

		return "/shop/addProduct";
	}

//	=========================

	// 當使用者填妥資料按下Submit按鈕後，本方法接收將瀏覽器送來的會員資料，新進行資料的檢查，
	// 若資料有誤，轉向寫入錯誤訊息的網頁，若資料無誤，則呼叫Service元件寫入資料庫
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	@PostMapping("/add")
	public String addProduct(@ModelAttribute("product") /* @Valid */ ProductBean product, BindingResult result,
			Model model, HttpServletRequest request, HttpSession session) {

		//model.addAttribute("categories", productCategoryService.findParentCategories());

		ProductBeanValidator validator = new ProductBeanValidator();
		// 呼叫Validate進行資料檢查
		validator.validate(product, result);
		if (result.hasErrors()) {
			return "/shop/addProduct";
		}

		// 取得addProduct.jsp所送來的圖片資訊
		MultipartFile picture = product.getProductMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (picture != null && !picture.isEmpty()) {
			try {
				byte[] b = picture.getBytes();
				Blob blob = new SerialBlob(b);
				product.setProductImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		// 儲存廠商ID
		ShopBean shopBean = (ShopBean) model.getAttribute("shopSignInSuccess");
		product.setShopBean(shopBean);

		// 自動帶入創建時間
		long miliseconds = System.currentTimeMillis();
		Date Date = new Date(miliseconds);
		product.setProductDate(Date);
		try {
			productService.save(product);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "/shop/shopaddProduct";
		}

		// 跳轉至查詢所有頁面
		return "redirect:/shop/shoplist";
	}

	// 讀圖轉成位元組陣列
	@RequestMapping(value = "/getImage/{productId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(HttpServletRequest resp, @PathVariable Integer productId) {
		String filePath = "/image/NoImage.jpg";
		byte[] media = null;
		String filename = "";
		int len = 0;
		ProductBean product = productService.findProductById(productId);
		if (product != null) {
			Blob blob = product.getProductImg();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("StudentController的getPicture()發生SQLException: " + e.getMessage());
				}
			} else {
				media = toByteArray(filePath);
				filename = filePath;
			}
		} else {
			media = toByteArray(filePath);
			filename = filePath;
		}
		ResponseEntity<byte[]> re = new ResponseEntity<>(media, HttpStatus.OK);

		return re;
	}

	// 方法toByteArray
	private byte[] toByteArray(String filePath) {
		byte[] b = null;
		String realPath = context.getRealPath(filePath);
		try {
			File file = new File(realPath);
			long size = file.length();
			b = new byte[(int) size];
			InputStream fis = context.getResourceAsStream(filePath);
			fis.read(b);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}

	// 刪除一筆紀錄
	// 送不出DELETE 先用product
	@GetMapping("/delete/{productId}")
	public String delete(@PathVariable("productId") Integer productId) {
		productService.deleteById(productId);
		System.out.println("刪除products");
		return "redirect:/shop/shoplist";
	}

	// 修改時，送回含有資料的表單，讓使用者進行修改
	// 由這個方法送回修改記錄的表單...
	@GetMapping("/update/{productId}")
	// 取得原始的productBean物件
	public String showDataForm(@PathVariable("productId") Integer productId, Model model) {
		ProductBean product = productService.findProductById(productId);
		model.addAttribute("product", product);

		return "shop/updateProduct";
	}

	@PostMapping("/update/{productId}")
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	public String modify(@ModelAttribute("product") ProductBean product, BindingResult result, Model model,
			@PathVariable Integer productId, HttpServletRequest request) {
		

		// 儲存廠商ID
		ShopBean shopBean = (ShopBean) model.getAttribute("shopSignInSuccess");
		product.setShopBean(shopBean);
		
		// 取得addProduct.jsp所送來的圖片資訊
				MultipartFile picture = product.getProductMultiImg();
				
				ProductBeanValidator validator = new ProductBeanValidator();
				// 呼叫Validate進行資料檢查
				validator.validate(product, result);
				if (result.hasErrors()) {
					return "shop/updateProduct";
				}

				// 建立Blob物件，交由 Hibernate 寫入資料庫
				if (picture != null && !picture.isEmpty()) {
					try {
						byte[] b = picture.getBytes();
						Blob blob = new SerialBlob(b);
						product.setProductImg(blob);
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
					}
				}
				
			productService.save(product);
		

		return "redirect:/shop/shoplist";
	}



}
