package com.soeasy.service.favoriteService.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.repository.favoriteRepository.FavoriteRepository;
import com.soeasy.service.favoriteService.FavoriteService;

@Transactional
@Service
public class FavoriteServiceImpl implements FavoriteService {

	@Autowired
	FavoriteRepository favoriteRepository;

	@Override
	public void addFavorite(FavoriteBean favoriteBean) {
		favoriteRepository.save(favoriteBean);
	}

	@Override
	public FavoriteBean checkFavoriteBean(Integer favoriteItemId, String favoriteCategory, CustomerBean customerBean) {
		return favoriteRepository.findByFavoriteItemIdAndFavoriteCategoryAndCustomerBean(favoriteItemId,
				favoriteCategory, customerBean);
	}

	@Override
	public void removeFavorite(Integer favoriteId) {
		favoriteRepository.deleteById(favoriteId);
	}

	@Override
	public List<FavoriteBean> findByCategory(String favoriteCategory) {
		return favoriteRepository.findByFavoriteCategory(favoriteCategory);
	}

	@Override
	public List<FavoriteBean> findByFavoriteItemIdAndFavoriteCategory(Integer favoriteItemId, String favoriteCategory) {
		return favoriteRepository.findByFavoriteItemIdAndFavoriteCategory(favoriteItemId, favoriteCategory);
	}

	@Override
	public Integer countFavoriteItemIdAndFavoriteCategory(Integer favoriteItemId, String favoriteCategory) {

		List<FavoriteBean> favoriteBeans = favoriteRepository.findByFavoriteItemIdAndFavoriteCategory(favoriteItemId,
				favoriteCategory);
		Integer count = null;
		if (favoriteBeans == null) {
			count = 0;
		} else {
			count = favoriteBeans.size();
		}
		return count;
	}

	@Override
	public List<FavoriteBean> findByCategoryAndCustomer(String favoriteCategory, CustomerBean customerBean) {
		return favoriteRepository.findByFavoriteCategoryAndCustomerBean(favoriteCategory, customerBean);
	}


}
