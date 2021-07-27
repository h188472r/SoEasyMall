package com.soeasy.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PostCategory")
public class PostCategoryBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer postCategoryId;

	private String postCategoryName;
	

	// ------------------------------------------
	public PostCategoryBean() {
	}
	// ------------------------------------------

	public Integer getPostCategoryId() {
		return postCategoryId;
	}

	public void setPostCategoryId(Integer postCategoryId) {
		this.postCategoryId = postCategoryId;
	}

	public String getPostCategoryName() {
		return postCategoryName;
	}

	public void setPostCategoryName(String postCategoryName) {
		this.postCategoryName = postCategoryName;
	}

	@Override
	public String toString() {
		return "PostCategoryBean "
				+ "[postCategoryId=" + postCategoryId 
				+ ", postCategoryName=" + postCategoryName + "]";
	}
	
}
