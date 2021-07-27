<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>So Share</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/categoryNav.css">
<link rel="stylesheet" href="css/header&footer.css">
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
<!-- -----------------------------取得所有文章的Top3區塊------------------------------------ -->
<script>
document.addEventListener("DOMContentLoaded",function() {
	
	//變數宣告------------------------------------------------------------

	let top3Posts;

	//變數宣告------------------------------------------------------------
	
	//載入時 取得所有文章的Top3-----------------------------------------------------
	//新建XMLHttpRequest物件
	let xhr = new XMLHttpRequest();
	//設定連線內容
	xhr.open("GET","<c:url value='/PostController/getTop3Post'/>",true);
	//對伺服器發送請求
	xhr.send();
	//當readyState屬性值改變時呼叫此方法
	xhr.onreadystatechange = function() {
	if (xhr.readyState == 4 && xhr.status == 200) {

// 		console.log(xhr.responseText);
		top3Posts = JSON.parse(xhr.responseText);
// 		console.log("top3Posts="+top3Posts);

		displaytop3Post(); // 顯示讀取到的非文字性資料
		}
	}
	
	// 顯示送回來的所有文章
	function displaytop3Post() {
		
		let contentTop3 = "";
		
		(top3Posts).forEach(post =>{
			
// 			console.log(post.postTitle);
			
			contentTop3 += '<li class="span4">'
						+ '<div class="thumbnail">'
//						文章圖片
						+'<img alt="" src="<c:url value="/PostController/getPicture/'+post.postId+' " />" style="width: 300px; height: 300px; object-fit: cover;"/>'
						+'<div class="caption">'
//						文章標題
						+'<h3>'+post.postTitle+'</h3>'
//						文章內容
						+'<p>'+post.postContent.substring(0,26)+ '...</p>'
//						觀看更多
						+'<a href="<c:url value="/PostNeedLoginController/getPost/'+post.postId+'" />"> >>>觀看更多 </a>'
						+'<div style="display: block; text-align: right;">'
//						Like按鈕SVG
// 						+'<svg id="color" enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m22.843 12.586c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.384-.144-.686-.445-.829-.829l-.76-2.024c-.282-.754-.871-1.362-1.615-1.671-.741-.308-1.59-.293-2.323.04l-1.969.895c-.373.17-.801.17-1.172 0l-1.97-.895c-.732-.334-1.581-.349-2.323-.04-.744.308-1.333.917-1.615 1.671l-.76 2.024c-.143.384-.445.685-.829.829l-2.024.76c-.754.282-1.363.871-1.671 1.615-.308.743-.293 1.59.04 2.323l.895 1.969c.169.372.169.8 0 1.172l-.895 1.969c-.333.733-.348 1.58-.04 2.323.309.744.917 1.333 1.671 1.615l2.024.76c.384.144.686.445.829.829l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.373-.17.801-.17 1.172 0l1.969.895c.732.334 1.581.348 2.323.04.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323z" fill="#f44336"/><g fill="#fafafa"><path d="m13.414 9.702c-.877-.877-2.305-.877-3.182 0s-.877 2.305 0 3.182l1.414 1.414c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182zm.354 3.535c-.293.293-.768.293-1.061 0l-1.414-1.414c-.292-.292-.292-.769 0-1.061.146-.147.338-.219.53-.219s.384.072.53.219l1.414 1.414c.293.293.293.769.001 1.061z"/><path d="m8.818 12.177c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l1.237 1.237-1.061 1.062-1.238-1.238c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l3.536 3.536c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z"/><path d="m18.364 9.702-3.006-3.006.53-.53c.293-.293.293-.768 0-1.061s-.768-.293-1.061 0l-1.059 1.06-.002.001-.001.001-1.06 1.061c-.293.293-.293.768 0 1.061.146.146.339.22.53.22.192 0 .384-.073.53-.22l.53-.531 3.006 3.006c.146.146.338.22.53.22s.384-.073.53-.22c.296-.294.296-.769.003-1.062z"/></g><path d="m13.025 11.435-1.061 1.061.742.742c.146.146.338.22.53.22s.384-.073.53-.22c.292-.292.292-.769 0-1.061zm6.809-6.809-3.273 3.273 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.804-1.804-1.415 1.415.742.742c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658s-1.152-.22-1.591-.658l-.742-.742-.354.354 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.237-1.237-1.061 1.062 1.237 1.237c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.803-1.803-2.743 2.743c.048.078.089.161.121.248l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.187-.085.387-.127.587-.127s.4.042.585.127l1.969.895c.381.174.795.261 1.208.261.38 0 .76-.074 1.116-.221.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323l-.895-1.969c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.087-.036-.17-.076-.248-.124z" fill="#d43a2f"/><path d="m14.086 10.374-1.061 1.061.742.742c.292.292.292.768 0 1.061-.147.146-.338.22-.53.22s-.384-.073-.53-.22l-.742-.742-1.061 1.061.742.742c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182z" fill="#dadada"/><path d="m10.551 13.909-3.182 3.182 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/><path d="m16.561 7.899-1.061 1.06 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/></svg>'
// 						+'<svg enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><g id="color"><g><g><path d="m21.758 12.527c-.152-.335-.152-.72 0-1.055l.805-1.772c.3-.66.313-1.422.036-2.091-.278-.67-.825-1.2-1.504-1.454l-1.822-.684c-.345-.129-.617-.401-.746-.746l-.684-1.822c-.253-.677-.783-1.225-1.453-1.503-.667-.277-1.431-.264-2.091.036l-1.772.805c-.336.153-.721.153-1.055 0l-1.771-.805c-.659-.3-1.423-.313-2.091-.036-.67.278-1.2.825-1.454 1.504l-.684 1.822c-.129.346-.4.617-.746.746l-1.822.684c-.678.254-1.226.784-1.504 1.454-.276.669-.263 1.431.036 2.091l.805 1.772c.152.335.152.72 0 1.055l-.805 1.772c-.3.66-.313 1.422-.036 2.091.278.67.825 1.2 1.504 1.454l1.822.684c.345.129.617.401.746.746l.684 1.822c.254.677.784 1.225 1.454 1.503.32.133.662.199 1.004.199.372 0 .744-.078 1.087-.235l1.772-.805c.336-.153.721-.153 1.055 0l1.772.805c.659.301 1.423.313 2.091.036.67-.278 1.2-.825 1.454-1.504l.684-1.822c.129-.345.401-.617.746-.746l1.822-.684c.679-.254 1.226-.784 1.504-1.454.277-.669.264-1.431-.036-2.091z" fill="#f44336"/></g></g></g><g id="_x31_.5"><g><g><path d="m8.237 23.998c-.38 0-.76-.073-1.115-.221-.744-.309-1.333-.917-1.615-1.671l-.76-2.024c-.144-.384-.445-.686-.829-.829l-2.024-.76c-.754-.282-1.362-.871-1.671-1.615-.308-.743-.293-1.59.04-2.323l.895-1.969c.169-.372.169-.8 0-1.172l-.895-1.969c-.333-.733-.348-1.58-.04-2.323.308-.744.917-1.333 1.671-1.615l2.024-.76c.384-.144.686-.445.829-.829l.76-2.024c.282-.754.871-1.363 1.615-1.671.742-.309 1.591-.294 2.323.04l1.969.895c.371.17.799.17 1.172 0l1.969-.895c.733-.333 1.582-.348 2.323-.04.744.309 1.333.917 1.615 1.671l.76 2.024c.144.384.445.686.829.829l2.024.76c.754.282 1.362.871 1.671 1.615.308.743.293 1.59-.04 2.323l-.895 1.969c-.169.372-.169.8 0 1.172l.895 1.969c.333.733.348 1.58.04 2.323-.309.744-.917 1.333-1.671 1.615l-2.024.76c-.384.144-.686.445-.829.829l-.76 2.024c-.282.754-.871 1.362-1.615 1.671-.741.308-1.59.294-2.323-.04l-1.969-.895c-.371-.17-.799-.17-1.172 0l-1.969.895c-.382.174-.795.261-1.208.261zm.001-22.498c-.184 0-.367.036-.543.108-.366.152-.645.44-.784.812l-.76 2.024c-.296.788-.918 1.41-1.706 1.706l-2.024.76c-.372.14-.66.418-.812.784-.151.367-.145.768.02 1.129l.895 1.969c.349.768.349 1.646 0 2.414l-.895 1.969c-.164.361-.171.762-.02 1.129.152.366.44.645.812.784l2.024.76c.788.296 1.41.918 1.706 1.706l.76 2.024c.14.372.418.66.784.812.366.15.767.144 1.129-.02l1.969-.895c.768-.35 1.646-.35 2.414 0l1.969.895c.361.163.763.171 1.129.02.366-.152.645-.44.784-.812l.76-2.024c.296-.788.918-1.41 1.706-1.706l2.024-.76c.372-.14.66-.418.812-.784.151-.367.145-.768-.02-1.129l-.895-1.969c-.349-.768-.349-1.646 0-2.414l.895-1.969c.164-.361.171-.762.02-1.129-.152-.366-.44-.645-.812-.784l-2.024-.76c-.788-.296-1.41-.918-1.706-1.706l-.76-2.024c-.14-.372-.418-.66-.784-.812-.367-.15-.767-.144-1.129.02l-1.969.895c-.768.35-1.646.35-2.414 0l-1.969-.895c-.187-.085-.386-.128-.586-.128z"/></g></g><g><g><g><path d="m13.237 14.956c-.576 0-1.152-.22-1.591-.658l-1.414-1.414c-.877-.877-.877-2.305 0-3.182s2.305-.877 3.182 0l1.414 1.414c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658zm-1.414-4.412c-.192 0-.384.072-.53.219-.292.292-.292.769 0 1.061l1.414 1.414c.293.293.768.293 1.061 0 .292-.292.292-.769 0-1.061l-1.414-1.414c-.147-.147-.338-.219-.531-.219z"/></g></g><g><g><path d="m13.237 8.508c-.191 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.293-.293.768-.293 1.061 0s.293.768 0 1.061l-2.121 2.122c-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m9.702 19.114c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m11.823 16.992c-.192 0-.384-.073-.53-.22l-3.535-3.535c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.535 3.535c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m17.834 10.982c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.339.22-.531.22z"/></g></g><g><g><path d="m7.935 17.347c-.192 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.292-.292.767-.294 1.061 0 .293.293.293.768 0 1.061l-2.121 2.122c-.148.146-.339.22-.531.22z"/></g></g></g></g></svg>'
						+'<img src="${pageContext.request.contextPath}/images/post/postHot.png">&nbsp;&nbsp;&nbsp;'
						
//						Like數量
						+ post.postLike
						+'<p style="font-size: 15px; color: grey;">By &nbsp;'+post.customerBean.customerNickname+'</p>'
//						文章上傳時間
						+'<p style="font-size: 15px; color: grey;">'+post.postUploadTime.substring(0,16)+'</p>'
						+'</div>'
						+'</div>'
						+'</div>'
						+'</li>'
						+''
		})
		document.getElementById("insertTop3").innerHTML = contentTop3;
	}
})
</script>
<!-- -----------------------------取得所有文章的Top3區塊------------------------------------ -->

