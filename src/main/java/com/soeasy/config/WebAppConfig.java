package com.soeasy.config;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

import com.soeasy.controller.adminController.AdminLoginInterceptor;
import com.soeasy.controller.customerController.CustomerSignInInterceptor;
import com.soeasy.controller.shopController.ShopSignInInterceptor;

@Configuration
public class WebAppConfig implements WebMvcConfigurer {

	@Autowired
	private RequestMappingHandlerAdapter requestMappingHandlerAdapter;
	
	@Autowired
	private AdminLoginInterceptor adminLoginInterceptor;
	
	@Autowired
	private CustomerSignInInterceptor customerSignInInterceptor;
	
	@Autowired
	private ShopSignInInterceptor shopSignInInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(adminLoginInterceptor);
		registry.addInterceptor(customerSignInInterceptor);
		registry.addInterceptor(shopSignInInterceptor);
		
	}

	// 取消"redirect+冒號..."時會掛上QueryString
	@PostConstruct
	public void init() {
		requestMappingHandlerAdapter.setIgnoreDefaultModelOnRedirect(true);
	}	
}
