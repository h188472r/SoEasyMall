package com.soeasy.model;

import java.sql.Blob;

import org.springframework.web.multipart.MultipartFile;

public class PostUpdateBean {

	private String postTitle;

	private String postCategory;

	private String postContent;

	private Blob postImg;
	
	private MultipartFile postMultiImg;

	private Integer postStatus;

	private Integer postCategoryId;
	
	private PostCategoryBean postCategoryBean;

	public PostUpdateBean() {
		super();
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

	public Integer getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(Integer postStatus) {
		this.postStatus = postStatus;
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

	@Override
	public String toString() {
		return "PostUpdateBean "
				+ "[postTitle=" + postTitle 
				+ ", postCategory=" + postCategory 
				+ ", postContent="+ postContent 
				+ ", postImg=" + postImg 
				+ ", postMultiImg=" + postMultiImg 
				+ ", postStatus=" + postStatus
				+ ", postCategoryId=" + postCategoryId 
				+ ", PostCategoryBean=" + postCategoryBean 
				+ "]";
	}



}
