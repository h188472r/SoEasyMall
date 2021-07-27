<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Personal Page</title>
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
<link href="${pageContext.request.contextPath}/css/customerPage.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/sportMap_getAll.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/customerPageSlide.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/customer/customerPage_product.css" rel="stylesheet">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/style.css"> --%>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function(){
// 		基本資料欄位
		let customerName = document.getElementById("customerName");
		let customerNickname = document.getElementById("customerNickname");
		let customerPhone = document.getElementById("customerPhone");
		let customerBirthDay = document.getElementById("customerBirthDay");
// 		按鈕、回傳訊息欄位
// 		let informationUpdateDiv = document.getElementById("informationUpdateDiv");
		let informationUpdate = document.getElementById("informationUpdate");
		let infoMessage = document.getElementById("infoMessage");
		
		let informationUpdateMode = "update";
		
// 		初始化XMLHttpRequest物件
		let xhr = new XMLHttpRequest();
		
// 		會員基本資料修改按鈕
		informationUpdate.addEventListener("click", switchUpdateMode);
		
		//切換按鈕模式
		function switchUpdateMode () {
			if(informationUpdateMode == "update"){
				updateCustomerInfo ();
				informationUpdateMode = "submit";
			} else if(informationUpdateMode == "submit"){
				submitCustomerInfo ();
				informationUpdateMode = "update";
			}
		}
		
        //按下修改--打開編輯欄位--按鈕變成確認
        function updateCustomerInfo () {
        	customerName.disabled = "";
			customerNickname.disabled = "";
			customerPhone.disabled = "";
			customerBirthDay.disabled = "";
			informationUpdate.innerHTML = "確認";
        }
		
        //按下確認--送出JSON字串資料--關閉欄位--按鈕變成修改
        function submitCustomerInfo () {
//         	建立一支obj，裝入input內容
			let customerInformationBean = {
					'customerId' : ${customerSignInSuccess.customerId},
					'customerName' : customerName.value,
					'customerNickname' : customerNickname.value,
					'customerPhone' : customerPhone.value,
					'customerBirthDay' : customerBirthDay.value
			}
//			將物件轉為JSON字串
			let json = JSON.stringify(customerInformationBean);
			
			console.log(json);
			
			xhr.open('POST', "<c:url value='/customerController/updateCustomerInfo'/>" , true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xhr.send(json);	
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
// 					接收回傳訊息，更新訊息框
					let customerJSON = JSON.parse(xhr.responseText);
					infoMessage.innerHTML = customerJSON.updateMessage;
					console.log(customerJSON);
					
					
					//關閉欄位--模式設定為修改
					customerName.disabled = "disabled";
					customerNickname.disabled = "disabled";
					customerPhone.disabled = "disabled";
					customerBirthDay.disabled = "disabled";
					informationUpdate.innerHTML = "修改";
				}
			}
        }
        
//    ---------------------------------------------------------------------------------------------------
// 		健康資料欄位
		let customerGender1 = document.getElementById("customerGender1");
		let customerGender2 = document.getElementById("customerGender2");
		let customerDiet1 = document.getElementById("customerDiet1");
		let customerDiet2 = document.getElementById("customerDiet2");
		let customerExerciseHabits1 = document.getElementById("customerExerciseHabits1");
		let customerExerciseHabits2 = document.getElementById("customerExerciseHabits2");
		let customerExerciseHabits3 = document.getElementById("customerExerciseHabits3");
		let customerHeight = document.getElementById("customerHeight");
		let customerWeight = document.getElementById("customerWeight");
		

		
// 		按鈕、回傳訊息欄位
		let healthInfoMessage = document.getElementById("healthInfoMessage");
		let healthInformationUpdate = document.getElementById("healthInformationUpdate");
		
		let healthInformationUpdateMode = "update";
		
// // 		初始化XMLHttpRequest物件
// 		let xhr = new XMLHttpRequest();
		
