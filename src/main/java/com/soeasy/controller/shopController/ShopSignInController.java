package com.soeasy.controller.shopController;

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

import com.soeasy.model.ShopBean;
import com.soeasy.model.member.ShopSignInBean;
import com.soeasy.service.shopService.ShopService;
import com.soeasy.validator.shopValidator.ShopSignInValidator;

@Controller
@RequestMapping("/shopController")
@SessionAttributes({"shopSignInSuccess"})
public class ShopSignInController {
	
		@Autowired
		ShopService shopService;
	
		//表單初值--新增廠商_廠商登入--登入
		@GetMapping("/shopSignIn")
		public String shopSignInSendForm(Model model) {
			ShopBean shopBean = new ShopBean();
			ShopSignInBean shopSignInBean = new ShopSignInBean();
			String signMode = "sign_in";

			model.addAttribute("shopBean", shopBean);
			model.addAttribute("shopSignInBean", shopSignInBean);
			model.addAttribute("signMode", signMode);
			return "shop/shopSignInUp";
		}
	
		//送出表單--登入廠商會員
		@PostMapping("/shopSignIn")
		public String shopSignIn(
					@ModelAttribute("shopSignInBean")
					ShopSignInBean shopSignInBean,
					BindingResult result, 
					Model model,
					HttpServletRequest request, 
					HttpServletResponse response
				) {
			
			//檢測不正當欄位並回傳提示訊息
			ShopSignInValidator validator = new ShopSignInValidator();
			validator.validate(shopSignInBean, result);
			if (result.hasErrors()) {
				//重新設定表單
				model = resetSendForm(model);
				return "shop/shopSignInUp";
			}
			
			//--------------------------------------------------------------------
			//比對帳密
			String signInEmail = shopSignInBean.getShopSignInEmail();
			String signInPassword = shopSignInBean.getShopSignInPassword();
			ShopBean shopSignInSuccess = null;
			
			//加密字串比對
			try {
				shopSignInSuccess = shopService.checkEmailPassword(signInEmail, signInPassword);
				if(shopSignInSuccess != null) {
					//登入成功
					model.addAttribute("shopSignInSuccess", shopSignInSuccess);
				} else {
					//重新設定表單
					model = resetSendForm(model);
					result.rejectValue("invalidCredentials", "", "該帳號不存在或密碼錯誤");
					return "shop/shopSignInUp";
				}
			} catch (RuntimeException re) {
				//重新設定表單
				model = resetSendForm(model);
				result.rejectValue("invalidCredentials", "", re.getMessage());
				re.printStackTrace();
				return "shop/shopSignInUp";
			}
			
			HttpSession session = request.getSession();
			String nextPath = (String)session.getAttribute("shopServletPath");
			if (nextPath == null) {
				nextPath = "/";
			}
			return "redirect:" + nextPath;
		}
		
		public Model resetSendForm(Model model) {
			//重新設定隔壁表單的初值
			ShopBean shopBean = new ShopBean();
			//鎖定頁面為登入模式
			String signMode = "sign_in";
			model.addAttribute("shopBean", shopBean);
			model.addAttribute("signMode", signMode);
			
			return model;
		}
}
