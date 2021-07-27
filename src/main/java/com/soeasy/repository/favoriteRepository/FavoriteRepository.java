package com.soeasy.repository.favoriteRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;

public interface FavoriteRepository extends JpaRepository<FavoriteBean, Integer>{
	
	public FavoriteBean findByFavoriteItemIdAndFavoriteCategoryAndCustomerBean(Integer favoriteItemId, String favoriteCategory, CustomerBean customerBean);

	public List<FavoriteBean> findByFavoriteItemIdAndFavoriteCategory(Integer favoriteItemId, String favoriteCategory);
	
	public List<FavoriteBean> findByFavoriteCategory(String favoriteCategory);
	
	public List<FavoriteBean> findByFavoriteCategoryAndCustomerBean(String favoriteCategory, CustomerBean customerBean);
		
}
