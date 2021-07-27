package com.soeasy.controller.sportmapController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.sportmapService.SportCategoryService;
import com.soeasy.service.sportmapService.SportMapService;
import com.soeasy.util.GlobalService;
import com.soeasy.validator.sportMapValidator.SportMapBeanValidator;

@Controller
@RequestMapping("/sportMapController")
@SessionAttributes("customerSignInSuccess")
public class SportMapController {

	@Autowired
	SportMapService sportMapService;	
	
	@Autowired
	SportCategoryService sportCategoryService;
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	FavoriteService favoriteService;	
	
	

	//(前台用)查詢所有運動地點
	@GetMapping("/displaySportMaps")
	public String DisplaySportMaps(Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "pageNo", required = false) Integer pageNo) {

		if (pageNo == null) {
			pageNo = 1;     //網址加?pageNo=測試
			}

	Map<Integer,SportMapBean> sportsMap = sportMapService.getPageSportMaps(pageNo);
	model.addAttribute("pageNo", String.valueOf(pageNo));
	model.addAttribute("totalPages", sportMapService.getTotalPages());
	// 將讀到的一頁資料放入request物件內，成為它的屬性物件
	model.addAttribute("sportMaps_DPP", sportsMap);
		
	return "sportMap/getAllSportMaps";
	}		
	
	//(前台用)查詢單一地點詳細資料
	@GetMapping(value="/sportMap/{sportMapId}")
	public String showOneMap(@PathVariable("sportMapId") Integer sportMapId,Model model) {

	String sportMap = "sportMap";
	//存取登入訊息，	
	CustomerBean customerSignInSuccess = (CustomerBean) model.getAttribute("customerSignInSuccess");

	SportMapBean sportMapBean = sportMapService.get(sportMapId);			
	
	//1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false 
    if (customerSignInSuccess != null) {
    	CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
     	FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(sportMapId, sportMap, originalCustomer);
     	
     	System.out.println("originalCustomer="+originalCustomer);
     	System.out.println("sportMapId="+sportMapId);
     	System.out.println("sportMap="+sportMap);     	
     	
    		//2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
    		if(checkFavoriteBean != null) {
    			//3.存在FavoriteStatus=True;不存在FavoriteStatus=False
    			//4.將FavoriteStatus狀態存進model.addAttribute
    			sportMapBean.setFavoriteStatus(true);
    			}
//    			sportMapBean.setFavoriteStatus(false);
    				
    }
	System.out.println(sportMapBean.getFavoriteStatus());
	model.addAttribute("sportMapBean",sportMapBean);
		return "sportMap/getOneSportMap"; //查詢單一頁面
		}
	
