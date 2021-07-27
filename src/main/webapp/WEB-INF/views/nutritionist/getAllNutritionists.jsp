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
<title>查詢全部營養師列表</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<style>
#mainWrapper2 {
	width: 80%;
	padding-left: 10%;
	padding-right: 10%;
}

body * {
	font-family: '微軟正黑體';
}

#uk_breadcrumb {
	flex-wrap: wrap;
	list-style: none;
	display: flex;
	font-size: 18px;
}

#uk_breadcrumb li a {
	text-decoration: none;
}

#h3css {
	font-family: '微軟正黑體';
	color: #FF4D00;
}

#h3css2 {
	font-family: '微軟正黑體';
	color: #007FFF;
}

#pcss {
	font-family: '微軟正黑體';
	color: #B22222;
}

.thumbnail {
	float: left;
	width: 320px;
	height: 600px;
	margin-left: 30px;
	margin-right: 25px;
	margin-top: 30px;
}

.imgvideo {
	max-width: 100%;
	height: 400px;
}

.page-icon {
	margin: 20px 0 0 0;
	/*設置距離頂部20像素*/
	font-size: 0;
	/*修復行內元素之間空隙間隔*/
	text-align: center;
	/*設置內容居中顯示*/
}

/*設置共有的的樣式佈局，主要是進行代碼優化，提高運行效率*/
.page-icon a, .page-disabled, .page-next {
	border: 1px solid #ccc;
	border-radius: 3px;
	padding: 4px 10px 5px;
	font-size: 14PX;
	/*修復行內元素之間空隙間隔*/
	margin-right: 10px;
}

/*對 a 標籤進行樣式佈局 */
.page-icon a {
	text-decoration: none;
	/*取消鏈接的下劃線*/
	color: #005aa0;
}

.page-current {
	color: #ff6600;
	padding: 4px 10px 5px;
	font-size: 14PX;
	/*修復行內元素之間空隙間隔*/
}

.page-disabled {
	color: #ccc;
}

.page-next i, .page-disabled i {
	cursor: pointer;
	/*設置鼠標經過時的顯示狀態，這裏設置的是顯示狀態爲小手狀態*/
	display: inline-block;
	/*設置顯示的方式爲行內塊元素*/
	width: 5px;
	height: 9px;
	background-image:
		url(http://img.mukewang.com/547fdbc60001bab900880700.gif);
	/*獲取圖標的背景鏈接*/
}

.page-disabled i {
	background-position: -80px -608px;
	margin-right: 3px;
}

.page-next i {
	background-position: -62px -608px;
	margin-left: 3px;
}
</style>
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<section>
		<img
			src="${pageContext.request.contextPath}/images/nutritionist/nutritionistHeader.png"
			width="100%" height="100%">
	</section>
	<div id='mainWrapper2'>
		<section>
			<br>
			<div>
				<ul id="uk_breadcrumb">
					<li><a href='<c:url value='/'></c:url>'>首頁</a></li>
					<li>&emsp;&frasl;&emsp;營養師列表</li>
				</ul>
			</div>
			<hr>

			<h3 id="h3css">營養師列表</h3>
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">

						<c:forEach var='nutritionist' items='${nutritionists}'>

							<div class="thumbnail">
								<img class="imgvideo"
									src="<c:url value='/nutritionistController/getImage/${nutritionist.nutritionistId}' />" />

								<div class="caption">
									<h3>
										姓名 : <font id='h3css2'>${nutritionist.nutritionistName}</font>
									</h3>
									<p>
										專長 : <font id='pcss'>${nutritionist.nutritionistCategoryBean.nutritionistCategoryName}</font>
									</p>
									<p>
										學位 : <font>${nutritionist.nutritionistDegree}</font>
									</p>
									<p>
										<a class="btn btn-primary"
											href="<c:url value='/nutritionistController/nutritionist/${nutritionist.nutritionistId}'/>">營養師詳細資料</a>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<div class="page-icon">
				<span class="page-disabled"><i></i>上一頁</span> <span
					class="page-current">1</span> <a href="#">2</a> <a
					class="page-next" href="#">下一頁<i></i></a>
			</div>
			<br>

			<div>
				<a href="<c:url value='/recordController/addRecord'/>"><button>新增日誌</button></a>
				<a href="<c:url value='/recordController/getAllRecords'/>"><button>
						所有日誌</button></a> <a
					href="<c:url value='/recordController/record/getRecordByCustomerId'/>"><button>
						會員日誌</button></a>
			</div>


		</section>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>