<!-- -----------------------------取得文章類別的Top10區塊------------------------------------ -->

<script>
document.addEventListener("DOMContentLoaded",function() {
	
	//變數宣告------------------------------------------------------------

	let top10PostsByCategory;

	//變數宣告------------------------------------------------------------
	
	//載入時 取得所有文章的Top10-----------------------------------------------------
	//新建XMLHttpRequest物件
	let xhr = new XMLHttpRequest();
	//設定連線內容
	xhr.open("GET","<c:url value='/PostController/getTop10Post'/>",true);
	//對伺服器發送請求
	xhr.send();
	//當readyState屬性值改變時呼叫此方法
	xhr.onreadystatechange = function() {
	if (xhr.readyState == 4 && xhr.status == 200) {

		top10PostsByCategory = JSON.parse(xhr.responseText);
// 		console.log(xhr.responseText);
// 		console.log("top10PostsByCategory="+top10PostsByCategory);

		displaytop10PostByCategory(); // 顯示讀取到的非文字性資料
		}
	}
	
	// 當使用者按下『類別』的連結時，由本方法發出非同步請求。
	// id為前端的唯一值的id
	function categoryAsynRequest(id) {
		var xhr = new XMLHttpRequest();
		var postCategoryBean = 0; // 類別
		var queryString = ""; // queryString紀錄查詢字串
		
		// 判斷類別
		// 假如類別為全部則送全部的請求
		if (id == "all") { 
			xhr.open("GET","<c:url value='/PostController/getTop10Post' />", true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					top10PostsByCategory = JSON.parse(xhr.responseText);
					displaytop10PostByCategory();
				}
			}	
			
		// 假如類別為各類別則送類別的請求
		} else { // 算出查詢字串中，要送出的postCategoryBean為何?
			if (id == "c1") {
				postCategoryBean = 1;
			} else if (id == "c2") {
				postCategoryBean = 2;
			} else if (id == "c3") {
				postCategoryBean = 3;
			} else if (id == "c4") {
				postCategoryBean = 4;
			} else if (id == "c5") {
				postCategoryBean = 5;
			} else if (id == "c6") {
				postCategoryBean = 6;
			} else if (id == "c7") {
				postCategoryBean = 7;
			} else if (id == "c8") {
				postCategoryBean = 8;
			}
			
			// 查詢字串包含1.即將要讀取的類別(postCategoryBean),
			// 注意，查詢字串的前面有問號
			queryString = "?postCategoryBean=" + postCategoryBean ;

			xhr.open("GET","<c:url value='/PostController/getTop10PostByPostCategoryId.json' />"+ queryString, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					top10PostsByCategory = JSON.parse(xhr.responseText);
					displaytop10PostByCategory();
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
	function displaytop10PostByCategory() {
		
// 		console.log(xhr.responseText);
// 		console.log(top10PostsByCategory);
		
		
		let contentTop10 = "";
// 		console.log(top10PostsByCategory.length == 0);
		
		
		
		if(top10PostsByCategory.length == 0){
			contentTop10 += '<div style="display:flex; width:100%">'
				
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
		
		(top10PostsByCategory).forEach(post =>{
			
			console.log("post.favoriteStatus=" + post.favoriteStatus);
			
			// 有無收藏
			if (post.favoriteStatus === false || post.favoriteStatus === null) {
				// Like圖片(無收藏)ID
				img = '<img id="postImg'+post.postId+'" src="${pageContext.request.contextPath}/images/post/heart-empty.png">'
			} else {
				// Like圖片(有收藏)ID
				img = '<img id="postImg'+post.postId+'" src="${pageContext.request.contextPath}/images/post/heart.png">'
			}
			
// 			console.log(post.postTitle);
			
			contentTop10 += '<div class="row-fluid" style="border-bottom: 4px #325b43 dotted; margin-bottom: 1%; padding: 1% 1% 0% 1%;">'
				+ '<div class="row-<fluid" style="margin-bottom: 1%; padding-bottom: 1%;">'
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
// 		console.log(contentTop10);
		document.getElementById("insertTop10").innerHTML = contentTop10;
		favoritePost();
	}
	
// 	類別事件----------------------------------------------------------------------------------------------
	
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
		}
	}
	
	if (categoryC1 != null) {
		categoryC1.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC2 != null) {
		categoryC2.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC3 != null) {
		categoryC3.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC4 != null) {
		categoryC4.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC5 != null) {
		categoryC5.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC6 != null) {
		categoryC6.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC7 != null) {
		categoryC7.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	if (categoryC8 != null) {
		categoryC8.onclick = function() {
			categoryAsynRequest(this.id);
		}
	}
	
	// 	類別事件----------------------------------------------------------------------------------------------
	
	
})
</script>

<!-- -----------------------------取得文章類別的Top10區塊------------------------------------ -->

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

	<div class="container-fluid" style="width: 80%; padding-left: 10%;">
		<div class="row-fluid">
			<div class="span12">
				<div class="row-fluid">
					<div class="span12">
						<h3>熱門文章</h3>
						<!-- 	---------------------------insertTop3區塊------------------------------ -->
						<ul class="thumbnails" id=insertTop3>

						</ul>
						<!-- 	---------------------------insertTop3區塊------------------------------ -->
					</div>
				</div>
				<div class="row-fluid">
					<div class="span8" style="margin: 0px; margin-bottom: 1%;">
						<nav class="menu">
							<ol>
								<li class="menu-item"><a class="navbara" href="#0" id="all">全部</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c1">減肥</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c2">飲食</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c3">運動</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c4">健康</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c5">健身</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c6">講座</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c7">商品</a></li>
								<li class="menu-item"><a class="navbara" href="#0" id="c8">問答</a></li>
								<li class="menu-item"><a class="navbara"
									href="<c:url value="/postByCategory" />">觀看更多</a></li>
							</ol>
						</nav>
					</div>
					<div class="span4">
						<div>
							<div class="span10">
								<form class="form-search" method="get" action="<c:url value='/PostController/getAllPostsForKeyword'/>">
									<input class="input-medium search-query" type="text" name="keyword"/>
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
					<br> <br> <br> <br> <br>

					<!-- 	---------------------------insertTop10區塊------------------------------ -->
					<div class="row-fluid" id="insertTop10"></div>
					<!-- 	---------------------------insertTop10區塊------------------------------ -->
				</div>
			</div>
		</div>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />

	<!-- ----------------------------模糊查詢用-------------------------------- -->
	<script>
		//將 get 請求轉換為 post 請求提交
		$(document).ready(function() {
			$('.submitBtn').click(function() {
				if (confirm('確定要新增此留言嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

					console.log(href);
				}
				return false;

			});
		})
	</script>
	<!-- ----------------------------模糊查詢用-------------------------------- -->
</body>
</html>