//(以下為查詢單一地點詳細資料，未撈出favoriteStatus的舊版)
//	@GetMapping(value="/sportMap/{sportMapId}")
//	public String showOneMap(@PathVariable("sportMapId") Integer sportMapId,Model model) {
//	SportMapBean sportMapBean = sportMapService.get(sportMapId);			
//	model.addAttribute("sportMapBean",sportMapBean);
//		return "sportMap/getOneSportMap"; //查詢單一頁面
//		}
		
		
		
	//(未用到，寫在後台)修改運動地點，將瀏覽器送來修改過的資料時，由本方法負責檢核，若無誤則寫入資料庫
	@PostMapping("/sportMap/{sportMapId}")
	public String modify(
		@ModelAttribute("sportMapBean")SportMapBean sportMapBean,
		BindingResult result,Model model,@PathVariable Integer sportMapId,
		HttpServletRequest request) {
					
		//檢驗欄位內容
		SportMapBeanValidator validator = new SportMapBeanValidator();
		validator.validate(sportMapBean,result);
		if(result.hasErrors()) {
				
		return "sportMap/updateSportMap";	

		}	
			
		//找到對應的Category物件
		SportCategoryBean sportCategoryBean = sportCategoryService.getSportCategory(sportMapBean.getSportCategoryBean().getSportCategoryId());
		sportMapBean.setSportCategoryBean(sportCategoryBean);
						
		sportMapService.update(sportMapBean);
		return "redirect:/sportMapController/displaySportMaps"; 
		}
				
	
	//新增運動地點，先送一個空白表單(未用到，寫在後台)
	@GetMapping(value = "/add")
	public String showEmptyForm(Model model) {
		SportMapBean sportMapBean = new SportMapBean();
		//預設表單資料
		sportMapBean.setSportMapName("中正運動中心");
		sportMapBean.setSportMapAddress("100台北市中正區信義路一段1號");
		sportMapBean.setSportMapInfo("位於中正區的運動中心");
		sportMapBean.setSportMapMap("<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3614.8743211776746!2d121.51719641500641!3d25.038338833970293!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442a975c3b64793%3A0xb32fd7574524c01!2z5Lit5q2j6YGL5YuV5Lit5b-D!5e0!3m2!1szh-TW!2stw!4v1623571445899!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>");
		model.addAttribute("sportMapBean", sportMapBean);
		
		return "sportMap/addSportMap";	
		
	}
	//新增運動地點(未用到，寫在後台)
	@PostMapping(value = "/add")
	public String add(@ModelAttribute("sportMapBean") 
	SportMapBean sportMapBean,BindingResult result,
	Model model,HttpServletRequest request){
		System.out.println("test123123");
		//檢驗欄位內容
		SportMapBeanValidator validator = new SportMapBeanValidator();
		validator.validate(sportMapBean,result);
		if(result.hasErrors()) {
			
			return "sportMap/addSportMap";	

		}		
		// 找出對應的SportCategory物件
		SportCategoryBean sportCategoryBean =sportCategoryService.getSportCategory(sportMapBean.getSportCategoryBean().getSportCategoryId());
		sportMapBean.setSportCategoryBean(sportCategoryBean);
		
		try {
			sportMapService.save(sportMapBean);
			
		}catch (org.hibernate.exception.ConstraintViolationException e) {
			result.rejectValue("sportMapName", "", "地點已存在，請重新輸入");
			return "sportMap/addSportMap";	 
			
		}
		//跳轉至查詢所有運動地點頁面(送displaySportMaps請求)
		return "redirect:/sportMapController/displaySportMaps"; 
		
	}
	
	//產生下拉式選單(新增&修改用，寫在後台)
	@ModelAttribute
	public void commonCategory(Model model) {
		List<SportCategoryBean> sportCategoryBeanList = sportCategoryService.getAllSportCategorys();
		model.addAttribute("sportCategoryBeanList", sportCategoryBeanList);
	}			
	
	//刪除單筆運動地點(未用到，寫在後台)
	@PostMapping("/del/{sportMapId}")
	public String delete(@PathVariable("sportMapId") Integer sportMapId) {
//		System.out.println("抓到了抓到了");
		sportMapService.delete(sportMapId);
		
		//跳轉至查詢所有運動地點頁面(送displaySportMaps請求)
		return "redirect:/sportMapController/displaySportMaps";
	}	

	//查詢所有運動類別Ajax，搭配查詢所有運動地點Ajax(依分類拉出地點，未寫完)
	@GetMapping(value="/allSportCategory.json",produces= {"application/json; charset=UTF-8" })
	public @ResponseBody List<SportCategoryBean>getAllCategorys(){
		List<SportCategoryBean> sportCategorys = sportCategoryService.getAllSportCategorys();
		
		return sportCategorys;
	}
	
	//查詢所有運動地點Ajax，查詢所有運動類別Ajax(未寫完)
