package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;


public class ProductUpdateBean implements Serializable {

	private static final long serialVersionUID = 1L;


	private Integer productId;

	private String productName;

	private String productDescription;

	private Integer productPrice;

	private Integer productAmount;

	private String productCalories;

	private Integer category;

	private String productCategory;

	private Blob productImg;

	private MultipartFile productMultiImg;

	private Integer productCost;
	
	private ShopBean shopBean;
	private Date productDate;


	public Date getProductDate() {
		return productDate;
	}

	public void setProductDate(Date productDate) {
		this.productDate = productDate;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public Integer getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Integer productPrice) {
		this.productPrice = productPrice;
	}

	public Integer getProductAmount() {
		return productAmount;
	}

	public void setProductAmount(Integer productAmount) {
		this.productAmount = productAmount;
	}

	public String getProductCalories() {
		return productCalories;
	}

	public void setProductCalories(String productCalories) {
		this.productCalories = productCalories;
	}

	public Integer getCategory() {
		return category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public Blob getProductImg() {
		return productImg;
	}

	public void setProductImg(Blob productImg) {
		this.productImg = productImg;
	}

	public MultipartFile getProductMultiImg() {
		return productMultiImg;
	}

	public void setProductMultiImg(MultipartFile productMultiImg) {
		this.productMultiImg = productMultiImg;
	}

	public Integer getProductCost() {
		return productCost;
	}

	public void setProductCost(Integer productCost) {
		this.productCost = productCost;
	}

	public ShopBean getShopBean() {
		return shopBean;
	}

	public void setShopBean(ShopBean shopBean) {
		this.shopBean = shopBean;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public ProductUpdateBean(Integer productId, String productName, String productDescription, Integer productPrice,
			Integer productAmount, String productCalories, Integer category, String productCategory, Blob productImg,
			MultipartFile productMultiImg, Integer productCost, ShopBean shopBean) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productAmount = productAmount;
		this.productCalories = productCalories;
		this.category = category;
		this.productCategory = productCategory;
		this.productImg = productImg;
		this.productMultiImg = productMultiImg;
		this.productCost = productCost;
		this.shopBean = shopBean;
	}

	public ProductUpdateBean() {
		super();
		// TODO Auto-generated constructor stub
	}

}