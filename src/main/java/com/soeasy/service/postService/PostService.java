package com.soeasy.service.postService;

import java.util.List;

import com.soeasy.model.PostBean;
import com.soeasy.model.PostCategoryBean;
import com.soeasy.model.ProductBean;

public interface PostService {
	
	// 文章模糊查詢
	List<PostBean> findAllForKeyword(String keyword);

	// 查詢所有文章的 TOP3
	List<PostBean> findTop3();
	
	// 查詢所有文章的 TOP10
	List<PostBean> findTop10();

	// 查詢文章類別的 TOP10
	List<PostBean> findTop10ByPostCategoryBean(PostCategoryBean postCategoryBean);

	// 查詢全部(有分頁)-------------------------------------------------------------------------

	// 抓分頁一頁有哪些地圖
	List<PostBean> getPagePosts(int pageNo);
//	Map<String, Object> getPagePosts(int pageNo);
//		Map<Integer, PostBean> getPagePosts(int pageNo);

	// 抓資料庫裡全部有幾個地圖
	Long getRecordCounts();

	// 總共有幾頁
	Integer getTotalPages();

	// 查詢全部(有分頁)-------------------------------------------------------------------------

	// 查詢全部ByPostCategoryId(有分頁)-------------------------------------------------------------------------

	// 抓分頁一頁有哪些文章，依照PostCategoryId(PostBean裡PostCategoryId欄位名稱為PostCategoryBean)
	List<PostBean> getPageByPostCategoryBean(PostCategoryBean postCategoryBean, Integer pageNo);

	// 抓一個分類裡有多少個文章總數(搭配抓分頁一頁有哪些文章，依照PostCategoryId用)
	Long getRecordCountsByPostCategoryBean(PostCategoryBean postCategoryBean);

	// 一個分類總共有幾頁(搭配抓分頁一頁有哪些文章，依照PostCategoryId用)
	Integer getTotalPagesByPostCategoryId(PostCategoryBean postCategoryBean);

	// 查詢全部ByPostCategoryId(有分頁)-------------------------------------------------------------------------

	// 新增文章
	void addPost(PostBean postBean);

	// 查詢一筆By ID
	PostBean findByPostId(Integer postId);

	// 查詢全部
	List<PostBean> findAllByPostId();

	// 修改
	void updatePost(PostBean postBean);

	// 刪除
	void deleteByPostId(Integer postId);

	// 以多個ID查詢多篇文章
	List<PostBean> findAllById(List<Integer> postIds);
}