//	@GetMapping("/getSportMapsBySportCategory.json")
//	public @ResponseBody List<SportMapBean> getSportMapsBySportCategory(@RequestParam("sportCategoryId") Integer sportCategoryId){
//		List<SportMapBean> sportMapsList = sportMapService.getSportMapsBySportCategoryId(sportCategoryId);
//		
//		return sportMapsList;
//	}
	
	//(前台用)查詢所有運動地點by分類，給兩個參數(分類ID跟頁數，帶多個參數要用?參數=值&參數=值去串接)
		@GetMapping("/displaySportMapsByCategoryId")
		public String DisplaySportMapsBySportCategoryId(Model model, HttpServletRequest request, HttpServletResponse response,
				@RequestParam(value = "sportCategoryBean", required = false)SportCategoryBean sportCategoryBean,
				@RequestParam(value = "pageNo", required = false) Integer pageNo) {
//			System.out.println(sportCategoryBean);
			if (pageNo == null) {
				pageNo = 1;     //網址可加?pageNo=測試
				}			
		//把前一頁送來的分類存起來
		SportCategoryBean getSportCategoryBean=(SportCategoryBean)model.getAttribute("sportCategoryBean");	
		
		if(sportCategoryBean==null) {
			sportCategoryBean = getSportCategoryBean;
		}
		
		Map<Integer,SportMapBean> sportsMap = sportMapService.getPageSportMapsBySportCategoryId(sportCategoryBean,pageNo);
		//一個參數為
		model.addAttribute("pageNo", String.valueOf(pageNo));
		model.addAttribute("sportCategoryBean",sportCategoryBean);
		//撈這個分類的總頁數
		model.addAttribute("totalPages", sportMapService.getTotalPagesBySportCategoryId(sportCategoryBean));
		
		if (sportMapService.getTotalPagesBySportCategoryId(sportCategoryBean) == 0) {
			return "sportMap/getNoSportMap";
			}else {
				model.addAttribute("saveSportCategoryBean", sportCategoryBean);
				// 將讀到的一頁資料放入request物件內，成為它的屬性物件，送sportMaps_category到前端
				model.addAttribute("sportMaps_category", sportsMap);
			}
		
		return "sportMap/getAllSportMapsByCategoryId"; 
		}		
	

		//(前台用)查詢所有地圖裡的前3筆，依照地圖分數降冪排序(Ajax)
		@GetMapping(value="/allSportMapsByTopNo.json",produces= {"application/json; charset=UTF-8" })
		public @ResponseBody List<SportMapBean>findFirst3BySportMapScore(){
//			Sort sort=null;			
			//給特定分數(5分)撈出特定分數的前三筆
//			List<SportMapBean> sportMapsTopNo = sportMapService.findTop3BySportMapScore(5,sort);
			//給特定分數(5分)撈出特定分數的前三筆
//			List<SportMapBean> sportMapsTopNo = sportMapService.findFirst3BySportMapScore(5,sort);

			//查詢所有地圖裡的前3筆，依照地圖分數降冪排序
			List<SportMapBean> sportMapsTopNo = sportMapService.findTop3ByOrderBySportMapScoreDesc();
			return sportMapsTopNo;
		}
		
		//(前台用)查詢所有運動地點依照區域(地址關鍵字)，給兩個參數(分類ID跟頁數，帶多個參數要用?參數=值&參數=值去串接)
		@GetMapping("/displaySportMapsBySportMapAddress")
		public String DisplaySportMapsBySportMapAddress(Model model, HttpServletRequest request, 
				@RequestParam(value = "sportMapAddress", required = false)String sportMapAddress,
				@RequestParam(value = "pageNo", required = false) Integer pageNo) {
			System.out.println(sportMapAddress);
			if (pageNo == null) {
				pageNo = 1;     //網址可加?pageNo=測試
				}			
		//把前一頁送來的分類存起來
		SportMapBean getSportMapBean=(SportMapBean)model.getAttribute("sportMapAddress");	
		
		if(sportMapAddress==null) {
			sportMapAddress = getSportMapBean.getSportMapAddress();
		}
		
		Map<Integer,SportMapBean> sportsMap = sportMapService.getPageSportMapsBySportMapAddress(sportMapAddress,pageNo);
				
		//一個參數為
		model.addAttribute("pageNo", String.valueOf(pageNo));
		model.addAttribute("sportMapAddress",sportMapAddress);
		//撈這個分類的總頁數
		model.addAttribute("totalPages", sportMapService.getTotalPagesByBySportMapAddress(sportMapAddress));
		
		if (sportMapService.getTotalPagesByBySportMapAddress(sportMapAddress) == 0) {
			return "sportMap/getNoSportMap";
		}else {
			model.addAttribute("saveSportMapAddress", sportMapAddress);
			// 將讀到的一頁資料放入request物件內，成為它的屬性物件，送sportMaps_category到前端
			model.addAttribute("sportMaps_Address", sportsMap);
		}		
		
		return "sportMap/getAllSportMapsBySportMapAddress"; 
		}				
	
	
	
}
