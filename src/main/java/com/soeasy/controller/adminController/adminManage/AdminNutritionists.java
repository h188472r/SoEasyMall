package com.soeasy.controller.adminController.adminManage;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.soeasy.model.NutritionistBean;
import com.soeasy.model.NutritionistCategoryBean;

import com.soeasy.service.nutritionistService.NutritionistCategoryService;
import com.soeasy.service.nutritionistService.NutritionistService;
import com.soeasy.validator.nutritionistValidator.NutritionistValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminNutritionists {

	@Autowired
	NutritionistService nutritionistService;

	@Autowired
	NutritionistCategoryService nutritionistCategoryService;

	@Autowired
	ServletContext context;

	// 後台查詢全部營養師
	@GetMapping("/adminNutritionist")
	public String DisplayNutritionist(Model model) {
		model.addAttribute("nutritionists", nutritionistService.findAllByNutritionistId());
		return "/admin/adminNutritionist/adminNutritionist";
	}

	// 讀圖轉成位元組陣列
	@RequestMapping(value = "/getImage/{nutritionistId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(HttpServletRequest resp, @PathVariable Integer nutritionistId) {
		String filePath = "/image/NoImage.jpg";
		byte[] media = null;
		String filename = "";
		int len = 0;
		NutritionistBean nutritionistBean = nutritionistService.findByNutritionistId(nutritionistId);
		if (nutritionistBean != null) {
			Blob blob = nutritionistBean.getNutritionistImage();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("StudentController的getPicture()發生SQLException: " + e.getMessage());
				}
			} else {
				media = toByteArray(filePath);
				filename = filePath;
			}
		} else {
			media = toByteArray(filePath);
			filename = filePath;
		}
		ResponseEntity<byte[]> re = new ResponseEntity<>(media, HttpStatus.OK);

		return re;
	}

	// 方法toByteArray
	private byte[] toByteArray(String filePath) {
		byte[] b = null;
		String realPath = context.getRealPath(filePath);
		try {
			File file = new File(realPath);
			long size = file.length();
			b = new byte[(int) size];
			InputStream fis = context.getResourceAsStream(filePath);
			fis.read(b);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}

	// 新增營養師，先送一個空白表單，並給予初值
	@GetMapping(value = "/adminNutritionist/add")
	public String emptyNutritionist(Model model) {
		NutritionistBean nutritionistBean = new NutritionistBean();
		// 預設表單資料
		nutritionistBean.setNutritionistName("五公斤肥貓");
		nutritionistBean.setNutritionistGender("M");
		nutritionistBean.setNutritionistDegree("肥貓醫學大學保健營養學系");
		nutritionistBean.setNutritionistEmail("fatcat05@gmail.com");
		model.addAttribute("nutritionistBean", nutritionistBean);

		return "/admin/adminNutritionist/adminAddNutritionist";
	}

	// 新增營養師
	@PostMapping(value = "/adminNutritionist/add")
	public String addNutritionist(@ModelAttribute("nutritionistBean") NutritionistBean nutritionistBean,
			BindingResult result, Model model, HttpServletRequest request) {

		// 檢測不正當欄位並回傳提示訊息
		NutritionistValidator validator = new NutritionistValidator();
		validator.validate(nutritionistBean, result);
		if (result.hasErrors()) {
			return "/admin/adminNutritionist/adminAddNutritionist";
		}

		// 取得addnutritionist.jsp所送來的圖片資訊
		MultipartFile nutritionistImg = nutritionistBean.getNutritionistMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (nutritionistImg != null && !nutritionistImg.isEmpty()) {
			try {
				byte[] b = nutritionistImg.getBytes();
				Blob blob = new SerialBlob(b);
				nutritionistBean.setNutritionistImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		// 營養師創建時間
		long miliseconds = System.currentTimeMillis();
		Date Date = new Date(miliseconds);
		nutritionistBean.setNutritionistDate(Date);

		NutritionistCategoryBean nutritionistCategoryBean = nutritionistCategoryService
				.getNutritionistCategory(nutritionistBean.getNutritionistCategoryBean().getNutritionistCategoryId());
		nutritionistBean.setNutritionistCategoryBean(nutritionistCategoryBean);
		nutritionistBean.setNutritionistCategory(nutritionistCategoryBean.getNutritionistCategoryName());

		try {
			nutritionistService.addNutritionist(nutritionistBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "/admin/adminNutritionist/adminAddNutritionist";

		}

		return "redirect:/admin/adminManage/adminNutritionist";
	}

	// 產生下拉式選單
	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "男性");
		genderMap.put("F", "女性");
		model.addAttribute("genderMap", genderMap);

		List<NutritionistCategoryBean> nutritionistCategoryList = nutritionistCategoryService
				.getAllNutritionistCategorys();
		model.addAttribute("nutritionistCategoryList", nutritionistCategoryList);
	}

	// 刪除單筆營養師
	@PostMapping("/adminNutritionist/del/{nutritionistId}")
	public String delete(@PathVariable("nutritionistId") Integer nutritionistId) {
		nutritionistService.deleteByNutritionistId(nutritionistId);
		return "redirect:/admin/adminManage/adminNutritionist";
	}

	// 查詢修改單營養師表單
	@GetMapping(value = "/adminNutritionist/up/{nutritionistId}")
	public String getOneNutritionistById(@PathVariable("nutritionistId") Integer nutritionistId, Model model) {
		NutritionistBean nutritionistBean = nutritionistService.findByNutritionistId(nutritionistId);
		model.addAttribute("nutritionistBean", nutritionistBean);
		
		return "/admin/adminNutritionist/adminUpdateNutritionist"; // 帶出修改資料

	}

	// 查詢修改單營養師表單
	@PostMapping("/adminNutritionist/up/{nutritionistId}")
	public String emptyNutritionist (@ModelAttribute("nutritionistBean")NutritionistBean nutritionistBean,
			BindingResult result,Model model,@PathVariable("nutritionistId") Integer nutritionistId,
			HttpServletRequest request) {
		NutritionistValidator validator = new NutritionistValidator();
		validator.validate(nutritionistBean, result);
		if (result.hasErrors()) {
			return "/admin/adminNutritionist/adminUpdateNutritionist";
		}

		// 取得addnutritionist.jsp所送來的圖片資訊
		MultipartFile nutritionistImg = nutritionistBean.getNutritionistMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (nutritionistImg != null && !nutritionistImg.isEmpty()) {
			try {
				byte[] b = nutritionistImg.getBytes();
				Blob blob = new SerialBlob(b);
				nutritionistBean.setNutritionistImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}
		
		// 營養師創建時間
		long miliseconds = System.currentTimeMillis();
		Date Date = new Date(miliseconds);
		nutritionistBean.setNutritionistDate(Date);
		
		NutritionistCategoryBean nutritionistCategoryBean = nutritionistCategoryService.
				getNutritionistCategory(nutritionistBean.getNutritionistCategoryBean().getNutritionistCategoryId());
		nutritionistBean.setNutritionistCategoryBean(nutritionistCategoryBean);	
		nutritionistBean.setNutritionistCategory(nutritionistCategoryBean.getNutritionistCategoryName());
		
		try {
			nutritionistService.updateNutritionist(nutritionistBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "/admin/adminNutritionist/adminUpdateNutritionist";
		}
		return "redirect:/admin/adminManage/adminNutritionist";

	}
	
}
