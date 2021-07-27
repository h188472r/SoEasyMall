package com.soeasy.model.Order;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

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
import com.soeasy.model.CustomerBean;

@Entity
@Table(name = "OrderBean")
public class OrderBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer orderId;

	private String orderCustomerName;

	private String orderAddress;

	private String orderPhone;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date orderRegisterTime;

//	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
//	private Timestamp orderArrviedTime;

//	private String orderRemark;
//

	private Integer orderTotalPrice;
	private String shipping;

	private String orderStatus;

	private String payStatus;

	

		// 會員
		@Transient
		@Column(name = "fk_customerId")
		private Integer customerId;

		@JsonIgnore
		@ManyToOne(fetch = FetchType.EAGER)
		@JoinColumn(name = "fk_customerId")
		private CustomerBean customerBean;


	// 訂單項目
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orderBean", cascade = CascadeType.ALL)
	List<OrderDetailBean> OrderDetail = new ArrayList<OrderDetailBean>();
	
	// ------------------------------------------
	public OrderBean() {
	}
	// ------------------------------------------

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getOrderCustomerName() {
		return orderCustomerName;
	}

	public void setOrderCustomerName(String orderCustomerName) {
		this.orderCustomerName = orderCustomerName;
	}

//	public String getOrderAddress() {
//		return orderAddress;
//	}
//
//	public void setOrderAddress(String orderAddress) {
//		this.orderAddress = orderAddress;
//	}
//
//	public String getOrderPhone() {
//		return orderPhone;
//	}
//
//	public void setOrderPhone(String orderPhone) {
//		this.orderPhone = orderPhone;
//	}

	public Date getOrderRegisterTime() {
		return orderRegisterTime;
	}

	public void setOrderRegisterTime(Date orderRegisterTime) {
		this.orderRegisterTime = orderRegisterTime;
	}

//	public Timestamp getOrderArrviedTime() {
//		return orderArrviedTime;
//	}
//
//	public void setOrderArrviedTime(Timestamp orderArrviedTime) {
//		this.orderArrviedTime = orderArrviedTime;
//	}
//
//	public String getOrderRemark() {
//		return orderRemark;
//	}
//
//	public void setOrderRemark(String orderRemark) {
//		this.orderRemark = orderRemark;
//	}
//
//	public String getOrderPaytype() {
//		return orderPaytype;
//	}
//
//	public void setOrderPaytype(String orderPaytype) {
//		this.orderPaytype = orderPaytype;
//	}

	

	public String getOrderStatus() {
		return orderStatus;
	}

	public Integer getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(Integer orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

//	public Integer getPayStatus() {
//		return payStatus;
//	}
//
//	public void setPayStatus(Integer payStatus) {
//		this.payStatus = payStatus;
//	}

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

	public List<OrderDetailBean> getOrderDetail() {
		return OrderDetail;
	}

	public void setOrderDetail(List<OrderDetailBean> orderDetail) {
		OrderDetail = orderDetail;
	}

	public String getShipping() {
		return shipping;
	}

	public void setShipping(String shipping) {
		this.shipping = shipping;
	}
	
	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	public String getOrderPhone() {
		return orderPhone;
	}

	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}
	

	
}
