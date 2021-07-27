package com.soeasy.service.mallService.impl;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soeasy.model.Order.OrderDetailBean;
import com.soeasy.repository.mallRepository.OrderDetailRepository;
import com.soeasy.service.mallService.OrderDetailService;

@Transactional
@Service("OrdereDetailsrvice")
public class OrderDetailServiceImpl implements OrderDetailService{

	@Autowired
		private OrderDetailRepository orderDetailRepository;
	
	@Override
	public OrderDetailBean save(OrderDetailBean orderDetail) {
		return orderDetailRepository.save(orderDetail);
	}
	
	

	

	
}
