<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link -->
<!-- 	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css" -->
<!-- 	rel="stylesheet" media="screen"> -->
<link
	href="https://fonts.googleapis.com/css2?family=Caudex&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">

<meta charset="UTF-8">
<style>
span.error {
	color: red;
	display: inline-block;
	font-size: 8pt;
}

.MainDiv {
	display: flex;
	justify-content: center;
	width: 100%;
	padding-top: 30px;
	padding-bottom: 30px;
/* 	border: 1px solid red; */
}

.font1 {
	font-size: 30px;
	font-weight: bold;
/* 	font-style: italic; */
	color: #b1b3b6; 
}


.font2 {
	height: 55px;
	padding-top: 20px;
}

.font3 {
	font-size: 25px;
	color: #619b8a;
	font-weight: bold;
	/* 	text-decoration: underline; */
}

.font4 {
	font-size: 20px;
	/* 	color: #619b8a; */
	/* 	font-weight: bold; */
}

.btn1 {
	border-radius: 20px;
	border: 3px solid #74c69d;
	width: 200px;
	height: 40px;
	font-size: 20px;
	background-color: white;
	color:#49a078;
	font-weight: bold;
}

.btn1:hover {
	border-radius: 20px;
	border: 3px solid #74c69d;
	color: white;
	width: 200px;
	height: 40px;
	font-size: 20px;
	background-color: #74c69d;
}

.btn2:hover {
	border-radius: 20px;
	border: 3px solid #74c69d;
	width: 100px;
	height: 40px;
	font-size: 17px;
	background-color: white;
	color:#49a078;
	font-weight: bold;
}

.btn2 {
	border-radius: 20px;
	border: 3px solid #74c69d;
	color: white;
	width: 100px;
	height: 40px;
	font-size: 17px;
	background-color: #74c69d;
}

hr{
	border: 1px solid #dae3e5;
}
fieldset {
	margin-top: 20px; 
	border:3px #dae3e5 solid;
	border-radius: 10px;
	
}

.column1 {
	float: left;
/* 	border: 1px solid red; */
	
}


</style>



<title>修改廠商個人資料</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>

	<jsp:include page="/fragment/header.jsp" />

	<!-- --------------------------------------------------- -->
	<!-- <div class="mainWrapper"> -->
	<!-- 		<section id="offer"> -->
	<!-- 			<div style="background-color: #C9D8BF; text-align: center;"> -->
	<!-- 				<div style="margin: 5% auto;"> -->
	<!-- 					<h1 style="color: #1d3b2a; font-family: Caudex;">About You</h1> -->
	<!-- 					<p style="color: #325b43; font-family: Lobster; font-size: 18px;"> -->
	<!-- 						an ethical company !</p> -->

	<!-- 										<p style="color: #325b43; font-family: Lobster; font-size: 18px;"> -->
	<!-- 											Let's Know About You.</p> -->
	<!-- 				</div> -->

	<!-- 			</div> -->
	<!-- 		</section> -->
	<!-- 	</div> -->
	<!-- ----------------------------------------------------------------------------------------- -->



	<div class="MainDiv">

		<div>
			<a href="<c:url value='//shopController/showShopPage'/>"
				title="ShopPage">
				<button class="btn1">回廠商個人頁面</button>
			</a>
			<fieldset>
			<div class="column1">
			<div class="font1">修改個人資料</div>
			<hr>
				<form:form modelAttribute='shopBean' enctype="multipart/form-data"
					method="post">

					<div class="font2">
						<span class="font3"> <label>廠商名稱 : </label>
						</span> <span> <form:input path="shopName" type="text"
								class="font4" /> <form:errors path="shopName" Class="error" />
						</span>
					</div>


					<div class="font2">
						<span class="font3"> <label>廠商電話 : </label>
						</span> <span> <form:input path="shopPhone" type="text"
								class="font4" /> <form:errors path="shopPhone" Class="error" />
						</span>
					</div>


					<div class="font2">
						<span class="font3"> <label>更換頭像：</label>
						</span> <span> <form:input path='shopMultiImg' type="file"
								class="font4" /> <form:errors path="shopMultiImg" Class="error" />
						</span>
					</div>

					<div class="font2">
						<input type="submit" value="Submit" class="btn2" /> <input
							type="reset" value="reset" class="btn2" />

					</div>



				</form:form>
				</div>
				
				<div class="column1">
				<img src="${pageContext.request.contextPath}/images/write1.jpg" width="350px" height="350px">
				</div>
			</fieldset>
			


		</div>
		
	</div>
	<!-- ---------------------------------------------------- -->


	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>