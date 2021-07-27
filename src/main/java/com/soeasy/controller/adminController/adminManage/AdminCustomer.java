package com.soeasy.controller.adminController.adminManage;

import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.CustomerBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.util.GlobalService;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminCustomer {
	
	@Autowired
	CustomerService customerService;
	
	//會員
	@GetMapping({"/adminCustomer"})
	public String admin() {
		return "/admin/adminCustomer/adminCustomer";
	}
	
	//取得所有會員(ajax)
	@GetMapping(value = "/adminCustomer/getAllCustomer.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<CustomerBean> getAllCustomer(){
		List<CustomerBean> customerBeans = customerService.getAllCustomer();
		for (CustomerBean customerBean : customerBeans) {
			System.out.println(customerBean.getCustomerId());
		}
		return customerBeans;
	}
	
	//以過濾取得會員(ajax)
	@GetMapping(value = "/adminCustomer/getCustomerByStatus.json/{customerCategory}/conf/{customerStatus}", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<CustomerBean> getCustomerByFilterStatus(@PathVariable("customerCategory") String customerCategory, @PathVariable("customerStatus") String customerStatus){
		List<CustomerBean> customerBeans = null;
		if(customerCategory.equals("all") && customerStatus.equals("all")) {
			customerBeans = customerService.getAllCustomer();
		}else if(customerCategory.equals("all") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStastus(GlobalService.CUSTOMER_STATUS_NORMAL);				
		}else if (customerCategory.equals("all") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStastus(GlobalService.CUSTOMER_STATUS_BANNED);
		}else if(customerCategory.equals("male") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByGender(GlobalService.CUSTOMER_GENDER_MALE);
		}else if(customerCategory.equals("male") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndGender(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_GENDER_MALE);
		}else if(customerCategory.equals("male") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndGender(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_GENDER_MALE);
		}else if(customerCategory.equals("female") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByGender(GlobalService.CUSTOMER_GENDER_FEMALE);	
		}else if(customerCategory.equals("female") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndGender(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_GENDER_FEMALE);
		}else if(customerCategory.equals("female") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndGender(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_GENDER_FEMALE);
		}else if(customerCategory.equals("meat") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByDiet(GlobalService.CUSTOMER_DIET_MEAT);
		}else if(customerCategory.equals("meat") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndDiet(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_DIET_MEAT);
		}else if(customerCategory.equals("meat") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndDiet(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_DIET_MEAT);
		}else if(customerCategory.equals("vegetable") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByDiet(GlobalService.CUSTOMER_DIET_VAGETABLE);
		}else if(customerCategory.equals("vegetable") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndDiet(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_DIET_VAGETABLE);
		}else if(customerCategory.equals("vegetable") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndDiet(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_DIET_VAGETABLE);
		}else if(customerCategory.equals("strong") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByExercise(GlobalService.CUSTOMER_EXERCISE_STRONG);
		}else if(customerCategory.equals("strong") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_EXERCISE_STRONG);
		}else if(customerCategory.equals("strong") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_EXERCISE_STRONG);
		}else if(customerCategory.equals("normal") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByExercise(GlobalService.CUSTOMER_EXERCISE_NORMAL);
		}else if(customerCategory.equals("normal") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_EXERCISE_NORMAL);
		}else if(customerCategory.equals("normal") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_EXERCISE_NORMAL);
		}else if(customerCategory.equals("weak") && customerStatus.equals("all")) {
			customerBeans = customerService.getCustomerByExercise(GlobalService.CUSTOMER_EXERCISE_WEAK);
		}else if(customerCategory.equals("weak") && customerStatus.equals("active")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_NORMAL, GlobalService.CUSTOMER_EXERCISE_WEAK);
		}else if(customerCategory.equals("weak") && customerStatus.equals("disabled")) {
			customerBeans = customerService.getCustomerByStatusAndExercise(GlobalService.CUSTOMER_STATUS_BANNED, GlobalService.CUSTOMER_EXERCISE_WEAK);
		}
		
		return customerBeans;
	}
	
//	透過ID修改會員基本資料
	@PostMapping(value = "/adminUpdateCustomerInfo", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> adminUpdateCustomerInfo(@RequestBody CustomerBean updateCustomerBean) {
		//以傳入的ID搜尋原始的會員物件
		CustomerBean originalCustomer = customerService.findByCustomerId(updateCustomerBean.getCustomerId());
		
		//更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();
		
		if(updateCustomerBean.getCustomerName() == null) {
			updateMessage.put("updateErrorNameMessage", "名字不得為空");
		}
		if(updateCustomerBean.getCustomerEmail() == null) {
			updateMessage.put("updateErrorEmailMessage", "信箱不得為空");
		}
		//為原始物件設定傳入的欄位值
		originalCustomer.setCustomerName(updateCustomerBean.getCustomerName());
		originalCustomer.setCustomerStatus(updateCustomerBean.getCustomerStatus());
		originalCustomer.setCustomerEmail(updateCustomerBean.getCustomerEmail());
		originalCustomer.setCustomerPhone(updateCustomerBean.getCustomerPhone());
		originalCustomer.setCustomerNickname(updateCustomerBean.getCustomerNickname());
		originalCustomer.setCustomerScore(updateCustomerBean.getCustomerScore());
		originalCustomer.setCustomerBirthDay(updateCustomerBean.getCustomerBirthDay());
		
		
		//save原始物件
		customerService.updateCustomer(originalCustomer);
		
		//更新成功訊息
		updateMessage.put("updateSuccessMessage", "更新成功");
		return updateMessage;
	}
	
//	透過ID修改會員健康資料
	@PostMapping(value = "/adminUpdateCustomerHealthInfo", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> UpdateCustomerHealthInfo(@RequestBody CustomerBean updateCustomerBean) {
		//以傳入的ID搜尋原始的會員物件
		CustomerBean originalCustomer = customerService.findByCustomerId(updateCustomerBean.getCustomerId());
		
		//更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();
		
		if(updateCustomerBean.getCustomerName() == null) {
			updateMessage.put("updateErrorNameMessage", "名字不得為空");
		}
		
		//為原始物件設定傳入的欄位值
		originalCustomer.setCustomerName(updateCustomerBean.getCustomerName());
		originalCustomer.setCustomerHealthBean(updateCustomerBean.getCustomerHealthBean());
		
		
		//save原始物件
		customerService.updateCustomer(originalCustomer);
		
		//更新成功訊息
		updateMessage.put("updateSuccessMessage", "更新成功");
		return updateMessage;
	}
	
	//上傳個人頭像
	@PostMapping(value = "/adminUploadCustomerImg")
	public String adminUploadCustomerImg(@RequestParam("customerImgUploadId") Integer customerId, @RequestParam("customerImgUpload")MultipartFile customerMultiImg) {
				
		CustomerBean originalCustomer = customerService.findByCustomerId(customerId);
//		//更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();
		
		//處理圖片MultipartFile --> Blob
		if(customerMultiImg != null && !customerMultiImg.isEmpty()) {
			try {
				byte[] bImg = customerMultiImg.getBytes();
				Blob blob = new SerialBlob(bImg);
				originalCustomer.setCustomerImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
				
		//save原始物件
		customerService.updateCustomer(originalCustomer);
		updateMessage.put("updateSuccessMessage", "圖片更新成功");
		return "/admin/adminCustomer/adminCustomer";
	}
}
