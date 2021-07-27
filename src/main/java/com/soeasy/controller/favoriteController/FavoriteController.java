package com.soeasy.controller.favoriteController;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.FavoriteBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;
import com.soeasy.service.customerService.CustomerService;
import com.soeasy.service.favoriteService.FavoriteService;
import com.soeasy.service.postService.PostService;
import com.soeasy.service.replyService.ReplyService;

@Controller
@RequestMapping("/favoriteController")
@SessionAttributes("customerSignInSuccess")
public class FavoriteController {

	@Autowired
	CustomerService customerService;

	@Autowired
	FavoriteService favoriteService;

	@Autowired
	PostService postService;
	
	@Autowired
	ReplyService replyService;

	// 新增or取消收藏
	@PostMapping(value = "/addFavorite", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Boolean> addFavorite(@RequestBody FavoriteBean favoriteBean, Model model) {
		CustomerBean customerSignInSuccess = (CustomerBean) model.getAttribute("customerSignInSuccess");
		CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
		Map<String, Boolean> favoriteMessage = new HashMap<String, Boolean>();
		// 查詢有無該收藏
		FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(favoriteBean.getFavoriteItemId(),
				favoriteBean.getFavoriteCategory(), originalCustomer);
		if (checkFavoriteBean == null) {
			// 若查無收藏則新增收藏
			favoriteBean.setCustomerBean(originalCustomer);
			favoriteService.addFavorite(favoriteBean);
			favoriteMessage.put("favoriteExist", true);
		} else if (checkFavoriteBean != null) {
			// 若已有收藏則取消收藏
			favoriteService.removeFavorite(checkFavoriteBean.getFavoriteId());
			favoriteMessage.put("favoriteExist", false);
		}

		return favoriteMessage;

	}

	// 新增or取消收藏By文章
	@PostMapping(value = "/addFavoritePost", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> addFavoriteByPost(@RequestBody FavoriteBean favoriteBean, Model model) {
		CustomerBean customerSignInSuccess = (CustomerBean) model.getAttribute("customerSignInSuccess");
		CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
		Map<String, Object> favoriteMessage = new HashMap<String, Object>();
		// 查詢有無該收藏
		FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(favoriteBean.getFavoriteItemId(),favoriteBean.getFavoriteCategory(), originalCustomer);
		PostBean originalPost = postService.findByPostId(favoriteBean.getFavoriteItemId());
		CustomerBean authorCustomer =originalPost.getCustomerBean();
		Integer customerScore = authorCustomer.getCustomerScore();
//		System.err.println("customerScore="+customerScore);
		
		if (checkFavoriteBean == null) {
			// 若查無收藏則新增收藏，文章作者積分+1
			favoriteBean.setCustomerBean(originalCustomer);
			favoriteService.addFavorite(favoriteBean);
			favoriteMessage.put("favoriteExist", true);
			authorCustomer.setCustomerScore(customerScore+1);
		} else if (checkFavoriteBean != null) {
			// 若已有收藏則取消收藏，文章作者積分-1
			favoriteService.removeFavorite(checkFavoriteBean.getFavoriteId());
			favoriteMessage.put("favoriteExist", false);
			authorCustomer.setCustomerScore(customerScore-1);
		}
		model.addAttribute("customerSignInSuccess", originalCustomer);
		Integer count = favoriteService.countFavoriteItemIdAndFavoriteCategory(favoriteBean.getFavoriteItemId(),
				favoriteBean.getFavoriteCategory());
		originalPost.setPostLike(count);
		postService.updatePost(originalPost);
		favoriteMessage.put("favoriteCount", count);

		return favoriteMessage;

	}
	
	// 新增or取消收藏By留言
		@PostMapping(value = "/addFavoriteReply", produces = { "application/json; charset=UTF-8" })
		public @ResponseBody Map<String, Object> addFavoriteByReply(@RequestBody FavoriteBean favoriteBean, Model model) {
			CustomerBean customerSignInSuccess = (CustomerBean) model.getAttribute("customerSignInSuccess");
			CustomerBean originalCustomer = customerService.findByCustomerId(customerSignInSuccess.getCustomerId());
			Map<String, Object> favoriteMessage = new HashMap<String, Object>();
			// 查詢有無該收藏
			FavoriteBean checkFavoriteBean = favoriteService.checkFavoriteBean(favoriteBean.getFavoriteItemId(),
					favoriteBean.getFavoriteCategory(), originalCustomer);
			ReplyBean originalReply = replyService.findByReplyId(favoriteBean.getFavoriteItemId());
			CustomerBean authorCustomer =originalReply.getCustomerBean();
			Integer customerScore = authorCustomer.getCustomerScore();
			
			if (checkFavoriteBean == null) {
				// 若查無收藏則新增收藏
				favoriteBean.setCustomerBean(originalCustomer);
				favoriteService.addFavorite(favoriteBean);
				favoriteMessage.put("favoriteExist", true);
				authorCustomer.setCustomerScore(customerScore+1);
			} else if (checkFavoriteBean != null) {
				// 若已有收藏則取消收藏
				favoriteService.removeFavorite(checkFavoriteBean.getFavoriteId());
				favoriteMessage.put("favoriteExist", false);
				authorCustomer.setCustomerScore(customerScore-1);
			}
			model.addAttribute("customerSignInSuccess", originalCustomer);
			Integer count = favoriteService.countFavoriteItemIdAndFavoriteCategory(favoriteBean.getFavoriteItemId(),
					favoriteBean.getFavoriteCategory());
			originalReply.setReplyLike(count);
			replyService.updateByReplyId(originalReply);
			favoriteMessage.put("favoriteCount", count);

			return favoriteMessage;

		}
		
	
	
	
}
