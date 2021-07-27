package com.soeasy.service.recordService.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.RecordBean;
import com.soeasy.repository.recordRepository.RecordRepository;
import com.soeasy.service.recordService.RecordService;

@Transactional
@Service
public class RecordServiceImpl implements RecordService {

	@Autowired
	RecordRepository recordRepository;

	public RecordServiceImpl() {
	}

	@Override
	public void addRecord(RecordBean recordBean) {
		recordRepository.save(recordBean);
	}

	@Override
	public RecordBean findByRecordId(Integer recordId) {
		Optional<RecordBean> opt = recordRepository.findById(recordId);
		RecordBean recordBean = null;
		if (opt.isPresent()) {
			recordBean = opt.get();
		} else {
			throw new RuntimeException("RecordBean(recordId=" + recordId + ")不存在");
		}
		return recordBean;
	}

	@Override
	public List<RecordBean> findAllByRecordId() {
		return recordRepository.findAll();
	}

	@Override
	public void updateRecord(RecordBean recordBean) {
		recordRepository.save(recordBean);
	}

	@Override
	public void deleteByRecordId(Integer recordId) {
		recordRepository.deleteById(recordId);
	}

	@Override
	public List<RecordBean> getCustomerId(CustomerBean customerBean) {
		Sort sort = Sort.by(Sort.Order.asc("recordDate"));
		
		List<RecordBean> list = recordRepository.findByCustomerBean(customerBean,sort);
		
		return list;
	}

	@Override
	public List<RecordBean> getTop10CustomerId(CustomerBean customerBean) {
		Sort sort = Sort.by(Sort.Order.asc("recordDate"));
		List<RecordBean> list = recordRepository.findByCustomerBean(customerBean,sort);
		
		if(list.size()>=10) {
			List<RecordBean> newList = list.subList(0,10);
			
			return newList;
			
		}
		return list;
	}

}
