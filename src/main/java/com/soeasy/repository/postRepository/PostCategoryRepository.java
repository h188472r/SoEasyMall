package com.soeasy.repository.postRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.PostCategoryBean;


public interface PostCategoryRepository extends JpaRepository<PostCategoryBean, Integer>{

}
