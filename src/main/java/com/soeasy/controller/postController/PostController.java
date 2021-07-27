package com.soeasy.controller.postController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.PostCategoryBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.postService.PostCategoryService;
import com.soeasy.service.postService.PostService;

@Controller
@RequestMapping("/PostController")
@SessionAttributes({ "customerSignInSuccess" })
public class PostController {

	@Autowired
	PostService postService;

	@Autowired
	PostCategoryService postCategoryService;

	@Autowired
	CustomerService customerService;

	@Autowired
	FavoriteService favoriteService;

	@Autowired
	ServletContext context;

	// 文章模糊查詢
	@GetMapping(value = "/getAllPostsForKeyword")
	public String findAllForKeyword( @Param("keyword") String keyword, Model model) {
		
		System.err.println("進入查詢");
		System.err.println("keyword="+keyword);
		

		List<PostBean> postBeans = postService.findAllForKeyword(keyword);
//		System.err.println(postBeans);
		
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//		System.err.println("customerBean="+customerBean);
		String post = "post";
//		
		for (PostBean postBean : postBeans) {
			Integer postId = postBean.getPostId();
			System.err.println("postId=" + postId);

//			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);

//				System.err.println("originalCustomer=" + originalCustomer);
				System.err.println("postId=" + postId);
//				System.err.println("post=" + post);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					postBean.setFavoriteStatus(true);
				} else {
					postBean.setFavoriteStatus(false);
				}
				System.err.println("FavoriteStatus="+postBean.getFavoriteStatus());

			}

		}
		
		model.addAttribute("postBeans", postBeans);

		return "post/postByKeyword";
	}
//	// 文章模糊查詢
//	@GetMapping(value = "/getAllPostsForKeyword")
//	public String findAllForKeyword( @Param("keyword") String keyword, Model model) {
//		
//		System.err.println("進入查詢");
//		System.err.println("keyword="+keyword);
//		
//		
//		List<PostBean> postBeans = postService.findAllForKeyword(keyword);
////		System.err.println(postBeans);
//		
//		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
////		System.err.println("customerBean="+customerBean);
//		String post = "post";
////		
//		for (PostBean postBean : postBeans) {
//			Integer postId = postBean.getPostId();
//			System.err.println("postId=" + postId);
//			
////			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
//			if (customerBean != null) {
//				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
//				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);
//				
////				System.err.println("originalCustomer=" + originalCustomer);
//				System.err.println("postId=" + postId);
////				System.err.println("post=" + post);
//				
//				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
//				if (checkFavoriteBean != null) {
//					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
//					// 4.將FavoriteStatus狀態存進model.addAttribute
//					postBean.setFavoriteStatus(true);
//				} else {
//					postBean.setFavoriteStatus(false);
//				}
//				System.err.println("FavoriteStatus="+postBean.getFavoriteStatus());
//				
//			}
//			
//		}
//		
//		model.addAttribute("postBeans", postBeans);
//		
//		return "post/postByKeyword";
//	}

	// 查詢所有文章的 TOP3
	@GetMapping(value = "/getTop3Post", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<PostBean> getTop3() {

		List<PostBean> list = postService.findTop3();

		return list;
	}

	// 查詢所有文章的 TOP10
	@GetMapping(value = "/getTop10Post", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<PostBean> getTop10(Model model) {
//		System.err.println("進入getTop10Post");

		List<PostBean> list = postService.findTop10();

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//		System.err.println("customerBean="+customerBean);
		String post = "post";
//		
		for (PostBean postBean : list) {
			Integer postId = postBean.getPostId();
			System.err.println("postId=" + postId);

//			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);

//				System.err.println("originalCustomer=" + originalCustomer);
				System.err.println("postId=" + postId);
				System.err.println("post=" + post);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					postBean.setFavoriteStatus(true);
				} else {
					postBean.setFavoriteStatus(false);
				}

			}

//			newlist.add(postBean);
		}

//		System.err.println("list=" + list);
//		System.err.println("出去PostController");
		return list;
	}

	// 查詢文章類別的 TOP10
	@GetMapping(value = "/getTop10PostByPostCategoryId.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<PostBean> getTop10ByPostCategoryBean(Model model,
			@RequestParam(value = "postCategoryBean", required = false) PostCategoryBean postCategoryBean) {
//		System.err.println("進入getTop10PostByPostCategoryId");

		List<PostBean> list = postService.findTop10ByPostCategoryBean(postCategoryBean);

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//		System.err.println("customerBean="+customerBean);
		String post = "post";
//		
		for (PostBean postBean : list) {
			Integer postId = postBean.getPostId();
			System.err.println("postId=" + postId);

//			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);

//				System.err.println("originalCustomer=" + originalCustomer);
				System.err.println("postId=" + postId);
				System.err.println("post=" + post);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					postBean.setFavoriteStatus(true);
				} else {
					postBean.setFavoriteStatus(false);
				}

			}

//			newlist.add(postBean);
		}

