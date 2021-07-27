package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Timestamp;
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

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="ArticleList")
public class ArticleListBean  implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer articleId;
	
	private String articleCategories;
	
	private String articleAuthor;
	
	private String articleTitle;
	
	private Blob articleThumbnail;
	
	@Transient
	private MultipartFile articleMultiImg;
	
	private Blob articleContent;
	
	@JsonFormat(pattern ="yyyy-MM-dd hh:mm:ss",timezone = "GMT+8")
	private Timestamp articleUploadTime;
	
	private Integer articleViews;
	
	//留言列表(So園地)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "articleListBean", cascade = CascadeType.ALL)
	Set<CommentListBean> commentListBeans = new LinkedHashSet<CommentListBean>();
	
	//留言修改紀錄(So園地)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "articleListBean", cascade = CascadeType.ALL)
	Set<CommentLogBean> commentLogBeans = new LinkedHashSet<CommentLogBean>();
	// ------------------------------------------
	public ArticleListBean() {
	}
	// ------------------------------------------

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String getArticleCategories() {
		return articleCategories;
	}

	public void setArticleCategories(String articleCategories) {
		this.articleCategories = articleCategories;
	}

	public String getArticleAuthor() {
		return articleAuthor;
	}

	public void setArticleAuthor(String articleAuthor) {
		this.articleAuthor = articleAuthor;
	}

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public Blob getArticleThumbnail() {
		return articleThumbnail;
	}

	public void setArticleThumbnail(Blob articleThumbnail) {
		this.articleThumbnail = articleThumbnail;
	}

	public MultipartFile getArticleMultiImg() {
		return articleMultiImg;
	}

	public void setArticleMultiImg(MultipartFile articleMultiImg) {
		this.articleMultiImg = articleMultiImg;
	}

	public Blob getArticleContent() {
		return articleContent;
	}

	public void setArticleContent(Blob articleContent) {
		this.articleContent = articleContent;
	}

	public Timestamp getArticleUploadTime() {
		return articleUploadTime;
	}

	public void setArticleUploadTime(Timestamp articleUploadTime) {
		this.articleUploadTime = articleUploadTime;
	}

	public Integer getArticleViews() {
		return articleViews;
	}

	public void setArticleViews(Integer articleViews) {
		this.articleViews = articleViews;
	}

	public Set<CommentListBean> getCommentListBeans() {
		return commentListBeans;
	}

	public void setCommentListBeans(Set<CommentListBean> commentListBeans) {
		this.commentListBeans = commentListBeans;
	}

	public Set<CommentLogBean> getCommentLogBeans() {
		return commentLogBeans;
	}

	public void setCommentLogBeans(Set<CommentLogBean> commentLogBeans) {
		this.commentLogBeans = commentLogBeans;
	}
	
	
}
