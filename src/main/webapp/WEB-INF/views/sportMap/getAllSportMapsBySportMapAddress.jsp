<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link href="css/header&footer.css" rel="stylesheet">
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>

<link
	href="https://fonts.googleapis.com/css2?family=Caudex&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">	
<link href="${pageContext.request.contextPath}/css/sportMap_getAll.css"
	rel="stylesheet">
	
	
<style>
.btn1 {
	border-radius: 20px 20px;
	border-color: #D7FFEE;
	background-color: #D7FFEE;
}
</style>

<title>地區運動地點</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Map</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						運動使我們充滿活力，快揮灑你的汗水，展現你的風采</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						現在就起身尋找一個適合自己的地點吧！</p>
				</div>

			</div>

		</section>
	</div>
	
	
	
	
<!-- ------------------------------內容開始區塊--------------------------------- -->
	
	
	<div class='container'>
	<div class="style2"><a href="<c:url value='/showSportMapIndex'></c:url>" title="SportMap"> ／首頁</a>／依地區</div>
		<c:forEach varStatus="stVar" var="entry" items="${sportMaps_Address}">

			<div class='column'>
				<div class='demo-title'>${(entry.value.sportCategoryBean.sportCategoryName)}</div>
				<div class='post-module'>
					<div class='thumbnail'>
						<div class='date'>
							<div class='day'>go</div>
							<div class='month'>go</div>
														
							
						</div>
						${entry.value.sportMapMap}
					</div>
					<div class='post-content'>
						<div class='category'>Map</div>
						<h3 class='sub_title'>運動地點：${entry.value.sportMapName}</h3>
						<h3 class='description'>地址：${entry.value.sportMapAddress}</h3>
						<div class='post-meta'>
							<span class='timestamp'> <i class='fa fa-clock-o'></i>
								${(entry.value.sportCategoryBean.sportCategoryName)}
							</span>
							<span class='comments'> <i class='fa fa-comments'></i> <a
								href="<c:url value='sportMap/${entry.value.sportMapId}' />">詳細資訊</a>
							</span> 
<!-- 							<span class='comments'> <i class='fa fa-comments'></i>  -->
<!-- 							<a	class='deleteSportMap' -->
<%-- 								href="<c:url value='/' />sportMapController/del/${entry.value.sportMapId}">刪除</a> --%>
<!-- 							</span> -->
						</div>
					</div>
				</div>

			</div>

		</c:forEach>

	</div>



<!-- ------------------------------內容結束區塊--------------------------------- -->
<!-- ---------------------------控制分頁用----------------------------------- -->
<div class="style1">

	
		<table border="0" id="tb2">
			<tr align="center">
				<td width='80' height='20'><c:if test="${pageNo > 1}">
						<div id="">
							<a href="<c:url 
	value='displaySportMapsBySportMapAddress?sportMapAddress=${sportMapAddress}&pageNo=1#tb2' />"> 
							<img
							src="${pageContext.request.contextPath}/images/sportMap/iconStart.png"
								border='0' alt='第一頁' height='30' width='30' />
							</a>
						</div>
					</c:if></td>
				<td width='80'><c:if test="${pageNo > 1}">
						<div id="">
							<a
								href="<c:url value='displaySportMapsBySportMapAddress?sportMapAddress=${sportMapAddress}&pageNo=${pageNo-1}#tb2' />">
								<img src="${pageContext.request.contextPath}/images/sportMap/iconPre.png"
								border='0' alt='前一頁' height='30' width='30' />
							</a>
						</div>
					</c:if></td>
				<td width='76'>${pageNo}/ ${totalPages}</td>
				<td width='80'><c:if test="${pageNo != totalPages}">
						<div id="">
							<a
								href="<c:url value='displaySportMapsBySportMapAddress?sportMapAddress=${sportMapAddress}&pageNo=${pageNo+1}#tb2' />">
								<img src="${pageContext.request.contextPath}/images/sportMap/iconNext.png"
								border='0' alt='下一頁' height='30' width='30' />
							</a>
						</div>
					</c:if></td>
				<td width='80'><c:if test="${pageNo != totalPages}">
						<div id="">
							<a
								href="<c:url value='displaySportMapsBySportMapAddress?sportMapAddress=${sportMapAddress}&pageNo=${totalPages}#tb2' />">
								<img 
								src="${pageContext.request.contextPath}/images/sportMap/iconEnd.png"
								border='0' alt='最末頁' height='30' width='30' />
							</a>
						</div>
					</c:if></td>
			</tr>
		</table>
		
	</div>

<!-- ------------------------------控制分頁結束區塊--------------------------------- -->
<%-- 	<a href="<c:url value='/sportMapController/displaySportMaps' />"><button>所有運動地點</button></a> --%>

	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>