// 		會員健康資料修改按鈕
		healthInformationUpdate.addEventListener("click", switchHealthUpdateMode);
		
		//切換按鈕模式
		function switchHealthUpdateMode () {
			if(healthInformationUpdateMode == "update"){
				updateHealthCustomerInfo ();
				healthInformationUpdateMode = "submit";
			} else if(healthInformationUpdateMode == "submit"){
				submitCustomerHealthInfo ();
				healthInformationUpdateMode = "update";
			}
		}
		
        //按下修改--打開編輯欄位--按鈕變成確認
        function updateHealthCustomerInfo () {
        	customerGender1.disabled = "";
        	customerGender2.disabled = "";
        	customerDiet1.disabled = "";
        	customerDiet2.disabled = "";
        	customerExerciseHabits1.disabled = "";
        	customerExerciseHabits2.disabled = "";
        	customerExerciseHabits3.disabled = "";
        	customerHeight.disabled = "";
        	customerWeight.disabled = "";
        	healthInformationUpdate.innerHTML = "確認";
        }
		
        //按下確認--送出JSON字串資料--關閉欄位--按鈕變成修改
        function submitCustomerHealthInfo () {
        	
//     		取得單選群組value
    		let customerGender1 = document.getElementById("customerGender1");
			let customerGender2 = document.getElementById("customerGender2");
			let customerDiet1 = document.getElementById("customerDiet1");
			let customerDiet2 = document.getElementById("customerDiet2");
			let customerExerciseHabits1 = document.getElementById("customerExerciseHabits1");
			let customerExerciseHabits2 = document.getElementById("customerExerciseHabits2");
			let customerExerciseHabits3 = document.getElementById("customerExerciseHabits3");
    		
			let customerGender = null;
			let customerDiet = null;
			let customerExerciseHabits = null;
			if(customerGender1.checked){
				customerGender = customerGender1.value;
			} else {
				customerGender = customerGender2.value;
			}
        	console.log(customerGender);
			
			if(customerDiet1.checked){
				customerDiet = customerDiet1.value;
			} else {
				customerDiet = customerDiet2.value;
			}
			
			if(customerExerciseHabits1.checked){
				customerExerciseHabits = customerExerciseHabits1.value;
			} else if(customerExerciseHabits2.checked){
				customerExerciseHabits = customerExerciseHabits2.value;
			} else if(customerExerciseHabits3.checked){
				customerExerciseHabits = customerExerciseHabits3.value;
			}
//         	建立一支obj，裝入input內容
			let customerHealthInformationBean = {
					'customerId' : ${customerSignInSuccess.customerId},
					'customerHealthBean' : {
							'customerHealthId' : ${customerSignInSuccess.customerHealthBean.customerHealthId},
							'customerGender' : customerGender,
							'customerDiet' : customerDiet,
							'customerExerciseHabits' : customerExerciseHabits,
							'customerHeight' : customerHeight.value,
							'customerWeight' : customerWeight.value
					}
			}
//			將物件轉為JSON字串
			let json = JSON.stringify(customerHealthInformationBean);
			
			console.log(json);
			
			xhr.open('POST', "<c:url value='/customerController/updateCustomerHealthInfo'/>" , true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xhr.send(json);	
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
// 					接收回傳訊息，更新訊息框
					let customerHealthJSON = JSON.parse(xhr.responseText);
					healthInfoMessage.innerHTML = customerHealthJSON.updateHealthMessage;
					console.log(customerHealthJSON);
					
					
					//關閉欄位--模式設定為修改
					customerGender1.disabled = "disabled";
					customerGender2.disabled = "disabled";
					customerDiet1.disabled = "disabled";
					customerDiet2.disabled = "disabled";
					customerExerciseHabits1.disabled = "disabled";
					customerExerciseHabits2.disabled = "disabled";
					customerExerciseHabits3.disabled = "disabled";
					customerHeight.disabled = "disabled";
					customerWeight.disabled = "disabled";
					healthInformationUpdate.innerHTML = "修改";
				}
			}
        }
        
//         -----------------------------------------------------------------------------------
// 		上傳頭像
// 		上傳按鈕--圖片
		let imgUploadbtn = document.getElementById("imgUploadbtn");
// 		送出表單鈕
		let customerImgUpload = document.getElementById("customerImgUpload");

		imgUploadbtn.addEventListener("click", imgUpload);
		
		function imgUpload () {
			customerImgUpload.click();
			customerImgUpload.addEventListener("change", imgSubmit);
		}
		
		function imgSubmit () {
			document.getElementById("customerImgSubmit").click();			
		}
// 		---------------------------------------------------------------------------------------

