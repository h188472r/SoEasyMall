package com.soeasy.repository.shopRepository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.soeasy.model.ProductBean;
import com.soeasy.model.ShopBean;
import com.soeasy.model.Order.OrderBean;

public interface ShopRepository extends JpaRepository<ShopBean, Integer>{

	List<ShopBean> findByShopEmail(String shopEmail);
	
	List<ShopBean> findByShopEmailAndShopPassword(String shopEmail, String shopPassword);
	
	List<ShopBean> findByShopStatus(Integer shopStatus);
	
	//根據shopID去尋找產品(前台)
		@Query("from ProductBean where shopBean.shopId= :shopId order by productId desc")
		public List<ProductBean>findAllWithProduct(@Param("shopId")Integer shopId);
		

}

