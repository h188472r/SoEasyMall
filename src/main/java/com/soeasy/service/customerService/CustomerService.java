package com.soeasy.service.customerService;

import java.util.List;

import com.soeasy.model.CustomerBean;

public interface CustomerService {
	//檢查email是否存在
	Boolean emailExists(String customerEmail);
	//檢查帳密是否正確
	CustomerBean checkEmailPassword(String customerEmail, String customerPassword);
	//新增會員
	void addCustomer(CustomerBean customer);
	//ID查詢會員
	CustomerBean findByCustomerId(Integer customerId);
	//Email查詢會員
	List<CustomerBean> findByCustomerEmail(String customerEmail);
	//修改基本資料
	void updateCustomer(CustomerBean customer);
	//變更會員狀態
	void updateCustomerStatus(CustomerBean customer, Integer customerStatus);
	//會員積分花費&增加
	void updateCustomerScore(CustomerBean customer, Integer score);
	//查詢所有會員
	List<CustomerBean> getAllCustomer();
	//以狀態查詢會員
	List<CustomerBean> getCustomerByStastus(Integer customerStatus);
	//以性別查詢會員
	List<CustomerBean> getCustomerByGender(Integer customerGender);
	//以葷素查詢會員
	List<CustomerBean> getCustomerByDiet(Integer customerDiet);
	//以運動強度查詢會員
	List<CustomerBean> getCustomerByExercise(Integer customerExerciseHabits);
	//以狀態與性別查詢
	List<CustomerBean> getCustomerByStatusAndGender(Integer customerStatus, Integer customerGender);
	//以狀態與飲食習慣查詢
	List<CustomerBean> getCustomerByStatusAndDiet(Integer customerStatus, Integer customerDiet);
	//以狀態與運動強度查詢
	List<CustomerBean> getCustomerByStatusAndExercise(Integer customerStatus, Integer customerExerciseHabits);
}
