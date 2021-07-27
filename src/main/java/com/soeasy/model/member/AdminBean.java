package com.soeasy.model.member;


public class AdminBean {
	private String adminName;

	private String adminPassword;
	
	// 登入失敗
	private String invalidCredentials;
	
	// 帳號衝突提示
	private String accountConflict;
	
	public AdminBean() {
		super();
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminPassword() {
		return adminPassword;
	}

	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public String getInvalidCredentials() {
		return invalidCredentials;
	}

	public void setInvalidCredentials(String invalidCredentials) {
		this.invalidCredentials = invalidCredentials;
	}

	public String getAccountConflict() {
		return accountConflict;
	}

	public void setAccountConflict(String accountConflict) {
		this.accountConflict = accountConflict;
	}

	
	
	
}
