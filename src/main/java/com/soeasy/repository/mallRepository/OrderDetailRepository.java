package com.soeasy.repository.mallRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.Order.OrderDetailBean;



public interface OrderDetailRepository extends JpaRepository<OrderDetailBean, Integer>{
	
	// 根據最新產品去找產品
		public List<OrderDetailBean> findAll();
	



	
}