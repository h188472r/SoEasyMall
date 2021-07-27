package com.soeasy.controller.recordController;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.RecordBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.recordService.RecordService;
import com.soeasy.validator.recordValidator.RecordValidator;

@Controller
@RequestMapping("/recordController")
@SessionAttributes({ "customerSignInSuccess" })
public class RecordController {

	@Autowired
	RecordService recordService;

	@Autowired
	CustomerService customerService;

	// 查詢全部日誌
	@GetMapping("/getAllRecords")
	public String DisplayRecord(Model model) {
		model.addAttribute("records", recordService.findAllByRecordId());
		return "/record/getAllRecords";
	}

//	// 查詢單日誌
//	@GetMapping(value = "/record/{recordId}")
//	public String getOneRecordById(@PathVariable("recordId") Integer recordId, Model model) {
//		RecordBean recordBean = recordService.findByRecordId(recordId);
//		model.addAttribute("recordBean", recordBean);
//		return "/record/recordIndex";
//	}

	// 由customerId查詢日誌
	@GetMapping(value = "/record/getRecordByCustomerId")
	public String getCustomerById(Model model) {
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		List<RecordBean> recordBean = recordService.getCustomerId(customerBean);
		model.addAttribute("recordBean", recordBean);
		return "/record/reordIndex";
	}

	// 由customerId查詢日誌(json)
	@GetMapping(value = "/record/getJsonRecordByCustomerId.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<RecordBean> getJsonCustomerById(Model model) {
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		CustomerBean recordCustomer = customerService.findByCustomerId(customerBean.getCustomerId());

		List<RecordBean> recordBean = recordService.getCustomerId(recordCustomer);

		return recordBean;
	}

	// 由customerId查詢日誌(依日期排序前10筆)
	@GetMapping(value = "/record/getTop10RecordByCustomerId.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<RecordBean> getTop10RecordByCustomerId(Model model) {
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		CustomerBean recordCustomer = customerService.findByCustomerId(customerBean.getCustomerId());

		List<RecordBean> top10record = recordService.getTop10CustomerId(recordCustomer);

		return top10record;
	}

	// 新增日誌，先送一個空白表單，並給予初值
	@GetMapping(value = "/addRecord")
	public String emptyRecord(Model model) {
		RecordBean recordBean = new RecordBean();
		// 預設表單資料
		recordBean.setRecordWeight(67.0);
		recordBean.setRecordHeight(192.0);
		recordBean.setRecordDate(new Date(System.currentTimeMillis()));
		model.addAttribute("recordBean", recordBean);

		return "/record/addRecord";
	}

	// 新增日誌
	@PostMapping(value = "/addRecord")
	public String addRecord(@ModelAttribute("nutritionistBean") RecordBean recordBean, BindingResult result,
			Model model, HttpServletRequest request) {

		// 檢測不正當欄位並回傳提示訊息
		RecordValidator validator = new RecordValidator();
		validator.validate(recordBean, result);
		if (result.hasErrors()) {
			return "/record/addRecord";
		}

		// 會員ID
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		System.out.println(customerBean);
		recordBean.setCustomerBean(customerBean);

		try {
			recordService.addRecord(recordBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "/record/addRecord";

		}

		return "redirect:/recordController/record/getRecordByCustomerId";
	}

	// 刪除日誌
	@PostMapping("/deleteRecord/{recordId}")
	public String deleteRecord(@PathVariable("recordId") Integer recordId) {
		recordService.deleteByRecordId(recordId);
		return "redirect:/recordController/record/getRecordByCustomerId";
	}

}
