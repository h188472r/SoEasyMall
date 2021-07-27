package com.soeasy.controller.adminController.adminManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;
import com.soeasy.service.sportmapService.SportCategoryService;
import com.soeasy.service.sportmapService.SportMapService;
import com.soeasy.validator.sportMapValidator.SportMapBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminSportMap {
	
	@Autowired
	SportMapService sportMapService;
	
	@Autowired
	SportCategoryService sportCategoryService;
	
		
	//顯示所有地圖(後台首頁)
	@GetMapping("/adminSportMap")
		public String list(Model model,HttpServletRequest request, HttpServletResponse response,
				@RequestParam(value = "pageNo", required = false) Integer pageNo) {
		if (pageNo == null) {
			pageNo = 1;     //網址加?pageNo=測試
			}	
		Map<Integer,SportMapBean> sportsMap = sportMapService.getPageSportMaps(pageNo);
		model.addAttribute("pageNo", String.valueOf(pageNo));
		model.addAttribute("totalPages", sportMapService.getTotalPages());
			
		model.addAttribute("sportMaps",sportsMap);
			return "admin/adminSportMap/adminSportMap";
		
		}
	
	
//	//顯示所有地圖(未用到，改有分頁)
//		@GetMapping("/adminSportMap")
//			public String list(Model model) {
//				model.addAttribute("sportMaps",sportMapService.getAllSportMaps());
//				return "admin/adminSportMap/adminSportMap";
//			
//			}
	
	//查詢單一ById
	@GetMapping("/adminSportMap/search/{sportMapId}")
	public String searchOne(@PathVariable("sportMapId") Integer sportMapId,Model model) {
		SportMapBean sportMapBean = sportMapService.get(sportMapId);			
		model.addAttribute("sportMapBean",sportMapBean);
		
		return "admin/adminSportMap/searchSportMap";
	
	}	
	
	
	//Ajax顯示所有地圖(未用到，未測試)
	@GetMapping(value="/getAllSportMaps.json",produces={ "application/json; charset=UTF-8" })
	public@ResponseBody Map<String,Object> getAllSportMaps(){		
			Map<String,Object> map = new HashMap<>();
			List<SportMapBean> list = sportMapService.getAllSportMaps();
			map.put("list", list);
			
			return map;
		
	}
	
	//帶出地圖修改前單一表單(後台用)
	@GetMapping(value="/adminSportMap/up/{sportMapId}")
	public String showOneMap(@PathVariable("sportMapId") Integer sportMapId,Model model) {
	SportMapBean sportMapBean = sportMapService.get(sportMapId);			
	model.addAttribute("sportMapBean",sportMapBean);
	return "admin/adminSportMap/adminUpdateSportMap"; //帶出修改資料
		    
	}
	
	
	//修改運動地點，將送來修改過的資料用本方法檢核，若無誤則寫入資料庫(後台用)
	@PostMapping("/adminSportMap/up/{sportMapId}")
	public String modify(
	@ModelAttribute("sportMapBean")SportMapBean sportMapBean,
	BindingResult result,Model model,@PathVariable Integer sportMapId,
	HttpServletRequest request) {
						
	//檢驗欄位內容(檢驗幾項欄位不能為空)
	SportMapBeanValidator validator = new SportMapBeanValidator();
	validator.validate(sportMapBean,result);
	if(result.hasErrors()) {
					
	return "admin/adminSportMap/adminUpdateSportMap";	

	}	
				
	//找到對應的Category物件(帶出分類欄位)
	SportCategoryBean sportCategoryBean = sportCategoryService.getSportCategory(sportMapBean.getSportCategoryBean().getSportCategoryId());
	sportMapBean.setSportCategoryBean(sportCategoryBean);
				
	sportMapService.update(sportMapBean);

	//跳轉至後台所有運動地點頁面
	return "redirect:/admin/adminManage/adminSportMap"; 
	}
	
	
	
	//新增運動地點，先送一個空白表單(後台)
	@GetMapping(value = "/adminSportMap/add")
	public String showEmptyForm(Model model) {
	SportMapBean sportMapBean = new SportMapBean();
	//預設表單資料
	sportMapBean.setSportMapName("新店國民運動中心");
	sportMapBean.setSportMapAddress("231新北市新店區北新路一段88巷12號");
	sportMapBean.setSportMapInfo("由長佳機電工程股份有限公司取得OT經營權，本中心鄰近捷運綠線(新店區公所)，除了擁有25M游泳池、體適能中心、綜合球場..之外，更增設[兒童體操專門教室]，期望打造兒童運動的安全環境，並提供市民一個健康休閒的新去處");
	sportMapBean.setSportMapScore(20);
//	sportMapBean.setSportMapCategory(1);
//	sportMapBean.setSportMapMap("<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7233.937528051018!2d121.54247222964078!3d24.967177355169582!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34680192061b03d5%3A0x3c613171e5e81235!2z5paw5YyX5biC5paw5bqX5ZyL5rCR6YGL5YuV5Lit5b-D!5e0!3m2!1szh-TW!2stw!4v1625132585222!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>");
	//用Google embed Maps Api金鑰產生iframe
	sportMapBean.setSportMapMap("<iframe width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0\" src=\"https://www.google.com/maps/embed/v1/place?key=AIzaSyAslkjoKdTG8kP9v47BpOssCN7VQ20oAFE&q=新店國民運動中心\" allowfullscreen></iframe>");
	
	model.addAttribute("sportMapBean", sportMapBean);
			
	return "admin/adminSportMap/adminAddSportMap";	
	}
		
		
	//新增運動地點(後台用)
	@PostMapping(value = "/adminSportMap/add")
	public String add(@ModelAttribute("sportMapBean") 
	SportMapBean sportMapBean,BindingResult result,
	Model model,HttpServletRequest request){
	//檢驗欄位內容
	SportMapBeanValidator validator = new SportMapBeanValidator();
	validator.validate(sportMapBean,result);
	if(result.hasErrors()) {
				
		return "admin/adminSportMap/adminAddSportMap";	

		}		
	// 找出對應的SportCategory物件(帶出分類欄位)
	SportCategoryBean sportCategoryBean =sportCategoryService.getSportCategory(sportMapBean.getSportCategoryBean().getSportCategoryId());
	sportMapBean.setSportCategoryBean(sportCategoryBean);
			
		try {
			sportMapService.save(sportMapBean);
				
			}catch (org.hibernate.exception.ConstraintViolationException e) {
			result.rejectValue("sportMapName", "", "地點已存在，請重新輸入");//這裡未檢驗到
			return "admin/adminSportMap/adminAddSportMap";	
				
			}
			//跳轉至後台所有運動地點頁面
			return "redirect:/admin/adminManage/adminSportMap"; 
			
		}
		
	//產生下拉式選單(後台用，新增&修改用到)
	@ModelAttribute
	public void commonCategory(Model model) {
	List<SportCategoryBean> sportCategoryBeanList = sportCategoryService.getAllSportCategorys();
	model.addAttribute("sportCategoryBeanList", sportCategoryBeanList);
		}
	
		
	//刪除單筆運動地點(後台用)
	@PostMapping("/adminSportMap/del/{sportMapId}")
	public String delete(@PathVariable("sportMapId") Integer sportMapId) {
	sportMapService.delete(sportMapId);
			
	//跳轉至後台所有運動地點頁面
	return "redirect:/admin/adminManage/adminSportMap"; 
		}
		
		
		

	

}
