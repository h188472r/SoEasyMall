package com.soeasy.service.sportmapService;

import java.util.List;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;

public interface SportCategoryService {
	
	//撈出SportCategory by ID
	SportCategoryBean getSportCategory(Integer sportCategoryId);
	
	//取出所有SportCategory
	List<SportCategoryBean> getAllSportCategorys();

	//新增分類
	SportCategoryBean save(SportCategoryBean sportCategoryBean);

	//更新分類資料
	void updateSportCategory(SportCategoryBean sportCategoryBean);
	
	//刪除單筆分類，連動底下分類裡所有地圖
	void deleteSportCategory(Integer sportCategoryId);
}
