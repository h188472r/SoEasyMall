package com.soeasy.repository.mallRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.soeasy.model.Order.OrderBean;



public interface OrderRepository extends JpaRepository<OrderBean, Integer>{

	
	//根據訂單ID&顧客ID去尋找訂單(前台)
	@Query("from OrderBean where customerBean.customerId= :customerId order by orderId desc")
	public List<OrderBean>findAllWithOrder(@Param("customerId")Integer customerId);
	
	
	//根據訂單ID去尋找訂單(後台)
	@Query("from OrderBean order by orderId desc")
	public List<OrderBean>findAllWithOrder();
		
	//根據最大的訂單ID尋找訂單
	@Query("SELECT p FROM OrderBean p WHERE p.orderId = (SELECT max(p2.orderId) FROM OrderBean p2)") 
	public OrderBean getMaxIdOrder(); 

	


	
}