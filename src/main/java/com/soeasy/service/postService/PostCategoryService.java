package com.soeasy.service.postService;

import java.util.List;

import com.soeasy.model.PostCategoryBean;

public interface PostCategoryService {

	// 撈出SportCategory by ID
	PostCategoryBean getPostCategory(Integer postCategoryId);

	// 取出所有SportCategory
	List<PostCategoryBean> getAllPostCategorys();

}
