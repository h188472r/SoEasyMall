<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<link
	href="https://fonts.googleapis.com/css2?family=Caudex&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<style>
.MainDiv {
	display: flex;
	justify-content: center;
	width: 100%;
	padding-top: 40px;
	padding-bottom: 40px;
	/* 	border: 1px solid red; */
}

.column1 {
	float: left;
	margin-left: 30px;
	margin-right: 30px;
	/* 	margin: auto; */
	/* 	border: 2px green solid; */
}

.column2 {
	float: left;
	margin-left: 30px;
	margin-right: 30px;
	margin-top: 40px;
	/* 	border: 2px green solid; */
	/* 	margin:auto; */
}
.column3{
	float: left;
}

.divImg {
	width: 350px;
	height: 350px;
	border-radius: 50%;
/* 	border: 3px #94d2bd solid; */
}

.hr1 {
	border: 2px solid #74c69d;
}

.hr2 {
	border: 2px solid #74c69d;
}

.font1 {
	font-size: 35px;
	font-weight: bold;
/* 	font-style: italic; */
	color: #b1b3b6; 
}

.font2{
	height:55px;
	padding-top: 20px;

}
.font3{
	font-size: 25px;
	color: #619b8a;
	font-weight: bold;
/* 	text-decoration: underline; */
}

.font4{
	font-size: 25px;
/* 	color: #619b8a; */
/* 	font-weight: bold; */
}
.btn1:hover{
	border-radius: 20px;
	border:3px solid #74c69d;
	width:200px;
	height:40px;
	font-size: 20px;
	background-color: white;
	color:#49a078;
	font-weight: bold;
	
}
.btn1 {
	border-radius: 20px;
	border:3px solid #74c69d;
	color:white;
	width:200px;
	height:40px;
	font-size: 20px;
	background-color: #74c69d;
	
}


.rightC{
	float:right;
	
}


</style>


<title>廠商個人頁面</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<jsp:include page="/fragment/header.jsp" />
	<!-- ----------------------------------------內容區塊-開始----------------------------------------	 -->
	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">About You</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						an ethical company !</p>

					<!-- 					<p style="color: #325b43; font-family: Lobster; font-size: 18px;"> -->
					<!-- 						Let's Know About You.</p> -->
				</div>

			</div>
		</section>
	</div>
	<!-- ----------------------------------------------------------------------------------------- -->

	<div class="MainDiv">


		<div class="column1">
			<div></div>
			<div>
				<img class="divImg"
					src="<c:url value='/shopController/getShopImg' />" alt="">
			</div>
		</div>

		<div class="column2">
			<div class="font1">廠商資料</div>
			<hr class="hr1">
			<div class="font2">
				<span class="font3">◎ 廠商名稱 </span>
				<span class="font4">：${shopBean.shopName} </span>
			</div>
			
			<div class="font2">
			<span class="font3">◎ E m a i l </span>
			<span class="font4">：${shopBean.shopEmail}</span>
			</div>
			
			<div>
				<%-- 密碼：${shopBean.shopPassword} --%>
			</div>
			
			<div class="font2">			
			<span class="font3">◎ 聯絡電話  </span>
			<span class="font4"> ：${shopBean.shopPhone}</span>
			</div>
	
<!-- 			<hr class="hr2"> -->
			<div class="rightC">
				<a 	href="<c:url value='/shopController/updateShopPage/${shopBean.shopId}' />"><button class="btn1">修改廠商資料</button></a>
			</div>
		</div>




	</div>
	<!-- -----------------------------------------內容區塊-結束------------------------------------------- -->
	<jsp:include page="/fragment/footer.jsp" />


</body>
</html>