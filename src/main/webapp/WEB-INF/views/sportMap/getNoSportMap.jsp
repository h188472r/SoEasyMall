<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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

	
	
<style>
.btn1{
	display: flex;
    justify-content: center;
    width:100%;
    margin-top:40px;
    color:#f08080;

}
</style>

<title>查無地點</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

<!-- 	<div class="mainWrapper"> -->
<!-- 		<section id="offer"> -->
<!-- 			<div style="background-color: #C9D8BF; text-align: center;"> -->
<!-- 				<div style="margin: 5% auto;"> -->
<!-- 					<h1 style="color: #1d3b2a; font-family: Caudex;">So Map</h1> -->
<!-- 					<p style="color: #325b43; font-family: Lobster; font-size: 18px;"> -->
<!-- 						運動使我們充滿活力，快揮灑你的汗水，展現你的風采</p> -->

<!-- 					<p style="color: #325b43; font-family: Lobster; font-size: 18px;"> -->
<!-- 						現在就起身尋找一個適合自己的地點吧！</p> -->
<!-- 				</div> -->

<!-- 			</div> -->

<!-- 		</section> -->
<!-- 	</div> -->
<!-- ------------------------------內容開始區塊--------------------------------- -->
	
	<div><div class="btn1"><img src="${pageContext.request.contextPath}/images/sportMap/NotFound.png" >	
	</div>
	<div class="btn1">
				
				<h2><a href="<c:url value='/showSportMapIndex'></c:url>" style="color:#e76f51;">這個地方沒有運動地點唷！回首頁吧</a></h2>
				
	</div>
	
	</div>
	
	

<!-- ------------------------------內容結束區塊--------------------------------- -->

	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>