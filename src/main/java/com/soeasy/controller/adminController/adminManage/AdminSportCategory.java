package com.soeasy.controller.adminController.adminManage;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.service.sportmapService.SportCategoryService;
import com.soeasy.service.sportmapService.SportMapService;
import com.soeasy.validator.sportMapValidator.SportCategoryBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminSportCategory {

	@Autowired
	SportMapService sportMapService;
	
	@Autowired
	SportCategoryService sportCategoryService;
	
	
	//顯示所有分類(後台分類首頁)
	@GetMapping("/adminSportCategory")
	public String list(Model model) {
	model.addAttribute("sportCategorys",sportCategoryService.getAllSportCategorys());
	return "admin/adminSportMap/adminSportCategory";
			
	}
	
	
	//帶出分類修改單一表單(後台用)
	@GetMapping(value="/adminSportCategory/up/{sportCategoryId}")
	public String showOneCategoty(@PathVariable("sportCategoryId") Integer sportCategoryId,Model model) {
	SportCategoryBean sportCategoryBean = sportCategoryService.getSportCategory(sportCategoryId);			
	model.addAttribute("sportCategoryBean",sportCategoryBean);
	return "admin/adminSportMap/adminUpdateSportCategory"; //帶出修改資料
	}
	
	
	//修改分類，將修改過的資料由本方法檢核，若無誤則寫入資料庫(後台用)
	@PostMapping("/adminSportCategory/up/{sportCategoryId}")
	public String modify(
	@ModelAttribute("sportCategoryBean")SportCategoryBean sportCategoryBean,
	BindingResult result,Model model,@PathVariable Integer sportCategoryId,
	HttpServletRequest request) {
						
	//檢驗欄位內容(檢驗分類名稱不能為空白)
	SportCategoryBeanValidator validator = new SportCategoryBeanValidator();
	validator.validate(sportCategoryBean,result);
	if(result.hasErrors()) {
					
	return "admin/adminSportMap/adminUpdateSportCategory";	

	}	
				
	sportCategoryService.updateSportCategory(sportCategoryBean);

	//跳轉至後台所有運動地點頁面
	return "redirect:/admin/adminManage/adminSportCategory"; 
	}
		
	
	//新增分類，先送一個空白表單(後台用)
	@GetMapping(value = "/adminSportCategory/add")
	public String showEmptyForm(Model model) {
		SportCategoryBean sportCategoryBean = new SportCategoryBean();
		//預設表單資料
		sportCategoryBean.setSportCategoryName("其他場地");		
		model.addAttribute("sportCategoryBean", sportCategoryBean);
		
		return "admin/adminSportMap/adminAddSportCategory";	
	}
	
	
	//新增分類(後台用)
	@PostMapping(value = "/adminSportCategory/add")
	public String add(@ModelAttribute("sportCategoryBean") 
	SportCategoryBean sportCategoryBean,BindingResult result,
	Model model,HttpServletRequest request){
		//檢驗欄位內容
		SportCategoryBeanValidator validator = new SportCategoryBeanValidator();
		validator.validate(sportCategoryBean,result);
		if(result.hasErrors()) {
			
			return "admin/adminSportMap/adminAddSportCategory";	

		}		
			try {
			sportCategoryService.save(sportCategoryBean);
			
		}catch (org.hibernate.exception.ConstraintViolationException e) {
			result.rejectValue("sportCategoryName", "", "名稱已存在，請重新輸入");
			return "admin/adminSportMap/adminAddSportCategory";	
			
		}
		//跳轉至後台所有運動地點頁面
		return "redirect:/admin/adminManage/adminSportCategory"; 
		
	}
	
	//刪除單筆分類(當初未設定到單向的關聯，變成分類底下有資料必須先刪除資料才能刪除分類，不然會報錯)
	@PostMapping("/adminSportCategory/del/{sportCategoryId}")
	public String delete(@PathVariable("sportCategoryId") Integer sportCategoryId) {
		sportCategoryService.deleteSportCategory(sportCategoryId);
				
		//跳轉至後台所有運動地點頁面
		return "redirect:/admin/adminManage/adminSportCategory"; 
			}
			
	
	
	
	
	
}