//		System.err.println("list=" + list);
//		System.err.println("出去PostController");
		return list;
	}

	// 取得所有文章
	@GetMapping(value = "/getAllPost.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> getPageBook(Model model,
			@RequestParam(value = "pageNo", required = false, defaultValue = "1") Integer pageNo,
			@RequestParam(value = "totalPage", required = false) Integer totalPage) {

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");

		// System.err.println("接收到/pagingPostData.json請求");

		if (pageNo == null) {
			pageNo = 1; // 網址加?pageNo=測試
		}

		if (totalPage == null) {
			totalPage = postService.getTotalPages();
		}

		Map<String, Object> postmap = new HashMap<>();
		List<PostBean> listTarget = postService.getPagePosts(pageNo);

//		List<PostBean> newlist = new ArrayList();

//		System.err.println("postmap=" + postmap);
//		
		String post = "post";
//		
		for (PostBean postBean : listTarget) {
			Integer postId = postBean.getPostId();
			System.err.println("postId=" + postId);

//			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);

//				System.err.println("originalCustomer=" + originalCustomer);
				System.err.println("postId=" + postId);
				System.err.println("post=" + post);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					postBean.setFavoriteStatus(true);
				} else {
					postBean.setFavoriteStatus(false);
				}

			}

//			newlist.add(postBean);
		}

		postmap.put("currPage", String.valueOf(pageNo));
		postmap.put("totalPage", totalPage);
		// 將讀到的一頁資料放入request物件內，成為它的屬性物件
//		postmap.put("post_DPP", newlist);
		postmap.put("post_DPP", listTarget);
//		System.err.println("newpostmap=" + postmap);

//		ResponseEntity<Map<String, Object>> re = new ResponseEntity<>(postmap, HttpStatus.OK);

//		return re;
		return postmap;

	}

	// 取得所有文章By PostCategoryId
	@GetMapping(value = "/getAllPostByPostCategoryId.json", produces = { "application/json; charset=UTF-8" })
	public ResponseEntity<Map<String, Object>> getByPostCategoryBean(Model model,
			@RequestParam(value = "postCategoryBean", required = false) PostCategoryBean postCategoryBean,
			@RequestParam(value = "pageNo", required = false, defaultValue = "1") Integer pageNo,
			@RequestParam(value = "totalPage", required = false) Integer totalPage) {

		if (pageNo == null) {
			pageNo = 1; // 網址加?pageNo=測試
		}

		if (totalPage == null) {
			totalPage = postService.getTotalPagesByPostCategoryId(postCategoryBean);
		}

		Map<String, Object> postmap = new HashMap<>();
		List<PostBean> listTarget = postService.getPageByPostCategoryBean(postCategoryBean, pageNo);

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");

		String post = "post";
//		
		for (PostBean postBean : listTarget) {
			Integer postId = postBean.getPostId();
			System.err.println("postId=" + postId);

//			 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(postId, post, originalCustomer);

//				System.err.println("originalCustomer=" + originalCustomer);
				System.err.println("postId=" + postId);
				System.err.println("post=" + post);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					postBean.setFavoriteStatus(true);
				} else {
					postBean.setFavoriteStatus(false);
				}

			}

//			newlist.add(postBean);
		}

//			System.err.println("postmap=" + postmap);

		postmap.put("currPage", String.valueOf(pageNo));
		postmap.put("totalPage", totalPage);
		// 將讀到的一頁資料放入request物件內，成為它的屬性物件
		postmap.put("post_DPP", listTarget);
//		System.err.println("newpostmap=" + postmap);

		ResponseEntity<Map<String, Object>> re = new ResponseEntity<>(postmap, HttpStatus.OK);

		return re;

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
//		System.out.println("postBean="+postBean);
		if (postBean != null) {
			Blob blob = postBean.getPostImg();
//			System.out.println("blob="+blob);
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
//					System.out.println("len="+len);
//					System.out.println("media="+media);
				} catch (SQLException e) {
					throw new RuntimeException("StudentController的getPicture()發生SQLException: " + e.getMessage());
				}
			} else {
				media = toByteArray(filePath);
				filename = filePath;
//				System.out.println("blob=null ,media="+media);
//				System.out.println("blob=null ,filename="+filename);
			}
		} else {
			media = toByteArray(filePath);
			filename = filePath;
//			System.out.println("postBean=null ,media="+media);
//			System.out.println("postBean=null ,filename="+filename);
		}
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, HttpStatus.OK);
//		System.out.println("responseEntity="+responseEntity);
		return responseEntity;
	}

	// 方法toByteArray
	private byte[] toByteArray(String filepath) {
		byte[] b = null;
		String realPath = context.getRealPath(filepath);
//		System.out.println("realPath="+realPath);
		try {
			File file = new File(realPath);
			long size = file.length();
			b = new byte[(int) size];
			InputStream fis = context.getResourceAsStream(filepath);
//			System.out.println("file="+file);
//			System.out.println("size="+size);
//			System.out.println("byte[] b ="+b);
//			System.out.println("fis="+fis);
			fis.read(b);
//			System.out.println("fis.read(b)="+fis.read(b));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}

}
