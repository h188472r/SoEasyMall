package com.soeasy.service.postService.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.PostBean;
import com.soeasy.model.PostCategoryBean;
import com.soeasy.repository.postRepository.PostRepository;
import com.soeasy.service.postService.PostService;
import com.soeasy.util.GlobalService;

@Transactional
@Service
public class PostServiceImpl implements PostService {

	// 建立Logger
	private static final Logger logger = LoggerFactory.getLogger(PostServiceImpl.class);

	private int recordsPerPage = GlobalService.POSTS_PER_PAGE; // 預設值：每頁109筆
//	private int recordsPerPage = 10; // 預設值：每頁10筆
	private int totalPages = -1;

	@Autowired
	PostRepository postRepository;

	public PostServiceImpl() {
	}

	// 查詢所有文章的 TOP3
	@Override
	public List<PostBean> findTop3() {
		
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));
		
		List<PostBean> list = postRepository.findAll(sort);
		
		if(list.size()>=3) {
			
			List<PostBean> newList = list.subList(0,3);
			
			return newList;
		}
		
		return list;
		
	}
	
	// 查詢所有文章的 TOP10
	@Override
	public List<PostBean> findTop10() {
		
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));
		
		List<PostBean> list = postRepository.findAll(sort);
		
		if(list.size()>=10) {
			List<PostBean> newList = list.subList(0,10);
			
			return newList;
			
		}
		return list;
	}

	// 查詢文章類別的 TOP10
	@Override
	public List<PostBean> findTop10ByPostCategoryBean(PostCategoryBean postCategoryBean) {
		
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));
		
		List<PostBean> list = postRepository.findTop10ByPostCategoryBean(postCategoryBean,sort);
		
		return list;
	}

	// 查詢全部(有分頁)--------------------------------------------------------------------------------------------------
	@Override
	public List<PostBean> getPagePosts(int pageNo) {
//			System.err.println("進入service");

		// 排序
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));

		// PageRequest.of(pageNo, recordsPerPage): 第一個參數為 0-based
		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage, sort);


		Page<PostBean> beans = postRepository.findAll(pageable);

		// PostBean的List
		List<PostBean> list = beans.getContent();
		
		return list;
	}

	// 抓資料庫裡全部有幾個文章(搭配查詢所有文章，帶分頁用)
	@Override
	public Long getRecordCounts() {
		return postRepository.count();
	}

	// 總共有幾頁(搭配查詢所有文章，帶分頁用)
	@Override
	public Integer getTotalPages() {
		totalPages = (int) (Math.ceil(getRecordCounts() / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		return totalPages;
	}

	// 查詢全部(有分頁)-----------------------------------------------------------------------------------------

	// 查詢全部ByPostCategoryId(有分頁)-------------------------------------------------------------------------

//	 抓分頁一頁有哪些文章，依照PostCategoryId(PostBean裡PostCategoryId欄位名稱為PostCategoryBean)
	@Override
	public List<PostBean> getPageByPostCategoryBean(PostCategoryBean postCategoryBean, Integer pageNo) {

		// 排序
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));

		Pageable pageable = PageRequest.of(pageNo - 1, recordsPerPage, sort);


		Page<PostBean> beans = postRepository.findByPostCategoryBean(postCategoryBean, pageable);

		// PostBean的List
		List<PostBean> list = beans.getContent();

		return list;
	}

	// 抓一個分類裡有多少個文章總數(搭配抓分頁一頁有哪些文章，依照PostCategoryId用)
	@Override
	public Long getRecordCountsByPostCategoryBean(PostCategoryBean postCategoryBean) {
		return postRepository.countByPostCategoryBean(postCategoryBean);
	}

	// 一個分類總共有幾頁(搭配抓分頁一頁有哪些文章，依照PostCategoryId用)
	@Override
	public Integer getTotalPagesByPostCategoryId(PostCategoryBean postCategoryBean) {
		totalPages = (int) (Math.ceil(getRecordCountsByPostCategoryBean(postCategoryBean) / (double) recordsPerPage));
		logger.info("totalPages=" + totalPages);
		return totalPages;
	}

	// 查詢全部ByPostCategoryId(有分頁)-------------------------------------------------------------------------

	// 新增文章
	@Override
	public void addPost(PostBean postBean) {
		postRepository.save(postBean);
	}

	// 查詢單篇文章By postId
	@Override
	public PostBean findByPostId(Integer postId) {
		Optional<PostBean> optional = postRepository.findById(postId);
		PostBean postBean = null;
		if (optional.isPresent()) {
			postBean = optional.get();
		} else {
			throw new RuntimeException("PostBean(postId=" + postId + ")不存在");

		}
		return postBean;
	}

	// 查詢所有文章By postId
	@Override
	public List<PostBean> findAllByPostId() {
		return postRepository.findAll();
	}

	// 更新文章By postId
	@Override
	public void updatePost(PostBean postBean) {
		postRepository.save(postBean);
	}

	// 刪除文章By postId
	@Override
	public void deleteByPostId(Integer postId) {
		postRepository.deleteById(postId);
	}

	// 以多個ID查詢多篇文章
	@Override
	public List<PostBean> findAllById(List<Integer> postIds) {
		return postRepository.findAllById(postIds);
	}

	// 文章模糊查詢
	@Override
	public List<PostBean> findAllForKeyword(String keyword) {
		Sort sort = Sort.by(Sort.Order.desc("postUploadDate"), Sort.Order.desc("postLike"));
//		System.err.println("進入Service");
//		System.err.println("keyword="+keyword);
		
		System.err.println(postRepository.findAllForKeyword(keyword, sort));
		
//		System.err.println("出去Service");
		return postRepository.findAllForKeyword(keyword, sort);
	}

}
