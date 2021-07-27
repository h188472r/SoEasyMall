package com.soeasy.service.shopService;

import java.util.List;

import com.soeasy.model.ProductBean;
import com.soeasy.model.ShopBean;
import com.soeasy.model.Order.OrderBean;

public interface ShopService {

	// 檢查email是否存在
	Boolean emailExists(String shopEmail);

	// 檢查帳密是否正確
	ShopBean checkEmailPassword(String shopEmail, String shopPassword);

	// 新增廠商會員
	void addShop(ShopBean shop);

	// ID查詢廠商會員
	ShopBean findByShopId(Integer shopId);
	
	// email查詢廠商會員
	List<ShopBean> findByShopEmail(String shopEmail);
	
	// 修改基本資料
	void updateShop(ShopBean shop);

	// 變更會員狀態
	void updateShopStatus(ShopBean shop, Integer shopStatus);
	
	//查詢所有廠商會員
	List<ShopBean> getAllShop();
	
	//以狀態查詢廠商
	List<ShopBean> getShopByStatus(Integer shopStatus);
	
	//前台
	public List<ProductBean> findAllwithProduct(Integer shopId);

	//印出相關店家產品
	List<ProductBean> findByRelatedShop(Integer shopId);
	

	
}
