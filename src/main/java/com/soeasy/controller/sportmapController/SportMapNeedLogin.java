package com.soeasy.controller.sportmapController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.SportMapBean;
import com.soeasy.service.sportmapService.SportMapService;

@Controller
@RequestMapping("/sportMapNeedLogin")
@SessionAttributes("customerSignInSuccess")
public class SportMapNeedLogin {

	@Autowired
	SportMapService sportMapService;	
	
	
	//地圖加入收藏(未用到，用收藏的controller)
	@PostMapping("/getLike/{sportMap}/{sportMapId}")
	public String getLike(Model model,
	@PathVariable("sportMap") String sportMap,		
	@PathVariable("sportMapId") Integer sportMapId) {
			
		// 判斷是否為會員
	       CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
	       if (customerBean == null) {
	            return "redirect:/customerController/customerSignIn";
	       }	        
	         //1.會員將此地點(存sportMapId)到會員收藏表 2.收藏按鈕要判斷顯示是否收藏過	 			
//			return "redirect:/sportMapController/sportMap/{sportMapId}";
			return "redirect:/sportMapController/displaySportMaps";
			
		}	
	
				
	//地圖評分(接兩個參數1.ID 2.分數)
	@PostMapping("/getScore/{sportMapId}/{scoreNo}")
	public String getScore(Model model,
			@PathVariable("sportMapId") Integer sportMapId ,
			@PathVariable("scoreNo") Integer scoreNo, HttpServletRequest request){
		
		// 判斷是否為會員
//	    CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//	    if (customerBean == null) {
//	         return "redirect:/customerController/customerSignIn";
//	        }
	        
	    //1.new一個sportMapBean物件，用sportMapId撈出舊資料裝進sportMapBean物件裡 
	    //2.將修改的scoreNo裝進sportMapBean物件的score欄位裡
	    //3.set物件進資料庫裡
	    SportMapBean sportMapOrginBean = sportMapService.get(sportMapId);
	    sportMapOrginBean.setSportMapScore(sportMapOrginBean.getSportMapScore()+scoreNo);
	    //警惕用的笨方法(以下)
//	    SportMapBean sportMapUpdateBean = new SportMapBean();  
//	    sportMapUpdateBean.setSportMapScore(sportMapOrginBean.getSportMapScore()+scoreNo);
//	    sportMapUpdateBean.setSportMapId(sportMapOrginBean.getSportMapId());
//	    sportMapUpdateBean.setSportMapName(sportMapOrginBean.getSportMapName());
//	    sportMapUpdateBean.setSportMapAddress(sportMapOrginBean.getSportMapAddress());
//	    sportMapUpdateBean.setSportMapInfo(sportMapOrginBean.getSportMapInfo());
//	    sportMapUpdateBean.setSportMapMap(sportMapOrginBean.getSportMapMap());
//	    sportMapUpdateBean.setSportMapCategory(sportMapOrginBean.getSportMapCategory());
//	    sportMapUpdateBean.setSportCategoryBean(sportMapOrginBean.getSportCategoryBean());
	   
	    try {
	    	sportMapService.update(sportMapOrginBean);	
	    }catch (org.hibernate.exception.ConstraintViolationException e) {
	    	
	    	System.out.println("接不到分數啦!!!");
	    }
	   	System.out.println("scoreNo="+scoreNo);
			return "redirect:/sportMapController/sportMap/{sportMapId}";
		}
	
	
}
