package com.soeasy.service.favoriteService;

import java.util.List;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;


public interface FavoriteService {
	public void addFavorite(FavoriteBean favoriteBean);
	
	public FavoriteBean checkFavoriteBean(Integer favoriteItemId, String favoriteCategory, CustomerBean customerBean);
	
	public void removeFavorite(Integer favoriteId);
	
	public List<FavoriteBean> findByCategory(String favoriteCategory);
	
	public List<FavoriteBean> findByFavoriteItemIdAndFavoriteCategory(Integer favoriteItemId, String favoriteCategory);
	
	public List<FavoriteBean> findByCategoryAndCustomer(String favoriteCategory, CustomerBean customerBean);
		
	public Integer countFavoriteItemIdAndFavoriteCategory(Integer favoriteItemId, String favoriteCategory);
}
