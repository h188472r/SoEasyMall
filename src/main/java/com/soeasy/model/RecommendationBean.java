package com.soeasy.model;

import java.io.Serializable;

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

@Entity
@Table(name = "Recommendation")
public class RecommendationBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer recommendId;

	private String recommendTitle;

	@Column(length = 8000)
	private String recommendContent;

	// 講座分類介紹
	@Transient
	@Column(name = "fk_lectureIntroId")
	private Integer lectureIntroId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_lectureIntroId")
	private LectureIntroBean lectureIntroBean;

	// ------------------------------------------
	public RecommendationBean() {
	}
	// ------------------------------------------

	public Integer getRecommendId() {
		return recommendId;
	}

	public void setRecommendId(Integer recommendId) {
		this.recommendId = recommendId;
	}

	public String getRecommendTitle() {
		return recommendTitle;
	}

	public void setRecommendTitle(String recommendTitle) {
		this.recommendTitle = recommendTitle;
	}

	public String getRecommendContent() {
		return recommendContent;
	}

	public void setRecommendContent(String recommendContent) {
		this.recommendContent = recommendContent;
	}

}
