<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Share</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<link
	href="https://fonts.googleapis.com/css2?family=Caudex&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/categoryNav.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<style type="text/css">
.addbtn {
	border-radius: 20px;
	border: 3px solid #28A745;
	background-color: transparent;
	padding: 1% 3%;
	font-family: Microsoft JhengHei;
}

.addbtn:hover {
	background-color: #28A745;
	color: white;
}
</style>

<script>
	document.addEventListener("DOMContentLoaded",function() {

		//變數宣告------------------------------------------------------------

		var pageNo = 0;
		var totalPage = 0;
		var responseData;
		var categoryStatus="all";

		//變數宣告------------------------------------------------------------

		
		//載入時 取得所有文章-----------------------------------------------------
		//新建XMLHttpRequest物件
		let xhr = new XMLHttpRequest();
		//設定連線內容
		xhr.open("GET","<c:url value='/PostController/getAllPost.json' />",true);
		//對伺服器發送請求
		xhr.send();
		//當readyState屬性值改變時呼叫此方法
		xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
		// 				console.log(xhr.responseText);

			var responseData = xhr.responseText;

			displayPagePosts(responseData); // 顯示讀取到的非文字性資料
			}
		}
		//載入時 取得所有文章-----------------------------------------------------

		// 當使用者按下『第一頁』、『前一頁』、『下一頁』、『最末頁』的連結時，由本方法發出非同步請求。
		// id為前端的唯一值的id
		function asynRequest(id) {
			var xhr = new XMLHttpRequest();
			var no = 0; // 頁數
			var queryString = ""; // queryString紀錄查詢字串
			
			if(categoryStatus=="all"){
				// 判斷頁數
				if (id == "first") { // 算出查詢字串中，要送出的pageNo為何?
					no = 1;
				} else if (id == "prev") {
					no = parseInt(pageNo) - 1;
				} else if (id == "next") {
					no = parseInt(pageNo) + 1;
				} else if (id == "last") {
					no = totalPage;
				}

				// 查詢字串包含1.即將要讀取的頁數(pageNo), 2.總共有幾頁(totalPage)
				// 注意，查詢字串的前面有問號
				queryString = "?pageNo=" + no + "&totalPage="+ totalPage;

				xhr.open("GET","<c:url value='/PostController/getAllPost.json' />"+ queryString, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var responseData = xhr.responseText;
						displayPagePosts(responseData);
					}
				}
			} else {
				// 判斷頁數
				if (id == "first") { // 算出查詢字串中，要送出的pageNo為何?
					no = 1;
				} else if (id == "prev") {
					no = parseInt(pageNo) - 1;
				} else if (id == "next") {
					no = parseInt(pageNo) + 1;
				} else if (id == "last") {
					no = totalPage;
				}

				// 查詢字串包含1.即將要讀取的頁數(pageNo), 2.總共有幾頁(totalPage)
				// 注意，查詢字串的前面有問號
				queryString = "?postCategoryBean="+categoryStatus+"&pageNo=" + no + "&totalPage="+ totalPage;

				xhr.open("GET","<c:url value='/PostController/getAllPostByPostCategoryId.json' />"+ queryString, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var responseData = xhr.responseText;
						displayPagePosts(responseData);
					}
				}
			}
			
		}
		
		// 當使用者按下『類別』的連結時，由本方法發出非同步請求。
		// id為前端的唯一值的id
		function categoryAsynRequest(name) {
			var xhr = new XMLHttpRequest();
			var postCategoryBean = 0; // 類別
			var queryString = ""; // queryString紀錄查詢字串
			
			// 判斷類別
			// 假如類別為全部則送全部的請求
			if (name == "all") { 
				xhr.open("GET","<c:url value='/PostController/getAllPost.json' />", true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var responseData = xhr.responseText;
						displayPagePosts(responseData);
					}
				}	
				
			// 假如類別為各類別則送類別的請求
			} else { // 算出查詢字串中，要送出的postCategoryBean為何?
				if (name == "c1") {
					postCategoryBean = 1;
				} else if (name == "c2") {
					postCategoryBean = 2;
				} else if (name == "c3") {
					postCategoryBean = 3;
				} else if (name == "c4") {
					postCategoryBean = 4;
				} else if (name == "c5") {
					postCategoryBean = 5;
				} else if (name == "c6") {
					postCategoryBean = 6;
				} else if (name == "c7") {
					postCategoryBean = 7;
				} else if (name == "c8") {
					postCategoryBean = 8;
				}
				
				// 查詢字串包含1.即將要讀取的類別(postCategoryBean),
				// 注意，查詢字串的前面有問號
				queryString = "?postCategoryBean=" + postCategoryBean ;

				xhr.open("GET","<c:url value='/PostController/getAllPostByPostCategoryId.json' />"+ queryString, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var responseData = xhr.responseText;
						displayPagePosts(responseData);
					}
				}
			}		
		}
		
		function favoritePost() {
			let inputFavoritePostId = null;
			$(".postShowFavorite").on('click', function (event) {
				console.log("點擊愛心");
				console.log(this.dataset.id);
				let updateFavoritePostId = this.dataset.id;
				let postLike = document.getElementById("postLike"+updateFavoritePostId);
				let postImg = document.getElementById("postImg"+updateFavoritePostId);

				//建一支Object，裝收藏controller要的內容
				let favoriteInfo = {
					'favoriteCategory': 'post',
					'favoriteItemId': updateFavoritePostId
				}

				//將物件轉為json			
				let json = JSON.stringify(favoriteInfo);

				console.log(json);

				xhr.open('POST', "<c:url value='/favoriteController/addFavoritePost'/>");
				xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
				xhr.send(json);

				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4 && xhr.status == 200) {

						if (xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn") {
							location.href = "/soeasy/customerController/customerSignIn";
						}

						let favoriteJson = JSON.parse(xhr.responseText);
						console.log(favoriteJson);
						//更改圖片
						if (favoriteJson.favoriteExist) {
							postImg.src = "${pageContext.request.contextPath}/images/post/heart.png";
							postLike.innerHTML = favoriteJson.favoriteCount;
						} else {
							postImg.src = "${pageContext.request.contextPath}/images/post/heart-empty.png";
							postLike.innerHTML = favoriteJson.favoriteCount;

						}

					}

				}
			})
		}

		// 顯示送回來的所有文章
		function displayPagePosts(responseData) {

			var mapObj = JSON.parse(responseData);
			var posts = mapObj.post_DPP;
			pageNo = mapObj.currPage;
			totalPage = mapObj.totalPage;
			
			let content = "";

			console.log("totalPage="+totalPage);
			
			if(totalPage == 0){
				content += '<div style="display:flex; width:100%">'
				
						+'<div class="span6">'
						+'<img src="${pageContext.request.contextPath}/images/post/postNoFind.jpg" style="width:200%;">'
						+'</div>'
						
						+'<div class="span6" style="padding-top:10%;">'
						+'<h2 style="letter-spacing: 3px;font-family: Microsoft YaHei;">還未有人在此發過文章</h2>'
						+'<h4 style="letter-spacing: 3px; line-height: 30px; font-family: Microsoft JhengHei;">還未有人在此發過文章。'
						+'<br>'
						+'趕快來分享你的故事。'
						+'<br>'
						+'成為第一個發文的人。'
						+'</h4>'
						+'<a href="<c:url value="/PostNeedLoginController/addPost "/>">'
						+'<button class="addbtn" style="letter-spacing: 3px;">'
						+'新增分享'
						+'</button>'
						+'</a>'
						+'</div>'
						
						+'</div>'
			}else{

			//內容
			(posts).forEach(post =>{
// 			Object.entries(posts).forEach(([i,post]) =>{
// 			console.log("totalPage="+totalPage);
			
			console.log("post.favoriteStatus=" + post.favoriteStatus);
			
			// 有無收藏
			if (post.favoriteStatus === false || post.favoriteStatus === null) {
				// Like圖片(無收藏)ID
				img = '<img id="postImg'+post.postId+'" src="${pageContext.request.contextPath}/images/post/heart-empty.png">'
			} else {
				// Like圖片(有收藏)ID
				img = '<img id="postImg'+post.postId+'" src="${pageContext.request.contextPath}/images/post/heart.png">'
			}
	
			content += '<div class="row-fluid" style="border-bottom: 4px #325b43 dotted; margin-bottom: 1%; padding: 1% 1% 0% 1%;">'
				+ '<div class="row-fluid" style="margin-bottom: 1%; padding-bottom: 1%;">'
				+ '<div class="span9">'
				+ '<div class="media">'
				// 						文章圖片
				+ '<a class="pull-left" href=""> <img class="media-object" style="width: 100px; height: 100px; border: 1px lightgrey dashed;" src="<c:url value="/PostController/getPicture/' + post.postId + ' " />" /></a>'
				+ '<div class="media-body" style="line-height: 30px;">'
				//	 					文章標題+類別
				+ '<h3 class="media-heading">'
				+ post.postTitle
				+ '&nbsp;<button class="btn-success">'
				+ post.postCategory
				+ '</button></h3>'
				//	 					文章內容(取前100字)
				+ post.postContent.substring(0, 100) + '...'
				//	 					觀看單篇文章
				+ ' <a href="<c:url value="/PostNeedLoginController/getPost/' + post.postId + '" />">>>>觀看更多 </a>'
				+ '</div>'
				+ '</div>'
				+ '</div>'
				+ '<div class="span3" style="display:block;">'

				+ '<div style="display:flex; align-items :end;" class="postFavorite" data-id="' + post.postId + '">'
				//							Like按鈕(無收藏)ID
				+ '<button class="postShowFavorite"  data-id="' + post.postId + '"'
				+ 'style="border: none; background-color: transparent;">'
				+ img
				+ '</button>'
				//	 						Like數量
				+ '<p id="postLike' + post.postId + '">'
				+ post.postLike + '</p>'
				+ '</div>'

				+ '<p style="font-size: 15px; color: grey;">'
				+ '	<br> <br> By '
				//	 					暱稱
				+ post.customerBean.customerNickname
				+ '<br>'
				//	 					文章上傳時間
				+ post.postUploadTime.substring(0, 16)
				+ '</p>'
				+ '</div>'
				+ '</div>'
				+ '</div>'

				});
				
			}
					
			document.getElementById("insertPosts").innerHTML = content;
			favoritePost();
		

			// 	頁數區塊----------------------------------------------------------------------------------------------
			var navContent = "<div class='pagination pagination-large pagination-centered'><ul>";
			if (pageNo != 1) {
				navContent += "	<li><a id='first' style='color:green;'>第一頁</a></li>";
				navContent += "<li><a id='prev' style='color:green;'>前一頁</a></li>";
			} else {
				navContent += "<li>&nbsp;</li>";
				navContent += "<li>&nbsp;</li>";
			}
			
			
			navContent += "<li><a style='text-decoration:none; color:green;'>第" + pageNo + "頁 / 共"+ totalPage + "頁</a></li>";
			if (pageNo != totalPage) {
				navContent += "<li><a id='next' style='color:green;'>下一頁</a></li>";
				navContent += "<li><a id='last' style='color:green;'>最末頁</a></li>";
			} else {
				navContent += "<li>&nbsp;</li>";
				navContent += "<li>&nbsp;</li>";
			}
			
			if(totalPage == 0){
				document.getElementById("navigation").innerHTML ="";
			}else{
				document.getElementById("navigation").innerHTML = navContent;
			}
			
			// 	頁數區塊----------------------------------------------------------------------------------------------
			
			// 	頁數事件----------------------------------------------------------------------------------------------

			var firstBtn = document.getElementById("first");
			var prevBtn = document.getElementById("prev");
			var nextBtn = document.getElementById("next");
			var lastBtn = document.getElementById("last");
							
			if (firstBtn != null) {
				firstBtn.onclick = function() {
				asynRequest(this.id);
				}
			}

			if (prevBtn != null) {
				prevBtn.onclick = function() {
				asynRequest(this.id);
				}
			}

			if (nextBtn != null) {
				nextBtn.onclick = function() {
				asynRequest(this.id);
				}
			}

			if (lastBtn != null) {
				lastBtn.onclick = function() {
				asynRequest(this.id);
				}
			}

			// 	頁數事件----------------------------------------------------------------------------------------------
			

		}
