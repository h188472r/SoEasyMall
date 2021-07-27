package com.soeasy.repository.mallRepository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.soeasy.model.ProductBean;

public interface ProductRepository
		extends JpaRepository<ProductBean, Integer>,PagingAndSortingRepository<ProductBean, Integer> {

	// 產品模糊查詢
	// 如果使用concat 省略語法會有SQL指令轉換的問題(?
	@Query("SELECT p FROM ProductBean p WHERE p.productName Like %?1%" + " OR p.productPrice Like %?1%"
			+ " OR p.productId Like %?1%" + " OR p.productAmount Like %?1%" + " OR p.productDescription Like %?1%"
			+ " OR p.productCalories Like %?1%" + " OR p.productCategory Like %?1%" + " OR p.category Like %?1%"
			+ " OR p.productDate Like %?1%"
			+ " OR p.shopBean.shopName Like %?1%")
	public Page<ProductBean> findAll(String keyword, Pageable pageable);
	public List<ProductBean>findAll();
	
	//查詢分類，並會以分頁顯示
	public Page<ProductBean> findByCategory(Integer category, Pageable pageable);


	List<ProductBean> findByProductName(String productName);
	List<ProductBean> findBycategory(Integer category);

	

	
	

}