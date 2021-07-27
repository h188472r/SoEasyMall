package com.soeasy.model.member;

public class ShopSignInBean {
	private String shopSignInEmail;

	private String shopSignInPassword;
	// 登入失敗
	private String invalidCredentials;

	public ShopSignInBean() {
		super();
	}

	public String getShopSignInEmail() {
		return shopSignInEmail;
	}

	public void setShopSignInEmail(String shopSignInEmail) {
		this.shopSignInEmail = shopSignInEmail;
	}

	public String getShopSignInPassword() {
		return shopSignInPassword;
	}

	public void setShopSignInPassword(String shopSignInPassword) {
		this.shopSignInPassword = shopSignInPassword;
	}

	public String getInvalidCredentials() {
		return invalidCredentials;
	}

	public void setInvalidCredentials(String invalidCredentials) {
		this.invalidCredentials = invalidCredentials;
	}
	
	
}
