package com.soeasy.controller.adminController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.ShopBean;
import com.soeasy.model.member.AdminBean;
import com.soeasy.validator.adminValidator.AdminBeanValidator;

@Controller
@RequestMapping("/admin")
@SessionAttributes({"adminLoginSuccess", "customerSignInSuccess", "shopSignInSuccess", "switchMode"}) 
public class AdminLogin {

	// 後臺首頁
	@GetMapping({"/", "/adminLogin"})
	public String admin(Model model, HttpServletRequest request) {
		AdminBean adminBean = new AdminBean();
		adminBean.setAdminName("admin");
		adminBean.setAdminPassword("soeasy");
		model.addAttribute("adminBean", adminBean);
		HttpSession session = request.getSession();
		session.setAttribute("servletPath", request.getServletPath());
		return "/adminIndex";
	}
	
	//管理員登入
	//會員
	@PostMapping("/adminLogin")
	public String admin(
			@ModelAttribute("adminBean")
			AdminBean adminBean,
			BindingResult result, 
			Model model,
			HttpServletRequest request, 
			HttpServletResponse response) {
		
		// 若有顧客或廠商已登入，則必須先登出
		CustomerBean customer = (CustomerBean) model.getAttribute("customerSignInSuccess");
		ShopBean shop = (ShopBean) model.getAttribute("shopSignInSuccess");
		System.out.println(customer);
		System.out.println(shop);
		
		if (customer != null || shop != null) {
			result.rejectValue("accountConflict", "", "已有其他會員帳號登入");
			return "/adminIndex";
		}
		// ------------------------------------------------------------------------------
		// 檢測不正當欄位並回傳提示訊息
		AdminBeanValidator validator = new AdminBeanValidator();
		
		validator.validate(adminBean, result);
		if (result.hasErrors()) {
			return "/adminIndex";
		}
		//-------------------------------------------------------------------------------
		// 比對帳密
		String adminName = adminBean.getAdminName();
		String adminPassword = adminBean.getAdminPassword();
		AdminBean adminLoginSuccess = null;
		
		if(adminName.equals("admin") && adminPassword.equals("soeasy")) {
			adminLoginSuccess = adminBean;
			model.addAttribute("adminLoginSuccess", adminLoginSuccess);
		} else {
			result.rejectValue("invalidCredentials", "", "該帳號不存在或密碼錯誤");
			System.out.println("失敗");
			return "/adminIndex";
		}
		
		HttpSession session = request.getSession();
		String nextPath = (String)session.getAttribute("adminServletPath");
		System.out.println(nextPath);
		if (nextPath == null) {
			nextPath = "/admin/";
		}
		System.out.println(nextPath);
		return "redirect:" + nextPath;
	}
	@GetMapping(value = "/switchMode.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String switchMode(Model model) {
		String switchMode = (String) model.getAttribute("switchMode");
		if (switchMode == null) {
			// 設定夜間模式
			switchMode = "moon";
			model.addAttribute("switchMode", "moon");
		} else if (switchMode.equals("moon")) {
			// 設定日間模式
			switchMode = "sun";
			model.addAttribute("switchMode", "sun");
		} else if (switchMode.equals("sun")) {
			// 設定夜間模式
			switchMode = "moon";
			model.addAttribute("switchMode", "moon");
		}
		
		return switchMode;
	}
}
