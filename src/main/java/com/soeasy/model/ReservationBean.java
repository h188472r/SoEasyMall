package com.soeasy.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "Reservation")
public class ReservationBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer reservationId;
	
	private Integer reservationStatus;
	
	@JsonFormat(pattern ="yyyy-MM-dd hh:mm:ss",timezone = "GMT+8")
	private Timestamp reservationTime;
	
	private Integer reservationAmount;
	
	private Integer reservationLeft;
	
	//會員
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "reservation_customer", joinColumns = {
			@JoinColumn(name = "fk_reservationId", referencedColumnName = "reservationId")
	}, inverseJoinColumns = {
			@JoinColumn(name = "fk_customerId", referencedColumnName = "customerId")
	})
	Set<CustomerBean> customerBeans = new HashSet<CustomerBean>();
	
	// ------------------------------------------
	public ReservationBean() {
	}
	// ------------------------------------------

	public Integer getReservationId() {
		return reservationId;
	}

	public void setReservationId(Integer reservationId) {
		this.reservationId = reservationId;
	}

	public Integer getReservationStatus() {
		return reservationStatus;
	}

	public void setReservationStatus(Integer reservationStatus) {
		this.reservationStatus = reservationStatus;
	}

	public Timestamp getReservationTime() {
		return reservationTime;
	}

	public void setReservationTime(Timestamp reservationTime) {
		this.reservationTime = reservationTime;
	}

	public Integer getReservationAmount() {
		return reservationAmount;
	}

	public void setReservationAmount(Integer reservationAmount) {
		this.reservationAmount = reservationAmount;
	}

	public Integer getReservationLeft() {
		return reservationLeft;
	}

	public void setReservationLeft(Integer reservationLeft) {
		this.reservationLeft = reservationLeft;
	}

	public Set<CustomerBean> getCustomerBeans() {
		return customerBeans;
	}

	public void setCustomerBeans(Set<CustomerBean> customerBeans) {
		this.customerBeans = customerBeans;
	}
	
	
}
