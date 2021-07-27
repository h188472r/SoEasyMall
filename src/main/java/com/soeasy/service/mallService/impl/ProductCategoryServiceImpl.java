package com.soeasy.service.mallService.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soeasy.model.ProductCategoryBean;
import com.soeasy.repository.mallRepository.ProductCategoryRepository;
import com.soeasy.service.mallService.ProductCategoryService;

@Transactional
@Service("ProductCategoryService")
public class ProductCategoryServiceImpl implements ProductCategoryService {
	
	
	@Autowired
	private ProductCategoryRepository productCategoryRepository;

	@Override
	public Iterable<ProductCategoryBean> findAll() {
		return productCategoryRepository.findAll();
	}

	@Override
	public List<ProductCategoryBean> findParentCategories() {
		return productCategoryRepository.findParentCategories() ;
	}

	@Override
	public ProductCategoryBean save(ProductCategoryBean category) {
		return productCategoryRepository.save(category);		
	}

	@Override
	public void delete(int productCategoryId) {
		productCategoryRepository.deleteById(productCategoryId);
	}

	@Override
	public ProductCategoryBean findByProductCategoryId(int productCategoryId) {
		return productCategoryRepository.findById(productCategoryId).get();

	}
	
	
	
	
	
	
	
	
	
//	@Override
//	public ProductCategoryBean saveCategory(ProductCategoryBean productCategory) {
//		// TODO Auto-generated method stub
//		return productCategoryRepository.save(productCategory) ;
//	}
//
//	@Override
//	public ProductCategoryBean getCategory(Integer productCategoryId) {
//		// TODO Auto-generated method stub
//		return productCategoryRepository.findById(productCategoryId).get();
//	}
//	
//	
//	@Override
//	public Page<ProductCategoryBean>listCategory(Pageable pageable){
//		return productCategoryRepository.findAll(pageable);
//
//	}
//
//	
//	// 刪除產品
//
//	@Override
//	public void deleteCategory(Integer productCategoryId) {
//	 productCategoryRepository.deleteById(productCategoryId);
//	}
//	
//	@Override
//	public ProductCategoryBean updateCategory(Integer productCategoryId,ProductCategoryBean productCategory) throws NotFoundException {
//		
//		ProductCategoryBean category=productCategoryRepository.findById(productCategoryId).get();
//		if(category==null) {
//			throw new NotFoundException("不存在該類型");
//		}
//		BeanUtils.copyProperties(productCategory, category);
//		return productCategoryRepository.save(category);
//			}
	
	
	
	
	

	

	
}
