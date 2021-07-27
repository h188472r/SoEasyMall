package com.soeasy.service.lectureService;

import java.util.List;

import com.soeasy.model.LectureCategoryBean;

public interface LectureCategoryService {
	
	//撈出LectureCategory by ID
	LectureCategoryBean getLectureCategory(Integer lectureCategoryId);
	
	//取出所有NutritionistCategory
	List<LectureCategoryBean> getAllLectureCategories();
}
