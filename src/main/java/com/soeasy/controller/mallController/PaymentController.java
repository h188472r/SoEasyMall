package com.soeasy.controller.mallController;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import com.soeasy.model.CartItem;
import com.soeasy.model.CustomerBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.model.Order.OrderDetailBean;
import com.soeasy.model.Order.PaymentModel;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.mallService.OrderService;
import com.soeasy.service.mallService.PaymentService;
import com.soeasy.service.mallService.ProductService;
import com.soeasy.util.URLUtils;

@Controller
@SessionAttributes("customerSignInSuccess")

public class PaymentController {

	/**
	 * 成功頁
	 */
	public static final String PAYPAL_SUCCESS_URL = "mall/pay/success";

	/**
	 * 取消頁
	 */
	public static final String PAYPAL_CANCEL_URL = "mall/pay/cancel";

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private ProductService productService;

	@GetMapping("/mall/paypal")
	public String index() {
		return "/mall/paypal/index";
	}

	@PostMapping("/mall/pay")
	public String payment(HttpServletRequest request, Model model, HttpSession session) {
		// * 取消頁
		String cancelUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_CANCEL_URL;
		// 獲取成功頁
		String successUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_SUCCESS_URL;
		Payment payment = null;

		PaymentModel paymentModel = new PaymentModel();
		// List <OrderBean> order =;
//        CustomerBean customerSignIn = (CustomerBean)model.getAttribute("customerSignInSuccess");
//        CustomerBean originCustomer = customerService.findByCustomerId(customerSignIn.getCustomerId());
		List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
		Integer amount = 0;
		StringBuilder description = new StringBuilder("");

		for (CartItem cartItem : cartItems) {
			amount += cartItem.getCartQuantity() * cartItem.getProduct().getProductPrice();
			description.append(cartItem.getProduct().getProductName() + "*" + cartItem.getCartQuantity() + "\r\n");
		}
		System.out.println(description);
		// 運費60
		amount += 60;
		// 如何獲取訂單金額
		// paymentModel.setAmount(order.getOrderTotalPrice().toString());
		paymentModel.setAmount(String.valueOf(amount));
		// 貨幣
		paymentModel.setCurrency("TWD");
		// 付款描述
		paymentModel.setDescription(description.toString());
		try {
			payment = paymentService.createPayment(paymentModel, cancelUrl, successUrl);
		} catch (PayPalRESTException e) {
			e.printStackTrace();
		}
		for (Links links : payment.getLinks()) {
			if (links.getRel().equals("approval_url")) {
				// 付款的登入頁面
				return "redirect:" + links.getHref();
			}
		}
		return "redirect:/";
	}

	// 取消頁面
	@GetMapping(value = PAYPAL_CANCEL_URL)
	public String cancelPay() {
		return "/mall/paypal/cancel";
	}

	// 執行付款
	@GetMapping(value = PAYPAL_SUCCESS_URL)
	public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId,
			HttpSession session, Model model) {
		Payment payment = null;
		try {
			payment = paymentService.executePayment(paymentId, payerId);
		} catch (PayPalRESTException e) {
			e.printStackTrace();
		}
		if (payment.getState().equals("approved")) {
			System.out.println("支付成功" + "paymentId:" + paymentId + "====payerId:" + payerId);

			// 根據最新的訂單ID 去修改付款狀態"paid"
			CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
			// OrderBean orderBean=new OrderBean();
			OrderBean order = orderService.getMaxIdOrder();
			System.out.println("最新orderId:" + order + "會員:" + customerBean.getCustomerId());

			order.setPayStatus("已付款");
			orderService.save(order);

			// Remove cart
			List<CartItem> cartTotalPrice = (List<CartItem>) session.getAttribute("cart");
			session.removeAttribute("cart");
			return "/mall/paypal/success";
		}

		return "redirect:/";
	}

//    //訂單完成設定
//    @GetMapping("/mall/status")
//	public String orderpay(@PathVariable("orderId") Integer orderId,Model model) {
//		OrderBean order = orderService.findByOrderId(orderId);
//		order.setPayStatus("已完成");
//		orderService.save(order);
//		
//		return "/mall/paypal/success";
//		
//		
//	}

	// 使用貨到付款
	@PostMapping("/mall/deliverPay")
	public String deliveryPay(HttpSession session, Model model) {

		// 根據最新的訂單ID 去修改付款狀態"貨到付款"
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		OrderBean order = orderService.getMaxIdOrder();
		System.out.println("最新orderId:" + order + "會員:" + customerBean.getCustomerId());

		// 修改付款狀態
		order.setPayStatus("貨到付款");
		orderService.save(order);



		// Remove cart
		List<CartItem> cartTotalPrice = (List<CartItem>) session.getAttribute("cart");
		session.removeAttribute("cart");
		return "/mall/paypal/success";

	}

}
