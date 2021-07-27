package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Shop")
public class ShopBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer shopId;

	private String shopEmail;

	private String shopName;

	private String shopPassword;

	@Transient
	private String shopCheckPassword;
	
	private String shopPhone;

	@JsonIgnore
	private Blob shopImg;

	@Transient
	private MultipartFile shopMultiImg;

	private Integer shopStatus;

	//商品
	@Transient
	private Integer productId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "shopBean", cascade = CascadeType.ALL)
	Set<ProductBean> productBeans = new LinkedHashSet<ProductBean>();
	
	// ------------------------------------------
	public ShopBean() {
	}
	// ------------------------------------------

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public String getShopEmail() {
		return shopEmail;
	}

	public void setShopEmail(String shopEmail) {
		this.shopEmail = shopEmail;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopPassword() {
		return shopPassword;
	}

	public void setShopPassword(String shopPassword) {
		this.shopPassword = shopPassword;
	}
	
	public String getShopCheckPassword() {
		return shopCheckPassword;
	}

	public void setShopCheckPassword(String shopCheckPassword) {
		this.shopCheckPassword = shopCheckPassword;
	}

	public String getShopPhone() {
		return shopPhone;
	}

	public void setShopPhone(String shopPhone) {
		this.shopPhone = shopPhone;
	}

	public Blob getShopImg() {
		return shopImg;
	}

	public void setShopImg(Blob shopImg) {
		this.shopImg = shopImg;
	}

	public MultipartFile getShopMultiImg() {
		return shopMultiImg;
	}

	public void setShopMultiImg(MultipartFile shopMultiImg) {
		this.shopMultiImg = shopMultiImg;
	}

	public Integer getShopStatus() {
		return shopStatus;
	}

	public void setShopStatus(Integer shopStatus) {
		this.shopStatus = shopStatus;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Set<ProductBean> getProductBeans() {
		return productBeans;
	}

	public void setProductBeans(Set<ProductBean> productBeans) {
		this.productBeans = productBeans;
	}

	
}
