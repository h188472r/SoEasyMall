package com.soeasy.controller.adminController.adminManage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;

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

import com.soeasy.model.LecturerBean;
import com.soeasy.service.lecturerService.LecturerService;
import com.soeasy.validator.lecturerValidator.LecturerBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminLecturer {

	@Autowired
	LecturerService lecturerService;

	@Autowired
	ServletContext servletContext;

	// 後台講師首頁
	@GetMapping("/adminLecture/lecturer")
	public String adminLecturerIndex(Model model) {
		model.addAttribute("lecturers", lecturerService.getAllByLecturerId());
		return "/admin/adminLecturer/adminLecturer";
	}

	// 新增講師，先送一個空白表單，並給予初值
	@GetMapping("/adminLecturer/addLecturer")
	public String showEmptyForm(Model model) {
		LecturerBean lecturerBean = new LecturerBean();
		// 預設表單資料
		lecturerBean.setLecturerName("peeta葛格");
		lecturerBean.setLecturerTalent("健美先生、營養師");
		lecturerBean.setLecturerExp("●經歷<br>\r\n"
				+ "　紐西蘭奧克蘭大學營養學系畢業<br>\r\n"
				+ "<br>\r\n"
				+ "●peeta Fitness創辦人<br>\r\n"
				+ "<br>\r\n"
				+ "●著有<br>\r\n"
				+ "　《體態改造與生酮攻略！》");
		lecturerBean.setLecturerMultiImg(null);

		model.addAttribute("lecturerBean", lecturerBean);

		return "/admin/adminLecturer/adminAddLecturer";
	}

	// 新增講師
	@PostMapping("/adminLecturer/addLecturer")
	public String addLecturer(@ModelAttribute("lecturerBean") LecturerBean lecturerBean, BindingResult result,
			Model model, HttpServletRequest request) {

		// 檢驗欄位內容(空白未填)
		LecturerBeanValidator validator = new LecturerBeanValidator();
		validator.validate(lecturerBean, result);
		if (result.hasErrors()) {

			// 新增不成功會停留在新增講師畫面
			return "/admin/adminLecturer/adminAddLecturer";
		}

		// 取得adminLecturerUpdate.jsp所送來的圖片資訊
		MultipartFile lecturerImg = lecturerBean.getLecturerMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (lecturerImg != null && !lecturerImg.isEmpty()) {
			try {
				byte[] b = lecturerImg.getBytes();
				Blob blob = new SerialBlob(b);
				lecturerBean.setLecturerImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		lecturerService.addLecturer(lecturerBean);

		// 如果新增成功就跳轉至查詢所有講師
		return "redirect:/admin/adminManage/adminLecture/lecturer";
	}
	
	// 讀圖轉成位元組陣列
		@RequestMapping(value = "/getLecturerImage/{lecturerId}", method = RequestMethod.GET)
		public ResponseEntity<byte[]> getImage(HttpServletRequest resp, @PathVariable Integer lecturerId) {
			LecturerBean lecturerBean = lecturerService.getOneByLecturerId(lecturerId);

			
			Blob customerImg = lecturerBean.getLecturerImg();
			
			InputStream is = null;
			String fileName = null;
			byte[] media = null;
			ResponseEntity<byte[]> responseEntity = null;
			
			try {
				if (customerImg != null) {
					is = customerImg.getBinaryStream();
				}
				// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)	
				if(is == null) {
					fileName = "salad.png";
					is = servletContext.getResourceAsStream(
							"/images/" + fileName);
				}
				
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				// 由InputStream讀取位元組，然後由OutputStream寫出
				int len = 0;
				byte[] bytes = new byte[8192];
				
				while ((len = is.read(bytes)) != -1) {
					baos.write(bytes, 0, len);
				}
				
				media = baos.toByteArray();
				responseEntity = new ResponseEntity<>(media, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				try {
					if (is != null) is.close();
				} catch(IOException e) {
					;
				}
			}
			return responseEntity;
		}
	
		// 刪除單筆講師
		@PostMapping("/adminLecturer/deleteLecturer/{lecturerId}")
		public String deleteLecturer(@PathVariable("lecturerId") Integer lecturerId) {
			lecturerService.deleteLecturer(lecturerId);
			return "redirect:/admin/adminManage/adminLecture/lecturer";
		}

		//===============================修改===============================
		// 修改單筆講師表單
		@GetMapping(value = "/adminLecturer/updateLecturer/{lecturerId}")
		public String getOneByLecturerId(@PathVariable("lecturerId") Integer lecturerId, Model model) {
			LecturerBean lecturerBean = lecturerService.getOneByLecturerId(lecturerId);
			model.addAttribute("lecturerBean", lecturerBean);

			return "/admin/adminLecturer/adminUpdateLecturer"; // 帶出修改資料
		}

		// 修改講師，將送來修改過的資料用本方法檢核，若無誤則寫入資料庫(後台用)
		@PostMapping("/adminLecturer/updateLecturer/{lecturerId}")
		public String modify(@ModelAttribute("lecturerBean") LecturerBean lecturerBean, BindingResult result, Model model,
				@PathVariable Integer lecturerId, HttpServletRequest request) {

			// 檢驗欄位內容(檢驗幾項欄位不能為空)
			LecturerBeanValidator validator = new LecturerBeanValidator();
			validator.validate(lecturerBean, result);
			if (result.hasErrors()) {

				return "admin/adminLecturer/adminUpdateLecturer";
			}
			// 取得adminLecturerUpdate.jsp所送來的圖片資訊
			MultipartFile lecturerImg = lecturerBean.getLecturerMultiImg();

			// 建立Blob物件，交由 Hibernate 寫入資料庫
			if (lecturerImg != null && !lecturerImg.isEmpty()) {
				try {
					byte[] b = lecturerImg.getBytes();
					Blob blob = new SerialBlob(b);
					lecturerBean.setLecturerImg(blob);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
				}
			}

			lecturerService.updateLecturer(lecturerBean);

			return "redirect:/admin/adminManage/adminLecture/lecturer";
		}
		//=================================================================
}