//	 	類別事件----------------------------------------------------------------------------------------------
		
		var categoryall = document.getElementById("all");
		var categoryC1 = document.getElementById("c1");
		var categoryC2 = document.getElementById("c2");
		var categoryC3 = document.getElementById("c3");
		var categoryC4 = document.getElementById("c4");
		var categoryC5 = document.getElementById("c5");
		var categoryC6 = document.getElementById("c6");
		var categoryC7 = document.getElementById("c7");
		var categoryC8 = document.getElementById("c8");
						
		if (categoryall != null) {
			categoryall.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=all;
			}
		}
		
		if (categoryC1 != null) {
			categoryC1.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=1;
			}
		}
		if (categoryC2 != null) {
			categoryC2.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=2;
			}
		}
		if (categoryC3 != null) {
			categoryC3.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=3;
			}
		}
		if (categoryC4 != null) {
			categoryC4.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=4;
			}
		}
		if (categoryC5 != null) {
			categoryC5.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=5;
			}
		}
		if (categoryC6 != null) {
			categoryC6.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=6;
			}
		}
		if (categoryC7 != null) {
			categoryC7.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=7;
			}
		}
		if (categoryC8 != null) {
			categoryC8.onclick = function() {
				categoryAsynRequest(this.id);
				categoryStatus=8;
			}
		}
		
		// 	類別事件----------------------------------------------------------------------------------------------

	})	
