package com.soeasy.controller.adminController.adminManage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.NutritionistBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.ProductUpdateBean;
import com.soeasy.service.mallService.ProductCategoryService;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.validator.mallValidator.ProductBeanValidator;
import com.soeasy.validator.mallValidator.ProductUpdateBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminProduct {

	@Autowired
	private ProductService productService;

	@Autowired
	ServletContext context;

	@Autowired
	private ProductCategoryService productCategoryService;

	@Autowired
	ServletContext servletContext;

	// 頁面跳轉
	@RequestMapping("/adminProduct")
	public String viewPage(Model model) {
		String keyword = null;
		return ListByPage(model, 1, "productId", "asc", keyword, null);
	}

	// showProduct
	@GetMapping("/adminProduct/{pageNo}")
	public String ListByPage(Model model, @PathVariable("pageNo") int currentPage, @Param("sortField") String sortField,
			@Param("sortDir") String sortDir, @Param("keyword") String keyword, @Param("category") Integer category

	) {
		Page<ProductBean> page = productService.findAllByPage(currentPage, sortField, sortDir, keyword, category);

		System.out.println("印出來all products");
		// 分頁參數
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());
		// 羅列產品
		List<ProductBean> list = page.getContent();
		model.addAttribute("product", list);
		// 用各類別進去排序&
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("keyword", keyword);
		ProductBean product = new ProductBean();

		// 用來翻轉排序的參數
		String reverseSortDir = sortDir.equals("asc") ? "desc" : "asc";
		model.addAttribute("reverSortDir", reverseSortDir);

		return "admin/adminMall/adminProduct";
	}

	// 使用ID查詢單一產品
	@GetMapping("/adminProduct/search/{productId}")
	public String getOne(@PathVariable Integer productId, Model model) {
		ProductBean product = productService.findProductById(productId);
		model.addAttribute("product", product);
		System.out.println("印出來單一產品了");
		return "admin/adminMall/adminOneProduct";

	}

	// 新增產品 使用product請求
	// 跳轉add提交頁 於新增時，送出空白的表單讓使用者輸入資料

	@GetMapping("/add")
	public String add(Model model) {
		ProductBean product = new ProductBean();
		product.setProductName("經典烤嫩雞胸菲力");
		product.setProductDescription("農夫彼得X健康餐盒\r\n" + "外送-外帶-內用(皆須預訂)\r\n" + "  吃得少不如吃得好，起初清淡，\r\n" + "回歸清爽無負擔。\r\n"
				+ "細嚼慢品，菜根清香，肉味鮮甜。\r\n" + "食材鮮甜×簡單烹調×新鮮現做=營養滿分堅持新鮮現做，選購當季的食材，無隔夜菜，採預約制拒絕食材耗費。");
		product.setCategory(2);
		product.setProductAmount(120);
		product.setProductCalories("450/份");
		product.setProductPrice(120);
		product.setProductCost(90);

		model.addAttribute("product", product);

		return "admin/adminMall/adminAddProduct";
	}

