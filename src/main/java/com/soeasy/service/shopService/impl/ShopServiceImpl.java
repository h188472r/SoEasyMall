package com.soeasy.service.shopService.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soeasy.model.ProductBean;
import com.soeasy.model.ShopBean;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.repository.shopRepository.ShopRepository;
import com.soeasy.service.shopService.ShopService;

@Transactional
@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopRepository shopRepository;

	@Override
	public Boolean emailExists(String shopEmail) {
		List<ShopBean> shopBeans = shopRepository.findByShopEmail(shopEmail);
		if (shopBeans.size() > 0) {
			return true;
		}

		return false;
	}

	@Override
	public ShopBean checkEmailPassword(String shopEmail, String shopPassword) {
		ShopBean shopBean = null;
		List<ShopBean> shopBeans = shopRepository.findByShopEmailAndShopPassword(shopEmail, shopPassword);
		if (shopBeans.size() > 0) {
			shopBean = shopBeans.get(0);
		}
		return shopBean;
	}

	@Override
	public void addShop(ShopBean shop) {
		shopRepository.save(shop);
	}

	@Override
	public ShopBean findByShopId(Integer shopId) {
		return shopRepository.getById(shopId);
	}

	@Override
	public void updateShop(ShopBean shop) {
		shopRepository.save(shop);
	}

	@Override
	public void updateShopStatus(ShopBean shop, Integer shopStatus) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ShopBean> getAllShop() {
		return shopRepository.findAll();
	}

	@Override
	public List<ShopBean> getShopByStatus(Integer shopStatus) {
		return shopRepository.findByShopStatus(shopStatus);
	}
	
	
	//尋找訂單 by 顧客ID (前台給顧客用)
		public List<ProductBean> findAllwithProduct(Integer shopId){
			return shopRepository.findAllWithProduct(shopId);
		}
		
		
		
	//尋找相同店家的產品
		@Override
		public List<ProductBean> findByRelatedShop(Integer shopId){
			
			List<ProductBean> list = shopRepository.findAllWithProduct(shopId);	
			if(list.size()>=3) {
				List<ProductBean> newList = list.subList(0,3);
				return newList;
			}
			return list;
		}
		
	//以email查詢廠商會員
	@Override
	public List<ShopBean> findByShopEmail(String shopEmail) {
		return shopRepository.findByShopEmail(shopEmail);
	} 

	






	

}