// 		---------------------------------------------------------------------------------------

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
					<h1 style="color: #1d3b2a; font-family: Caudex;font-size: 38.5px;font-weight: normal;">About You</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						Taking Our Health in Our Hands!</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						Let's Know About You.</p>
				</div>

			</div>
		</section>
	</div>
	<div class="customer-main">
		<div>
			<div class="customer-img">
				<div id="imgUploadbtn">
						<img alt="" src="${pageContext.request.contextPath}/customerController/getCustomerImg">
						<form method="POST" action="uploadCustomerImg" enctype="multipart/form-data">
							<input id="customerImgUpload" name="customerImgUpload" type="file" style="display: none;">
							<input id="customerImgSubmit" type="submit" style="display: none">
						</form>
				</div>
			</div>
			<div class="customer-information" >
				<div class="customer-information-inside">
			<fieldset style="width: 500px; height: 500px">
				<legend>基本資料</legend>
						<div class="customer-information-items">
							<div>
								<div style="width: 20%">姓名：</div>
								<div style="width: 80%">
									<input id='customerName' value='${customerSignInSuccess.customerName}' disabled="disabled" type='text' placeholder='請輸入姓名'>
								</div>
							</div>
							<div>
								<div  style="width: 20%">暱稱：</div>
								<div style="width: 80%">
									<input id='customerNickname' value='${customerSignInSuccess.customerNickname}' disabled="disabled" type='text' placeholder='請輸入暱稱'>
								</div>
							</div>
							<div>
								<div style="width: 20%">電話：</div>
								<div style="width: 80%">
									<input id='customerPhone' value='${customerSignInSuccess.customerPhone}' disabled="disabled" type='text' placeholder='請輸入電話'>
								</div>
							</div>
							<div>
								<div style="width: 20%">生日：</div>
								<div style="width: 80%">
									<input id='customerBirthDay' value='${customerSignInSuccess.customerBirthDay}' disabled="disabled" type='date' placeholder='請輸入生日'>
								</div>
							</div>
							<div id="informationUpdateDiv" class="customer-information-items-button">
								<div id="infoMessage" style="justify-content: flex-start; font-size: 16px ; color: red ; width: 75%;"></div>
								<button id="informationUpdate">修改</button>
							</div>
						</div>
			</fieldset>
				</div>
			</div>
			
			
		</div>
<!-----------------健康資料表-------------------------------------------------------------------------------------------------->
		<div>
			<div class="customer-health-information">
				<div class="customer-health-information-inside">
					<fieldset style="width: 500px; height: 500px">
						<legend>健康調查表</legend>
						<div class="customer-health-information-items">
							<div>
								<div style="width: 20%">性別：</div>
								<div style="width: 80%;">
										<c:choose>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerGender == 1}">
												<input style="height: 40%" id='customerGender1' checked="checked" value='1' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender1">男</label>
												<input style="height: 40%" id='customerGender2' value='2' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender2">女</label>
											</c:when>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerGender == 2}">
												<input style="height: 40%" id='customerGender1' value='1' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender1">男</label>
												<input style="height: 40%" id='customerGender2' checked="checked" value='2' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender2">女</label>
											</c:when>
											<c:otherwise>
												<input style="height: 40%" id='customerGender1' value='1' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender1">男</label>
												<input style="height: 40%" id='customerGender2' value='2' disabled="disabled" type='radio' name="customerGender">
												<label for="customerGender2">女</label>
											</c:otherwise>
										</c:choose>
								</div>
							</div>
							<div>
								<div style="width: 20%">飲食：</div>
								<div style="width: 80%">
										<c:choose>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerDiet == 1}">
												<input style="height: 40%" id='customerDiet1' checked="checked" value='1' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet1">葷</label>
												<input style="height: 40%" id='customerDiet2' value='2' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet2">素</label>
											</c:when>											
											<c:when test="${customerSignInSuccess.customerHealthBean.customerDiet == 2}">
												<input style="height: 40%" id='customerDiet1' value='1' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet1">葷</label>
												<input style="height: 40%" id='customerDiet2' checked="checked" value='2' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet2">素</label>
											</c:when>
											<c:otherwise>
												<input style="height: 40%" id='customerDiet1' value='1' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet1">葷</label>
												<input style="height: 40%" id='customerDiet2' value='2' disabled="disabled" type='radio' name="customerDiet">
												<label for="customerDiet2">素</label>
											</c:otherwise>
										</c:choose>
								</div>
							</div>
							<div>
								<div style="width: 20%">運動：</div>
								<div style="width: 80%">
										<c:choose>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerExerciseHabits == 1}">
												<input style="height: 40%" id='customerExerciseHabits3' value='3' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits3">強</label>
												<input style="height: 40%" id='customerExerciseHabits2' value='2' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits2">中</label>
												<input style="height: 40%" id='customerExerciseHabits1' value='1' checked="checked" disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits1">弱</label>
											</c:when>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerExerciseHabits == 2}">
												<input style="height: 40%" id='customerExerciseHabits3' value='3' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits3">強</label>
												<input style="height: 40%" id='customerExerciseHabits2' value='2' checked="checked" disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits2">中</label>
												<input style="height: 40%" id='customerExerciseHabits1' value='1' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits1">弱</label>
											</c:when>
											<c:when test="${customerSignInSuccess.customerHealthBean.customerExerciseHabits == 3}">
												<input style="height: 40%" id='customerExerciseHabits3' value='3' checked="checked" disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits3">強</label>
												<input style="height: 40%" id='customerExerciseHabits2' value='2' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits2">中</label>
												<input style="height: 40%" id='customerExerciseHabits1' value='1' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits1">弱</label>
											</c:when>
											<c:otherwise>
												<input style="height: 40%" id='customerExerciseHabits3' value='3' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits3">強</label>
												<input style="height: 40%" id='customerExerciseHabits2' value='2' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits2">中</label>
												<input style="height: 40%" id='customerExerciseHabits1' value='1' disabled="disabled" type='radio' name="customerExerciseHabits">
												<label for="customerExerciseHabits1">弱</label>
											</c:otherwise>
										</c:choose>
								</div>
							</div>
							<div>
								<div style="width: 20%">身高：</div>
								<div style="width: 80%">
									<input id='customerHeight' value='${customerSignInSuccess.customerHealthBean.customerHeight}' disabled="disabled" type='text' name="customerHeight" placeholder='請輸入身高(公分)'>
								</div>
							</div>
							<div>
								<div style="width: 20%">體重：</div>
								<div style="width: 80%">
									<input id='customerWeight' value='${customerSignInSuccess.customerHealthBean.customerWeight}' disabled="disabled" type='text' name="customerWeight" placeholder='請輸入體重(公斤)'>
								</div>
							</div>
							<div class="customer-health-information-items-button">
								<div id="healthInfoMessage" style="justify-content: flex-start; font-size: 16px ; color: red ; width: 75%;"></div>
								<button id="healthInformationUpdate">修改</button>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
				
			<div class="customer-favorite-map">
				<div class="container customer-favorite-map-items">
				
