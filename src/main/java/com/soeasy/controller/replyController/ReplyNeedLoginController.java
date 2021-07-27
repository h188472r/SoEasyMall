package com.soeasy.controller.replyController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.replyService.ReplyService;
import com.soeasy.util.GlobalService;

@Controller
@RequestMapping("/ReplyNeedLoginController")
@SessionAttributes({ "customerSignInSuccess" })
public class ReplyNeedLoginController {

	@Autowired
	ReplyService replyService;

	@Autowired
	CustomerService customerService;

	@Autowired
	FavoriteService favoriteService;

	@Autowired
	ServletContext context;

	// 查詢的留言ByPostId
	@GetMapping(value = "/getAllReply.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<ReplyBean> findByPostBean(Model model,
			@RequestParam(value = "postBean", required = false) PostBean postBean) {

		List<ReplyBean> list = replyService.findByPostBean(postBean);

		List<ReplyBean> newlist = new ArrayList();
//
		ReplyBean replyChangeBean = new ReplyBean();

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		String reply = "reply";

		for (ReplyBean replyBean : list) {

			// 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(replyBean.getReplyId(), reply,
						originalCustomer);

				System.out.println("originalCustomer=" + originalCustomer);
				System.out.println("replyId=" + replyBean.getReplyId());
				System.out.println("reply=" + reply);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					replyBean.setFavoriteStatus(true);
				}
//		    			postBean.setFavoriteStatus(false);

			}

			// 取得留言內容
			String replyContent = replyBean.getReplyContent();

			// 將換行(\n)換成<br>
			String newReplyContent = replyContent.replaceAll("\n", "<br>");
			
			replyChangeBean=replyBean;
//
//			// 將更改過的內容塞入newlist
			replyChangeBean.setReplyContent(newReplyContent);
			newlist.add(replyChangeBean);

//			replyBean.setReplyContent(newReplyContent);
//			newlist.add(replyBean);

		}

		return newlist;
	}

	// 查詢Top3的留言ByPostId
	@GetMapping(value = "/getTop3Reply.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<ReplyBean> findTop3ByPostBeanOrderByReplyLike(Model model,
			@RequestParam(value = "postBean", required = false) PostBean postBean) {

		List<ReplyBean> list = replyService.findTop3ByPostBeanOrderByReplyLikeDesc(postBean);

		List<ReplyBean> newlist = new ArrayList();

		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		String reply = "reply";

		for (ReplyBean replyBean : list) {

			// 取得留言內容
			String replyContent = replyBean.getReplyContent();

			// 將換行(\n)換成<br>
			String newReplyContent = replyContent.replaceAll("\n", "<br>");

			// 將更改過的內容塞入newlist
			replyBean.setReplyContent(newReplyContent);

			// 1.判斷是否有登入，有就跳step2，沒有就FavoriteStatus=false
			if (customerBean != null) {
				CustomerBean originalCustomer = customerService.findByCustomerId(customerBean.getCustomerId());
				FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(replyBean.getReplyId(), reply,
						originalCustomer);

				System.out.println("originalCustomer=" + originalCustomer);
				System.out.println("replyId=" + replyBean.getReplyId());
				System.out.println("reply=" + reply);

				// 2.查詢有無收藏(需CustomerId、FavoriteCategory、FavoriteItem同時符合)
				if (checkFavoriteBean != null) {
					// 3.存在FavoriteStatus=True;不存在FavoriteStatus=False
					// 4.將FavoriteStatus狀態存進model.addAttribute
					replyBean.setFavoriteStatus(true);
				}
//		    			postBean.setFavoriteStatus(false);

			}

			newlist.add(replyBean);

		}

		return newlist;
	}

////	 新增留言，先送一個空白表單，並給予初值
//	@GetMapping(value = "/addReply", produces = { "application/json" })
//	public String showEmptyForm(Model model) {
//
//		// 登入攔截
//		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//		if (customerBean == null) {
//			return "redirect:/customerController/customerSignIn";
//		}
//
//		ReplyBean replyBean = new ReplyBean();
//
//		// 預設表單資料
//		replyBean.setReplyContent(
//				"我是個從國中開始減肥到大學的小女子 \\r\\n\" + \"減肥的坎坷路大概也鏟了21公斤的肉 \\r\\n\" + \"今天想跟大家分享的是我自己煮的減肥餐 \\r\\n\"\r\n"
//						+ "				+ \"\\r\\n\" + \"這大概是其中的一小部分 \\r\\n\" + \"如果大家很興趣的話我也很樂意分享我的食譜 \\r\\n\" + \"也希望減肥的大家都能成功 \\r\\n\" + \"減肥之路有你 有我（淚～ \\r\\n\"\r\n"
//						+ "				+ \"\\r\\n\" + \"歪個樓 \\r\\n\" + \"最近想在家專研高蛋白甜點");
//
//		model.addAttribute("replyBean", replyBean);
//
//		return "post/getOnePost";
//
//	}

