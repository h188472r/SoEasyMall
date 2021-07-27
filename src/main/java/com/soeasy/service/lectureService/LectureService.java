package com.soeasy.service.lectureService;

import java.util.List;

import com.soeasy.model.LectureBean;
import com.soeasy.model.NutritionistBean;

public interface LectureService {

	// 新增講座
	LectureBean addLecture(LectureBean lectureBean);

	// 查詢一筆
	LectureBean getOneByLectureId(Integer lectureId);

	// 查詢全部講座
	List<LectureBean> getAllByLectureId();

	// 修改
	void updateLecture(LectureBean lectureBean);

	// 刪除
	void deleteLecture(Integer lectureId);

	// 依據講座日期更新講座狀態
	List<LectureBean> updateLectureStatus();

	// 依據講座狀態自動進入輪播
	List<LectureBean> findByLectureStatus(Integer lectureStatus);

	// 查詢全部(有分頁)
	List<LectureBean> getAllPageLecture(Integer pageNo);

	Long getRecordCounts();

	Integer getTotalPages();
}
