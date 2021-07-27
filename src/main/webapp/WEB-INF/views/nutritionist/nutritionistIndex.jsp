<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-ui"></script>
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/css/nutritionist/nutritionist_index.css"
	rel="stylesheet">

<title>營養師介紹</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<br>
	<section id="offer">
		<div style="background-color: #C9D8BF; text-align: center;">
			<div style="margin: 5% auto;">
				<h1 style="color: #1d3b2a; font-family: Caudex;">So
					Nutritionist</h1>
				<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
					營養師職業的出現，是適應社會健康的需求而產生的。他們不但是食物的專家，更是營養檢測、營養強化、</p>

				<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
					營養評估等領域的專家，幫助人們獲取健康。營養師的職業要求是專心專業服務於健康。</p>
			</div>
		</div>
	</section>

	<div id='mainWrapper2'>

		<section>
			<br>
			<div>
				<ul id="uk_breadcrumb">
					<li><a href='<c:url value='/'></c:url>'>首頁</a></li>
					<li><a href='<c:url value='/nutritionist'></c:url>'>&emsp;&frasl;&emsp;營養師列表</a></li>
					<li>&emsp;&frasl;&emsp;營養師介紹</li>
				</ul>
			</div>
			<hr>
			<div id="nutrit01">
				<img id="nutritImage01"
					src="<c:url value='/nutritionistController/getImage/${nutritionistBean.nutritionistId}' />">
			</div>
			<div id="nutrit02">
				<h2 id="dr_title">營養師基本資料</h2>
				<font size="5">1. 姓名 : <a id='content1'>${nutritionistBean.nutritionistName}
				</a></font><br> <br> <font size="5">2. 性別 : <a id='content1'>${nutritionistBean.nutritionistGender == 'F' ? "女性" : "男性"}</a></font><br>
				<br> <font size="5">3. 學位 : <a id='content1'>${nutritionistBean.nutritionistDegree}</a></font><br>
				<br> <font size="5">4. E-mail : <a id='content1'>${nutritionistBean.nutritionistEmail}</a></font><br>
				<br> <font size="5">5. 專長 : <a id='content1'>${nutritionistBean.nutritionistCategory}</a></font><br>
				<br>
			</div>


			<div id="nutrit03">
				<br>
				<h3 id="h3css">推薦菜單</h3>
				<hr>
				<h4 id="h4css">時下正夯吃飽飽不挨餓，營養師提倡的「減醣飲食法」，只要天天將飲食中的醣類攝取量控制在60g左右，健康又享瘦！</h4>
				<h4 id="h4css">營養師達人減醣廚房用最新鮮的食材、用心的料理方式，推出忙碌上班族們省時又美味的減醣豪華餐！！配菜多樣化，餐餐減醣，減醣美味計畫就從現在開始！</h4>
				<div id="slim">
					<h4>A套餐</h4>
					<h5>${productBean1.productName}</h5>
					<button type="button">
						<img style="width: 300px; height: 200px;"
							src="<c:url value='/mall/getImage/${productBean1.productId}' />">
					</button>

					<h5>價格:${productBean1.productPrice}元整</h5>
					<a href="<c:url value='/nutritionistController/buy/${productBean1.productId}'/>"
						class="theme-btn br-30 ml-20"><button type="button">加入購物車</button></a>
				</div>
				<div id="slim">
					<h4>B套餐</h4>
					<h5>${productBean2.productName}</h5>
					<button type="button">
						<img style="width: 300px; height: 200px;"
							src="<c:url value='/mall/getImage/${productBean2.productId}' />">
					</button>

					<h5>價格:${productBean2.productPrice}元整</h5>
					<a href="<c:url value='/nutritionistController/buy/${productBean2.productId}'/>"
						class="theme-btn br-30 ml-20"><button type="button">加入購物車</button></a>
				</div>
				<div id="slim">
					<h4>C套餐</h4>
					<h5>${productBean3.productName}</h5>
					<button type="button">
						<img style="width: 300px; height: 200px;"
							src="<c:url value='/mall/getImage/${productBean3.productId}' />">
					</button>

					<h5>價格:${productBean3.productPrice}元整</h5>
					<a href="<c:url value='/nutritionistController/buy/${productBean3.productId}'/>"
						class="theme-btn br-30 ml-20"><button type="button">加入購物車</button></a>
				</div>
				<div id="slim">
					<h4>D套餐</h4>
					<h5>${productBean4.productName}</h5>
					<button type="button">
						<img style="width: 300px; height: 200px;"
							src="<c:url value='/mall/getImage/${productBean4.productId}' />">
					</button>

					<h5>價格:${productBean4.productPrice}元整</h5>
					<a href="<c:url value='/nutritionistController/buy/${productBean4.productId}'/>"
						class="theme-btn br-30 ml-20"><button type="button">加入購物車</button></a>
				</div>
			</div>
		</section>

	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>