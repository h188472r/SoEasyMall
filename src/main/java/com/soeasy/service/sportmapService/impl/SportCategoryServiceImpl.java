package com.soeasy.service.sportmapService.impl;

import java.util.List;
import java.util.Optional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.repository.sportmapRepository.SportCategoryRepository;
import com.soeasy.service.sportmapService.SportCategoryService;
@Transactional
@Service
public class SportCategoryServiceImpl implements SportCategoryService {

	
	@Autowired
	SportCategoryRepository sportCategoryRepository;
	
	
	//撈出SportCategory by ID
	@Override
	public SportCategoryBean getSportCategory(Integer sportCategoryId) {
		Optional<SportCategoryBean> optional = sportCategoryRepository.findById(sportCategoryId);
		SportCategoryBean sportCategoryBean = null;
		//isPresent()判斷值存在就回傳true
		if(optional.isPresent()) { 
			sportCategoryBean = optional.get();
		} else {
			throw new RuntimeException("SportCategory(id="+sportCategoryId+")不存在");
		}
		return sportCategoryBean;
		
	}
	
	
	//取出所有SportCategory
	@Override
	public List<SportCategoryBean> getAllSportCategorys(){
		return (List<SportCategoryBean>) sportCategoryRepository.findAll();
	}

	//新增分類
	@Override
	public SportCategoryBean save(SportCategoryBean sportCategoryBean) {
				
		return sportCategoryRepository.save(sportCategoryBean);
	}

	//更新分類資料
	@Override
	public void updateSportCategory(SportCategoryBean sportCategoryBean) {
		sportCategoryRepository.save(sportCategoryBean);
	}

	//刪除單筆分類，連動分類底下所有地圖
	@Override
	public void deleteSportCategory(Integer sportCategoryId) {
		sportCategoryRepository.deleteById(sportCategoryId);
	}


	
	
	
}
