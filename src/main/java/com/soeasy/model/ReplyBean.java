package com.soeasy.model;

import java.io.Serializable;
import java.sql.Timestamp;

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

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "Reply")
//@JsonIgnoreProperties({"postBean","hibernateLazyInitializer","handler","customerBean","hibernateLazyInitializer","handler"})
public class ReplyBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer replyId;

	@Column(length = 400)
	private String replyContent;

	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
	private Timestamp replyTime;

	private Integer replyLike;

	private Integer replyStatus;

	private Integer replyFloor;

	// 判斷收藏
	@Transient
	private Boolean favoriteStatus;

	// ---------------------------
	// 會員
	@Transient
	@Column(name = "fk_customerId")
	private Integer customerId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_customerId")
	private CustomerBean customerBean;

	// 文章(會員發的So分享)
	@Transient
	@Column(name = "fk_postId")
	private Integer postId;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_postId")
	private PostBean postBean;

	// ---------------------------
	public ReplyBean() {

	}
	// ---------------------------

	public Integer getReplyId() {
		return replyId;
	}

	public void setReplyId(Integer replyId) {
		this.replyId = replyId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Timestamp getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Timestamp replyTime) {
		this.replyTime = replyTime;
	}

	public Integer getReplyLike() {
		return replyLike;
	}

	public void setReplyLike(Integer replyLike) {
		this.replyLike = replyLike;
	}

	public Integer getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(Integer replyStatus) {
		this.replyStatus = replyStatus;
	}

	public Integer getReplyFloor() {
		return replyFloor;
	}

	public void setReplyFloor(Integer replyFloor) {
		this.replyFloor = replyFloor;
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

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public PostBean getPostBean() {
		return postBean;
	}

	public void setPostBean(PostBean postBean) {
		this.postBean = postBean;
	}

	public Boolean getFavoriteStatus() {
		return favoriteStatus;
	}

	public void setFavoriteStatus(Boolean favoriteStatus) {
		this.favoriteStatus = favoriteStatus;
	}
	
	

}
