package com.soeasy.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "CustomerHealth")
public class CustomerHealthBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer customerHealthId;

	private Integer customerGender;

	private Double customerHeight;

	private Double customerWeight;

	private Integer customerExerciseHabits;

	private Integer customerDiet;
	//-------------------------------------------
	//會員
	@OneToOne(mappedBy = "customerHealthBean")
	@JsonIgnore
	private CustomerBean customerBean;
	
	
	// --------------------------------
	public CustomerHealthBean() {
	}
	// --------------------------------

	public Integer getCustomerHealthId() {
		return customerHealthId;
	}

	public void setCustomerHealthId(Integer customerHealthId) {
		this.customerHealthId = customerHealthId;
	}

	public Integer getCustomerGender() {
		return customerGender;
	}

	public void setCustomerGender(Integer customerGender) {
		this.customerGender = customerGender;
	}

	public Double getCustomerHeight() {
		return customerHeight;
	}

	public void setCustomerHeight(Double customerHeight) {
		this.customerHeight = customerHeight;
	}

	public Double getCustomerWeight() {
		return customerWeight;
	}

	public void setCustomerWeight(Double customerWeight) {
		this.customerWeight = customerWeight;
	}

	public Integer getCustomerExerciseHabits() {
		return customerExerciseHabits;
	}

	public void setCustomerExerciseHabits(Integer customerExerciseHabits) {
		this.customerExerciseHabits = customerExerciseHabits;
	}

	public Integer getCustomerDiet() {
		return customerDiet;
	}

	public void setCustomerDiet(Integer customerDiet) {
		this.customerDiet = customerDiet;
	}

	public CustomerBean getCustomerBean() {
		return customerBean;
	}

	public void setCustomerBean(CustomerBean customerBean) {
		this.customerBean = customerBean;
	}

	
	
}
