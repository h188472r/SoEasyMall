<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/header&footer.css" rel="stylesheet">
</head>
<body>
	<!-- 引入共同的頁尾  copy這行-->
	<%-- 	<jsp:include page="/fragment/footer.jsp" /> --%>
	<div class="mainWrapper">
	<footer>
		<hr>
		<div class="footerlinks" style="text-align: right;">
			<p>
				<a href="<c:url value='/'></c:url>" title="Link">首頁</a> 
				<a href="#" title="Link">園地</a> 
				<a href="<c:url value='/lectureIndex'></c:url>" title="SoLecture">講座</a>
				<a href="#" title="Link">商城</a> 
				<a href="<c:url value='/postIndex'></c:url>" title="So Share">分享</a> 
				<a href="<c:url value='/showSportMapIndex'></c:url>" title="SportMap">地圖</a> 
				<a href="<c:url value='/nutritionist'></c:url>" title="Link">營養師</a>
			</p>
		</div>
	</footer>
	</div>
</body>
</html>