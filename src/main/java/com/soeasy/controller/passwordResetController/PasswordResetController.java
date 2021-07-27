package com.soeasy.controller.passwordResetController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.PasswordResetValidate;
import com.soeasy.model.ShopBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.passwordResetService.PasswordResetService;
import com.soeasy.service.shopService.ShopService;

@Controller
@RequestMapping("/passwordResetValidate")
public class PasswordResetController {

	@Autowired
	PasswordResetService passwordResetService;

	@Autowired
	CustomerService customerService;

	@Autowired
	ShopService shopService;

//	發信者
	@Value("${spring.mail.username}")
	private String fromEmail;

//	送出顧客會員變更密碼信箱驗證
	@PostMapping(value = "/sendCustomerValidationEmail.do", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> sendCustomerValidationEmail(@RequestParam(value = "email") String email,
			String memberType, HttpServletRequest request) {
		System.out.println(email);

		Map<String, String> responseMessage = new HashMap<String, String>();
		List<CustomerBean> customerBeans = customerService.findByCustomerEmail(email);
		System.out.println(customerBeans);
		if (customerBeans.isEmpty()) {// 檢查是否有該信箱
			responseMessage.put("responseMessage", "該信箱用戶不存在");
		} else {
			// 尚未檢驗允許重製---未完成
			if (passwordResetService.sendValidateLimitation(email, "customerPasswordReset", 5L, 1L)) {
				// 允許重製密碼
				// 產生重製密碼申請記錄
				PasswordResetValidate passwordResetValidate = new PasswordResetValidate();
				passwordResetService.insertCustomerResetRecord(passwordResetValidate, customerBeans.get(0),
						UUID.randomUUID().toString());

				// 設置郵件內容
				String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
				SimpleMailMessage passwordResetEmail = new SimpleMailMessage();
				passwordResetEmail.setFrom(fromEmail);
				passwordResetEmail.setTo(email);
				passwordResetEmail.setSubject("[Soeasy健康平台]忘記密碼");
				passwordResetEmail.setText("您正在申請重新設置密碼，請點擊此連結重製密碼:\n" + appUrl
						+ "/soeasy/passwordResetValidate/resetPassword?token=" + passwordResetValidate.getResetToken());
				passwordResetService.sendPasswordResetEmail(passwordResetEmail);

				System.out.println(email);
				System.out.println(appUrl);
				responseMessage.put("responseMessage", "已送出密碼重置郵件，請至您的註冊信箱確認");

			} else {
				// 一天申請超過五次，或一分鐘內連續送出
				responseMessage.put("responseMessage", "申請失敗，失敗原因：一天申請超過五次，或一分鐘內連續送出");
			}

		}

		return responseMessage;
	}
	
//	送出顧客會員變更密碼信箱驗證
	@PostMapping(value = "/sendShopValidationEmail.do", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> sendShopValidationEmail(@RequestParam(value = "email") String email,
			String memberType, HttpServletRequest request) {
		System.out.println(email);

		Map<String, String> responseMessage = new HashMap<String, String>();
		List<ShopBean> shopBeans = shopService.findByShopEmail(email);
		if (shopBeans.isEmpty()) {// 檢查是否有該信箱
			responseMessage.put("responseMessage", "該信箱用戶不存在");
		} else {
			// 尚未檢驗允許重製---未完成
			if (passwordResetService.sendValidateLimitation(email, "shopPasswordReset", 5L, 1L)) {
				// 允許重製密碼
				// 產生重製密碼申請記錄
				PasswordResetValidate passwordResetValidate = new PasswordResetValidate();
				passwordResetService.insertShopResetRecord(passwordResetValidate, shopBeans.get(0),
						UUID.randomUUID().toString());

				// 設置郵件內容
				String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
				SimpleMailMessage passwordResetEmail = new SimpleMailMessage();
				passwordResetEmail.setFrom(fromEmail);
				passwordResetEmail.setTo(email);
				passwordResetEmail.setSubject("[Soeasy健康平台]忘記密碼");
				passwordResetEmail.setText("您正在申請重新設置密碼，請點擊此連結重製密碼:\n" + appUrl
						+ "/soeasy/passwordResetValidate/resetPassword?token=" + passwordResetValidate.getResetToken());
				passwordResetService.sendPasswordResetEmail(passwordResetEmail);

				System.out.println(email);
				System.out.println(appUrl);
				responseMessage.put("responseMessage", "已送出密碼重置郵件，請至您的註冊信箱確認");

			} else {
				// 一天申請超過五次，或一分鐘內連續送出
				responseMessage.put("responseMessage", "申請失敗，失敗原因：一天申請超過五次，或一分鐘內連續送出");
			}

		}

		return responseMessage;
	}
	

	@GetMapping("/resetPassword")
	public String resetPassword(@RequestParam("token") String token, Model model) {
		model.addAttribute("token", token);
		return "/customer/customerResetPasswordValidate";
	}

	@PostMapping(value = "/resetPassword.do", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> doResetPassword(@RequestParam("token") String token,
			@RequestParam("password") String password, @RequestParam("checkPassword") String checkPassword) {
		Map<String, String> responseMessage = new HashMap<String, String>();
		List<PasswordResetValidate> passwordResetValidates = passwordResetService.findUserByResetToken(token);
		if (passwordResetValidates.isEmpty()) {// 查無請求
			responseMessage.put("responseMessage", "該重置請求不存在");
		} else {
			PasswordResetValidate passwordResetValidate = passwordResetValidates.get(0);

			//驗證連結是否失效
			if (passwordResetService.validateLimitation(passwordResetValidate.getEmail(), Long.MAX_VALUE, 60L, token)) {
				if (passwordResetValidate.getMemberType().equals("customerPasswordReset")) {// email來自顧客
					// 以email取得會員
					CustomerBean customer = customerService.findByCustomerEmail(passwordResetValidate.getEmail())
							.get(0);
					if (password.equals(checkPassword)) {
						customer.setCustomerPassword(password);
						customerService.updateCustomer(customer);
						responseMessage.put("responseMessage", "密碼更新成功");
					} else {
						responseMessage.put("responseMessage", "確認密碼與密碼不一致");
					}
				} else if (passwordResetValidate.getMemberType().equals("shopPasswordReset")) {// email來自廠商
					// 以email取得廠商
					ShopBean shop = shopService.findByShopEmail(passwordResetValidate.getEmail()).get(0);
					if (password.equals(checkPassword)) {
						shop.setShopPassword(password);
						shopService.updateShop(shop);
						responseMessage.put("responseMessage", "密碼更新成功");
					} else {
						responseMessage.put("responseMessage", "確認密碼與密碼不一致");
					}
				}
			} else {
				responseMessage.put("responseMessage", "連結已失效");
			}

		}

		return responseMessage;
	}
}