</script>

</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Share</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						Taking Our Health in Our Hands!</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						Let's Share Your Story.</p>
				</div>

			</div>

		</section>
	</div>

	<div class="container-fluid">
		<div class="row-fluid" style="width: 80%; padding-left: 10%;">
			<div class="span12">
				<div class="row-fluid">
					<div class="row-fluid" style="border-radius: 5px; padding-top: 5%;">
						<div class="span8" style="margin: 0px; margin-bottom: 1%;">
							<nav class="menu">
								<ol>
									<li class="menu-item"><a class="navbara" href="#0"
										id="all">全部</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c1">減肥</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c2">飲食</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c3">運動</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c4">健康</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c5">健身</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c6">講座</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c7">商品</a></li>
									<li class="menu-item"><a class="navbara" href="#0" id="c8">問答</a></li>
								</ol>
							</nav>
						</div>
						<div class="span4">
							<div>
								<div class="span10">
									<form class="form-search" method="get" action="<c:url value='/PostController/getAllPostsForKeyword'/>">
										<input class="input-medium search-query" type="text"
											name="keyword" />
										<button type="submit" class="btn">Search</button>
									</form>
								</div>
								<div class="span1 text-right">
									<a href="<c:url value='/PostNeedLoginController/addPost '/>">
										<button
											class="btn btn-success btn-large glyphicon glyphicon-plus"
											aria-hidden="true" type="button"></button>
									</a>
								</div>
							</div>
						</div>
						<hr style="color: transparent;">
						<br> <br> <br> <br>

						<!-- ------------------------------內容區塊--------------------------------- -->
						<div id="insertPosts"></div>
						<!-- ------------------------------內容區塊--------------------------------- -->

						<!-- ------------------------------分頁區塊--------------------------------- -->
						<div id='navigation' style='height: 60px;'></div>
						<!-- ------------------------------分頁區塊--------------------------------- -->

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>