package com.soeasy.service.nutritionistService.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.NutritionistBean;
import com.soeasy.repository.nutritionistRepository.NutritionistRepository;
import com.soeasy.service.nutritionistService.NutritionistService;
import com.soeasy.util.GlobalService;

@Transactional
@Service
public class NutritionistServiceImpl implements NutritionistService {

	// 建立Logger
	private static final Logger logger = LoggerFactory.getLogger(NutritionistServiceImpl.class);

	private int recordsPerPage = GlobalService.NUTRITIONISTS_PER_PAGE;
	private int totalPages = -1;

	@Autowired
	NutritionistRepository nutritionistRepository;

	public NutritionistServiceImpl() {
	}

	@Override
	public void addNutritionist(NutritionistBean nutritionistBean) {
		nutritionistRepository.save(nutritionistBean);
	}

	@Override
	public NutritionistBean findByNutritionistId(Integer nutritionistId) {
		Optional<NutritionistBean> opt = nutritionistRepository.findById(nutritionistId);
		NutritionistBean nutritionistBean = null;
		if (opt.isPresent()) {
			nutritionistBean = opt.get();
		} else {
			throw new RuntimeException("NutritionistBean(NutritionistId=" + nutritionistId + ")不存在");
		}
		return nutritionistBean;
	}

	@Override
	public List<NutritionistBean> findAllByNutritionistId() {
		return nutritionistRepository.findAll();
	}

	@Override
	public void updateNutritionist(NutritionistBean nutritionistBean) {
		nutritionistRepository.save(nutritionistBean);
	}

	@Override
	public void deleteByNutritionistId(Integer nutritionistId) {
		nutritionistRepository.deleteById(nutritionistId);
	}

	
	@Override
	public List<NutritionistBean> getAllPageNutritionist(int pageNo) {

		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage);
		Page<NutritionistBean> beans = nutritionistRepository.findAll(pageable);
		List<NutritionistBean> list = beans.getContent();

		return list;
	}

	@Override
	public Long getRecordCounts() {
		return nutritionistRepository.count();
	}

	@Override
	public Integer getTotalPages() {
		totalPages = (int) (Math.ceil(getRecordCounts() / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		return totalPages;
	}

}
