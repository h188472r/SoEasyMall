package com.soeasy.service.mallService.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.repository.mallRepository.OrderRepository;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.mallService.OrderService;

@Transactional
@Service("OrderService")
public class OrderServiceImpl implements OrderService {

		@Autowired
		private OrderRepository orderRepository;
	
		@Autowired
		private CustomerService customerService;

	@Override
	public OrderBean save(OrderBean order) {
		return orderRepository.save(order);
	}
	
	//尋找訂單 by 顧客ID (前台給顧客用)
	@Override
	public List<OrderBean> findAllwithOrder(Integer customerId){
		return orderRepository.findAllWithOrder(customerId);
	}
	
	//尋找訂單  (後端用)
	@Override
	public List<OrderBean> findAllwithOrder(){
		return orderRepository.findAllWithOrder();
	}
	
	


	@Override
	public OrderBean findByOrderId(Integer orderId) {
		return orderRepository.findById(orderId).get();
	}

	@Override
	public void deleteById(Integer orderId) {
		orderRepository.deleteById(orderId);
		
	}
	
	//根據最大的訂單ID尋找訂單

	@Override
	public OrderBean getMaxIdOrder() {
		return orderRepository.getMaxIdOrder();
	}

}
