package com.soeasy.service.mallService;

import java.util.List;

import com.soeasy.model.ProductCategoryBean;

public interface ProductCategoryService {
	
//	ProductCategoryBean saveCategory(ProductCategoryBean productCategory);
//	ProductCategoryBean getCategory(Integer productCategoryId);
//		
//	void deleteCategory(Integer productCategory);
//	
//	Page<ProductCategoryBean> listCategory(Pageable pageable);
//	
//	ProductCategoryBean updateCategory(Integer productCategoryId, ProductCategoryBean productCategory) throws NotFoundException;
//	
	
	public Iterable<ProductCategoryBean> findAll();
	public List<ProductCategoryBean> findParentCategories();
	public ProductCategoryBean save(ProductCategoryBean category);
	public ProductCategoryBean findByProductCategoryId(int productCategoryId);
	public void delete(int productCategoryId);

	
}
