package com.soeasy.service.lecturerService;

import java.util.List;

import com.soeasy.model.LecturerBean;

public interface LecturerService {
	
	//新增講師
	LecturerBean addLecturer(LecturerBean lecturerBean);

	//查詢一筆
	LecturerBean getOneByLecturerId(Integer lecturerId);

	//查詢全部
	List<LecturerBean> getAllByLecturerId();

	//修改
	void updateLecturer(LecturerBean lecturerBean);

	//刪除
	void deleteLecturer(Integer lecturerId);
}
