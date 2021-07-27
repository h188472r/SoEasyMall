package com.soeasy.repository.lectureRepository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.LectureBean;

public interface LectureRepository extends JpaRepository<LectureBean, Integer> {

	List<LectureBean> findByLectureId(Integer lectureId);
	
	List<LectureBean> findByLectureCategory(String lectureCategory);
	
	List<LectureBean> findByLectureStatus(Integer lectureStatus, Sort sort);
	
}
