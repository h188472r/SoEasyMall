package com.soeasy.service.sportmapService.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;
import com.soeasy.repository.sportmapRepository.SportMapRepository;
import com.soeasy.service.sportmapService.SportMapService;
import com.soeasy.util.GlobalService;

@Service
@Transactional
public class SportMapServiceImpl implements SportMapService {
	private static final Logger logger = LoggerFactory.getLogger(SportMapServiceImpl.class);

	private int recordsPerPage = GlobalService.SPORTMAPS_PER_PAGE; // 預設值：每頁9筆
	private int totalPages = -1;

	@Autowired
	SportMapRepository sportMapRepository;
	
	
	//新增地圖
	@Override
	public SportMapBean save(SportMapBean sportMapBean) {
		return sportMapRepository.save(sportMapBean);
	}		
	
	//查詢單一地圖ByID
	@Override
	public SportMapBean get(Integer sportMapId) {
		Optional<SportMapBean> optional =sportMapRepository.findById(sportMapId);
		SportMapBean sportMapBean = null;
		if(optional.isPresent()) {
			sportMapBean = optional.get();
		}else {
			throw new RuntimeException("SportMapBean(sportMadId="+sportMapId+")不存在");
			
		}
		System.out.println("service ID="+sportMapId);
		return sportMapBean ;
	}

	//查詢所有地圖，帶分頁
	@Transactional
	@Override
	public Map<Integer, SportMapBean> getPageSportMaps(int pageNo) {

		Map<Integer, SportMapBean> map = new LinkedHashMap<>();
		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage);
		Page<SportMapBean> beans = sportMapRepository.findAll(pageable);

		List<SportMapBean> list = beans.getContent();
		for (SportMapBean bean : list) {
			map.put(bean.getSportMapId(), bean);
		}
		return map;
	}
	
	// 抓資料庫裡全部有幾個地圖(搭配查詢所有地圖，帶分頁用)
	@Override
	public Long getRecordCounts() {		
		return sportMapRepository.count();
	}

	// 總共有幾頁(搭配查詢所有地圖，帶分頁用)
	@Transactional
	@Override
	public Integer getTotalPages() {
		totalPages = (int) (Math.ceil(getRecordCounts() / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		return totalPages;		

	}	
	
	//更新地圖資料
	@Transactional
	@Override
	public void update(SportMapBean sportMapBean) {
		sportMapRepository.save(sportMapBean);
	}	
		
	
	//刪除單筆地圖
	@Override
	public void delete(Integer sportMapId) {
		sportMapRepository.deleteById(sportMapId);
	}
	
	//查詢所有地圖
	@Override
	public List<SportMapBean> getAllSportMaps() {
	return sportMapRepository.findAll();
	}

	// 抓分頁一頁有哪些地圖，依照SportCategoryId(SportMapBean裡SportCategoryId欄位名稱為SportCategoryBean)
	@Override
	public Map<Integer, SportMapBean> getPageSportMapsBySportCategoryId(SportCategoryBean SportCategoryBean, Integer pageNo) {
		Map<Integer, SportMapBean> map = new LinkedHashMap<>();
		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage);
		Page<SportMapBean> beans = sportMapRepository.findBySportCategoryBean(SportCategoryBean,pageable);

		List<SportMapBean> list = beans.getContent();
		for (SportMapBean bean : list) {
			map.put(bean.getSportMapId(), bean);
		}
		return map;
	}
	
	// 抓資料庫一個分類裡有幾個地圖(搭配抓分頁一頁有哪些地圖，依照SportCategoryId用)
	@Transactional
	@Override
	public Long getRecordCountsBySportCategoryId(SportCategoryBean sportCategoryBean) {
		System.out.println("第二關收到進來的sportCategoryBean="+sportCategoryBean);
		return sportMapRepository.countBySportCategoryBean(sportCategoryBean);
	}


	// 一個分類總共有幾頁(搭配抓分頁一頁有哪些地圖，依照SportCategoryId用)
	@Transactional
	@Override
	public Integer getTotalPagesBySportCategoryId(SportCategoryBean sportCategoryBean) {
		System.out.println("第一關進來的sportCategoryBean="+sportCategoryBean);
		totalPages = (int) (Math.ceil(getRecordCountsBySportCategoryId(sportCategoryBean) / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		System.out.println("印出來的totalPages="+totalPages);
		return totalPages;		

	}
	
	//給特定分數撈出特定分數的前3筆
	@Override
	public List<SportMapBean> findFirst3BySportMapScore(Integer sportMapScore, Sort sort) {
		return sportMapRepository.findFirst3BySportMapScore(sportMapScore, sort);
	}

	//給特定分數撈出特定分數的前3筆
	@Override
	public List<SportMapBean> findTop3BySportMapScore(Integer sportMapScore, Sort sort) {
		return sportMapRepository.findTop3BySportMapScore(sportMapScore, sort);
	}

	//查詢所有地圖裡的前3筆，依照地圖分數降冪排序
	@Override
	public List<SportMapBean> findTop3ByOrderBySportMapScoreDesc() {
		return sportMapRepository.findTop3ByOrderBySportMapScoreDesc();
	}

	//抓分頁一頁有哪些地圖，依照區域(地址關鍵字)
	@Override
	public Map<Integer, SportMapBean> getPageSportMapsBySportMapAddress(String sportMapAddress, Integer pageNo) {
		Map<Integer,SportMapBean> map = new LinkedHashMap<>();
		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage);
		Page<SportMapBean> beans = sportMapRepository.findBySportMapAddressContaining(sportMapAddress, pageable);
		
		List<SportMapBean> list = beans.getContent();
		for(SportMapBean bean : list) {
			map.put(bean.getSportMapId(), bean);
		}
		return map;
	}

	// 抓資料庫依照區域(地址關鍵字)裡有幾個地圖(搭配抓分頁一頁有哪些地圖，依照區域(地址關鍵字))
	@Override
	public Long getRecordCountsBySportMapAddress(String sportMapAddress) {
		System.out.println("第二關收到進來的SportMapAddress="+sportMapAddress);
		return sportMapRepository.countBySportMapAddressContaining(sportMapAddress);
	}
	
	// 抓依照區域(地址關鍵字)總共有幾頁(搭配抓分頁一頁有哪些地圖，依照區域(地址關鍵字))
	@Override
	public Integer getTotalPagesByBySportMapAddress(String sportMapAddress) {
		System.out.println("第一關進來的SportMapAddress="+sportMapAddress);
		totalPages = (int) (Math.ceil(getRecordCountsBySportMapAddress(sportMapAddress) / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		System.out.println("印出來的totalPages="+totalPages);
		return totalPages;	
	}

	//以多個Id查詢多張地圖
	@Override
	public List<SportMapBean> findAllById(List<Integer> sportMapIds) {
		return sportMapRepository.findAllById(sportMapIds);
	}
	
	
	

		

	
		
		

	
	
	
	
	

}
