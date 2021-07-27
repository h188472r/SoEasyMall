package com.soeasy.repository.lectureRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.LectureCategoryBean;

public interface LectureCategoryRepository extends JpaRepository<LectureCategoryBean, Integer> {

}