<!-- 				------------------------- -->
					<c:choose>
						<c:when test="${!empty sportMaps}">
					<div class="slideshow-container">
						<a class="prev" id="prevMapsSlides">&#10094;</a> 
<!-- 						---------------------------------------------------- -->
					<c:forEach var="sportMap" items="${sportMaps}">
						<div class="mySlides fade-map mapSlides">
					<div class='column' style="margin: 0 20px 10px 20px;">
						<div class='demo-title'>${sportMap.sportCategoryBean.sportCategoryName}</div>
						<div class='post-module'>
							<div class='thumbnail'>
								<div class='date'>
									<div class='day'>go</div>
									<div class='month'>go</div>
								</div>
								${sportMap.sportMapMap}
							</div>
							<div class='post-content'>
								<div class='category'>Map</div>
								<h3 class='sub_title'>運動地點：${sportMap.sportMapName}</h3>
								<h3 class='description'>地址：${sportMap.sportMapAddress}</h3>
								<div class='post-meta'>
									<span class='timestamp'> <i class='fa fa-clock-o'></i>
										${sportMap.sportCategoryBean.sportCategoryName}
									</span>
									<span class='comments'> <i class='fa fa-comments'></i> <a
										href="<c:url value='/sportMapController/sportMap/${sportMap.sportMapId}' />">詳細資訊</a>
									</span> 
<!-- 							<span class='comments'> <i class='fa fa-comments'></i>  -->
<!-- 							<a	class='deleteSportMap' -->
<%-- 								href="<c:url value='/' />sportMapController/del/${entry.value.sportMapId}">刪除</a> --%>
<!-- 							</span> -->
								</div>
							</div>
						</div>

					</div>
						</div>
					</c:forEach>
						<!-- Next and previous buttons -->
						<a class="next" id="nextMapsSlides">&#10095;</a>
					<div style="text-align: center">
					<c:forEach var="sportMap" items="${sportMaps}">
						<span class="dot dotOfMap"></span> 
					</c:forEach>
						
					</div>
<!-- 					---------------------------------------- -->
					</div>
					<script type="text/javascript">
//			 			輪播地圖JS
						var slideMapsIndex = 1;
						showMapsSlides(slideMapsIndex);

						let dotsOfMaps = document.querySelectorAll(".dotOfMap");
						for(let i = 0; i < dotsOfMaps.length; i++){
							dotsOfMaps[i].addEventListener("click", function(){
								currentMapsSlide(i + 1);
							});
						}

						let prevMapsSlides = document.getElementById("prevMapsSlides");
						let nextMapsSlides = document.getElementById("nextMapsSlides");
						prevMapsSlides.addEventListener("click", function(){
							plusMapsSlides(-1);
						});	
						nextMapsSlides.addEventListener("click", function(){
							plusMapsSlides(1);
						});
					
						// Next/previous controls
						function plusMapsSlides(n) {
			  				showMapsSlides(slideMapsIndex += n);
						}
		
						// Thumbnail image controls
						function currentMapsSlide(n) {
			  				showMapsSlides(slideMapsIndex = n);
						}

						function showMapsSlides(n) {
			  				let i;
			  				let slides = document.getElementsByClassName("mapSlides");
			  				let dotsOfMaps = document.getElementsByClassName("dotOfMap");
			  				if (n > slides.length) {slideMapsIndex = 1}
			  					if (n < 1) {slideMapsIndex = slides.length}
			  				for (i = 0; i < slides.length; i++) {
			      				slides[i].style.display = "none";
			  				}
			  				for (i = 0; i < dotsOfMaps.length; i++) {
			      				dotsOfMaps[i].className = dotsOfMaps[i].className.replace(" active", "");
			  				}
			  				slides[slideMapsIndex-1].style.display = "block";
			  				dotsOfMaps[slideMapsIndex-1].className += " active";
						}
					</script>
					
						</c:when>
						<c:otherwise>
							<div style="text-align: center;">
								<a href="<c:url value='/showSportMapIndex'></c:url>">
								<img class="addFavorite" src="${pageContext.request.contextPath}/images/customer/heart.png">
								</a>
								<br>
								<p style="color: #325b43; font-family: Lobster; font-size: 18px;">No favorite map here.</p>
							</div>
						</c:otherwise>
					</c:choose>
					<br>

					<!-- The dotsOfMaps/circles -->


					<!-- 				--------------------------------- -->
				</div>
			</div>
			<div>
