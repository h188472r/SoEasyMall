package com.soeasy.controller.shopController;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.ShopBean;
import com.soeasy.model.member.ShopSignInBean;
import com.soeasy.service.shopService.ShopService;
import com.soeasy.util.GlobalService;
import com.soeasy.validator.shopValidator.ShopBeanValidator;

@Controller
@RequestMapping("/shopController")
@SessionAttributes("shopSignInSuccess")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	ServletContext servletContext;
	
	//表單初值--新增廠商_廠商登入--註冊
	@GetMapping("/addShop")
	public String addShopSendForm(Model model) {
		ShopBean shopBean = new ShopBean();
		ShopSignInBean shopSignInBean = new ShopSignInBean();
		String signMode = "sign_up";
		
		shopBean.setShopName("農夫彼得");
		shopBean.setShopEmail("farmerpeter101@gmail.com");
		shopBean.setShopPassword("peter123");
		shopBean.setShopCheckPassword("peter123");
		shopBean.setShopPhone("0960 725 368");
		
		shopSignInBean.setShopSignInEmail("farmerpeter101@gmail.com");
		shopSignInBean.setShopSignInPassword("peter123");
		
		model.addAttribute("shopBean", shopBean);
		model.addAttribute("shopSignInBean", shopSignInBean);
		model.addAttribute("signMode", signMode);
		return "shop/shopSignInUp";
	}
		
	//送出表單--新增廠商會員
	@PostMapping("/addShop")
	public String addShopProcess(
				@ModelAttribute("shopBean") ShopBean shopBean,
				BindingResult result, Model model,
				HttpServletRequest request
			) {
		//檢測不正當欄位並回傳提示訊息
		ShopBeanValidator validator = new ShopBeanValidator();
		validator.validate(shopBean, result);
		if (result.hasErrors()) {
			//重新設定表單
			model = resetSendForm(model);
			return "shop/shopSignInUp";
		}
		
		//設定初始值
		//帳號狀態:正常
		shopBean.setShopStatus(GlobalService.SHOP_STATUS_NORMAL);
	
		// 檢查 shopEmail是否重複
		if (shopService.emailExists(shopBean.getShopEmail())) {
			//重新設定表單
			model = resetSendForm(model);
			result.rejectValue("shopEmail", "", "帳號已存在，請重新輸入");
			return "shop/shopSignInUp";
		}
			
		try {
			shopService.addShop(shopBean);
		} catch (Exception e) {
			System.out.println(e.getClass().getName() + ", ex.getMessage()=" + e.getMessage());
			result.rejectValue("shopName", "", "發生異常，請通知系統人員..." + e.getMessage());
			return "shop/shopSignInUp";
		}
	
		return "redirect:/";
	}
	
	public Model resetSendForm(Model model) {
		//重新設定隔壁表單的初值
		ShopSignInBean shopSignInBean = new ShopSignInBean();
		//鎖定頁面為註冊模式
		String signMode = "sign_up";
		model.addAttribute("shopSignInBean", shopSignInBean);
		model.addAttribute("signMode", signMode);
		
		return model;
	}
	
	// 取得登入者個人上傳頭像
	@GetMapping("/getShopImg")
	public ResponseEntity<byte[]> getShopImg(Model model) {
		// 從session取得登入者ID
		Integer shopId = ((ShopBean) model.getAttribute("shopSignInSuccess")).getShopId();
		ShopBean originalShop = shopService.findByShopId(shopId);

		Blob shopImg = originalShop.getShopImg();

		InputStream is = null;
		String fileName = null;
		byte[] media = null;
		ResponseEntity<byte[]> responseEntity = null;

		try {
			if (shopImg != null) {
				is = shopImg.getBinaryStream();
			}
			// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)
			if (is == null) {
				fileName = "salad.png";
				is = servletContext.getResourceAsStream("/images/" + fileName);
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
	
	// 以ID取得上傳頭像
	@GetMapping("/getShopImgById/{shopId}")
	public ResponseEntity<byte[]> getShopImgById(@PathVariable("shopId") Integer shopId) {
		ShopBean originalShop = shopService.findByShopId(shopId);

		Blob shopImg = originalShop.getShopImg();

		InputStream is = null;
		String fileName = null;
		byte[] media = null;
		ResponseEntity<byte[]> responseEntity = null;

		try {
			if (shopImg != null) {
				is = shopImg.getBinaryStream();
			}
			// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)
			if (is == null) {
				fileName = "salad.png";
				is = servletContext.getResourceAsStream("/images/" + fileName);
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
	
	
	
	
//=======================================================================	
	
	//顯示前台廠商個人頁面
	@GetMapping("/showShopPage")
	public String showShopPage(Model model) {
		ShopBean shopSignInSuccess=(ShopBean)model.getAttribute("shopSignInSuccess");
		ShopBean origionShop = shopService.findByShopId(shopSignInSuccess.getShopId());
		model.addAttribute("shopBean",origionShop);
		return "shop/shopPage";
	}
	//修改前台廠商個人頁面
	@GetMapping(value="/updateShopPage/{shopId}")
	public String updateShopPage(@PathVariable("shopId")Integer shopId,Model model) {
		
		ShopBean shopBean = shopService.findByShopId(shopId);
		model.addAttribute("shopBean",shopBean);
		return "shop/updateShopPage";
		
	}
	
	//修改前台廠商頁面，將送來修改過的資料用本方法檢核，若無誤則寫入資料庫
	@PostMapping("/updateShopPage/{shopId}")
	public String modify(
	@ModelAttribute("shopBean")ShopBean shopBean,BindingResult result,
	Model model,@PathVariable Integer shopId,HttpServletRequest request) {
		
		System.out.println("進來囉1");
		
		//取得原始shop物件
		ShopBean shopOriginBean = shopService.findByShopId(shopId);
		System.out.println("進來囉2");
		//取得廠商照片
		MultipartFile shopImg = shopBean.getShopMultiImg();
		System.out.println("進來囉3");
		System.out.println("shopBean="+shopBean);
		//檢測欄位
		ShopBeanValidator validator = new ShopBeanValidator();
		
//		validator.validate(shopBean, result);		
//		if (result.hasErrors()) {
//			return "shop/updateShopPage";		
//				
//		}
		//圖片傳入資料庫
		if (shopImg != null && !shopImg.isEmpty()) {
			try {
				byte[] b = shopImg.getBytes();
				Blob blob = new SerialBlob(b);
				shopOriginBean.setShopImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}else {
			shopOriginBean.setShopImg(shopOriginBean.getShopImg());
		}
		
		shopOriginBean.setShopName(shopBean.getShopName());
		shopOriginBean.setShopPhone(shopBean.getShopPhone());
		
		try {
			shopService.updateShop(shopOriginBean);
			}catch(org.hibernate.exception.ConstraintViolationException e){
				return "shop/updateShopPage";
			}

		return "redirect:/shopController/showShopPage"; 
	
	}
	
	// 導向忘記密碼
	@GetMapping("/shopForgotPassword")
	public String shopForgotPassword() {
		return "/shop/shopPasswordReset";
	}
//======================================================================	
	
}
