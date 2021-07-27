package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "Lecturer")
public class LecturerBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer lecturerId;
	
	private String lecturerName;

	private String lecturerTalent;

	@Column(length = 2000)
	private String lecturerExp;

	private Blob lecturerImg;

	@Transient
	private MultipartFile lecturerMultiImg;

	// -------------------------------------
	public LecturerBean() {
	}
	// -------------------------------------

	public Integer getLecturerId() {
		return lecturerId;
	}

	public void setLecturerId(Integer lecturerId) {
		this.lecturerId = lecturerId;
	}
	
	public String getLecturerName() {
		return lecturerName;
	}

	public void setLecturerName(String lecturerName) {
		this.lecturerName = lecturerName;
	}

	public String getLecturerTalent() {
		return lecturerTalent;
	}

	public void setLecturerTalent(String lecturerTalent) {
		this.lecturerTalent = lecturerTalent;
	}

	public String getLecturerExp() {
		return lecturerExp;
	}

	public void setLecturerExp(String lecturerExp) {
		this.lecturerExp = lecturerExp;
	}

	public Blob getLecturerImg() {
		return lecturerImg;
	}

	public void setLecturerImg(Blob lecturerImg) {
		this.lecturerImg = lecturerImg;
	}

	public MultipartFile getLecturerMultiImg() {
		return lecturerMultiImg;
	}

	public void setLecturerMultiImg(MultipartFile lecturerMultiImg) {
		this.lecturerMultiImg = lecturerMultiImg;
	}

}
