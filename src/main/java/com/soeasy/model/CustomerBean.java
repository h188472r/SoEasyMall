package com.soeasy.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.soeasy.model.Order.OrderBean;

@Entity
@Table(name = "Customer")
public class CustomerBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer customerId;

	private String customerEmail;

	private String customerName;

	private String customerPassword;
	
	@Transient
	private String customerCheckPassword;

	private String customerPhone;

	@JsonIgnore
	private Blob customerImg;

	@Transient
	private MultipartFile customerMultiImg;

	private String customerNickname;

	private Integer customerScore;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date customerBirthDay;

	private Integer customerStatus;

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@Column(updatable=false)
	private Timestamp customerRegisterTime;

	//-------------------------------------------
	//健康資訊
	@Column(name = "fk_customerHealthId")
	@Transient
	private Integer customerHealthId;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "fk_customerHealthId")
	private CustomerHealthBean customerHealthBean;
	
	//收藏
//	@Transient
//	private Integer favoriteId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<FavoriteBean> favoriteBeans = new LinkedHashSet<FavoriteBean>();
	
	//講座預約
//	@Transient
//	private Integer reservationId;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "customer_reservation", joinColumns = {
			@JoinColumn(name = "fk_customerId", referencedColumnName = "customerId")
	}, inverseJoinColumns = {
			@JoinColumn(name = "fk_reservationId", referencedColumnName = "reservationId")
	})
	Set<ReservationBean> reservationBeans = new HashSet<ReservationBean>();
	
	//訂單
//	@Transient
//	private Integer orderId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	List<OrderBean> orderBeans = new ArrayList<OrderBean>();
	
	//購物車	
//	@Column(name = "fk_shoppingcartId")
//	@Transient
//	private Integer shoppingcartId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<ShoppingcartBean> shoppingcartBean = new LinkedHashSet<ShoppingcartBean>();

	
	//留言
//	@Transient
//	private Integer commentListId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<CommentListBean> commentListBeans = new LinkedHashSet<CommentListBean>();
	
	//留言修改紀錄
//	@Transient
//	private Integer commentLogId;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<CommentLogBean> commentLogBeans = new LinkedHashSet<CommentLogBean>();
	
	//文章(會員發的So分享)
//	@Transient
//	private Integer postId;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<PostBean> postBeans = new LinkedHashSet<PostBean>();
	
	//日誌
//	@Transient
//	private Integer recordId;
	

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<RecordBean> recordBeans = new LinkedHashSet<RecordBean>();
	
	//回覆(So分享)
//	@Transient
//	private Integer replyId;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customerBean", cascade = CascadeType.ALL)
	Set<ReplyBean> replyBeans = new LinkedHashSet<ReplyBean>();
	// ------------------------------------------
	public CustomerBean() {
	}
	// ------------------------------------------

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerPassword() {
		return customerPassword;
	}

	public void setCustomerPassword(String customerPassword) {
		this.customerPassword = customerPassword;
	}

	public String getCustomerCheckPassword() {
		return customerCheckPassword;
	}

	public void setCustomerCheckPassword(String customerCheckPassword) {
		this.customerCheckPassword = customerCheckPassword;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	public Blob getCustomerImg() {
		return customerImg;
	}

	public void setCustomerImg(Blob customerImg) {
		this.customerImg = customerImg;
	}

	public MultipartFile getCustomerMultiImg() {
		return customerMultiImg;
	}

	public void setCustomerMultiImg(MultipartFile customerMultiImg) {
		this.customerMultiImg = customerMultiImg;
	}

	public String getCustomerNickname() {
		return customerNickname;
	}

	public void setCustomerNickname(String customerNickname) {
		this.customerNickname = customerNickname;
	}

	public Integer getCustomerScore() {
		return customerScore;
	}

	public void setCustomerScore(Integer customerScore) {
		this.customerScore = customerScore;
	}

	public Date getCustomerBirthDay() {
		return customerBirthDay;
	}

	public void setCustomerBirthDay(Date customerBirthDay) {
		this.customerBirthDay = customerBirthDay;
	}

	public Integer getCustomerStatus() {
		return customerStatus;
	}

	public void setCustomerStatus(Integer customerStatus) {
		this.customerStatus = customerStatus;
	}

	public Timestamp getCustomerRegisterTime() {
		return customerRegisterTime;
	}

	public void setCustomerRegisterTime(Timestamp customerRegisterTime) {
		this.customerRegisterTime = customerRegisterTime;
	}

	public Integer getCustomerHealthId() {
		return customerHealthId;
	}

	public void setCustomerHealthId(Integer customerHealthId) {
		this.customerHealthId = customerHealthId;
	}

	public CustomerHealthBean getCustomerHealthBean() {
		return customerHealthBean;
	}

	public void setCustomerHealthBean(CustomerHealthBean customerHealthBean) {
		this.customerHealthBean = customerHealthBean;
	}

	public Set<FavoriteBean> getFavoriteBeans() {
		return favoriteBeans;
	}

	public void setFavoriteBeans(Set<FavoriteBean> favoriteBeans) {
		this.favoriteBeans = favoriteBeans;
	}

	public Set<ReservationBean> getReservationBeans() {
		return reservationBeans;
	}

	public void setReservationBeans(Set<ReservationBean> reservationBeans) {
		this.reservationBeans = reservationBeans;
	}

	public List<OrderBean> getOrderBeans() {
		return orderBeans;
	}

	public void setOrderBeans(List<OrderBean> orderBeans) {
		this.orderBeans = orderBeans;
	}

	
	public Set<ShoppingcartBean> getShoppingcartBean() {
		return shoppingcartBean;
	}

	public void setShoppingcartBean(Set<ShoppingcartBean> shoppingcartBean) {
		this.shoppingcartBean = shoppingcartBean;
	}

	public Set<CommentListBean> getCommentListBeans() {
		return commentListBeans;
	}

	public void setCommentListBeans(Set<CommentListBean> commentListBeans) {
		this.commentListBeans = commentListBeans;
	}

	public Set<CommentLogBean> getCommentLogBeans() {
		return commentLogBeans;
	}

	public void setCommentLogBeans(Set<CommentLogBean> commentLogBeans) {
		this.commentLogBeans = commentLogBeans;
	}

	public Set<PostBean> getPostBeans() {
		return postBeans;
	}

	public void setPostBeans(Set<PostBean> postBeans) {
		this.postBeans = postBeans;
	}

	public Set<RecordBean> getRecordBeans() {
		return recordBeans;
	}

	public void setRecordBeans(Set<RecordBean> recordBeans) {
		this.recordBeans = recordBeans;
	}

	public Set<ReplyBean> getReplyBeans() {
		return replyBeans;
	}

	public void setReplyBeans(Set<ReplyBean> replyBeans) {
		this.replyBeans = replyBeans;
	}

	
}
