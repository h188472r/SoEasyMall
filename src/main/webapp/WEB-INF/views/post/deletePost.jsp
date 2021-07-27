<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share Deleted</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel='stylesheet'
	href='https://fonts.googleapis.com/css?family=Dosis:400,300,500,800'>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/postDelete.css">
</head>
<body>
	<!-- partial:index.partial.html -->
	<div class="content" style="">
		<canvas class="snow" id="snow"></canvas>
		<div class="main-text">
			<h1>
				Oh！文章不見了。<br />
			</h1>
			<a class="home-link" href="<c:url value='/postIndex'/>">這篇文章已被作者或管理者刪除。返回看更多文章吧</a>
		</div>
		<div class="ground">
			<div class="mound">
				<div class="mound_spade"></div>
			</div>
		</div>
	</div>
	<!-- partial -->
	<script src="${pageContext.request.contextPath}/js/postDelete.js"></script>



</body>
</html>