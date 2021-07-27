package com.soeasy.repository.lecturerRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.LecturerBean;

public interface LecturerRepository extends JpaRepository<LecturerBean, Integer> {

	List<LecturerBean> findByLecturerId(Integer lecturerId);
	
}
