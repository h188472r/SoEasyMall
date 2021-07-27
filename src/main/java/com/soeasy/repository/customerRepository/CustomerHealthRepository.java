package com.soeasy.repository.customerRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.CustomerHealthBean;

public interface CustomerHealthRepository extends JpaRepository<CustomerHealthBean, Integer>{
	
	List<CustomerHealthBean> findByCustomerGender(Integer customerGender);
	
	List<CustomerHealthBean> findByCustomerDiet(Integer customerDiet);
	
	List<CustomerHealthBean> findByCustomerExerciseHabits(Integer customerExerciseHabits);
}
