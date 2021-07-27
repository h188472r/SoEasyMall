package com.soeasy.service.lectureService.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.LectureCategoryBean;
import com.soeasy.repository.lectureRepository.LectureCategoryRepository;
import com.soeasy.service.lectureService.LectureCategoryService;


@Transactional
@Service
public class LectureCategoryServiceImpl implements LectureCategoryService{

	@Autowired
	LectureCategoryRepository lectureCategoryRepository;
	
	@Override
	public LectureCategoryBean getLectureCategory(Integer lectureCategoryId) {
		Optional<LectureCategoryBean> lecture=lectureCategoryRepository.findById(lectureCategoryId);
		LectureCategoryBean lectureCategoryBean =null;
		if(lecture.isPresent()) {
			lectureCategoryBean=lecture.get();
		}else {
			throw new RuntimeException("SportCategory(id="+lectureCategoryId+")不存在");
		}
		return lectureCategoryBean;
	}

	@Override
	public List<LectureCategoryBean> getAllLectureCategories() {
		return (List<LectureCategoryBean>) lectureCategoryRepository.findAll();
	}
}
