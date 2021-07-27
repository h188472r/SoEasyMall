package com.soeasy.controller.adminController.adminManage;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soeasy.model.PostBean;
import com.soeasy.model.PostCategoryBean;
import com.soeasy.model.PostUpdateBean;
import com.soeasy.service.postService.PostCategoryService;
import com.soeasy.service.postService.PostService;
import com.soeasy.validator.postValidator.PostUpdateBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
public class AdminPost {

	@Autowired
	PostService postService;

	@Autowired
	PostCategoryService postCategoryService;

	@Autowired
	ServletContext context;

	// 查詢全部文章
	@GetMapping("/adminPost")
	public String getAllPostById(Model model) {
		List<PostBean> postBean = postService.findAllByPostId();
		model.addAttribute("postList", postBean);
		return "admin/adminPost/adminPost";
	}

	// 修改文章
	@GetMapping(value = "/adminPost/adminPostUpdate/{postId}")
	public String showOnePost(@PathVariable("postId") Integer postId, Model model) {

		PostBean postBean = postService.findByPostId(postId);

		PostUpdateBean postUpdateBean = new PostUpdateBean();

		postUpdateBean.setPostTitle(postBean.getPostTitle());
		postUpdateBean.setPostCategory(postBean.getPostCategory());
		postUpdateBean.setPostContent(postBean.getPostContent());
		postUpdateBean.setPostImg(postBean.getPostImg());
		postUpdateBean.setPostStatus(postBean.getPostStatus());
		postUpdateBean.setPostCategoryBean(postBean.getPostCategoryBean());

		model.addAttribute("postBean", postUpdateBean);

		return "admin/adminPost/adminPostUpdate";
	}

	// 修改文章，將瀏覽器送來修改過的資料時，由本方法負責檢核，若無誤則寫入資料庫
	@PostMapping("/adminPost/adminPostUpdate/{postId}")
	public String updatePost(@ModelAttribute("postBean") PostUpdateBean postUpdateBean, BindingResult result,
			Model model, @PathVariable Integer postId, HttpServletRequest request) {

		// 取得原始的PostBean物件
		PostBean postOrginalBean = postService.findByPostId(postId);

		// 取得PostUpdateBean的PostCategoryBean物件
		PostCategoryBean updatePostCategoryBean = postCategoryService
				.getPostCategory(postUpdateBean.getPostCategoryBean().getPostCategoryId());

		// 取得adminPostUpdate.jsp所送來的圖片資訊
		MultipartFile postImg = postUpdateBean.getPostMultiImg();

		// 檢驗欄位內容
		PostUpdateBeanValidator validator = new PostUpdateBeanValidator();
		validator.validate(postUpdateBean, result);

		if (result.hasErrors()) {
			return "admin/adminPost/adminPostUpdate";
		}

		// 將postUpdateBean的資料修改進postOrginalBean

		// 圖片傳入資料庫
		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (postImg != null && !postImg.isEmpty()) {
			try {
				byte[] b = postImg.getBytes();
				Blob blob = new SerialBlob(b);
				postOrginalBean.setPostImg(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		} else {
			postOrginalBean.setPostImg(postOrginalBean.getPostImg());
		}

		postOrginalBean.setPostTitle(postUpdateBean.getPostTitle());

		postOrginalBean.setPostCategory(updatePostCategoryBean.getPostCategoryName());

		postOrginalBean.setPostContent(postUpdateBean.getPostContent());

		postOrginalBean.setPostStatus(postUpdateBean.getPostStatus());

		postOrginalBean.setPostCategoryBean(updatePostCategoryBean);

		try {
			postService.updatePost(postOrginalBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "admin/adminPost/adminPostUpdate";
		}

		// 跳轉至查詢所有文章頁面(送adminPost請求)
		return "redirect:/admin/adminManage/adminPost";
	}

	// 刪除單筆文章
	@PostMapping("/adminPost/adminPostDelete/{postId}")
	public String delete(@PathVariable("postId") Integer postId) {
		postService.deleteByPostId(postId);

		// 跳轉至查詢所有文章頁面(送adminPost請求)
		return "redirect:/admin/adminManage/adminPost";
	}

	// 產生下拉式選單
	@ModelAttribute
	public void commonCategory(Model model) {
		List<PostCategoryBean> postCategoryBeanList = postCategoryService.getAllPostCategorys();
		model.addAttribute("postCategoryBeanList", postCategoryBeanList);
	}

	// 讀圖轉成位元組陣列
	@RequestMapping(value = "/getPicture/{postId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getPicture( // ResponseEntity代表整個回應(本體,狀態列,狀態標頭)
			HttpServletResponse resp, @PathVariable Integer postId) {
		String filePath = "/image/NoImage.jpg";

		byte[] media = null;
		String filename = "";
		int len = 0;
		PostBean postBean = postService.findByPostId(postId);
//			System.out.println("postBean="+postBean);
		if (postBean != null) {
			Blob blob = postBean.getPostImg();
//				System.out.println("blob="+blob);
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
//						System.out.println("len="+len);
//						System.out.println("media="+media);
				} catch (SQLException e) {
					throw new RuntimeException("StudentController的getPicture()發生SQLException: " + e.getMessage());
				}
			} else {
				media = toByteArray(filePath);
				filename = filePath;
//					System.out.println("blob=null ,media="+media);
//					System.out.println("blob=null ,filename="+filename);
			}
		} else {
			media = toByteArray(filePath);
			filename = filePath;
//				System.out.println("postBean=null ,media="+media);
//				System.out.println("postBean=null ,filename="+filename);
		}
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, HttpStatus.OK);
//			System.out.println("responseEntity="+responseEntity);
		return responseEntity;
	}

	// 方法toByteArray
	private byte[] toByteArray(String filepath) {
		byte[] b = null;
		String realPath = context.getRealPath(filepath);
//			System.out.println("realPath="+realPath);
		try {
			File file = new File(realPath);
			long size = file.length();
			b = new byte[(int) size];
			InputStream fis = context.getResourceAsStream(filepath);
//				System.out.println("file="+file);
//				System.out.println("size="+size);
//				System.out.println("byte[] b ="+b);
//				System.out.println("fis="+fis);
			fis.read(b);
//				System.out.println("fis.read(b)="+fis.read(b));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}

}