<!-- 			---------------------------------------------------------------------------------------------------------- -->
				<div class="customer-post">
					<div id="customer-post-items">
<!-- 						----------------------------------------------------------------------------------------- -->
						<c:choose>
						<c:when test="${!empty posts}">
						
						<div class="slideshow-container">
						<a class="prev" id="prevPostsSlides">&#10094;</a>
						<c:forEach var="post" items="${posts}">
							<div class="mySlides fade-post postSlides">
								<div class="span4" style="margin: 0 0 10px 0;background-color: #fff;">
									<div class="thumbnail">
<!-- //									文章圖片 -->
										<img alt="" src="<c:url value='/PostController/getPicture/${post.postId}'></c:url>" style="width: 300px; height: 300px; object-fit: cover;"/>
						
										<div class="caption">
<!-- //									文章標題 -->
											<h3>${post.postTitle}</h3>
<!-- //									文章內容 -->
											<p>${fn:substring(post.postContent,0,20)}...</p>
<!-- //									觀看更多 -->
											<a href="<c:url value='/PostNeedLoginController/getPost/${post.postId}' />"> >>>觀看更多 </a>
											<div style="display: block; text-align: right;">
<!-- //											Like按鈕SVG -->
<!-- // 										<svg id="color" enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m22.843 12.586c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.384-.144-.686-.445-.829-.829l-.76-2.024c-.282-.754-.871-1.362-1.615-1.671-.741-.308-1.59-.293-2.323.04l-1.969.895c-.373.17-.801.17-1.172 0l-1.97-.895c-.732-.334-1.581-.349-2.323-.04-.744.308-1.333.917-1.615 1.671l-.76 2.024c-.143.384-.445.685-.829.829l-2.024.76c-.754.282-1.363.871-1.671 1.615-.308.743-.293 1.59.04 2.323l.895 1.969c.169.372.169.8 0 1.172l-.895 1.969c-.333.733-.348 1.58-.04 2.323.309.744.917 1.333 1.671 1.615l2.024.76c.384.144.686.445.829.829l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.373-.17.801-.17 1.172 0l1.969.895c.732.334 1.581.348 2.323.04.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323z" fill="#f44336"/><g fill="#fafafa"><path d="m13.414 9.702c-.877-.877-2.305-.877-3.182 0s-.877 2.305 0 3.182l1.414 1.414c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182zm.354 3.535c-.293.293-.768.293-1.061 0l-1.414-1.414c-.292-.292-.292-.769 0-1.061.146-.147.338-.219.53-.219s.384.072.53.219l1.414 1.414c.293.293.293.769.001 1.061z"/><path d="m8.818 12.177c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l1.237 1.237-1.061 1.062-1.238-1.238c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l3.536 3.536c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z"/><path d="m18.364 9.702-3.006-3.006.53-.53c.293-.293.293-.768 0-1.061s-.768-.293-1.061 0l-1.059 1.06-.002.001-.001.001-1.06 1.061c-.293.293-.293.768 0 1.061.146.146.339.22.53.22.192 0 .384-.073.53-.22l.53-.531 3.006 3.006c.146.146.338.22.53.22s.384-.073.53-.22c.296-.294.296-.769.003-1.062z"/></g><path d="m13.025 11.435-1.061 1.061.742.742c.146.146.338.22.53.22s.384-.073.53-.22c.292-.292.292-.769 0-1.061zm6.809-6.809-3.273 3.273 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.804-1.804-1.415 1.415.742.742c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658s-1.152-.22-1.591-.658l-.742-.742-.354.354 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.237-1.237-1.061 1.062 1.237 1.237c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.803-1.803-2.743 2.743c.048.078.089.161.121.248l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.187-.085.387-.127.587-.127s.4.042.585.127l1.969.895c.381.174.795.261 1.208.261.38 0 .76-.074 1.116-.221.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323l-.895-1.969c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.087-.036-.17-.076-.248-.124z" fill="#d43a2f"/><path d="m14.086 10.374-1.061 1.061.742.742c.292.292.292.768 0 1.061-.147.146-.338.22-.53.22s-.384-.073-.53-.22l-.742-.742-1.061 1.061.742.742c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182z" fill="#dadada"/><path d="m10.551 13.909-3.182 3.182 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/><path d="m16.561 7.899-1.061 1.06 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/></svg> -->
<!-- // 										<svg enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><g id="color"><g><g><path d="m21.758 12.527c-.152-.335-.152-.72 0-1.055l.805-1.772c.3-.66.313-1.422.036-2.091-.278-.67-.825-1.2-1.504-1.454l-1.822-.684c-.345-.129-.617-.401-.746-.746l-.684-1.822c-.253-.677-.783-1.225-1.453-1.503-.667-.277-1.431-.264-2.091.036l-1.772.805c-.336.153-.721.153-1.055 0l-1.771-.805c-.659-.3-1.423-.313-2.091-.036-.67.278-1.2.825-1.454 1.504l-.684 1.822c-.129.346-.4.617-.746.746l-1.822.684c-.678.254-1.226.784-1.504 1.454-.276.669-.263 1.431.036 2.091l.805 1.772c.152.335.152.72 0 1.055l-.805 1.772c-.3.66-.313 1.422-.036 2.091.278.67.825 1.2 1.504 1.454l1.822.684c.345.129.617.401.746.746l.684 1.822c.254.677.784 1.225 1.454 1.503.32.133.662.199 1.004.199.372 0 .744-.078 1.087-.235l1.772-.805c.336-.153.721-.153 1.055 0l1.772.805c.659.301 1.423.313 2.091.036.67-.278 1.2-.825 1.454-1.504l.684-1.822c.129-.345.401-.617.746-.746l1.822-.684c.679-.254 1.226-.784 1.504-1.454.277-.669.264-1.431-.036-2.091z" fill="#f44336"/></g></g></g><g id="_x31_.5"><g><g><path d="m8.237 23.998c-.38 0-.76-.073-1.115-.221-.744-.309-1.333-.917-1.615-1.671l-.76-2.024c-.144-.384-.445-.686-.829-.829l-2.024-.76c-.754-.282-1.362-.871-1.671-1.615-.308-.743-.293-1.59.04-2.323l.895-1.969c.169-.372.169-.8 0-1.172l-.895-1.969c-.333-.733-.348-1.58-.04-2.323.308-.744.917-1.333 1.671-1.615l2.024-.76c.384-.144.686-.445.829-.829l.76-2.024c.282-.754.871-1.363 1.615-1.671.742-.309 1.591-.294 2.323.04l1.969.895c.371.17.799.17 1.172 0l1.969-.895c.733-.333 1.582-.348 2.323-.04.744.309 1.333.917 1.615 1.671l.76 2.024c.144.384.445.686.829.829l2.024.76c.754.282 1.362.871 1.671 1.615.308.743.293 1.59-.04 2.323l-.895 1.969c-.169.372-.169.8 0 1.172l.895 1.969c.333.733.348 1.58.04 2.323-.309.744-.917 1.333-1.671 1.615l-2.024.76c-.384.144-.686.445-.829.829l-.76 2.024c-.282.754-.871 1.362-1.615 1.671-.741.308-1.59.294-2.323-.04l-1.969-.895c-.371-.17-.799-.17-1.172 0l-1.969.895c-.382.174-.795.261-1.208.261zm.001-22.498c-.184 0-.367.036-.543.108-.366.152-.645.44-.784.812l-.76 2.024c-.296.788-.918 1.41-1.706 1.706l-2.024.76c-.372.14-.66.418-.812.784-.151.367-.145.768.02 1.129l.895 1.969c.349.768.349 1.646 0 2.414l-.895 1.969c-.164.361-.171.762-.02 1.129.152.366.44.645.812.784l2.024.76c.788.296 1.41.918 1.706 1.706l.76 2.024c.14.372.418.66.784.812.366.15.767.144 1.129-.02l1.969-.895c.768-.35 1.646-.35 2.414 0l1.969.895c.361.163.763.171 1.129.02.366-.152.645-.44.784-.812l.76-2.024c.296-.788.918-1.41 1.706-1.706l2.024-.76c.372-.14.66-.418.812-.784.151-.367.145-.768-.02-1.129l-.895-1.969c-.349-.768-.349-1.646 0-2.414l.895-1.969c.164-.361.171-.762.02-1.129-.152-.366-.44-.645-.812-.784l-2.024-.76c-.788-.296-1.41-.918-1.706-1.706l-.76-2.024c-.14-.372-.418-.66-.784-.812-.367-.15-.767-.144-1.129.02l-1.969.895c-.768.35-1.646.35-2.414 0l-1.969-.895c-.187-.085-.386-.128-.586-.128z"/></g></g><g><g><g><path d="m13.237 14.956c-.576 0-1.152-.22-1.591-.658l-1.414-1.414c-.877-.877-.877-2.305 0-3.182s2.305-.877 3.182 0l1.414 1.414c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658zm-1.414-4.412c-.192 0-.384.072-.53.219-.292.292-.292.769 0 1.061l1.414 1.414c.293.293.768.293 1.061 0 .292-.292.292-.769 0-1.061l-1.414-1.414c-.147-.147-.338-.219-.531-.219z"/></g></g><g><g><path d="m13.237 8.508c-.191 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.293-.293.768-.293 1.061 0s.293.768 0 1.061l-2.121 2.122c-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m9.702 19.114c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m11.823 16.992c-.192 0-.384-.073-.53-.22l-3.535-3.535c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.535 3.535c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m17.834 10.982c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.339.22-.531.22z"/></g></g><g><g><path d="m7.935 17.347c-.192 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.292-.292.767-.294 1.061 0 .293.293.293.768 0 1.061l-2.121 2.122c-.148.146-.339.22-.531.22z"/></g></g></g></g></svg> -->
												<img src="${pageContext.request.contextPath}/images/post/heart.png">&nbsp;&nbsp;&nbsp;
						
