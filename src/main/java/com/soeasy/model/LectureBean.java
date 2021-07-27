package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "Lecture")
public class LectureBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer lectureId;

	private String lectureTitle;

	private String lectureCategory;

	@Column(length = 8000)
	private String lectureContent;

	private Blob lectureImg;

	@Transient
	private MultipartFile lectureMultiImg;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date lectureDate;

	private Integer lectureStatus;
	
	private String lectureAddress;
	
	@Column(length = 1000)
	private String lectureMap;

	// 講座介紹類型
	@Transient
	@Column(name = "fk_lectureIntroId")
	private Integer lectureIntroId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_lectureIntroId")
	private LectureIntroBean lectureIntroBean;

	// 講座預約
	@Column(name = "fk_reservationId")
	@Transient
	private Integer reservationId;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "fk_reservationId")
	private ReservationBean reservationBean;

	// ------------------------------------------
	public LectureBean() {
	}
	// ------------------------------------------

	public Integer getLectureId() {
		return lectureId;
	}

	public void setLectureId(Integer lectureId) {
		this.lectureId = lectureId;
	}

	public String getLectureTitle() {
		return lectureTitle;
	}

	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
	}

	public String getLectureCategory() {
		return lectureCategory;
	}

	public void setLectureCategory(String lectureCategory) {
		this.lectureCategory = lectureCategory;
	}

	public String getLectureContent() {
		return lectureContent;
	}

	public void setLectureContent(String lectureContent) {
		this.lectureContent = lectureContent;
	}

	public Blob getLectureImg() {
		return lectureImg;
	}

	public void setLectureImg(Blob lectureImg) {
		this.lectureImg = lectureImg;
	}

	public MultipartFile getLectureMultiImg() {
		return lectureMultiImg;
	}

	public void setLectureMultiImg(MultipartFile lectureMultiImg) {
		this.lectureMultiImg = lectureMultiImg;
	}

	public Date getLectureDate() {
		return lectureDate;
	}

	public void setLectureDate(Date lectureDate) {
		this.lectureDate = lectureDate;
	}

	public Integer getLectureStatus() {
		return lectureStatus;
	}

	public void setLectureStatus(Integer lectureStatus) {
		this.lectureStatus = lectureStatus;
	}

	public String getLectureAddress() {
		return lectureAddress;
	}

	public void setLectureAddress(String lectureAddress) {
		this.lectureAddress = lectureAddress;
	}

	public String getLectureMap() {
		return lectureMap;
	}

	public void setLectureMap(String lectureMap) {
		this.lectureMap = lectureMap;
	}

}
