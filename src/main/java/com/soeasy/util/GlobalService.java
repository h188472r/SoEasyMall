package com.soeasy.util;

public class GlobalService {
	// 會員
	// 會員帳號狀態
	public static final Integer CUSTOMER_STATUS_NORMAL = 1;
	public static final Integer CUSTOMER_STATUS_BANNED = 2;

	// 會員健康資訊
	// 性別
	public static final Integer CUSTOMER_GENDER_MALE = 1;
	public static final Integer CUSTOMER_GENDER_FEMALE = 2;
	// 運動習慣
	public static final Integer CUSTOMER_EXERCISE_WEAK = 1;
	public static final Integer CUSTOMER_EXERCISE_NORMAL = 2;
	public static final Integer CUSTOMER_EXERCISE_STRONG = 3;
	// 飲食習慣
	public static final Integer CUSTOMER_DIET_MEAT = 1;
	public static final Integer CUSTOMER_DIET_VAGETABLE = 2;

	// 廠商
	// 廠商帳號狀態
	public static final Integer SHOP_STATUS_NORMAL = 1;
	public static final Integer SHOP_STATUS_BANNED = 2;

	// 商品
	public static final Integer PRODUCT_PER_PAGE = 10;

	// 地圖
	public static final int SPORTMAPS_PER_PAGE = 6;
	
	// 講座分頁(精彩回顧)
	public static final Integer LECTURE_PER_PAGE = 5;

	// 講座狀態
	public static final Integer LECTURE_STATUS_UPCOMING = 1; // 即將舉辦
	public static final Integer LECTURE_STATUS_ONGOING = 2; // 進行中
	public static final Integer LECTURE_STATUS_ARCHIVED = 3; // 精采回顧

	// 講座分類
	public static final Integer LECTURE_CATEGORY_EAT = 1; // 飲食
	public static final Integer LECTURE_CATEGORY_EXERCISE = 2; // 運動

	// 講座預約狀態
	public static final Integer RESERVATION_STATUS_SUCCESS = 1; // 預約成功
	public static final Integer RESERVATION_STATUS_WAITINGLIST = 2; // 候補名單
	public static final Integer RESERVATION_STATUS_CANCEL = 3; // 取消預約
	public static final Integer RESERVATION_STATUS_ATTEND = 4; // 出席
	public static final Integer RESERVATION_STATUS_ABSENCE = 5; // 缺席
	
	// 講師分頁
	public static final Integer LECTURER_PER_PAGE = 6;

	// 分享
	// 文章狀態
	public static final Integer POST_STATUS_NORMAL = 1;
	public static final Integer POST_STATUS_BANNED = 2;
	// 一頁預設5篇文章
	public static final int POSTS_PER_PAGE = 5;

	// 留言狀態
	public static final Integer REPLY_STATUS_NORMAL = 1;
	public static final Integer REPLY_STATUS_BANNED = 2;

	// 營養師
	// 性別
	public static String NUTRITIONIST_GENDER_MALE = "男性";
	public static String NUTRITIONIST_GENDER_FEMALE = "女性";

	// 營養師
	public static final int NUTRITIONISTS_PER_PAGE = 6;

}
