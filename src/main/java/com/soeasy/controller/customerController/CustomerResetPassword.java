package com.soeasy.controller.customerController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/customerController")
public class CustomerResetPassword {
	
	@Autowired
    private JavaMailSender javaMailSender;
	
	@Value("${spring.mail.username}")
	private String from;

	@GetMapping("/sendValidationEmail")
	public String sendValidationEmail(){
		// 設置郵件內容
        SimpleMailMessage passwordResetEmail = new SimpleMailMessage();
        passwordResetEmail.setFrom(from);
        passwordResetEmail.setTo("a0939956219@gmail.com");
        passwordResetEmail.setSubject("soeasy測試信");
        passwordResetEmail.setText("驗證目前測試中");
        javaMailSender.send(passwordResetEmail);
		return "redirect:/";
	}
}
