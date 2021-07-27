package com.soeasy.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Record")
public class RecordBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer recordId;

	private Double recordHeight;

	private Double recordWeight;

	@Transient
	private Double recordBmi;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date recordDate;
	// ------------------------------------
	// 會員
	@Transient
	@Column(name = "fk_customerId")
	private Integer customerId;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_customerId")
	private CustomerBean customerBean;

	// ------------------------------------
	public RecordBean() {
	}
	// ------------------------------------

	public Integer getRecordId() {
		return recordId;
	}

	public void setRecordId(Integer recordId) {
		this.recordId = recordId;
	}

	public Double getRecordHeight() {
		return recordHeight;
	}

	public void setRecordHeight(Double recordHeight) {
		this.recordHeight = recordHeight;
	}

	public Double getRecordWeight() {
		return recordWeight;
	}

	public void setRecordWeight(Double recordWeight) {
		this.recordWeight = recordWeight;
	}

	public Double getRecordBmi() {
		Double BMI =recordWeight/((recordHeight/100)*(recordHeight/100));
		Double roundBMI = Math.round(BMI*10.0)/10.0;
		return roundBMI;
	}

	public void setRecordBmi(Double recordBmi) {
		this.recordBmi = recordBmi;
	}

	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public CustomerBean getCustomerBean() {
		return customerBean;
	}

	public void setCustomerBean(CustomerBean customerBean) {
		this.customerBean = customerBean;
	}

	@Override
	public String toString() {
		return "RecordBean [recordId=" + recordId + ", recordHeight=" + recordHeight + ", recordWeight=" + recordWeight
				+ ", recordBmi=" + recordBmi + ", recordDate=" + recordDate + ", customerId=" + customerId
				+ ", customerBean=" + customerBean + "]";
	}

	
}
