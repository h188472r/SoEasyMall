package com.soeasy.controller.nutritionistController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.CartItem;
import com.soeasy.model.CustomerBean;
import com.soeasy.model.NutritionistBean;
import com.soeasy.model.NutritionistCategoryBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ProductBean;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.service.nutritionistService.NutritionistCategoryService;
import com.soeasy.service.nutritionistService.NutritionistService;
import com.soeasy.validator.nutritionistValidator.NutritionistValidator;

@Controller
@RequestMapping("/nutritionistController")
@SessionAttributes("customerSignInSuccess")
public class NutritionistIdController {

	@Autowired
	NutritionistService nutritionistService;
	
	@Autowired
	ProductService productService; 

	@Autowired
	NutritionistCategoryService nutritionistCategoryService;
	
	@Autowired
	ServletContext context;
	
	// 查詢全部營養師
	@GetMapping("/getAllNutritionists")
	public String DisplayNutritionist(Model model) {
		model.addAttribute("nutritionists", nutritionistService.findAllByNutritionistId());
		return "/nutritionist/getAllNutritionists";
	}

	// 查詢單營養師
	@GetMapping(value = "/nutritionist/{nutritionistId}")
	public String getOneNutritionistById(@PathVariable("nutritionistId") Integer nutritionistId, Model model) {
		NutritionistBean nutritionistBean = nutritionistService.findByNutritionistId(nutritionistId);
		Random r = new Random();  //隨機宣告
		
		List<ProductBean> chickenList=productService.findNutritionistByRelatedCategory(2); //撈出商品種類2雞肉
		List<ProductBean> beefList=productService.findNutritionistByRelatedCategory(3);    //撈出商品種類3牛肉
		chickenList.addAll(beefList);                                          //兩種類相加 
		ProductBean productBean1= chickenList.get(r.nextInt(chickenList.size())); //隨機從兩種類抓一筆
		
		List<ProductBean> porkList=productService.findNutritionistByRelatedCategory(4);
		List<ProductBean> FishList=productService.findNutritionistByRelatedCategory(5);
		porkList.addAll(FishList);
		ProductBean productBean2=porkList.get(r.nextInt(porkList.size()));
		
		List<ProductBean> fruitList=productService.findNutritionistByRelatedCategory(1);
		ProductBean productBean3 = fruitList.get(r.nextInt(fruitList.size()));
		
		List<ProductBean> drinklist=productService.findNutritionistByRelatedCategory(7);
		ProductBean productBean4 = drinklist.get(r.nextInt(drinklist.size()));
		 
		model.addAttribute("nutritionistBean", nutritionistBean);
		model.addAttribute("productBean1", productBean1);
		model.addAttribute("productBean2", productBean2);
		model.addAttribute("productBean3", productBean3);
		model.addAttribute("productBean4", productBean4);
		return "/nutritionist/nutritionistIndex";
	}

	// 新增營養師，先送一個空白表單，並給予初值
	@GetMapping(value = "/addNutritionist")
	public String emptyNutritionist(Model model) {
		NutritionistBean nutritionistBean = new NutritionistBean();
		// 預設表單資料
		nutritionistBean.setNutritionistName("五公斤肥貓");
		nutritionistBean.setNutritionistGender("M");
		nutritionistBean.setNutritionistDegree("肥貓醫學大學保健營養學系");
		nutritionistBean.setNutritionistEmail("fatcat05@gmail.com");
		model.addAttribute("nutritionistBean", nutritionistBean);

		return "/nutritionist/addNutritionists";
	}

