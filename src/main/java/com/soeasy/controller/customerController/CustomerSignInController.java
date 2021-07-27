package com.soeasy.controller.customerController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.member.CustomerSignInBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.validator.customerValidator.CustomerSignInValidator;

@Controller
@RequestMapping("/customerController")
@SessionAttributes({"customerSignInSuccess"}) 
public class CustomerSignInController {
	
	@Autowired
	CustomerService customerService;
	
	//表單初值--新增會員_會員登入--登入
		@GetMapping("/customerSignIn")
		public String customerSignInSendForm(Model model) {
			CustomerBean customerBean = new CustomerBean();
			CustomerSignInBean customerSignInBean = new CustomerSignInBean();
			String signMode = "sign_in";
			
			customerBean.setCustomerName("方唐鏡");
			customerBean.setCustomerEmail("fangTC2021@gmail.com");
			customerBean.setCustomerPassword("ab1234");
			customerBean.setCustomerCheckPassword("ab1234");
			
			customerSignInBean.setCustomerSignInEmail("fangTC2021@gmail.com");
			
			model.addAttribute("customerBean", customerBean);
			model.addAttribute("customerSignInBean", customerSignInBean);
			model.addAttribute("signMode", signMode);
			return "customer/customerSignInUp";
		}
	
		//送出表單--登入顧客會員
		@PostMapping("/customerSignIn")
		public String customerSignIn(
				@ModelAttribute("customerSignInBean")
				CustomerSignInBean customerSignInBean,
				BindingResult result, 
				Model model,
				HttpServletRequest request, 
				HttpServletResponse response
			) {
		
		//檢測不正當欄位並回傳提示訊息
		CustomerSignInValidator validator = new CustomerSignInValidator();
		validator.validate(customerSignInBean, result);
		if (result.hasErrors()) {
			//重新設定表單
			model = resetSendForm(model);
			return "customer/customerSignInUp";
		}
		
		//--------------------------------------------------------------------
		//比對帳密
		String signInEmail = customerSignInBean.getCustomerSignInEmail();
		String signInPassword = customerSignInBean.getCustomerSignInPassword();
		CustomerBean customerSignInSuccess = null;
		
		//加密字串比對
		try {
			customerSignInSuccess = customerService.checkEmailPassword(signInEmail, signInPassword);
			if(customerSignInSuccess != null) {
				//登入成功
				model.addAttribute("customerSignInSuccess", customerSignInSuccess);
			} else {
				//重新設定表單
				model = resetSendForm(model);
				result.rejectValue("invalidCredentials", "", "該帳號不存在或密碼錯誤");
				return "customer/customerSignInUp";
			}
		} catch (RuntimeException re) {
			//重新設定表單
			model = resetSendForm(model);
			result.rejectValue("invalidCredentials", "", re.getMessage());
			re.printStackTrace();
			return "customer/customerSignInUp";
		}
		
		HttpSession session = request.getSession();
		String nextPath = (String)session.getAttribute("customerServletPath");
		System.out.println("登入完去哪:" + nextPath);
		if (nextPath == null) {
			nextPath = "/";
		}
		return "redirect:" + nextPath;
	}
	
	public Model resetSendForm(Model model) {
		//重新設定隔壁表單的初值
		CustomerBean customerBean = new CustomerBean();
		//鎖定頁面為登入模式
		String signMode = "sign_in";
		model.addAttribute("customerBean", customerBean);
		model.addAttribute("signMode", signMode);
		
		return model;
	}
}