<!-- //											Like數量 -->
						 						${post.postLike}
												<p style="font-size: 15px; color: grey;">By &nbsp;${post.customerBean.customerNickname}</p>
<!-- //											文章上傳時間 -->
												<p style="font-size: 15px; color: grey;">${fn:substring(post.postUploadTime,0,16)}</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<a class="next" id="nextPostsSlides">&#10095;</a>
						<div style="text-align: center">
						<c:forEach var="post" items="${posts}">
							<span class="dot dotOfPost"></span> 
						</c:forEach>
						</div>
						</div>
						
						<script type="text/javascript">
//				 			輪播分享Post
							var slidePostsIndex = 1;
							showPostsSlides(slidePostsIndex);

							let dotsOfPosts = document.querySelectorAll(".dotOfPost");
							for(let i = 0; i < dotsOfPosts.length; i++){
								dotsOfPosts[i].addEventListener("click", function(){
									currentPostsSlide(i + 1);
								});
							}

							let prevPostsSlides = document.getElementById("prevPostsSlides");
							let nextPostsSlides = document.getElementById("nextPostsSlides");
							prevPostsSlides.addEventListener("click", function(){
								plusPostsSlides(-1);
							});
							nextPostsSlides.addEventListener("click", function(){
								plusPostsSlides(1);
							});
						
							// Next/previous controls
							function plusPostsSlides(n) {
				  				showPostsSlides(slidePostsIndex += n);
							}

							// Thumbnail image controls
							function currentPostsSlide(n) {
				  				showPostsSlides(slidePostsIndex = n);
							}

							function showPostsSlides(n) {
				  				let i;
				  				let slides = document.getElementsByClassName("postSlides");
				  				let dotsOfPosts = document.getElementsByClassName("dotOfPost");
				  				if (n > slides.length) {slidePostsIndex = 1}
				  				if (n < 1) {slidePostsIndex = slides.length}
				  				for (i = 0; i < slides.length; i++) {
				      				slides[i].style.display = "none";
				  				}
				  				for (i = 0; i < dotsOfPosts.length; i++) {
				      				dotsOfPosts[i].className = dotsOfPosts[i].className.replace(" active", "");
				  				}
				  				slides[slidePostsIndex-1].style.display = "block";
				  				dotsOfPosts[slidePostsIndex-1].className += " active";
							}
						</script>
						
						</c:when>
						<c:otherwise>
							<div style="text-align: center;">
								<a href="<c:url value='/postIndex'></c:url>">
								<img class="addFavoritePost" src="${pageContext.request.contextPath}/images/customer/remove-favorite.png">
								</a>
								<br>
								<p style="color: #325b43; font-family: Lobster; font-size: 18px;">No favorite post here.</p>
							</div>
							<script type="text/javascript">
								let addFavoritePost = document.querySelector(".addFavoritePost");
								addFavoritePost.addEventListener("mouseover", function(){
									this.src = "${pageContext.request.contextPath}/images/customer/add-favorite.png"
								})
								addFavoritePost.addEventListener("mouseout", function(){
									this.src = "${pageContext.request.contextPath}/images/customer/remove-favorite.png"
								})
							</script>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
