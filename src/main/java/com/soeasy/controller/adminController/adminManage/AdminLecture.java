package com.soeasy.controller.adminController.adminManage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
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

import com.soeasy.model.LectureBean;
import com.soeasy.model.LectureCategoryBean;
import com.soeasy.service.lectureService.LectureCategoryService;
import com.soeasy.service.lectureService.LectureService;
import com.soeasy.util.GlobalService;
import com.soeasy.validator.lectureValidator.LectureBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminLecture {

	@Autowired
	LectureService lectureService;

	@Autowired
	LectureCategoryService lectureCategoryService;

	@Autowired
	ServletContext servletContext;

	// 後台講座首頁
	@GetMapping("/adminLecture")
	public String adminLectureIndex(Model model) {
		model.addAttribute("lectures", lectureService.updateLectureStatus());
		return "/admin/adminLecture/adminLecture";
	}

	//===============================新增===============================
	// 新增講座，先送一個空白表單，並給予初值
	@GetMapping("/adminLecture/addLecture")
	public String showEmptyForm(Model model) {
		LectureBean lectureBean = new LectureBean();
		// 預設表單資料
		lectureBean.setLectureTitle("正確飲食，讓您瘦的窈窕又健康");
		lectureBean.setLectureContent("怎麼做才能才能瘦的健康？"
				+ "<br>"
				+ "<br>"
				+ "&emsp;&emsp;炎炎夏日即將到來，在身上衣服漸漸穿少的同時，冬天堆積在身上的肥肉、脂肪也一一現形。肥胖除了外表不美觀外，對身體健康也有很大的影響，高血脂、高血壓、糖尿病、痛風等心血管疾病都跟肥胖有很大的關聯。目前坊間的飲食減肥法五花八門，肥胖者其實很清楚是自己的飲食方式出了問題，但不知道該如何著手改變，才能健康的減重。減重飲食應以減少不必要熱量及攝取足夠營養素為原則，才能瘦的健康。<br>"
				+ "<br>"
				+ "健康減重的飲食技巧<br>"
				+ "<br>"
				+ "&emsp;&emsp;●選擇低熱量的食物：例如選擇瘦肉不吃肥肉。烹調方式以烤、滷、煮最好，少吃煎、炸類。以天然食材為主，減少攝取加工食品。多攝取富含膳食纖維的食物，例如以糙米飯取代白米飯、綠色蔬菜熱量低且纖維多，可增加攝取。<br>"
				+ "<br>"
				+ "&emsp;&emsp;●食物種類應多元且均衡：減重飲食雖然熱量要減低，但營養也要充足，六大類食物都要均衡攝取，不能只吃一種食物，或完全不吃某種食物。<br>"
				+ "<br>"
				+ "&emsp;&emsp;●每日三餐最適當：有人減肥飲食只吃一餐或兩餐，希望藉由餐數減少來減低熱量，這種方法能讓體重很快降下來，但往往瘦下來後很快又復胖，這是因為長期只吃一兩餐是不可能的，飲食習慣才是減肥的關鍵，所以建議一天吃三餐，但三餐進食適量適當，如此才能長久維持。<br>"
				+ "<br>"
				+ "&emsp;&emsp;●進餐時細嚼慢嚥、定時定量：延長進餐時間，細嚼慢嚥品嚐每一口，好好享受用餐時光。固定時間及固定進食的量，盡量減少聚餐或吃到飽的邀約。<br>"
				+ "<br>"
				+ "&emsp;&emsp;●餐間盡量不吃進熱量：餐間額外的熱量常是讓減肥者失敗的主因，養成餐間不吃零食的習慣，如果感到飢餓就喝白開水或無糖的飲品來增加飽足感。<br>"
				+ "<br>"
				+ "&emsp;&emsp;●減少酒類及含糖飲料：酒類與含糖飲料是減肥的大敵，酒類不管是薄酒或厚酒熱量都高，含糖飲料就算改成微糖，一杯的含糖量仍超過一日建議的糖分攝取量，建議改掉喝含糖飲料的習慣，酒類若是聚餐需要點到為止就好。<br>"
				+ "<br>"
				+ "&emsp;&emsp;健康正確的飲食習慣是減重最重要的課題，也是維持體重的不二法門，以上減重飲食的技巧只要能把握住且不間斷的實行，才能健康的瘦，快樂的瘦！");
		lectureBean.setLectureAddress("106台北市大安區復興南路一段390號2樓");
		lectureBean.setLectureMap("<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d57840.08173673962!2d121.50837927910156!3d25.033900700000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442abd379a5ec97%3A0xedc006d25a9e35df!2z6LOH562W5pyDIOaVuOS9jeaVmeiCsueglOeptuaJgCDmlbjkvY3kurrmiY3ln7nogrLkuK3lv4M!5e0!3m2!1szh-TW!2stw!4v1626009126439!5m2!1szh-TW!2stw\" width=\"400\" height=\"300\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>");
		lectureBean.setLectureMultiImg(null);
		model.addAttribute("lectureBean", lectureBean);

		return "/admin/adminLecture/adminAddLecture";
	}

	// 新增講座
	@PostMapping(value = "/adminLecture/addLecture")
	public String addLecture(@ModelAttribute("lectureBean") LectureBean lectureBean, BindingResult result, Model model,
			HttpServletRequest request) {

		// 檢測不正當欄位並回傳提示訊息
		LectureBeanValidator validator = new LectureBeanValidator();
		validator.validate(lectureBean, result);
		if (result.hasErrors()) {
			return "/admin/adminLecture/adminAddLecture";
		}

		// 取得adminLectureUpdate.jsp所送來的圖片資訊
		MultipartFile lectureImg = lectureBean.getLectureMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (lectureImg != null && !lectureImg.isEmpty()) {
			try {
				byte[] b = lectureImg.getBytes();
				Blob blob = new SerialBlob(b);
				lectureBean.setLectureImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		Date date = new Date(System.currentTimeMillis());
		if ((date.getTime() - lectureBean.getLectureDate().getTime()) / (86400000 * 1) >= 1) {
			System.out.println("精彩回顧");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ARCHIVED);
		} else if ((date.getTime() - lectureBean.getLectureDate().getTime()) / (86400000 * 14) == 0) {
			System.out.println("現正進行");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ONGOING);
		} else if ((date.getTime() - lectureBean.getLectureDate().getTime()) < 0) {
			System.out.println("即將舉辦");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_UPCOMING);
		}
		
//		Date date = new Date(System.currentTimeMillis());
//		if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) > 14) {
//			System.out.println("即將舉辦");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ARCHIVED);
//		} else if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) < 0) {
//			System.out.println("精彩回顧");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_UPCOMING);
//		} else if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) < 14) {
//			System.out.println("現正進行");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ONGOING);
//		}

		lectureService.addLecture(lectureBean);

		return "redirect:/admin/adminManage/adminLecture";
	}
	//=================================================================

	// 讀圖轉成位元組陣列
	@RequestMapping(value = "/getLectureImage/{lectureId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(HttpServletRequest resp, @PathVariable Integer lectureId) {
		LectureBean lectureBean = lectureService.getOneByLectureId(lectureId);

		Blob customerImg = lectureBean.getLectureImg();

		InputStream is = null;
		String fileName = null;
		byte[] media = null;
		ResponseEntity<byte[]> responseEntity = null;

		try {
			if (customerImg != null) {
				is = customerImg.getBinaryStream();
			}
			// 如果圖片的來源有問題，就送回預設圖片(/images/salad.png)
			if (is == null) {
				fileName = "salad.png";
				is = servletContext.getResourceAsStream("/images/" + fileName);
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
		} finally {
			try {
				if (is != null)
					is.close();
			} catch (IOException e) {
				;
			}
		}
		return responseEntity;
	}

	// 產生講座類型radio選單
	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> lectureCategory = new HashMap<>();
		lectureCategory.put("Eat", "飲食");
		lectureCategory.put("Exercise", "運動");
		model.addAttribute("lectureCategory", lectureCategory);

		List<LectureCategoryBean> lectureCategoryList = lectureCategoryService.getAllLectureCategories();
		model.addAttribute("lectureCategoryList", lectureCategoryList);
	}

	// 刪除單筆講座
	@PostMapping("/adminLecture/deleteLecture/{lectureId}")
	public String deleteLecture(@PathVariable("lectureId") Integer lectureId) {
		lectureService.deleteLecture(lectureId);
		return "redirect:/admin/adminManage/adminLecture";
	}

	//===============================修改===============================
	// 修改單筆講座表單
	@GetMapping(value = "/adminLecture/updateLecture/{lectureId}")
	public String getOneByLectureId(@PathVariable("lectureId") Integer lectureId, Model model) {
		LectureBean lectureBean = lectureService.getOneByLectureId(lectureId);
		model.addAttribute("lectureBean", lectureBean);

		return "/admin/adminLecture/adminUpdateLecture"; // 帶出修改資料
	}

	// 修改講座，將送來修改過的資料用本方法檢核，若無誤則寫入資料庫(後台用)
	@PostMapping("/adminLecture/updateLecture/{lectureId}")
	public String modify(@ModelAttribute("lectureBean") LectureBean lectureBean, BindingResult result, Model model,
			@PathVariable Integer lectureId, HttpServletRequest request) {

		// 檢驗欄位內容(檢驗幾項欄位不能為空)
		LectureBeanValidator validator = new LectureBeanValidator();
		validator.validate(lectureBean, result);
		if (result.hasErrors()) {

			return "admin/adminLecture/adminUpdateLecture";
		}
		// 取得adminLectureUpdate.jsp所送來的圖片資訊
		MultipartFile lectureImg = lectureBean.getLectureMultiImg();

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (lectureImg != null && !lectureImg.isEmpty()) {
			try {
				byte[] b = lectureImg.getBytes();
				Blob blob = new SerialBlob(b);
				lectureBean.setLectureImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		Date date = new Date(System.currentTimeMillis());
		if ((date.getTime() - lectureBean.getLectureDate().getTime()) / (86400000 * 1) >= 1) {
			System.out.println("精彩回顧");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ARCHIVED);
		} else if ((date.getTime() - lectureBean.getLectureDate().getTime()) / (86400000 * 14) == 0) {
			System.out.println("現正進行");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ONGOING);
		} else if ((date.getTime() - lectureBean.getLectureDate().getTime()) < 0) {
			System.out.println("即將舉辦");
			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_UPCOMING);
		}
//		Date date = new Date(System.currentTimeMillis());
//		if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) > 14) {
//			System.out.println("即將舉辦");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ARCHIVED);
//		} else if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) < 0) {
//			System.out.println("精彩回顧");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_UPCOMING);
//		} else if (((lectureBean.getLectureDate().getTime() - date.getTime())  / 86400000) < 14) {
//			System.out.println("現正進行");
//			lectureBean.setLectureStatus(GlobalService.LECTURE_STATUS_ONGOING);
//		}

		lectureService.updateLecture(lectureBean);

		return "redirect:/admin/adminManage/adminLecture";
	}
	//=================================================================
}