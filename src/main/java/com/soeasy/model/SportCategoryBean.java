package com.soeasy.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name = "SportCategory")
public class SportCategoryBean implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer sportCategoryId;
	
	private String sportCategoryName;
	//運動地圖(加下面會爆)

	

	// ------------------------------------------
	public SportCategoryBean() {
	}
	// ------------------------------------------


	public Integer getSportCategoryId() {
		return sportCategoryId;
	}


	public void setSportCategoryId(Integer sportCategoryId) {
		this.sportCategoryId = sportCategoryId;
	}


	public String getSportCategoryName() {
		return sportCategoryName;
	}


	public void setSportCategoryName(String sportCategoryName) {
		this.sportCategoryName = sportCategoryName;
	}	

	

}

