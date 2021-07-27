package com.soeasy.model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "LectureIntro")
public class LectureIntroBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer lectureIntroId;
	
	private String lectureIntroCategoryL;
	
	private String lectureIntroCategoryS;
	
	@Column(length = 8000)
	private String lectureIntroContent;
	
	//講座
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lectureIntroBean", cascade = CascadeType.ALL)
	Set<LectureBean> lectureBeans = new LinkedHashSet<LectureBean>();
	
	//推薦文
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lectureIntroBean", cascade = CascadeType.ALL)
	Set<RecommendationBean> recommendationBeans = new LinkedHashSet<RecommendationBean>();
	
	// ------------------------------------------
	public LectureIntroBean() {
	}
	// ------------------------------------------
	public Integer getLectureIntroId() {
		return lectureIntroId;
	}
	public void setLectureIntroId(Integer lectureIntroId) {
		this.lectureIntroId = lectureIntroId;
	}
	public String getLectureIntroCategoryL() {
		return lectureIntroCategoryL;
	}
	public void setLectureIntroCategoryL(String lectureIntroCategoryL) {
		this.lectureIntroCategoryL = lectureIntroCategoryL;
	}
	public String getLectureIntroCategoryS() {
		return lectureIntroCategoryS;
	}
	public void setLectureIntroCategoryS(String lectureIntroCategoryS) {
		this.lectureIntroCategoryS = lectureIntroCategoryS;
	}
	public String getLectureIntroContent() {
		return lectureIntroContent;
	}
	public void setLectureIntroContent(String lectureIntroContent) {
		this.lectureIntroContent = lectureIntroContent;
	}
	
	
}
