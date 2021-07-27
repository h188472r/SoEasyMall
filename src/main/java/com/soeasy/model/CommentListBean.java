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

@Entity
@Table(name = "CommentList")
public class CommentListBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer commentListId;

	private Integer commentListSequence;
	
	@Column(length = 400)
	private String commentListContent;

	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
	private Timestamp commentListUploadTime;

	private Boolean commentListModified;

	//會員
	@Transient
	@Column(name = "fk_customerId")
	private Integer customerId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_customerId")
	private CustomerBean customerBean;
	
	//文章
	@Transient
	@Column(name = "fk_articleId")
	private Integer articleId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_articleId")
	private ArticleListBean articleListBean;
	// ------------------------------
	public CommentListBean() {
	}
	// ------------------------------

	public Integer getCommentListId() {
		return commentListId;
	}

	public void setCommentListId(Integer commentListId) {
		this.commentListId = commentListId;
	}

	public Integer getCommentListSequence() {
		return commentListSequence;
	}

	public void setCommentListSequence(Integer commentListSequence) {
		this.commentListSequence = commentListSequence;
	}
	
	public String getCommentListContent() {
		return commentListContent;
	}

	public void setCommentListContent(String commentListContent) {
		this.commentListContent = commentListContent;
	}

	public Timestamp getCommentListUploadTime() {
		return commentListUploadTime;
	}

	public void setCommentListUploadTime(Timestamp commentListUploadTime) {
		this.commentListUploadTime = commentListUploadTime;
	}

	public Boolean getCommentListModified() {
		return commentListModified;
	}

	public void setCommentListModified(Boolean commentListModified) {
		this.commentListModified = commentListModified;
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

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public ArticleListBean getArticleListBean() {
		return articleListBean;
	}

	public void setArticleListBean(ArticleListBean articleListBean) {
		this.articleListBean = articleListBean;
	}

	
}