//		==============================
//			=========================

	// 當使用者填妥資料按下Submit按鈕後，本方法接收將瀏覽器送來的會員資料，新進行資料的檢查，
	// 若資料有誤，轉向寫入錯誤訊息的網頁，若資料無誤，則呼叫Service元件寫入資料庫
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	@PostMapping("/add")
	public String addProduct(@ModelAttribute("product") /* @Valid */ ProductBean product, BindingResult result,
			Model model, HttpServletRequest request) {

		ProductBeanValidator validator = new ProductBeanValidator();
		// 呼叫Validate進行資料檢查
		validator.validate(product, result);
		if (result.hasErrors()) {
			return "mall/addProduct";
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
		// 自動帶入創建時間
		long miliseconds = System.currentTimeMillis();
		Date Date = new Date(miliseconds);
		product.setProductDate(Date);
		try {
			productService.save(product);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "admin/adminMall/adminProduct";
		}

		// 跳轉至查詢所有頁面
		return "redirect:/admin/adminManage/adminProduct";
	}

//		========================================================	

	// 以ID取得圖片
	@GetMapping("/getProductImage/{productId}")
	public ResponseEntity<byte[]> getShopImgById(@PathVariable("productId") Integer productId) {
		ProductBean originalproduct = productService.findProductById(productId);

		Blob productImg = originalproduct.getProductImg();

		InputStream is = null;
		String fileName = null;
		byte[] media = null;
		ResponseEntity<byte[]> responseEntity = null;

		try {
			if (productImg != null) {
				is = productImg.getBinaryStream();
			}
			// 如果圖片的來源有問題，就送回預設圖片
			if (is == null) {
				fileName = "default.png";
				is = servletContext.getResourceAsStream("/images/mall/" + fileName);
			}

			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			// 由InputStream讀取位元組，然後由OutputStream寫出
			int len = 0;
			byte[] bytes = new byte[8192];

			while ((len = is.read(bytes)) != -1) {
				baos.write(bytes, 0, len);
			}

			media = baos.toByteArray();
			responseEntity = new ResponseEntity<>(media, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (is != null)
					is.close();
			} catch (IOException e) {
				;
			}
		}
		return responseEntity;
	}

//			=========================================================

	// 刪除一筆紀錄
	// 送不出DELETE 先用product
	@PostMapping("/adminDelete/{productId}")
	public String delete(@PathVariable("productId") Integer productId) {
		productService.deleteById(productId);
		System.out.println("刪除products");
		return "redirect:/admin/adminManage/adminProduct";
	}

//			=========================================================
//			==================== 修改 =================================

	// 由這個方法送回修改記錄的表單...
	@GetMapping("/adminUpdate/{productId}")
	public String showDataForm(@PathVariable("productId") Integer productId, Model model) {
		ProductBean productBean = productService.findProductById(productId);
		ProductUpdateBean productUpdateBean = new ProductUpdateBean();

		productUpdateBean.setProductName(productBean.getProductName());
		productUpdateBean.setProductPrice(productBean.getProductPrice());
		productUpdateBean.setCategory(productBean.getCategory());
		productUpdateBean.setProductDate(productBean.getProductDate());
		productUpdateBean.setProductAmount(productBean.getProductAmount());
		productUpdateBean.setProductCalories(productBean.getProductCalories());
		productUpdateBean.setProductCost(productBean.getProductCost());
		productUpdateBean.setProductDescription(productBean.getProductDescription());
		productUpdateBean.setShopBean(productBean.getShopBean());
		productUpdateBean.setProductImg(productBean.getProductImg());

		model.addAttribute("product", productUpdateBean);
		
		
	return "admin/adminMall/adminUpdateProduct";

	}

	@PostMapping("/adminUpdate/{productId}")
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	public String modify(@ModelAttribute("product") ProductUpdateBean productupdateBean, BindingResult result, Model model,
			@PathVariable("productId") Integer productId, HttpServletRequest request) {
		
		// 取得原始的物件
		ProductBean originalBean = productService.findProductById(productId);
		
		// 取得adminPostUpdate.jsp所送來的圖片資訊
		MultipartFile productImg = productupdateBean.getProductMultiImg();
		
		ProductUpdateBeanValidator validator = new ProductUpdateBeanValidator();
		// 呼叫Validate進行資料檢查
		validator.validate(productupdateBean, result);
		if (result.hasErrors()) {
			return "admin/adminMall/adminUpdateProduct";
		}
		
		
				// 將postUpdateBean的資料修改進postOrginalBean

				// 圖片傳入資料庫
				// 建立Blob物件，交由 Hibernate 寫入資料庫
				if (productImg != null && !productImg.isEmpty()) {
					try {
						byte[] b = productImg.getBytes();
						Blob blob = new SerialBlob(b);
						originalBean.setProductImg(blob);
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
					}
				} else {
					originalBean.setProductImg(originalBean.getProductImg());
				}

		//為原始物件設定傳入的欄位值
				originalBean.setProductName(productupdateBean.getProductName());
				originalBean.setCategory(productupdateBean.getCategory());
				originalBean.setProductPrice(productupdateBean.getProductPrice());
				originalBean.setProductAmount(productupdateBean.getProductAmount());
				originalBean.setProductDate(productupdateBean.getProductDate());
				originalBean.setProductCalories(productupdateBean.getProductCalories());
				originalBean.setProductCost(productupdateBean.getProductCost());
				originalBean.setProductDescription(productupdateBean.getProductDescription());
				originalBean.setShopBean(productupdateBean.getShopBean());
				
		
		try {
			productService.save(originalBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "mall/addProduct";
		}

		productService.save(originalBean);
		return "redirect:/admin/adminManage/adminProduct";
	}

//			=========================================================
	//========================上傳圖片(沒用到)=========================================================

	
		@GetMapping(value = "/UploadProductImg/{productId}")
		public String getOneNutritionistById(@PathVariable("productId") Integer productId, Model model) {
			model.addAttribute("product", productService.findProductById(productId).getProductImg());
			return "/admin/adminMall/addPic"; 

		}
	
	@PostMapping(value = "/UploadProductImg")
	@ResponseBody
	public String modifyPic(ProductBean product,
			@RequestParam("productId") Integer productId,
			@RequestParam(value="file",required=false) MultipartFile picture,
			HttpServletRequest request)throws Exception{
		//		public String modifyPic(@ModelAttribute("product") ProductBean product, 
//				BindingResult result,
//				Model model,
//				@PathVariable Integer productId,
//				HttpServletRequest request) {
		
		ProductBean productBean = productService.findProductById(productId);

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
				productService.save(productBean);
				

		return "redirect:/admin/adminManage/adminProduct";
	
	}
	//========================(E)上傳圖片(沒用到)=========================================================


}