	// 新增營養師
	@PostMapping(value = "/addNutritionist")
	public String addNutritionist(@ModelAttribute("nutritionistBean") NutritionistBean nutritionistBean,
			BindingResult result, Model model, HttpServletRequest request) {

		// 檢測不正當欄位並回傳提示訊息
		NutritionistValidator validator = new NutritionistValidator();
		validator.validate(nutritionistBean, result);
		if (result.hasErrors()) {
			return "/nutritionist/addNutritionists";
		}

		// 取得addnutritionist.jsp所送來的圖片資訊
		MultipartFile nutritionistImg = nutritionistBean.getNutritionistMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (nutritionistImg != null && !nutritionistImg.isEmpty()) {
			try {
				byte[] b = nutritionistImg.getBytes();
				Blob blob = new SerialBlob(b);
				nutritionistBean.setNutritionistImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		// 營養師創建時間
		long miliseconds = System.currentTimeMillis();
		Date Date = new Date(miliseconds);
		nutritionistBean.setNutritionistDate(Date);
		
		NutritionistCategoryBean nutritionistCategoryBean = nutritionistCategoryService.
				getNutritionistCategory(nutritionistBean.getNutritionistCategoryBean().getNutritionistCategoryId());
		nutritionistBean.setNutritionistCategoryBean(nutritionistCategoryBean);	
		nutritionistBean.setNutritionistCategory(nutritionistCategoryBean.getNutritionistCategoryName());
		
		try {
			nutritionistService.addNutritionist(nutritionistBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "nutritionist/addNutritionists";

		}

		return "redirect:/nutritionistController/getAllNutritionists";
	}
	
	// 讀圖轉成位元組陣列
	@RequestMapping(value = "/getImage/{nutritionistId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(HttpServletRequest resp,@PathVariable Integer nutritionistId ){
		String filePath="/image/NoImage.jpg";
		byte[] media = null;
		String filename = "";
		int len = 0;
		NutritionistBean nutritionistBean = nutritionistService.findByNutritionistId(nutritionistId);
		if(nutritionistBean !=null) {
			Blob blob=nutritionistBean.getNutritionistImage();
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

	// 產生下拉式選單
	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "男性");
		genderMap.put("F", "女性");
		model.addAttribute("genderMap", genderMap);

		List<NutritionistCategoryBean> nutritionistCategoryList = nutritionistCategoryService
				.getAllNutritionistCategorys();
		model.addAttribute("nutritionistCategoryList", nutritionistCategoryList);
	}
	
	// 查詢全部營養師(分頁)
	@GetMapping(value="/getAllNutritionist.json",produces = { "application/json; charset=UTF-8" })
	public ResponseEntity<Map<String, Object>> getPageNutritionist(
			@RequestParam(value = "pageNo", required = false, defaultValue = "1")Integer pageNo,
			@RequestParam(value = "totalPage", required = false)Integer totalPage){
		
		if (pageNo == null) {
			pageNo = 1; // 網址加?pageNo=測試
		}
		
		if (totalPage == null) {
			totalPage = nutritionistService.getTotalPages();
		}
		
		Map<String, Object> genderMap=new HashMap<>();
		List<NutritionistBean> listTarget= nutritionistService.getAllPageNutritionist(pageNo);

		genderMap.put("currPage", String.valueOf(pageNo));
		genderMap.put("totalPage", totalPage);
		genderMap.put("nutritionistPage", nutritionistService.getAllPageNutritionist(pageNo));
		
		ResponseEntity<Map<String, Object>> re =new ResponseEntity<>(genderMap, HttpStatus.OK);
		System.out.println("re="+re);
		return re;
	}
	
	
//	===========================新增購物車內的項目==========================================	
	@GetMapping("/buy/{productId}")
	public String buy(@PathVariable("productId") Integer productId, 
			HttpSession session,Model model,HttpServletRequest request) {

		// 登入攔截
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		if (customerBean == null) {
			return "redirect:/customerController/customerSignIn";
		}
		
		
	
		//  如果購物車是空的
		if (session.getAttribute("cart")==null) {
			List<CartItem> cart = new ArrayList<CartItem>();
			cart.add(new CartItem(productService.findProductById(productId),1));
			session.setAttribute("cart", cart);
			}else {	
				List<CartItem>cart=(List<CartItem>)session.getAttribute("cart");
				int index = exists(productId,cart);
				if(index==-1) {
					//購物車可以可以再+1
					cart.add(new CartItem(productService.findProductById(productId),1));
				}else {
					int newQuantity=cart.get(index).getCartQuantity()+1;
					cart.get(index).setCartQuantity(newQuantity);
					
				}
		}
		String referer = request.getHeader("Referer"); 
		return "redirect:"+ referer;
		
	}
//	===========================(End)新增購物車內的項目==========================================	
	private int exists(Integer productId,List<CartItem>cart) {
		for(int i=0;i<cart.size();i++) {
			if(cart.get(i).getProduct().getProductId()==productId) {
				return i ;
			}
		}
		return -1;
	}
	
}
