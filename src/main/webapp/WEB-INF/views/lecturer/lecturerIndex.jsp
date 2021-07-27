<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>講師介紹</title>
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
	
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/lecture/lecturer.css">
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<!-- 	綠底標頭 -->
	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Lecturer</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">現在開始你/妳的健康革命！</p>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">聽聽講師怎麼說，讓你越吃越瘦、越動越健康！</p>
				</div>
			</div>
		</section>
	</div>

	<!---------------------- 內容開始區 ---------------------->

	<!------- 小表頭區 ------->
	<div id='pageWrapper'>
		<div id='headerBlank'>
			<a href='<c:url value='/'></c:url>'><button class="custom-btn btn-5">首頁</button></a> 
			<a href='<c:url value='/lectureIndex' />'><button class="custom-btn btn-5">講座介紹</button></a> 
			<input type="text" class="search-bar" placeholder="搜尋講師">
		</div>
		<hr>
	</div>

	<!-- 講師介紹 -->
	<c:forEach var='lecturer' items='${lecturers}'>
		<div class="wrapper">
			<ul>

				<li>
					<!-- 					用box把圖片和文字包起來 -->
					<div class="box">
						<div class="lectureImg">
							<img src="<c:url value='/lecturerController/getLecturerImage/${lecturer.lecturerId}' />" alt="">
						</div>
						<div class="archivedLectures_boxRight">
							<br> 
							<font class="lecturerName">${lecturer.lecturerName}</font><br>
							<p class="custom-eft eft12"><span>講師專長</span></p><br><font class="lecturerTalent">${lecturer.lecturerTalent}</font><br>
							<p class="custom-eft eft12"><span>講師經歷</span></p><br><font class="lecturerExp">${fn:substring(lecturer.lecturerExp,0,150)}</font></p>

<%-- 							<a href="<c:url value='/lecturerController/lecturer/${lecturer.lecturerId}' />"><button class="custom2-btn btn-4">(查看更多...)</button></a> --%>
						</div>
					</div> <!-- 					用box把圖片和文字包起來 -->
				</li>

			</ul>


		</div>
	</c:forEach>
	<!-- JS引入 -->
	
	<script
		src="${pageContext.request.contextPath}/js/lecture/lectureIndex.js"></script>

	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>