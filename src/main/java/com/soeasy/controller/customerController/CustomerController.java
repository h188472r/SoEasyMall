package com.soeasy.controller.customerController;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.CustomerHealthBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.SportMapBean;
import com.soeasy.model.member.CustomerSignInBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.service.postService.PostService;
import com.soeasy.service.sportmapService.SportMapService;
import com.soeasy.util.GlobalService;
import com.soeasy.validator.customerValidator.CustomerBeanValidator;

@Controller
@RequestMapping("/customerController")
@SessionAttributes("customerSignInSuccess")
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	ServletContext servletContext;
		
	@Autowired
	FavoriteService favoriteService;
	
	@Autowired
	SportMapService sportMapService;
	
	@Autowired
	PostService postService;
	
	@Autowired
	ProductService productService;

	//表單初值--新增會員_會員登入--註冊
	@GetMapping("/addCustomer")
	public String addCustomerSendForm(Model model) {
		CustomerBean customerBean = new CustomerBean();
		CustomerSignInBean customerSignInBean = new CustomerSignInBean();
		String signMode = "sign_up";
		
		customerBean.setCustomerName("方唐鏡");
		customerBean.setCustomerEmail("fangTC2021@gmail.com");
		customerBean.setCustomerPassword("ab1234");
		customerBean.setCustomerCheckPassword("ab1234");
		
		customerSignInBean.setCustomerSignInEmail("fangTC2021@gmail.com");
		customerSignInBean.setCustomerSignInPassword("ab1234");
		
		model.addAttribute("customerBean", customerBean);
		model.addAttribute("customerSignInBean", customerSignInBean);
		model.addAttribute("signMode", signMode);
		return "customer/customerSignInUp";
	}
	
	//送出表單--新增顧客會員
	@PostMapping("/addCustomer")
	public String addCustomerProcess(
				@ModelAttribute("customerBean")
				CustomerBean customerBean,
				BindingResult result, Model model,
				HttpServletRequest request
			) {
		//檢測不正當欄位並回傳提示訊息
		CustomerBeanValidator validator = new CustomerBeanValidator();
		validator.validate(customerBean, result);
		if (result.hasErrors()) {
			//重新設定表單
			model = resetSendForm(model);
			return "customer/customerSignInUp";
		}
		
		//設定初始值
		//關聯新的健康資訊
		customerBean.setCustomerHealthBean(new CustomerHealthBean());
		//關聯新的購物車
		//customerBean.setShoppingcartBean(new ShoppingcartBean());
		//初始積分為0
		customerBean.setCustomerScore(0);
		//帳號狀態:正常
		customerBean.setCustomerStatus(GlobalService.CUSTOMER_STATUS_NORMAL);
		//帳號創建時間
		Timestamp registerTime = new Timestamp(System.currentTimeMillis());
		customerBean.setCustomerRegisterTime(registerTime);
		
		// 檢查 customerEmail是否重複
		if (customerService.emailExists(customerBean.getCustomerEmail())) {
			//重新設定表單
			model = resetSendForm(model);
			result.rejectValue("customerEmail", "", "帳號已存在，請重新輸入");
			return "customer/customerSignInUp";
		}
				
		try {
			customerService.addCustomer(customerBean);
		} catch (Exception e) {
			System.out.println(e.getClass().getName() + ", ex.getMessage()=" + e.getMessage());
			result.rejectValue("customerName", "", "發生異常，請通知系統人員..." + e.getMessage());
			return "customer/customerSignInUp";
		}
		
		return "redirect:/";
	}
	
	public Model resetSendForm(Model model) {
		//重新設定隔壁表單的初值
		CustomerSignInBean customerSignInBean = new CustomerSignInBean();
		//鎖定頁面為註冊模式
		String signMode = "sign_up";
		model.addAttribute("customerSignInBean", customerSignInBean);
		model.addAttribute("signMode", signMode);
		
		return model;
	}
	
	//個人頁面
	@GetMapping("/customerPage")
	public String customerPage(Model model) {
		CustomerBean customerSignInSuccess = (CustomerBean)model.getAttribute("customerSignInSuccess");
		CustomerBean originCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
		//------------------------------------------------------------------------
		//記錄map類型的ItemId
		List<Integer> mapItemIds = new ArrayList<>();
		for (FavoriteBean favoriteBean : originCustomer.getFavoriteBeans()) {
			if(favoriteBean.getFavoriteCategory().equals("sportMap")) {
				mapItemIds.add(favoriteBean.getFavoriteItemId());
			}
		}
		//以mapItemIds查詢sportMap
		List<SportMapBean> sportMaps = sportMapService.findAllById(mapItemIds);
		//------------------------------------------------------------------------
		//記錄post類型的ItemId
		List<Integer> postItemIds = new ArrayList<>();
		for(FavoriteBean favoriteBean : originCustomer.getFavoriteBeans()) {
			if(favoriteBean.getFavoriteCategory().equals("post")) {
				postItemIds.add(favoriteBean.getFavoriteItemId());
			}
		}
		//以mapItemIds查詢sportMap
		List<PostBean> posts = postService.findAllById(postItemIds);
		//------------------------------------------------------------------------
		//記錄product類型的ItemId
		List<Integer> productItemIds = new ArrayList<>();
		for(FavoriteBean favoriteBean : originCustomer.getFavoriteBeans()) {
			if(favoriteBean.getFavoriteCategory().equals("productFavorite")) {
				productItemIds.add(favoriteBean.getFavoriteItemId());
			}
		}
		//以mapItemIds查詢sportMap
		List<ProductBean> products = productService.findAllById(productItemIds);
		
		model.addAttribute("sportMaps", sportMaps);
		model.addAttribute("posts", posts);
		model.addAttribute("products", products);
		return "/customer/customerPage";
	}
	
	//修改個人基本資料
	@PostMapping(value = "/updateCustomerInfo", produces = { "application/json; charset=UTF-8" })
	
	public @ResponseBody Map<String, String> updateCustomerInfo(@RequestBody CustomerBean customerBean, Model model){
		//以傳入的ID搜尋原始的會員物件
		CustomerBean originalBean = customerService.findByCustomerId(customerBean.getCustomerId());
		
		//更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();
		
		if(customerBean.getCustomerName() == null) {
			updateMessage.put("updateMessage", "名字不得為空");
		}
		
		
		//為原始物件設定傳入的欄位值
		originalBean.setCustomerName(customerBean.getCustomerName());
		originalBean.setCustomerNickname(customerBean.getCustomerNickname());
		originalBean.setCustomerPhone(customerBean.getCustomerPhone());
		originalBean.setCustomerBirthDay(customerBean.getCustomerBirthDay());
		
		//save原始物件
		customerService.updateCustomer(originalBean);
		
		//將更新資料設定給session
		model.addAttribute("customerSignInSuccess", originalBean);
		
		//更新成功訊息
		updateMessage.put("updateMessage", "更新成功");
		
		return updateMessage;
	}
	
		//修改個人健康資料
		@PostMapping(value = "/updateCustomerHealthInfo", produces = { "application/json; charset=UTF-8" })
		
		public @ResponseBody Map<String, String> updateCustomerHealthInfo(@RequestBody CustomerBean customerBean, Model model){
			//以傳入的ID搜尋原始的會員物件
			CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
			CustomerHealthBean updateCustomerHealthBean = customerBean.getCustomerHealthBean();
			//更新檢查訊息
			Map<String, String> updateHealthMessage = new HashMap<String, String>();
			
			
			
			//為原始物件設定傳入的欄位值
			originalCustomer.setCustomerHealthBean(updateCustomerHealthBean);
			
//			System.out.println(updateCustomerHealthBean.getCustomerGender());
//			System.out.println(updateCustomerHealthBean.getCustomerDiet());
//			System.out.println(updateCustomerHealthBean.getCustomerExerciseHabits());
			//save原始物件
			customerService.updateCustomer(originalCustomer);
			
			//將更新資料設定給session
			model.addAttribute("customerSignInSuccess", originalCustomer);
			
			//更新成功訊息
			updateHealthMessage.put("updateHealthMessage", "更新成功");
			
			return updateHealthMessage;
		}
		
		//上傳個人頭像
		@PostMapping("/uploadCustomerImg")
		public String uploadCustomerImg(@RequestParam("customerImgUpload")MultipartFile customerMultiImg, Model model) {
			
			CustomerBean customerSignInSuccess = (CustomerBean)model.getAttribute("customerSignInSuccess");
			CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
			
			//處理圖片MultipartFile --> Blob
			if(customerMultiImg != null && !customerMultiImg.isEmpty()) {
				try {
					byte[] bImg = customerMultiImg.getBytes();
					Blob blob = new SerialBlob(bImg);
					originalCustomer.setCustomerImg(blob);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			//save原始物件
			customerService.updateCustomer(originalCustomer);
			
			return "/customer/customerPage";
		}
		
		//取得登入者個人上傳頭像
		@GetMapping("/getCustomerImg")
		public ResponseEntity<byte[]> getCustomerImg(Model model) {
			//從session取得登入者ID
			Integer customerId = ((CustomerBean)model.getAttribute("customerSignInSuccess")).getCustomerId();
			CustomerBean originalCustomer = customerService.findByCustomerId(customerId);
			
			Blob customerImg = originalCustomer.getCustomerImg();
			
			InputStream is = null;
			String fileName = null;
			byte[] media = null;
			ResponseEntity<byte[]> responseEntity = null;
			
			try {
				if (customerImg != null) {
					is = customerImg.getBinaryStream();
				}
				// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)	
				if(is == null) {
					fileName = "salad.png";
					is = servletContext.getResourceAsStream(
							"/images/" + fileName);
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
			} finally{
				try {
					if (is != null) is.close();
				} catch(IOException e) {
					;
				}
			}
			return responseEntity;
		}
		
		//以ID取得上傳頭像
		@GetMapping("/getCustomerImgById/{customerId}")
		public ResponseEntity<byte[]> getCustomerImgById(@PathVariable("customerId")Integer customerId){
			CustomerBean originalCustomer = customerService.findByCustomerId(customerId);
			
			Blob customerImg = originalCustomer.getCustomerImg();
			
			InputStream is = null;
			String fileName = null;
			byte[] media = null;
			ResponseEntity<byte[]> responseEntity = null;
			
			try {
				if (customerImg != null) {
					is = customerImg.getBinaryStream();
				}
				// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)	
				if(is == null) {
					fileName = "salad.png";
					is = servletContext.getResourceAsStream(
							"/images/" + fileName);
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
			} finally{
				try {
					if (is != null) is.close();
				} catch(IOException e) {
					;
				}
			}
			return responseEntity;
		}
		
		//導向忘記密碼
		@GetMapping("/customerForgotPassword")
		public String customerForgotPassword() {
			return "/customer/customerPasswordReset";
		}
		
		
}
