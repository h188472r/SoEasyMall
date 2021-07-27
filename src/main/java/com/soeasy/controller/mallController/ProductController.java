package com.soeasy.controller.mallController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.Order.OrderDetailBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.mallService.ProductCategoryService;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.service.shopService.ShopService;
import com.soeasy.validator.mallValidator.ProductBeanValidator;

@Controller
@RequestMapping("/mall")
@SessionAttributes("customerSignInSuccess")

public class ProductController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	ServletContext context;
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@Autowired
	FavoriteService favoriteService;
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	ShopService shopService;
	
	
//	
//	//商城頁面跳轉
		@RequestMapping("/mallIndex")
		public String viewPage1(Model model){
			
			//印出最新上架的產品
		    List<ProductBean> newlist = productService.findNewProduct3();
		    model.addAttribute("newlist", newlist);
			System.out.println("最新的產品:"+newlist);
			return "mall/mallIndex";
			
			
		}
		
		//商城頁面跳轉
		@RequestMapping("/lists")
		public String viewPage(Model model){
			String keyword = null;
			return ListByPage(model,1,"productId","desc",keyword,null);
		}


	//showProduct
	@GetMapping("/lists/{pageNo}")
	public String ListByPage(Model model,
	        @PathVariable("pageNo") int currentPage,
	        @Param("sortField")String sortField,
	        @Param("sortDir")String sortDir,
	        @Param("keyword")String keyword,
	        @Param("category")Integer category
	        
	        )
			{

			Page<ProductBean> page = productService.findAllByPage(currentPage,sortField,sortDir,keyword,category);
			    
			
			    System.out.println("印出來all products");
			    //分頁參數
			    model.addAttribute("currentPage", currentPage);
			    model.addAttribute("totalPages", page.getTotalPages());
			    model.addAttribute("totalItems", page.getTotalElements());
			    
			    
			    
			   //羅列產品
			    List<ProductBean> list = page.getContent();
			    model.addAttribute("product", list);
			    //用各類別進去排序&
			    model.addAttribute("sortField", sortField);
			    model.addAttribute("sortDir", sortDir);
			    model.addAttribute("keyword",keyword);
			    model.addAttribute("category",category);
			    
			    
			    //印出最新上架的產品
			    List<ProductBean> list5 = productService.findNewProduct();
			    model.addAttribute("productTop3", list5);
			    
			    
			    
			    
			    			    
//			    
//				String favoriteProduct = "product";
//				for (ProductBean product : list) {
//					Integer productId = product.getProductId();
//					System.err.println("productId=" + productId);
//				
//			  //1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false 
//			    if (customerSignInSuccess != null) {
//			    	
//			    	CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
//			     	FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(productId, favoriteProduct, originalCustomer);
//			     	
//			     	System.out.println("originalCustomer="+originalCustomer);
//			     	System.out.println("productId="+productId);
//			     	System.out.println("favoriteProduct="+favoriteProduct);     	
//			     	
//			    		//2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
//			    		if(checkFavoriteBean != null) {
//			    			//3.存在FavoriteStatus=True;不存在FavoriteStatus=False
//			    			//4.將FavoriteStatus狀態存進model.addAttribute
//			    			product.setFavoriteStatus(true);
//			    			}
////			    			sportMapBean.setFavoriteStatus(false);
//			    				
//			    }
//				}
//			    
			    String reverseSortDir =sortDir.equals("asc") ? "desc":"asc";
			    model.addAttribute("reverSortDir", reverseSortDir);
			     
			    return "mall/mallDetail";
			}
	
	

		
	
	//========================使用ID查詢單一產品(進入商品詳情)====================================
	@GetMapping("/lists/product/{productId}")
	 public String getOne(@PathVariable Integer productId,Model model) {
		
	      	ProductBean product = productService.findProductById(productId);
	      	model.addAttribute("product", product);
	      
	    	//存取登入訊息
			CustomerBean customerSignInSuccess = (CustomerBean) model.getAttribute("customerSignInSuccess");
			String favoriteProduct = "productFavorite";

		  //1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false 
		    if (customerSignInSuccess != null) {
		    	
		    	CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
		     	FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(productId, favoriteProduct, originalCustomer);
		     	
		     	System.out.println("originalCustomer="+originalCustomer);
		     	System.out.println("productId="+productId);
		     	System.out.println("favoriteProduct="+favoriteProduct);     	
		     	
		    		//2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
		    		if(checkFavoriteBean != null) {
		    			//3.存在FavoriteStatus=True;不存在FavoriteStatus=False
		    			//4.將FavoriteStatus狀態存進model.addAttribute
		    			product.setFavoriteStatus(true);
				     	System.out.println("查詢出愛心是有的");     	

		    			}
//		    			sportMapBean.setFavoriteStatus(false);
		    				
		    }
		    
		    //印出最新售出的產品
		
		    List<OrderDetailBean> list5 = productService.findNewestProduct();
		    model.addAttribute("productTop3", list5);
		    
		    //印出相關類別的產品
		    List<ProductBean> sameCategory= productService.findByRelatedCategory(product.getCategory());
		    model.addAttribute("sameCategory", sameCategory);
		    
		    //印出相關店家的產品
		    List<ProductBean> sameShop= shopService.findByRelatedShop(product.getShopBean().getShopId());
		    model.addAttribute("sameShop", sameShop);
		    
		    
	      
	      
	        	System.out.println("印出來單一產品了");
	            return "mall/mallGoodsDetail";
	       
	    }
	
	
	//========================(End)使用ID查詢單一產品====================================

	
	
