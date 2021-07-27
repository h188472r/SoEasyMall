package com.soeasy.controller.adminController.adminManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.soeasy.service.recordService.RecordService;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminRecord {
	
	@Autowired
	RecordService recordService;
	
	@GetMapping("/adminRecord")
	public String DisplayRecord(Model model) {
		model.addAttribute("records", recordService.findAllByRecordId());
		return "/admin/adminRecord/adminAllRecords";
	}
}
