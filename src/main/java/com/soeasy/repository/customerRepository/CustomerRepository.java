package com.soeasy.repository.customerRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;

public interface CustomerRepository extends JpaRepository<CustomerBean, Integer> {
	
	List<CustomerBean> findByCustomerEmail(String customerEmail);
	
	List<CustomerBean> findByCustomerEmailAndCustomerPassword(String customerEmail, String customerPassword);
	
	List<CustomerBean> findByCustomerStatus(Integer customerStatus);
	
	@Query(value = "select c from CustomerBean c where c.customerStatus = ?1 AND c.customerHealthBean.customerGender = ?2")
	List<CustomerBean> findCustomerByStatusAndGender(Integer customerStatus, Integer customerGender);
	
	@Query(value = "select c from CustomerBean c where c.customerStatus = ?1 AND c.customerHealthBean.customerDiet = ?2")
	List<CustomerBean> findCustomerByStatusAndDiet(Integer customerStatus, Integer customerDiet);

	@Query(value = "select c from CustomerBean c where c.customerStatus = ?1 AND c.customerHealthBean.customerExerciseHabits = ?2")
	List<CustomerBean> findCustomerByStatusAndExercise(Integer customerStatus, Integer customerExerciseHabits);
}
