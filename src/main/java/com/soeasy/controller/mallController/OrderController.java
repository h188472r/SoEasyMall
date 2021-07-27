package com.soeasy.controller.mallController;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.mallService.OrderDetailService;
import com.soeasy.service.mallService.OrderService;
import com.soeasy.service.mallService.ProductService;


@Controller
@RequestMapping("/mall/order")
@SessionAttributes("customerSignInSuccess")
public class OrderController {
	
	
	@Autowired
	ProductService productService;
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	OrderDetailService orderDetailService;
	

//	
//	
//	//建立跳轉
//		@GetMapping("/history")
//		public String orderhistory() {
//		return "mall/orderHistory";
//		}
//		
	
	//建立跳轉 (消費者訂單)
	@GetMapping("/history")
	public String history(CustomerBean customerBean,Model model,HttpSession session) {
		
		//登入攔截
		customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		if (customerBean == null) {
			return "redirect:/customerController/customerSignIn";
		}
		
		System.out.println("ID:"+orderService.findAllwithOrder(customerBean.getCustomerId()));
		model.addAttribute("order",orderService.findAllwithOrder(customerBean.getCustomerId()));
		return "mall/orderHistory";
		

	}
	
	//  訂單詳情
	
	@GetMapping("orderDetail/{orderId}")
	public String orderDetail(@PathVariable("orderId") Integer orderId,CustomerBean customerBean,Model model) {
		
		//登入攔截
		customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		if (customerBean == null) {
			return "redirect:/customerController/customerSignIn";
		}
		
		model.addAttribute("orderDetail",orderService.findByOrderId(orderId));
		model.addAttribute("order",orderService.findAllwithOrder(customerBean.getCustomerId()));

		return "mall/orderDetail";
		

	}
	
	

}

