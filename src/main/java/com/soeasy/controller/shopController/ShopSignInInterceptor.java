package com.soeasy.controller.shopController;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.soeasy.model.ShopBean;

@Component
public class ShopSignInInterceptor implements HandlerInterceptor{
	List<String> urls = Arrays.asList(
			
	);
	
	String servletPath;
	String contextPath;
	String requestURI;
	
	public ShopSignInInterceptor() {
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
		
		if(mustSignInShop()) {
			if(checkShopSignIn(request)) {	//已登入
				HttpSession session = request.getSession();
				session.setAttribute("shopServletPath", servletPath);
				byPass = true;
			} else {	//需登入但未登入，導向廠商顧客會員登入頁面
				HttpSession session = request.getSession();
				if ( ! isRequestedSessionIdValid ) {
					session.setAttribute("timeOut", "使用逾時，請重新登入");
				} else {
					// 記住原本的"requestURI"，稍後如果登入成功，系統可以自動轉入
					// 原本要執行的程式。
//					System.out.println("CheckLoginInterceptor#preHandle, servletPath=" + servletPath );
//					System.out.println("CheckLoginInterceptor#preHandle, session=" + session );
					session.setAttribute("shopServletPath", servletPath);	
				}
				response.sendRedirect(contextPath + "/shopController/shopSignIn");
				byPass = false;
			}
		} else {	//不需登入
			byPass = true;
		}
		
		return byPass;
		
	}
	
	// 判斷Session物件內是否含有識別字串為LoginOK的屬性物件，如果有，表示已經登入，否則尚未登入
	private boolean checkShopSignIn(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ShopBean loginToken = (ShopBean) session.getAttribute("shopSignInSuccess");
		if (loginToken == null) {
			return false;
		} else {
			return true;
		}
	}
	
	// 如果請求的ServletPath的前導字是以某個必須登入才能使用之資源的路徑，那就必須登入。
	private Boolean mustSignInShop() {
		Boolean mustSignInShop = false;
		for (String url : urls) {
			url = url.substring(0, url.length() - 1); // 除去掉最後一個字元的剩餘字串
			if (servletPath.startsWith(url)) {
				mustSignInShop = true;
				break;
			} else {
				if (servletPath.equals(url)) {
					mustSignInShop = true;
					break;
				}
			}
		}
		return mustSignInShop;
	}
}
