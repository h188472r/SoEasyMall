package com.soeasy.service.replyService.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;
import com.soeasy.repository.replyRepository.ReplyRepository;
import com.soeasy.service.replyService.ReplyService;

@Transactional
@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepository;

	public ReplyServiceImpl() {
	}

	// 查詢全部ByReplyId
	@Override
	public List<ReplyBean> findAllByReplyId() {
		return replyRepository.findAll();
	}

	@Override
	public ReplyBean findByReplyId(Integer replyId) {
		Optional<ReplyBean> optional = replyRepository.findById(replyId);
		ReplyBean replyBean = null;

		if (optional.isPresent()) {
			replyBean = optional.get();
		} else {
			throw new RuntimeException("ReplyBean(replyId=" + replyId + ")不存在");
		}

		return replyBean;
	}

	// 查詢留言ByPostId
	@Override
	public List<ReplyBean> findByPostBean(PostBean postBean) {

//		System.err.println("進入Service---------------------------------------");

		List<ReplyBean> list = replyRepository.findByPostBean(postBean);
//		System.err.println("list="+list);
//		
//		System.err.println("出去Service---------------------------------------");

		return list;
	}

	// 查詢Top3的留言ByPostId
	@Override
	public List<ReplyBean> findTop3ByPostBeanOrderByReplyLikeDesc(PostBean postBean) {
//		System.err.println("進入Service---------------------------------------");

		List<ReplyBean> list = replyRepository.findTop3ByPostBeanOrderByReplyLikeDesc(postBean);
//		System.err.println("list="+replyRepository.findByPostBean(postBean));
////		
//		System.err.println("出去Service---------------------------------------");
		return list;
	}

	// 新增留言
	@Override
	public void addReply(ReplyBean replyBean) {
		replyRepository.save(replyBean);
	}

	// 修改留言
	@Override
	public void updateByReplyId(ReplyBean replyBean) {
		replyRepository.save(replyBean);
	}

	// 刪除留言
	@Override
	public void deleteByReplyId(Integer replyId) {
		replyRepository.deleteById(replyId);
	}

}
