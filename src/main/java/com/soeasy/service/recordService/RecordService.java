package com.soeasy.service.recordService;

import java.util.List;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.RecordBean;

public interface RecordService {

			// 新增文章
			void addRecord(RecordBean recordBean);

			// 查詢一筆
			RecordBean findByRecordId(Integer recordId);
			
			// 查詢全部
			List<RecordBean> findAllByRecordId();
			
			// 修改
			void updateRecord(RecordBean recordBean);
			
			// 刪除
			void deleteByRecordId(Integer recordId);

			//由customerId查詢
			List<RecordBean> getCustomerId(CustomerBean customerBean);
			
			//由customerId查詢(依日期排序前10筆)
			List<RecordBean> getTop10CustomerId(CustomerBean customerBean);
}
