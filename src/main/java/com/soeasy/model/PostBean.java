package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Post")
public class PostBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer postId;

	private String postTitle;

	private String postCategory;

	@Column(length = 8000)
	private String postContent;

	@JsonIgnore
	private Blob postImg;

	@Transient
	private MultipartFile postMultiImg;

	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
	private Timestamp postUploadTime;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date postUploadDate;

	private Integer postLike;

	private Integer postStatus;

	// 判斷收藏
	@Transient
	private Boolean favoriteStatus;

	// -------------------------------
	// 會員
	@Transient
	@Column(name = "fk_customerId")
	private Integer customerId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_customerId")
	private CustomerBean customerBean;

	// 回覆(So分享)
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "postBean", cascade = CascadeType.ALL)
	Set<ReplyBean> replyBeans = new LinkedHashSet<ReplyBean>();

	// 類別
	@Transient
	@Column(name = "fk_postCategoryId")
	private Integer postCategoryId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_postCategoryId")
	private PostCategoryBean postCategoryBean;

	// ----------------------------
	public PostBean() {
	}
	// ----------------------------

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostCategory() {
		return postCategory;
	}

	public void setPostCategory(String postCategory) {
		this.postCategory = postCategory;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public Blob getPostImg() {
		return postImg;
	}

	public void setPostImg(Blob postImg) {
		this.postImg = postImg;
	}

	public MultipartFile getPostMultiImg() {
		return postMultiImg;
	}

	public void setPostMultiImg(MultipartFile postMultiImg) {
		this.postMultiImg = postMultiImg;
	}

	public Timestamp getPostUploadTime() {
		return postUploadTime;
	}

	public void setPostUploadTime(Timestamp postUploadTime) {
		this.postUploadTime = postUploadTime;
	}

	public Date getPostUploadDate() {
		return postUploadDate;
	}

	public void setPostUploadDate(Date postUploadDate) {
		this.postUploadDate = postUploadDate;
	}

	public Integer getPostLike() {
		return postLike;
	}

	public void setPostLike(Integer postLike) {
		this.postLike = postLike;
	}

	public Integer getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(Integer postStatus) {
		this.postStatus = postStatus;
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

	public Set<ReplyBean> getReplyBeans() {
		return replyBeans;
	}

	public void setReplyBeans(Set<ReplyBean> replyBeans) {
		this.replyBeans = replyBeans;
	}

	public Integer getPostCategoryId() {
		return postCategoryId;
	}

	public void setPostCategoryId(Integer postCategoryId) {
		this.postCategoryId = postCategoryId;
	}

	public PostCategoryBean getPostCategoryBean() {
		return postCategoryBean;
	}

	public void setPostCategoryBean(PostCategoryBean postCategoryBean) {
		this.postCategoryBean = postCategoryBean;
	}

	public Boolean getFavoriteStatus() {
		return favoriteStatus;
	}

	public void setFavoriteStatus(Boolean favoriteStatus) {
		this.favoriteStatus = favoriteStatus;
	}

	@Override
	public String toString() {
		return "PostBean [postId=" + postId + ", postTitle=" + postTitle + ", postCategory=" + postCategory
				+ ", postContent=" + postContent + ", postImg=" + postImg + ", postMultiImg=" + postMultiImg
				+ ", postUploadTime=" + postUploadTime + ", postUploadDate=" + postUploadDate + ", postLike=" + postLike
				+ ", postStatus=" + postStatus + ", customerId=" + customerId + ", customerBean=" + customerBean
				+ ", replyBeans=" + replyBeans + ", postCategoryId=" + postCategoryId + ", PostCategoryBean="
				+ postCategoryBean + "]";
	}

}
