package com.soeasy.controller.adminController.adminManage;

import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;
import com.soeasy.service.replyService.ReplyService;
import com.soeasy.util.GlobalService;
import com.soeasy.validator.replyValidator.ReplyUpdateBeanValidator;

@Controller
@RequestMapping("/admin/adminManage")
@SessionAttributes({ "customerSignInSuccess", "getOnePostBean" })
public class AdminReply {

	@Autowired
	ReplyService replyService;

	@Autowired
	ServletContext context;

//	// 文章
//	@GetMapping({ "/adminPost" })
//	public String admin() {
//		return "/admin/adminPost";
//	}

	// 查詢全部留言
	@GetMapping({ "/adminReply" })
	public String getAllReplyById(Model model) {

		List<ReplyBean> replyBean = replyService.findAllByReplyId();
		model.addAttribute("ReplyList", replyBean);
		return "admin/adminReply/adminReply";
	}

	// 修改文章
	@GetMapping(value = "/adminReply/adminReplyUpdate/{replyId}")
	public String showOnePost(@PathVariable("replyId") Integer replyId, Model model) {

		ReplyBean replyBean = replyService.findByReplyId(replyId);

		model.addAttribute("replyBean", replyBean);

		return "admin/adminReply/adminReplyUpdate";
	}

	// 修改文章，將瀏覽器送來修改過的資料時，由本方法負責檢核，若無誤則寫入資料庫
	@PostMapping("/adminReply/adminReplyUpdate/{replyId}")
	public String updatePost(@ModelAttribute("replyBean") ReplyBean replyBean, BindingResult result, Model model,
			@PathVariable Integer replyId, HttpServletRequest request) {

		// 取得原始的PostBean物件
		ReplyBean replyOrginalBean = replyService.findByReplyId(replyId);

		// 檢驗欄位內容
		ReplyUpdateBeanValidator validator = new ReplyUpdateBeanValidator();
		validator.validate(replyBean, result);

		if (result.hasErrors()) {
			return "admin/adminReply/adminReplyUpdate";
		}

		// 將replyBean的資料修改進replyOrginalBean

//		內容
		replyOrginalBean.setReplyContent(replyBean.getReplyContent());

//		狀態
		replyOrginalBean.setReplyStatus(replyBean.getReplyStatus());

		try {
			replyService.updateByReplyId(replyOrginalBean);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			return "admin/adminReply/adminReplyUpdate";
		}

		// 跳轉至查詢所有文章頁面(送adminPost請求)
		return "redirect:/admin/adminManage/adminReply";
	}

	// 刪除單筆留言
	@PostMapping("/adminReply/adminReplyDelete/{replyId}")
	public String delete(@PathVariable("replyId") Integer replyId) {
		replyService.deleteByReplyId(replyId);

		// 跳轉至查詢所有留言頁面(送adminReply請求)
		return "redirect:/admin/adminManage/adminReply";
	}

	// 新增留言，先送一個空白表單，並給予初值
	@GetMapping(value = "/adminReply/addReply")
	public String showEmptyForm(Model model) {

		ReplyBean replyBean = new ReplyBean();
		// 預設表單資料
		replyBean.setReplyContent("我是個從國中開始減肥到大學的小女子 \r\n" + "減肥的坎坷路大概也鏟了21公斤的肉 \r\n" + "今天想跟大家分享的是我自己煮的減肥餐 \r\n"
				+ "\r\n" + "這大概是其中的一小部分 \r\n" + "如果大家很興趣的話我也很樂意分享我的食譜 \r\n" + "也希望減肥的大家都能成功 \r\n" + "減肥之路有你 有我（淚～ \r\n"
				+ "\r\n" + "歪個樓 \r\n" + "最近想在家專研高蛋白甜點");
		model.addAttribute("replyBean", replyBean);

		return "admin/adminReply/adminReplyAdd";

	}

	// 新增留言
	@PostMapping(value = "/adminReply/addReply")
	public String addReply(@ModelAttribute("replyBean") ReplyBean replyBean, Model model, BindingResult result,
			HttpServletRequest request) {

		System.err.println("進入addReply");

		// 登入攔截
		CustomerBean customerBean = (CustomerBean) model.getAttribute("customerSignInSuccess");
		System.err.println("customerBean="+customerBean);

		// 會員ID
		replyBean.setCustomerBean(customerBean);

		// 留言創建時間
		Timestamp registerTime = new Timestamp(System.currentTimeMillis());
		replyBean.setReplyTime(registerTime);

		// 留言狀態:正常
		replyBean.setReplyStatus(GlobalService.REPLY_STATUS_NORMAL);

		// 初始留言收藏數為0
		replyBean.setReplyLike(0);

		// 留言的文章 id
		PostBean postBean = (PostBean) model.getAttribute("getOnePostBean");
		System.err.println("postBean="+postBean);
		
//		replyBean.setPostId(postBean.getPostId());

		// 留言創建樓層
		List<ReplyBean> list = replyService.findByPostBean(postBean);
		Integer floor = 0;

		Iterator it = list.iterator();

		while (it.hasNext()) {
			System.err.println("List="+it.next());
			floor++;
		}

		replyBean.setReplyFloor(floor);

		try {
			replyService.addReply(replyBean);
		} catch (Exception e) {
			result.rejectValue("replyContent", "", "發生異常，請通知系統人員..." + e.getMessage());
			return "admin/adminReply/adminReplyAdd";

		}
		System.err.println("出去addReply");

		// 跳轉至查詢單一文章頁面
		return "admin/adminReply/adminReply";

	}

}
