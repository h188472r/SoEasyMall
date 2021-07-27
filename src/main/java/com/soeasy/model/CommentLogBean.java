package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
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

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "CommentLog")
public class CommentLogBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer commentLogId;

	private Integer commentLogSequence;
	
	@Column(length = 400)
	private String commentLogContent;

	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
	private Timestamp commentLogUploadTime;

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
	// ------------------------------------------
	public CommentLogBean() {
	}
	// ------------------------------------------

	public Integer getCommentLogId() {
		return commentLogId;
	}

	public void setCommentLogId(Integer commentLogId) {
		this.commentLogId = commentLogId;
	}

	public Integer getCommentLogSequence() {
		return commentLogSequence;
	}

	public void setCommentLogSequence(Integer commentLogSequence) {
		this.commentLogSequence = commentLogSequence;
	}

	public String getCommentLogContent() {
		return commentLogContent;
	}

	public void setCommentLogContent(String commentLogContent) {
		this.commentLogContent = commentLogContent;
	}

	public Timestamp getCommentLogUploadTime() {
		return commentLogUploadTime;
	}

	public void setCommentLogUploadTime(Timestamp commentLogUploadTime) {
		this.commentLogUploadTime = commentLogUploadTime;
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
