package com.soeasy.service.postService.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.PostCategoryBean;
import com.soeasy.repository.postRepository.PostCategoryRepository;
import com.soeasy.service.postService.PostCategoryService;

@Transactional
@Service
public class PostCategoryServiceImpl implements PostCategoryService {

	@Autowired
	PostCategoryRepository postCategoryRepository;

	@Override
	public PostCategoryBean getPostCategory(Integer postCategoryId) {
		Optional<PostCategoryBean> optional = postCategoryRepository.findById(postCategoryId);
		PostCategoryBean postCategoryBean = null;
		// isPresent()判斷值存在就回傳true
		if (optional.isPresent()) {
			postCategoryBean = optional.get();
		} else {
//			throw new RuntimeException("PostCategoryBean(id=" + postCategoryId + ")不存在");
		}
		return postCategoryBean;
	}

	// 取出所有類別
	@Override
	public List<PostCategoryBean> getAllPostCategorys() {
		
		List<PostCategoryBean> postCategory = postCategoryRepository.findAll();
		
		
		
		return (List<PostCategoryBean>) postCategoryRepository.findAll();
	}

}
