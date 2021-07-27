package com.soeasy.model.member;

public class CustomerSignInBean {

	private String customerSignInEmail;

	private String customerSignInPassword;
	// 登入失敗
	private String invalidCredentials;

	public CustomerSignInBean() {
		super();
	}

	public String getCustomerSignInEmail() {
		return customerSignInEmail;
	}

	public void setCustomerSignInEmail(String customerSignInEmail) {
		this.customerSignInEmail = customerSignInEmail;
	}

	public String getCustomerSignInPassword() {
		return customerSignInPassword;
	}

	public void setCustomerSignInPassword(String customerSignInPassword) {
		this.customerSignInPassword = customerSignInPassword;
	}

	public String getInvalidCredentials() {
		return invalidCredentials;
	}

	public void setInvalidCredentials(String invalidCredentials) {
		this.invalidCredentials = invalidCredentials;
	}

}
