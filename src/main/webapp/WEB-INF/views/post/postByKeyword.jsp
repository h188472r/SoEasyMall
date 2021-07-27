<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<script>
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {

						let postShowFavorite = document
								.querySelectorAll(".postShowFavorite");
						console.log('postShowFavorite' + postShowFavorite);

						for (let i = 0; i < postShowFavorite.length; i++) {
							postShowFavorite[i]
									.addEventListener(
											"click",
											function() {
												console.log("點擊愛心");
												console.log(this.dataset.id);

												let updateFavoritePostId = this.dataset.id;
												let postLike = document
														.getElementById("postLike"
																+ updateFavoritePostId);
												let postImg = document
														.getElementById("postImg"
																+ updateFavoritePostId);
												console.log("postImg="
														+ postImg);

												//建一支Object，裝收藏controller要的內容
												let favoriteInfo = {
													'favoriteCategory' : 'post',
													'favoriteItemId' : updateFavoritePostId
												}
												//將物件轉為json			
												let json = JSON
														.stringify(favoriteInfo);

												console.log("json=" + json);

												//新建XMLHttpRequest物件
												let xhr = new XMLHttpRequest();

												xhr
														.open('POST',
																"<c:url value='/favoriteController/addFavoritePost'/>");
												xhr
														.setRequestHeader(
																"Content-Type",
																"application/json;charset=UTF-8");
												xhr.send(json);

												xhr.onreadystatechange = function() {
													if (xhr.readyState == 4
															&& xhr.status == 200) {

														if (xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn") {
															location.href = "/soeasy/customerController/customerSignIn";
														}

														let favoriteJson = JSON
																.parse(xhr.responseText);
														console
																.log(favoriteJson);
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
											});
						}

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
					<div style="border-bottom: 3px solid lightgrey; margin-bottom: 1%;">
						<c:if test='${empty postBeans}'>
							<h2>查無相關文章</h2>
						</c:if>
						<c:if test='${!empty postBeans}'>
							<h2>顯示 ${fn:length(postBeans)} 篇文章的結果</h2>
						</c:if>
					</div>

					<!-- ------------------------------內容區塊--------------------------------- -->
					<div id="insertPosts">
						<c:choose>
							<c:when test="${empty postBeans}">
								<div style="display: flex; width: 100%">

									<div class="span6">
<!-- 										<img -->
<%-- 											src="${pageContext.request.contextPath}/images/post/postNoFind.jpg" --%>
<!-- 											style="width: 200%;"> -->
											<svg id="Capa_1" style="fill:#7F9871; width:85%; height:85%;" enable-background="new 0 0 512.002 512.002" height="512" viewBox="0 0 512.002 512.002" width="512" xmlns="http://www.w3.org/2000/svg"><g><g><path d="m512.002 110c0-60.654-49.346-110-110-110-55.391 0-101.351 41.154-108.91 94.492-6.109-2.052-12.326-3.808-18.605-5.252l-3.323-19.94c-1.698-10.185-9.432-17.298-18.807-17.298h-44.716c-9.375 0-17.109 7.113-18.807 17.299l-3.322 19.936c-21.449 4.918-41.695 13.306-60.359 25.006l-16.448-11.749c-8.402-6.002-18.902-5.565-25.531 1.065l-31.621 31.619c-6.627 6.629-7.065 17.127-1.065 25.53l11.75 16.449c-11.699 18.668-20.088 38.917-25.005 60.358l-19.936 3.322c-10.185 1.699-17.298 9.433-17.297 18.808v44.715c-.001 9.376 7.112 17.109 17.298 18.808l19.936 3.322c4.917 21.441 13.306 41.69 25.005 60.357l-11.75 16.451c-6 8.403-5.562 18.9 1.067 25.529l31.618 31.618c6.631 6.633 17.13 7.07 25.531 1.067l16.449-11.75c18.664 11.7 38.91 20.088 60.359 25.006l3.322 19.936c1.698 10.185 9.432 17.298 18.807 17.298h44.716c9.375 0 17.108-7.113 18.807-17.298l3.322-19.936c21.449-4.918 41.695-13.306 60.359-25.006l16.447 11.749c8.403 6.004 18.901 5.562 25.532-1.065l31.618-31.619c6.63-6.63 7.067-17.128 1.066-25.53l-11.75-16.449c11.7-18.668 20.089-38.916 25.006-60.358l19.936-3.322c10.185-1.698 17.298-9.432 17.298-18.807v-44.716c0-9.375-7.113-17.109-17.298-18.807l-19.939-3.323c-1.445-6.278-3.201-12.495-5.253-18.604 53.338-7.559 94.493-53.519 94.493-108.911zm-72.589 150.566c.229.038.424.089.586.142v42.589c-.162.053-.357.104-.586.142l-26.667 4.444c-4.123.688-7.384 3.867-8.175 7.972-4.55 23.609-13.7 45.697-27.197 65.651-2.342 3.462-2.283 8.014.146 11.415l15.715 22.001c.135.188.237.363.314.515l-30.114 30.116c-.152-.077-.327-.18-.516-.315l-22-15.715c-3.399-2.429-7.956-2.487-11.416-.145-19.947 13.495-42.035 22.646-65.651 27.196-4.104.791-7.284 4.052-7.971 8.175l-4.444 26.667c-.039.229-.089.424-.142.586h-42.589c-.053-.162-.104-.357-.142-.586l-4.444-26.667c-.687-4.123-3.867-7.384-7.972-8.175-23.616-4.551-45.704-13.701-65.65-27.196-3.462-2.343-8.016-2.284-11.417.145l-22.001 15.716c-.188.135-.362.237-.514.313l-30.116-30.115c.077-.151.18-.326.314-.515l15.715-22.001c2.429-3.4 2.487-7.953.146-11.415-13.496-19.954-22.646-42.042-27.197-65.651-.791-4.104-4.052-7.284-8.175-7.972l-26.666-4.444c-.229-.038-.424-.089-.586-.142v-42.589c.162-.053.357-.104.586-.142l26.666-4.444c4.124-.688 7.384-3.867 8.175-7.972 4.55-23.608 13.701-45.697 27.197-65.652 2.341-3.462 2.283-8.015-.146-11.415l-15.714-21.999c-.135-.189-.238-.364-.315-.517l30.115-30.114c.152.077.326.18.515.314l22 15.715c3.4 2.428 7.953 2.486 11.417.145 19.946-13.495 42.034-22.646 65.65-27.196 4.105-.791 7.285-4.052 7.972-8.176l4.444-26.666c.039-.229.089-.425.143-.587h42.589c.053.162.104.357.142.586l4.444 26.667c.687 4.124 3.867 7.385 7.972 8.176 9.61 1.852 19.105 4.517 28.28 7.935.557 11.484 2.9 22.756 6.918 33.425-21.198-11.036-44.691-16.789-69.05-16.789-23.512 0-46.041 5.3-66.959 15.752-4.94 2.468-6.944 8.475-4.476 13.415 2.469 4.939 8.473 6.943 13.416 4.476 18.118-9.053 37.639-13.643 58.02-13.643 26.323 0 51.473 7.747 73.054 22.454-1.554 5.794-3.108 11.591-4.663 17.394-1.665 6.247.09 12.686 4.693 17.223 4.533 4.467 11.132 6.185 17.237 4.489l17.221-4.618c14.709 21.58 22.458 46.733 22.458 73.058 0 71.683-58.317 130-130 130s-130-58.317-130-130c0-20.385 4.589-39.903 13.64-58.014 2.469-4.94.465-10.947-4.475-13.416-4.941-2.468-10.947-.466-13.416 4.475-10.453 20.912-15.751 43.438-15.751 66.955 0 82.71 67.29 150 150 150s150-67.29 150-150c0-24.36-5.753-47.853-16.789-69.051 10.669 4.018 21.941 6.361 33.425 6.919 3.419 9.176 6.085 18.671 7.937 28.281.791 4.104 4.052 7.284 8.175 7.972zm-37.411-60.566c-16.631 0-32.876-4.571-46.978-13.221-1.588-.974-3.399-1.476-5.229-1.476-.867 0-1.738.112-2.591.342l-28.494 7.642c2.547-9.503 5.095-19 7.642-28.496.712-2.651.302-5.479-1.134-7.818-8.646-14.1-13.217-30.342-13.217-46.973 0-49.626 40.374-90 90-90s90 40.374 90 90-40.373 90-89.999 90z"/><path d="m352.006 100h-.008c-5.522 0-9.996 4.478-9.996 10s4.481 10 10.004 10 10-4.478 10-10-4.478-10-10-10z"/><path d="m402.005 100h-.007c-5.522 0-9.997 4.478-9.997 10s4.481 10 10.004 10 10-4.478 10-10-4.478-10-10-10z"/><path d="m452.005 100h-.007c-5.522 0-9.997 4.478-9.997 10s4.481 10 10.004 10 10-4.478 10-10-4.478-10-10-10z"/><path d="m189.253 353.163c3.905 3.904 10.237 3.904 14.142 0 7.106-7.106 16.554-11.021 26.604-11.021s19.498 3.914 26.605 11.021c1.953 1.952 4.511 2.929 7.071 2.929s5.119-.977 7.071-2.929c3.905-3.906 3.905-10.237 0-14.143-10.885-10.884-25.356-16.878-40.748-16.878-15.393 0-29.863 5.994-40.747 16.878-3.904 3.906-3.903 10.238.002 14.143z"/><path d="m157.929 294.985c1.953 1.952 4.512 2.929 7.071 2.929s5.119-.977 7.071-2.929l7.928-7.929 7.928 7.929c1.953 1.953 4.512 2.929 7.071 2.929s5.119-.977 7.071-2.929c3.905-3.905 3.905-10.237 0-14.143l-7.929-7.929 7.929-7.929c3.905-3.905 3.905-10.237 0-14.143-3.906-3.904-10.237-3.904-14.143 0l-7.926 7.93-7.928-7.929c-3.906-3.905-10.237-3.903-14.143 0-3.905 3.905-3.905 10.237 0 14.143l7.929 7.929-7.929 7.929c-3.906 3.905-3.905 10.237 0 14.142z"/><path d="m257.928 294.985c1.953 1.952 4.512 2.929 7.071 2.929s5.118-.977 7.071-2.929l7.929-7.929 7.929 7.929c1.953 1.952 4.512 2.929 7.071 2.929s5.118-.977 7.071-2.929c3.905-3.905 3.905-10.237 0-14.143l-7.929-7.929 7.929-7.929c3.905-3.905 3.905-10.237 0-14.143-3.906-3.904-10.236-3.904-14.143 0l-7.929 7.929-7.929-7.929c-3.906-3.904-10.236-3.904-14.143 0-3.905 3.905-3.905 10.237 0 14.143l7.929 7.929-7.929 7.929c-3.904 3.906-3.904 10.238.002 14.143z"/><path d="m131.004 193.007c5.523 0 10-4.478 10-10s-4.477-10-10-10h-.007c-5.523 0-9.996 4.478-9.996 10s4.48 10 10.003 10z"/></g></g></svg>
									</div>

									<div class="span6" style="padding-top: 10%;">
										<h2 style="letter-spacing: 3px; font-family: Microsoft YaHei;">
											查無相關文章，請更換關鍵字。</h2>
											<a href="<c:url value="/postIndex"/>"><h2>回分享首頁</h2></a>
									</div>

								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="post" items="${postBeans}">
									<div class="row-fluid"
										style="border-bottom: 4px #325b43 dotted; margin-bottom: 1%; padding: 1% 1% 0% 1%;">
										<div class="row-fluid"
											style="margin-bottom: 1%; padding-bottom: 1%;">
											<div class="span9">
												<div class="media">
													<!-- 												文章圖片  -->
													<a class="pull-left" href=""> <img class="media-object"
														style="width: 100px; height: 100px; border: 1px lightgrey dashed;"
														src="<c:url value="/PostController/getPicture/${post.postId}" />" />
													</a>
													<div class="media-body" style="line-height: 30px;">
														<!-- 													 文章標題+類別 -->
														<h3 class="media-heading">
															${post.postTitle} &nbsp;
															<button class="btn-success">${post.postCategory}</button>
														</h3>
														<!-- 													文章內容(取前100字)  -->
														${fn:substring(post.postContent,0,100)} ...
														<!-- 													觀看單篇文章  -->
														<a
															href="<c:url value='/PostNeedLoginController/getPost/${post.postId}' />">>>>觀看更多
														</a>
													</div>
												</div>
											</div>
											<div class="span3" style="display: block;">

												<div style="display: flex; align-items: end;"
													class="postFavorite" data-id="${post.postId} ">
													<c:choose>
														<c:when test="${post.favoriteStatus == true}">
															<div style="display: flex; align-items: end;">
																<button class="postShowFavorite"
																	data-id="${post.postId}"
																	style="border: none; background-color: transparent;">
																	<img id="postImg${post.postId}"
																		src="${pageContext.request.contextPath}/images/post/heart.png">
																</button>
																<p id="postLike${post.postId}">${post.postLike}</p>
															</div>
														</c:when>
														<c:otherwise>
															<div style="display: flex; align-items: end;">
																<button class="postShowFavorite"
																	data-id="${post.postId}"
																	style="border: none; background-color: transparent;">
																	<img id="postImg${post.postId}"
																		src="${pageContext.request.contextPath}/images/post/heart-empty.png">
																</button>
																<p id="postLike${post.postId}">${post.postLike}</p>
															</div>

														</c:otherwise>
													</c:choose>
												</div>

												<p style="font-size: 15px; color: grey;">
													<br> <br> By
													${post.customerBean.customerNickname} <br>
													${fn:substring(post.postUploadTime,0,16)}
												</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>


					<!-- ------------------------------內容區塊--------------------------------- -->

				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>