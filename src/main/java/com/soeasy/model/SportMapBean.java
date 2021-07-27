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
@Table(name = "SportMap")
public class SportMapBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer sportMapId;

	private String sportMapName;
	private String sportMapAddress;
	
	@Column(length = 1000)
	private String sportMapInfo;
	
	@Column(length = 1000)
	private String sportMapMap;
	private Integer sportMapCategory;
	private Integer sportMapScore;
	
	//判斷收藏
	@Transient
	private Boolean favoriteStatus;
	

	// 種類
	@Transient
	@Column(name = "fk_sportCategoryId")
	private Integer sportCategoryId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_sportCategoryId")
	private SportCategoryBean sportCategoryBean;

	// ------------------------------------------
	public SportMapBean() {
	}
	// ------------------------------------------

	public Integer getSportMapId() {
		return sportMapId;
	}

	public void setSportMapId(Integer sportMapId) {
		this.sportMapId = sportMapId;
	}

	public String getSportMapName() {
		return sportMapName;
	}

	public void setSportMapName(String sportMapName) {
		this.sportMapName = sportMapName;
	}

	public String getSportMapAddress() {
		return sportMapAddress;
	}

	public void setSportMapAddress(String sportMapAddress) {
		this.sportMapAddress = sportMapAddress;
	}

	public String getSportMapInfo() {
		return sportMapInfo;
	}

	public void setSportMapInfo(String sportMapInfo) {
		this.sportMapInfo = sportMapInfo;
	}

	public String getSportMapMap() {
		return sportMapMap;
	}

	public void setSportMapMap(String sportMapMap) {
		this.sportMapMap = sportMapMap;
	}

	public Integer getSportMapCategory() {
		return sportMapCategory;
	}

	public void setSportMapCategory(Integer sportMapCategory) {
		this.sportMapCategory = sportMapCategory;
	}

	public Integer getSportMapScore() {
		return sportMapScore;
	}

	public void setSportMapScore(Integer sportMapScore) {
		this.sportMapScore = sportMapScore;
	}

	public Integer getSportCategoryId() {
		return sportCategoryId;
	}

	public void setSportCategoryId(Integer sportCategoryId) {
		this.sportCategoryId = sportCategoryId;
	}

	public SportCategoryBean getSportCategoryBean() {
		return sportCategoryBean;
	}

	public void setSportCategoryBean(SportCategoryBean sportCategoryBean) {
		this.sportCategoryBean = sportCategoryBean;
	}

	public Boolean getFavoriteStatus() {
		return favoriteStatus;
	}

	public void setFavoriteStatus(Boolean favoriteStatus) {
		this.favoriteStatus = favoriteStatus;
	}
	
	

	
}
