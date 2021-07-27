package com.soeasy.controller.customerController;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.soeasy.model.CustomerBean;

@Component
public class CustomerSignInInterceptor implements HandlerInterceptor {
	//需要登入且登入後需跳轉 名單
	List<String> urls = Arrays.asList(
			"/customerController/customerPage",
			"/customerController/updateCustomerInfo",
			"/customerController/updateCustomerHealthInfo",
			"/customerController/uploadCustomerImg",
			"/sportMapNeedLogin/*",
			"/favoriteController/*",
			"/PostNeedLoginController/*",
			"/ReplyNeedLoginController/*",
			"/mall/cart/index"
	);
	//需要登入但登入後不能跳轉 名單
	List<String> postUrls = Arrays.asList(
			"/favoriteController/*",
			"/sportMapNeedLogin/getScore/*",
			"/mall/buy/{productId}",
			"/mall/buyFromGoods/{productId}"
	);
	//不需要登入但登入後需跳轉 名單
	List<String> recordUrls = Arrays.asList(
			"/sportMapController/sportMap/*",
			"/postIndex",
			"/postByCategory",
			"/mall/mallIndex",
			"/mall/lists/product",
			"/nutritionistController/nutritionist/*"
	);
	String servletPath;
	String contextPath;
	String requestURI;
	
	
	
	public CustomerSignInInterceptor() {
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Boolean byPass = true;
		Boolean isRequestedSessionIdValid = false;
		
		servletPath = request.getServletPath();  
		contextPath = request.getContextPath();
		requestURI  = request.getRequestURI();
		
		
		isRequestedSessionIdValid = request.isRequestedSessionIdValid();
		
		if(mustSignInCustomer()) {
			if(checkCustomerSignIn(request)) {	//已登入
				HttpSession session = request.getSession();
				session.setAttribute("customerServletPath", servletPath);
				byPass = true;
			} else {	//需登入但未登入，導向登入顧客會員登入頁面
				HttpSession session = request.getSession();
				if ( ! isRequestedSessionIdValid ) {
					session.setAttribute("timeOut", "使用逾時，請重新登入");
				} else {
					// 記住原本的"requestURI"，稍後如果登入成功，系統可以自動轉入
					// 原本要執行的程式。
//					System.out.println("CheckLoginInterceptor#preHandle, servletPath=" + servletPath );
//					System.out.println("CheckLoginInterceptor#preHandle, session=" + session );
					if(!needLoginNoRecordRequest()) {
						System.out.println(servletPath);
						session.setAttribute("customerServletPath", servletPath);						
					}
				}
				response.sendRedirect(contextPath + "/customerController/customerSignIn");
				byPass = false;
			}
		} else {	//不需登入
			HttpSession session = request.getSession();
			if(needRecordRequestNoLogin()) {
				session.setAttribute("customerServletPath", servletPath);	
			}
			byPass = true;
		}
		
		return byPass;
	}
	
	// 判斷Session物件內是否含有識別字串為LoginOK的屬性物件，如果有，表示已經登入，否則尚未登入
	private boolean checkCustomerSignIn(HttpServletRequest req) {
		HttpSession session = req.getSession();
		CustomerBean loginToken = (CustomerBean) session.getAttribute("customerSignInSuccess");
		if (loginToken == null) {
			return false;
		} else {
			return true;
		}
	}
	
	// 如果請求的ServletPath的前導字是以某個必須登入才能使用之資源的路徑，那就必須登入。
	private Boolean mustSignInCustomer() {
		Boolean mustSignInCustomer = false;
			for (String url : urls) {
			url = url.substring(0, url.length() - 1); // 除去掉最後一個字元的剩餘字串
			if (servletPath.startsWith(url)) {
				mustSignInCustomer = true;
				break;
			} else {
				if (servletPath.equals(url)) {
					mustSignInCustomer = true;
					break;
				}
			}
		} 
		return mustSignInCustomer;
	}
	
	// 如果必須登入才能使用的請求為Post請求，則不須記入登入成功後轉入
	private Boolean needLoginNoRecordRequest() {
		Boolean needLoginNoRecordRequest = false;
			for(String postUrl : postUrls) {
				postUrl = postUrl.substring(0, postUrl.length() - 1); // 除去掉最後一個字元的剩餘字串
				if (servletPath.startsWith(postUrl)) {
					needLoginNoRecordRequest = true;
					break;
				} else {
					if (servletPath.equals(postUrl)) {
						needLoginNoRecordRequest = true;
						break;
					}
				}
			}
		return needLoginNoRecordRequest;
	}
	
	// 不需要登入，但該頁面包含了需要登入的請求路徑(例如訪客瀏覽的頁面含有需登入會員的功能)，加入登入後轉向
	private Boolean needRecordRequestNoLogin() {
		Boolean needRecordRequestNoLogin = false;
		for(String recordUrl : recordUrls) {
			recordUrl = recordUrl.substring(0, recordUrl.length() - 1); // 除去掉最後一個字元的剩餘字串
			if (servletPath.startsWith(recordUrl)) {
				needRecordRequestNoLogin = true;
				break;
			} else {
				if (servletPath.equals(recordUrl)) {
					needRecordRequestNoLogin = true;
					break;
				}
			}
		}
	return needRecordRequestNoLogin;
	}
}
