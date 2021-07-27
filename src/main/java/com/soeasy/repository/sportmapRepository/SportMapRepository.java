package com.soeasy.repository.sportmapRepository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;


public interface SportMapRepository extends JpaRepository<SportMapBean, Integer> {

//	@Query("SELECT DISTINCT sportMapCategory FROM SportMapBean")
//	List<String> findDistinctCategory();
	
	// 抓分頁一頁有哪些地圖，依照SportCategoryId(SportMapBean裡SportCategoryId欄位名稱為SportCategoryBean)
	Page<SportMapBean> findBySportCategoryBean(SportCategoryBean SportCategoryBean,Pageable pageable);
	
	//抓一個分類裡有多少個地圖總數(搭配抓分頁一頁有哪些地圖，依照SportCategoryId用)	
	Long countBySportCategoryBean(SportCategoryBean sportCategoryBean);

	//給特定分數撈出特定分數的前3筆
	List<SportMapBean>findFirst3BySportMapScore(Integer sportMapScore,  Sort sort);
	
	//給特定分數撈出特定分數的前3筆
	List<SportMapBean>findTop3BySportMapScore(Integer sportMapScore,  Sort sort);

	//查詢所有地圖裡的前3筆，依照地圖分數降冪排序
	List<SportMapBean>findTop3ByOrderBySportMapScoreDesc();
	
	//抓分頁一頁有哪些地圖，依照區域(地址關鍵字)，Query可不用寫也會動
	@Query(value = "select s from SportMapBean s where s.sportMapAddress like %:sportMapAddress%")
	Page<SportMapBean> findBySportMapAddressContaining(String sportMapAddress,Pageable pageable);
		 
	//抓依照區域(地址關鍵字)裡有多少個地圖總數(搭配抓分頁一頁有哪些地圖，依照區域(地址關鍵字))	
	Long countBySportMapAddressContaining(String sportMapAddress);

}
	

