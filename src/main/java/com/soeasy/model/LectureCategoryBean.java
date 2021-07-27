package com.soeasy.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "LectureCategory")
public class LectureCategoryBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer lectureCategoryId;
	private String lectureCategoryName;
	
	// ------------------------------------------
	public LectureCategoryBean() {
	}
	// ------------------------------------------

	public Integer getLectureCategoryId() {
		return lectureCategoryId;
	}

	public void setLectureCategoryId(Integer lectureCategoryId) {
		this.lectureCategoryId = lectureCategoryId;
	}

	public String getLectureCategoryName() {
		return lectureCategoryName;
	}

	public void setLectureCategoryName(String lectureCategoryName) {
		this.lectureCategoryName = lectureCategoryName;
	}
	
}
