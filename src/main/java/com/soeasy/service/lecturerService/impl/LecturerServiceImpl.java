package com.soeasy.service.lecturerService.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.LecturerBean;
import com.soeasy.repository.lecturerRepository.LecturerRepository;
import com.soeasy.service.lecturerService.LecturerService;

@Transactional
@Service
public class LecturerServiceImpl implements LecturerService {
	
	@Autowired
	LecturerRepository lecturerRepository;

	public LecturerServiceImpl() {
	}

	// 新增講師
	@Override
	public LecturerBean addLecturer(LecturerBean lecturerBean) {
		return lecturerRepository.save(lecturerBean);
	}

	// 查詢一筆講師
	@Override
	public LecturerBean getOneByLecturerId(Integer lecturerId) {
		return lecturerRepository.getById(lecturerId);
	}

	// 查詢全部講師
	@Override
	public List<LecturerBean> getAllByLecturerId() {
		return lecturerRepository.findAll();
	}

	// 更新講師
	@Override
	public void updateLecturer(LecturerBean lecturerBean) {
		lecturerRepository.save(lecturerBean);
	}

	// 刪除講師
	@Override
	public void deleteLecturer(Integer lecturerId) {
		lecturerRepository.deleteById(lecturerId);
	}
}
