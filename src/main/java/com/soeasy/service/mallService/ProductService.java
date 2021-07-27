package com.soeasy.service.mallService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.soeasy.model.PostBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.model.Order.OrderDetailBean;
import com.soeasy.repository.mallRepository.OrderDetailRepository;
import com.soeasy.repository.mallRepository.ProductRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	
	private OrderDetailRepository orderDetailRepository;

	
	
	// 新增.更新產品

	public ProductBean save(ProductBean product) {
		return productRepository.save(product);
	}
	
	
	
	
	
	

	//查詢分頁&排序 
	public Page<ProductBean> findAllByPage(int pageNumber,String sortField, String sortDir,String keyword, Integer category) {
		
		//設定分類排序
		Sort sort = Sort.by(sortField);
		sort = sortDir.equals("asc")?sort.ascending():sort.descending();

	     int pageSize = 12;//每頁會顯示15個產品
	     Pageable pageable = PageRequest.of(pageNumber - 1, pageSize,sort);// 顯示的方式
	     
	     //查詢關鍵字並連動分頁
	     if(keyword != null) {
				return productRepository.findAll(keyword,pageable);
			}
	     //查詢分類並連動分頁(如果分類的參數不是null)
	     if(category != null) {
	    	 return productRepository.findByCategory(category,pageable);
	     }
	     
	     return productRepository.findAll(pageable);
	}
	
	
	// 使用ID查詢一個產品

	public ProductBean findProductById(Integer productId) {
		return productRepository.findById(productId).get();
	}
	
	// 使用分類查詢一個產品
	
	public ProductBean findProductBycategory(Integer category) {
		return productRepository.findBycategory(category).get(category);
	}
	
	
	// 刪除產品
	public void deleteById(Integer productId) {
		productRepository.deleteById(productId);
	}

	//使用Name查詢產品
	public List<ProductBean> findByProductName(String productName) {
		return productRepository.findByProductName(productName);
	}
	

	// 使用ID查詢一個產品

		public List<ProductBean> findProductById1(Integer productId) {
			return (List<ProductBean>) productRepository.findById(productId).get();
		}

	public Object findAllProduct() {
		// TODO Auto-generated method stub
		return productRepository.findAll();
	}

	//尋找最新被訂購個產品  
		public List<OrderDetailBean> findNewestProduct(){
			List<OrderDetailBean> list = orderDetailRepository.findAll();	
			
			if(list.size()>=5) {
				List<OrderDetailBean> newList = list.subList(1,6);
				return newList;
			}
		
			return list;
		} 
		
		//尋找最新產品  (商品頁)
		public List<ProductBean> findNewProduct(){
			Sort sort = Sort.by(Sort.Order.desc("productId"));
			List<ProductBean> list = productRepository.findAll(sort);	
			
			if(list.size()>=5) {
				List<ProductBean> newList = list.subList(0,5);
				return newList;
			}
			
			return list;
		} 
		
		//尋找最新產品  (index)
		public List<ProductBean> findNewProduct3(){
			Sort sort = Sort.by(Sort.Order.desc("productId"));
			List<ProductBean> list = productRepository.findAll(sort);	
			
			if(list.size()>=5) {
				List<ProductBean> newList = list.subList(7,10);
				return newList;
			}
			
			return list;
		} 

		
		
		
		//尋找相同類別的產品
		public List<ProductBean> findByRelatedCategory(Integer category){
			
			List<ProductBean> list = productRepository.findBycategory(category);	
			if(list.size()>=4) {
				List<ProductBean> newList = list.subList(0,4);
				return newList;
			}
			if(list.size()==0) {
				List<ProductBean> noList = findProductById1(1) ;
				return noList;
			}
			
		
			
			return list;
		} 
	
		
		
		//以多個ID查詢多個商品
		public List<ProductBean> findAllById(List<Integer> productItemIds){
			return productRepository.findAllById(productItemIds);
		}
		
		//相同類別的產品(Nutritionist用)
		public List<ProductBean> findNutritionistByRelatedCategory(Integer category){
			List<ProductBean> list = productRepository.findBycategory(category);	
			return list;
		} 
}