//	==============Add============================

	
	//新增產品 使用product請求
	//跳轉add提交頁  於新增時，送出空白的表單讓使用者輸入資料

	@GetMapping("/add")
	public String add(Model model) {
		ProductBean product = new ProductBean();
		product.setProductName("經典烤嫩雞胸菲力");
		product.setProductDescription("農夫彼得X健康餐盒\r\n"
				+ "外送-外帶-內用(皆須預訂)\r\n"
				+ "  吃得少不如吃得好，起初清淡，\r\n"
				+ "回歸清爽無負擔。\r\n"
				+ "細嚼慢品，菜根清香，肉味鮮甜。\r\n"
				+ "食材鮮甜×簡單烹調×新鮮現做=營養滿分堅持新鮮現做，選購當季的食材，無隔夜菜，採預約制拒絕食材耗費。");
		product.setCategory(2);
		product.setProductAmount(120);
		product.setProductCalories("450");
		product.setProductPrice(120);
		product.setProductCost(90);
		//product.setProductDate(java.sql.Date.valueOf("2021-07-20"));
		model.addAttribute("product", product);

		return "mall/addProduct";
	}
	
	
	// 當使用者填妥資料按下Submit按鈕後，本方法接收將瀏覽器送來的會員資料，新進行資料的檢查，
	// 若資料有誤，轉向寫入錯誤訊息的網頁，若資料無誤，則呼叫Service元件寫入資料庫
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	@PostMapping("/add")
		public String addProduct(
				@ModelAttribute("product") /* @Valid */ ProductBean product,
				BindingResult result, Model model,HttpServletRequest request) {
		

		model.addAttribute("categories", productCategoryService.findParentCategories());
			
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
				return "mall/addProduct";
		}

			
		// 跳轉至查詢所有頁面
		return "redirect:/mall/lists";
		}
	
	
	//==============(E)Add==========================================
	
	//==============讀取圖片==========================================

	
	// 讀圖轉成位元組陣列
		@RequestMapping(value = "/getImage/{productId}", method = RequestMethod.GET)
		public ResponseEntity<byte[]> getImage(HttpServletRequest resp,@PathVariable Integer productId ){
			String filePath="/image/NoImage.jpg";
			byte[] media = null;
			String filename = "";
			int len = 0;
			ProductBean product = productService.findProductById(productId);
			if(product !=null) {
				Blob blob=product.getProductImg();
				if(blob!=null) {
					try {
						len=(int)blob.length();
						media = blob.getBytes(1, len);
					}catch(SQLException e) {
						throw new RuntimeException("StudentController的getPicture()發生SQLException: " + e.getMessage());
					}
				}else {
					media = toByteArray(filePath);
					filename = filePath;
				}
			}else {
				media = toByteArray(filePath);
				filename = filePath;
			}
			ResponseEntity<byte[]> re= new ResponseEntity<>(media, HttpStatus.OK);
			
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
		
		
//=============(E)=讀取圖片==========================================

		
// ==================DELETE==============================================

		
		
	// 刪除一筆紀錄
	//送不出DELETE 先用product
		@GetMapping("/delete/{productId}")
		public String delete(@PathVariable("productId") Integer productId) {
	        productService.deleteById(productId);
        	System.out.println("刪除products");
			return "redirect:/mall/lists"; 
		}
		
		
// =================(E)DELETE===============================================
		
		
		

// ==================UPDATE===============================================
		
	// 修改時，送回含有會員資料的表單，讓使用者進行修改
	// 由這個方法送回修改記錄的表單...
		@GetMapping("/update/{productId}")
		// 取得原始的productBean物件
		public String showDataForm(@PathVariable("productId") Integer productId, Model model) {
			ProductBean product = productService.findProductById(productId);
			
      		model.addAttribute("product", product);

			return "mall/updateProduct";
		}
		
		
		@PostMapping("/update/{productId}")
		// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
		public String modify(
				@ModelAttribute("product") ProductBean product, 
				BindingResult result, 
				Model model,
				@PathVariable Integer productId, 
				HttpServletRequest request) {
			
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
				try {
					productService.save(product);
				} catch (org.hibernate.exception.ConstraintViolationException e) {
					return "mall/addProduct";
			}

		
			return "redirect:/mall/lists";
		}
		
		
		// ==================(E)UPDATE===============================================

		
	

	

}
