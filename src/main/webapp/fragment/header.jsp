<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- header的css -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/style.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/responsive.css"> --%>
<link href="${pageContext.request.contextPath}/css/header&footer.css"
	rel="stylesheet">
</head>

<body>
	<!-- 引入共同的頁首  copy這行-->
	<%-- 	<jsp:include page="/fragment/header.jsp" /> --%>
<!-- 	<header class="main-header"> -->
<!-- 		<div class="container"> -->

			<div class="mainWrapper">
				<header>
					<div id="logo">
						<a href="<c:url value="/"></c:url>"><img
							src="${pageContext.request.contextPath}/images/ICON.png"></a>
					</div>
					<a href="<c:url value='/admin/adminLogin'></c:url>"><button
							style="position: absolute; color: white; background-color: white; border: 0px">admin</button></a>
					<div id="headerLinks">
						<c:if
							test="${empty customerSignInSuccess && empty shopSignInSuccess && empty adminLoginSuccess}">
							<a href="<c:url value='/customerController/addCustomer'></c:url>"
								title="Login/Register">登入/註冊</a>
						</c:if>
						<c:if test="${!empty customerSignInSuccess}">
							<jsp:include page="/fragment/customerMenu.jsp" />
						</c:if>
						<c:if test="${!empty shopSignInSuccess}">
							<jsp:include page="/fragment/shopMenu.jsp" />
						</c:if>
						<c:if test="${!empty adminLoginSuccess}">
							<jsp:include page="/fragment/adminMenu.jsp" />
						</c:if>
						<a href="<c:url value='/mall/cart/index'/>" title="Cart">購物車</a>
					</div>
					<nav>
						<a href="<c:url value='/'></c:url>" title="Link">首頁</a> <a
							href="#" title="Link">園地</a> <a
							href="<c:url value='/lectureIndex'></c:url>" title="SoLecture">講座</a>
						<a href="<c:url value='/mall'></c:url>" title="Mall">商城</a> <a
							href="<c:url value='/postIndex'></c:url>" title="So Share">分享</a>
						<a href="<c:url value='/showSportMapIndex'></c:url>"
							title="SportMap">地圖</a> <a
							href="<c:url value='/nutritionist'></c:url>" title="Link">營養師</a>
					</nav>
				</header>
			</div>
<!-- 		</div> -->
<!-- 	</header> -->
</body>
</html>