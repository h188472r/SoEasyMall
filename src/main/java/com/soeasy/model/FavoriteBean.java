package com.soeasy.model;

import java.io.Serializable;

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

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Favorite")
public class FavoriteBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer favoriteId;
	
	private String favoriteCategory;
	
	private Integer favoriteItemId;
	
	//-------------------------------
	//會員
	@Transient
	@Column(name = "fk_customerId")
	private Integer customerId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_customerId")
	@JsonIgnore
	private CustomerBean customerBean;
	
	
	//-------------------------------
	public FavoriteBean() {
	}
	//-------------------------------

	public Integer getFavoriteId() {
		return favoriteId;
	}

	public void setFavoriteId(Integer favoriteId) {
		this.favoriteId = favoriteId;
	}

	public String getFavoriteCategory() {
		return favoriteCategory;
	}

	public void setFavoriteCategory(String favoriteCategory) {
		this.favoriteCategory = favoriteCategory;
	}

	public Integer getFavoriteItemId() {
		return favoriteItemId;
	}

	public void setFavoriteItemId(Integer favoriteItemId) {
		this.favoriteItemId = favoriteItemId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public CustomerBean getCustomerBean() {
		return customerBean;
	}

	public void setCustomerBean(CustomerBean customerBean) {
		this.customerBean = customerBean;
	}
	
	
}