<!-- 						----------------------------------------------------------------------------------------- -->
				<div class="customer-information" >
					<div class="customer-information-inside">
					<c:choose>
						<c:when test="${!empty products}">


<!-- 						single product -->
					<div class="slideshow-container">
						<a class="prev" id="prevProductsSlides" style="z-index: 9">&#10094;</a>
					<c:forEach var="product" items="${products}">
					<div class="mySlides fade-product productSlides">
<!-- 					<div> -->
                        <div class="product">
                            <div class="product-img-wrap">
                                <img style="height: 270px; width: 420px" src='<c:url value="/mall/getImage/${product.productId}"></c:url>' alt="img">
                                <!-- Button trigger modal -->
                                <button class="quick-view" type="button" data-toggle="modal" data-target="#quick-view">Quick View</button>
                            </div>

                            <div class="product-content-wrap">
                                <div class="product-content">
                                    <p><a href="shop-details.html">${product.productName}</a></p>
                                </div>
                                <div class="product-action">
                                    <a href="#" class="add-to-btn small-btn">
                                        <i class="flaticon-shopping-cart"></i>
                                        <span>Add to Cart</span>
                                        <h5 class="product-price">${product.productPrice}</h5>
                                    </a>
                                    <div class="add-wishlist">
                                        <i class="fa fa-heart-o"></i>
                                    </div>
                                </div>
                            </div>
						</div>
