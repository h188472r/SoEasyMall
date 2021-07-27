package com.soeasy.controller.lecturerController;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.soeasy.model.LecturerBean;
import com.soeasy.service.lecturerService.LecturerService;

@Controller
@RequestMapping("/lecturerController")
public class LecturerController {

	@Autowired
	LecturerService lecturerService;

	@Autowired
	ServletContext servletContext;

	// 查詢所有講師
	@GetMapping("/lecturerIndex")
	public String getAllLecturers(Model model) {
		List<LecturerBean> lecturer = lecturerService.getAllByLecturerId();
		model.addAttribute("lecturers", lecturer);
		return "lecturer/lecturerIndex";
	}

	// 查詢單筆講師
		@GetMapping(value = "/lecturer/{lecturerId}")
		public String getOneByLecturerId(@PathVariable("lecturerId") Integer lecturerId, Model model) {
			LecturerBean lecturerBean = lecturerService.getOneByLecturerId(lecturerId);
			model.addAttribute("lecturerBean", lecturerBean);
			return "/lecturer/lecturerIndex";
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
}
