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

@Entity
@Table(name = "Product")
public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	// @GeneratedValue：告訴此Column的生成方式
	// GenerationType.IDENTITY 讓資料庫自己維護

	private Integer productId;

	private String productName;

	@Column(length = 8000)
	private String productDescription;

	private Integer productPrice;

	private Integer productAmount;

	private String productCalories;

	private Integer category;

	private String productCategory;

	// 判斷收藏
	@Transient
	private Boolean favoriteStatus;

	@JsonIgnore
	private Blob productImg;

	@Transient
	private MultipartFile productMultiImg;
//	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date productDate;

	private Integer productCost;
	// 廠商
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_shopId")
	private ShopBean shopBean;
	
	
//	// 評價
//		@OneToMany(fetch = FetchType.EAGER, mappedBy = "productBean", cascade = CascadeType.ALL)
//		Set<OrderReviewBean> replyBeans = new LinkedHashSet<OrderReviewBean>();


//	購物車	商品不需找回購物車	單向關聯	

	// ------------------------------------------
	public ProductBean() {
	}
	// ------------------------------------------

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

//	==============ProductImg==================
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

//	==============(E)ProductImg======================

	public Date getProductDate() {
		return productDate;
	}

	public void setProductDate(Date productDate) {
		this.productDate = productDate;
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

	public Boolean getFavoriteStatus() {
		return favoriteStatus;
	}

	public void setFavoriteStatus(Boolean favoriteStatus) {
		this.favoriteStatus = favoriteStatus;
	}

//	===========

}
