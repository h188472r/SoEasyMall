<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>講座介紹</title>
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
<link rel="stylesheet" href="css/categoryNav.css">
<link href="css/header&footer.css" rel="stylesheet">

<!-- 講座日期字型 -->
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">

<!-- 標題字型 -->
<link
	href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;500&display=swap"
	rel="stylesheet">
<!-- 輪播 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'
	crossorigin='anonymous'></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/lecture/lectureDetail.css">
</head>

<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<!-- 	綠底標頭 -->
	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Lecture</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						吃對食物才會越吃越瘦、正確運動才不會造成運動傷害！</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						讓各領域專業講師帶您一起瘦回健康體態！</p>
				</div>
			</div>
		</section>
	</div>

	<!---------------------- 內容開始區 ---------------------->

	<!------- 小表頭區 ------->
	<div id='pageWrapper'>
		<div id='headerBlank'>
			<a href='<c:url value='/'></c:url>'><button	class="custom-btn btn-5">首頁</button></a> 
			<a href='<c:url value='/lecturerController/lecturerIndex' />'><button class="custom-btn btn-5">講師介紹</button></a> 
			<a href='<c:url value='/lectureIndex' />'><button class="custom-btn btn-5">進行中講座</button></a> 
			<a href='<c:url value='/lectureIndex' />'><button class="custom-btn btn-5">即將舉辦講座</button></a>
			<a href='<c:url value='/lectureController/lecture/archivedLectures' />'><button class="custom-btn btn-5">精彩回顧講座</button></a> 
			<input type="text" class="search-bar" placeholder="搜尋講座">
		</div>
		<hr>
	</div>

	
	<!-- 講座標題區 -->
	<div id='pageWrapper'>
		<div style="font-weight: bold; font-size: xx-large; line-height: 1.5" class="header-title">${oneLectureDetail.lectureTitle}</div>
		<hr>

		<!-------------------------------- 講座細節區 -------------------------------->
<!-- 		<div class="wrapper"> -->
<!-- 			<ul> -->
<!-- 				<li> -->
<!-- 					用box把圖片和文字包起來 -->
<!-- 					<div class="box"> -->
					<div class="div1">
							<div>
								<p class="custom-eft eft12"><span>講座時間：</span></p> 
								<span class="lectureDate">${oneLectureDetail.lectureDate}</span>
							</div>
							
							<div>
								<p class="custom-eft eft12"><span>講座分類：</span></p> 
								<span class="lectureCategory">${oneLectureDetail.lectureCategory == "Eat"? "飲食": "運動"}</span>
							</div>
								
							<div>
								<p class="custom-eft eft12"><span>講座狀態：</span></p> 
								<span class="lectureStatus">${(oneLectureDetail.lectureStatus == 1? "即將舉辦":(oneLectureDetail.lectureStatus == 2? "進行中":"精彩回顧"))}</span>
							</div>
								
							<div>
								<p class="custom-eft eft12"><span>講座地址：</span></p> 
								<span class="lectureAddress">${oneLectureDetail.lectureAddress}</span> 
									<div class="div2"> ${oneLectureDetail.lectureMap}</div>
							</div>
							
							<div>
								<p class="custom-eft eft12"><span>講座內容：</span></p>
							</div>
							
								<div class="div2">
									<div class="lectureContent">
										<span>${oneLectureDetail.lectureContent}</span>
									</div>
									
									<div class="lectureImg">
										<img src="<c:url value='/lectureController/getLectureImage/${oneLectureDetail.lectureId}' />" alt="">
									</div>
								</div>
							
					</div>
																
<!-- 					</div> -->
<!-- 					用box把圖片和文字包起來 -->
<!-- 				</li> -->
<!-- 			</ul> -->
			
		
<!-- 		</div> -->
		
		<!--  ------ -->
		<hr>
		<script
			src="${pageContext.request.contextPath}/js/lecture/lectureIndex.js"></script>
		<!--  ------ -->
	</div>
	
	<!-- ------------------------------------------------------------------------------>

	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>