//
//	// 新增留言
//	@PostMapping(value = "/addReply")
//	public String addReply(
//			@ModelAttribute("replyBean") @RequestParam(value = "postBean", required = false) PostBean postBean,
//			ReplyBean replyBean, Model model, BindingResult result, HttpServletRequest request) {
//
//		System.err.println("進入addReply");
//
//		// 登入攔截
//		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
//		if (customerBean == null) {
//			return "redirect:/customerController/customerSignIn";
//		}
////		System.err.println("customerBean=" + customerBean);
//
//		// 會員ID
//		replyBean.setCustomerBean(customerBean);
//
//		// 留言創建時間
//		Timestamp registerTime = new Timestamp(System.currentTimeMillis());
//		replyBean.setReplyTime(registerTime);
//
//		// 留言狀態:正常
//		replyBean.setReplyStatus(GlobalService.REPLY_STATUS_NORMAL);
//
//		// 初始留言收藏數為0
//		replyBean.setReplyLike(0);
//
//		// 留言的文章 id
//
//		replyBean.setPostId(postBean.getPostId());
//
//		// 留言創建樓層
//		List<ReplyBean> list = replyService.findByPostBean(postBean);
//		Integer floor = 0;
//
//		Iterator it = list.iterator();
//
//		while (it.hasNext()) {
//			System.out.println(it.next());
//			floor++;
//		}
//
//		replyBean.setReplyFloor(floor);
//
//		try {
//			replyService.addReply(replyBean);
//		} catch (Exception e) {
//			result.rejectValue("replyContent", "", "發生異常，請通知系統人員..." + e.getMessage());
//			return "post/getOnePost";
//
//		}
//		System.err.println("addReply");
//
//		// 跳轉至查詢單一文章頁面
//		return "redirect:/PostNeedLoginController/getPost/{postId}";
//
//	}

	// 修改留言
	@PostMapping(value = "/updateReply", produces = { "application/json; charset=UTF-8" })

	public @ResponseBody Map<String, String> updateReply(@RequestBody ReplyBean replyBean, Model model) {
		// 以傳入的ID搜尋原始的會員物件
		ReplyBean originalBean = replyService.findByReplyId(replyBean.getReplyId());
		System.err.println("originalBean=" + originalBean);

		// 更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();

		if (replyBean.getReplyContent() == null) {
			updateMessage.put("updateMessage", "內容不得為空");
		}

		// 為原始物件設定傳入的欄位值
		String replyContent=replyBean.getReplyContent();
		String newReplyContent = replyContent.replaceAll("\n", "<br>");
		originalBean.setReplyContent(newReplyContent);
//		originalBean.setReplyContent(replyBean.getReplyContent());

		// save原始物件
		replyService.updateByReplyId(originalBean);

		// 將更新資料設定給session
		model.addAttribute("updateReply", originalBean);

		// 更新成功訊息
		updateMessage.put("updateMessage", "更新成功");

		return updateMessage;
	}

	// 將單筆留言的狀態更改為2(禁止)
	// 修改留言
	@PostMapping(value = "/deleteReply", produces = { "application/json; charset=UTF-8" })

	public @ResponseBody Map<String, String> changeStatus(@RequestBody ReplyBean replyBean, Model model) {
		// 以傳入的ID搜尋原始的會員物件
		ReplyBean originalBean = replyService.findByReplyId(replyBean.getReplyId());
		System.err.println("originalBean=" + originalBean);

		// 更新檢查訊息
		Map<String, String> updateMessage = new HashMap<String, String>();

		// 為原始物件設定傳入的欄位值
		originalBean.setReplyStatus(replyBean.getReplyStatus());

		// save原始物件
		replyService.updateByReplyId(originalBean);

		// 將更新資料設定給session
		model.addAttribute("updateReply", originalBean);

		// 更新成功訊息
		updateMessage.put("updateMessage", "更新成功");

		return updateMessage;
	}

	@PostMapping("/deleteReply/{replyId}")
	public String changeStatus(@ModelAttribute("replyBean") ReplyBean replyChangeBean, BindingResult result,
			Model model, @PathVariable Integer replyId, HttpServletRequest request) {

		System.err.println("進入刪除");

		// 取得原始的PostBean物件
		replyChangeBean = replyService.findByReplyId(replyId);

		replyChangeBean.setReplyStatus(GlobalService.REPLY_STATUS_BANNED);

		// 修改Post
		replyService.updateByReplyId(replyChangeBean);

		System.err.println("刪除了!!!");

		// 跳轉至單篇文章
		return "redirect:/PostNeedLoginController/getPost/{postId}";
	}

}
