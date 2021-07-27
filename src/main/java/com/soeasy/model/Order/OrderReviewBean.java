package com.soeasy.model.Order;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.soeasy.model.ProductBean;

public class OrderReviewBean {
	
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Integer reviewId;
//	@Column(length = 400)
//	private String content;
//	
//	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
//	private Timestamp replyTime;
//		
//	
//
//	@Transient
//	@Column(name = "fk_productId")
//	private Integer productId;
//
//	@JsonIgnore
//	@ManyToOne(fetch = FetchType.EAGER)
//	@JoinColumn(name = "fk_productId")
//	private ProductBean productBean;
//	
//	
//	
//	//===================================================================
//
//	public OrderReviewBean() {
//		super();
//		// TODO Auto-generated constructor stub
//	}
//	
//	//==============
//
//	public Integer getReviewId() {
//		return reviewId;
//	}
//
//
//	public void setReviewId(Integer reviewId) {
//		this.reviewId = reviewId;
//	}
//
//	public String getContent() {
//		return content;
//	}
//
//	public void setContent(String content) {
//		this.content = content;
//	}
//
//	public Timestamp getReplyTime() {
//		return replyTime;
//	}
//
//	public void setReplyTime(Timestamp replyTime) {
//		this.replyTime = replyTime;
//	}
//
//	public Integer getProductId() {
//		return productId;
//	}
//
//	public void setProductId(Integer productId) {
//		this.productId = productId;
//	}
//
//	public ProductBean getProductBean() {
//		return productBean;
//	}
//
//	public void setProductBean(ProductBean productBean) {
//		this.productBean = productBean;
//	}
//	
//	
	
	
	
	

}
