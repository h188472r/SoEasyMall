package com.soeasy.service.replyService;

import java.util.List;

import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;

public interface ReplyService {

	// 查詢全部replyIdByReplyId
	List<ReplyBean> findAllByReplyId();
	
	// 查詢單篇留言ByReplyId
	ReplyBean findByReplyId(Integer replyId);

	// 查詢留言ByPostId
	List<ReplyBean> findByPostBean(PostBean postBean);

	// 查詢Top3的留言ByPostId
	List<ReplyBean> findTop3ByPostBeanOrderByReplyLikeDesc(PostBean postBean);

	// 新增留言
	void addReply(ReplyBean replyBean);

	// 修改留言
	void updateByReplyId(ReplyBean replyBean);

	// 刪除留言
	void deleteByReplyId(Integer replyId);
}
