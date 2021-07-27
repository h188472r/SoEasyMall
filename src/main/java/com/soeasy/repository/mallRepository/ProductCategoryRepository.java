package com.soeasy.repository.mallRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.soeasy.model.ProductCategoryBean;

@Repository("ProductCategoryRepository")
public interface ProductCategoryRepository extends JpaRepository<ProductCategoryBean,Integer>{

	@Query("from ProductCategoryBean c where c.category = null")
	public List<ProductCategoryBean> findParentCategories();


}