<!--                        </div> -->
                    </div>
					</c:forEach>
					<a class="next" id="nextProductsSlides">&#10095;</a>
					<div style="text-align: center">
						<c:forEach var="product" items="${products}">
							<span class="dot dotOfProduct"></span> 
						</c:forEach>
					</div>
					</div>
					
					<script type="text/javascript">
//		 			輪播分享Product
						var slideProductsIndex = 1;
						showProductsSlides(slideProductsIndex);

						let dotsOfProducts = document.querySelectorAll(".dotOfProduct");
						for(let i = 0; i < dotsOfProducts.length; i++){
							dotsOfProducts[i].addEventListener("click", function(){
								currentProductsSlide(i + 1);
							});
						}

						let prevProductsSlides = document.getElementById("prevProductsSlides");
						let nextProductsSlides = document.getElementById("nextProductsSlides");
						prevProductsSlides.addEventListener("click", function(){
						plusProductsSlides(-1);
						});
						nextProductsSlides.addEventListener("click", function(){
							plusProductsSlides(1);
						});
				
						// Next/previous controls
						function plusProductsSlides(n) {
		  					showProductsSlides(slideProductsIndex += n);
						}

						// Thumbnail image controls
						function currentProductsSlide(n) {
		  					showProductsSlides(slideProductsIndex = n);
						}

						function showProductsSlides(n) {
		  					let i;
		  					let slides = document.getElementsByClassName("productSlides");
		  					let dotsOfProducts = document.getElementsByClassName("dotOfProduct");
		  					if (n > slides.length) {slideProductsIndex = 1}
		  					if (n < 1) {slideProductsIndex = slides.length}
		  					for (i = 0; i < slides.length; i++) {
		      					slides[i].style.display = "none";
		  					}
		  					for (i = 0; i < dotsOfProducts.length; i++) {
		      					dotsOfProducts[i].className = dotsOfProducts[i].className.replace(" active", "");
		  					}
		  					slides[slideProductsIndex-1].style.display = "block";
		  					dotsOfProducts[slideProductsIndex-1].className += " active";
						}
					</script>
					
					</c:when>
						<c:otherwise>
							<div style="text-align: center;">
								<a href="<c:url value='/mall/lists'></c:url>">
								<img class="addFavoriteProduct" src="${pageContext.request.contextPath}/images/customer/remove-to-favorites.png">
								</a>
								<br>
								<p style="color: #325b43; font-family: Lobster; font-size: 18px;">No favorite product here.</p>
							</div>
							<script type="text/javascript">
//					 			收藏導向變更圖案
								let addFavoriteProduct = document.querySelector(".addFavoriteProduct");
								addFavoriteProduct.addEventListener("mouseover", function(){
									this.src = "${pageContext.request.contextPath}/images/customer/add-to-favorites.png"
								})
								addFavoriteProduct.addEventListener("mouseout", function(){
									this.src = "${pageContext.request.contextPath}/images/customer/remove-to-favorites.png"
								})
							</script>
						</c:otherwise>
						</c:choose>
<!--                     --------------------------------- -->
					</div>
				</div>
			
			
			</div>
		</div>
	</div>
					

	<script type="text/javascript">
		
	</script>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>