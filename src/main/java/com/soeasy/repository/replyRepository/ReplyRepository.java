package com.soeasy.repository.replyRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;

public interface ReplyRepository extends JpaRepository<ReplyBean, Integer> {
	
	// 查詢留言ByPostId 
	List<ReplyBean> findByPostBean(PostBean postBean);
	
	// 查詢Top3的留言ByPostId 
	List<ReplyBean> findTop3ByPostBeanOrderByReplyLikeDesc(PostBean postBean);
	
	
	
	
	
	
	
	
	

}
