package com.soeasy.controller.adminController.adminManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.model.Order.OrderDetailBean;
import com.soeasy.service.mallService.OrderDetailService;
import com.soeasy.service.mallService.OrderService;
import com.soeasy.service.mallService.ProductService;


@Controller
@RequestMapping("/admin/adminManage")
public class AdminOrder {
	
	@Autowired
	ProductService productService;
	@Autowired
	OrderService orderService;
	@Autowired
	OrderDetailService orderDetailService;

	
	//建立跳轉 (後台所有訂單)
	@GetMapping("adminOrder")
	public String index(Model model) {
		model.addAttribute("order",orderService.findAllwithOrder());
			
		return "admin/adminOrder/adminOrderIndex";
		

	}
	
	//  訂單詳情
	
	@GetMapping("/adminOrder/detail/{orderId}")
	public String orderDetail(@PathVariable("orderId") Integer orderId,CustomerBean customerBean,Model model) {

		
		model.addAttribute("orderDetail",orderService.findByOrderId(orderId));
		//model.addAttribute("order",orderService.findAllwithOrder(customerBean.getCustomerId()));

		return "admin/adminOrder/adminOrderDetail";
		

	}
	
	
	// 刪除一筆紀錄
			@PostMapping("/adminOrder/delete/{orderId}")
			public String delete(@PathVariable("orderId") Integer orderId) {
		       orderService.deleteById(orderId);
	        	System.out.println("刪除訂單#"+orderId);
				return "redirect:/admin/adminManage/adminOrder"; 
			}
	
	
	
	//  訂單已完成
	
	@GetMapping("/adminOrder/status/{orderId}")
	public String orderDone(@PathVariable("orderId") Integer orderId,Model model) {
		 
		OrderBean order = orderService.findByOrderId(orderId);
		order.setOrderStatus("已完成");
		orderService.save(order);
		return "redirect:/admin/adminManage/adminOrder";	
	}
	//  訂單運送中
	
	@GetMapping("/adminOrder/deliver/{orderId}")
	public String orderDeliver(@PathVariable("orderId") Integer orderId,Model model) {
		
		OrderBean order = orderService.findByOrderId(orderId);
		order.setOrderStatus("運送中");
		orderService.save(order);
		return "redirect:/admin/adminManage/adminOrder";	
	}
	
	
	//  付款已完成
	
	@GetMapping("/adminOrder/payStatus/{orderId}")
	public String orderPay(@PathVariable("orderId") Integer orderId,Model model) {
		
		OrderBean order = orderService.findByOrderId(orderId);
		order.setPayStatus("已付款");
		orderService.save(order);
		
		return "redirect:/admin/adminManage/adminOrder";
		
		
	}
	//  付款未完成
	
	@GetMapping("/adminOrder/unpaid/{orderId}")
	public String orderpay(@PathVariable("orderId") Integer orderId,Model model) {
		
		OrderBean order = orderService.findByOrderId(orderId);
		order.setPayStatus("未付款");
		orderService.save(order);
		
		return "redirect:/admin/adminManage/adminOrder";
		
		
	}
	
	

	
	
	
	
	
	
	
	
	
	
	

}

