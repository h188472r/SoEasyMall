<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Order History</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mall/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mall/responsive.css">

</head>
<body>

	<div class="page-wrapper">

		<!--==================================================================== 
                                Start Header area
        =====================================================================-->
		<header class="main-header">
			<div class="container">
				<!-- 引入共同的頁首 -->
				<jsp:include page="/fragment/header.jsp" />
			</div>
		</header>
		<!--==================================================================== 
                                End Header area
        =====================================================================-->


		<!--==================================================================== 
            Start Banner Section
        =====================================================================-->
		<section class="banner-section"
			style="background-image:url(${pageContext.request.contextPath}/images/mall/indexbanner1.jpg); margin-top:120px;">
			<div class="container">
				<div class="banner-inner text-center">
					<h2 class="page-title">Order</h2>
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="<c:url value='/mall'></c:url>" title="Mall">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Order</li>
						</ol>
					</nav>
				</div>
			</div>

		</section>
		<!--==================================================================== 
            End Banner Section
        =====================================================================-->

		<section class="my-80 ">
<!-- 		<section class="my-80 rmy-500"> -->

			<div class="container" >

				<h5 class="header-title text-lg-center">Order History</h5>
				<div class="login-information bg-white" >
					<!--==================================================================== 
            Start Content 
      =====================================================================-->

					<table class="table table-border">

						<thead>

							<tr>

								<th class="text-lg-center">訂單編號</th>
								<th class="text-lg-center">會員帳號</th>
								<th class="text-lg-center">訂購日期</th>
								<th class="text-lg-center">訂單狀態</th>
								<th class="text-lg-center">總金額</th>
								<th class="text-lg-center">付款狀態</th>
<!-- 								<th class="text-lg-center">ID</th> -->
								<th class="text-lg-center">Detail</th>


							</tr>

						</thead>



						<tbody>
							<c:forEach var="order" items="${order}">

								<tr>

									<td class="text-lg-center">${order.orderId}</td>
									<td class="text-lg-center">${order.orderCustomerName}</td>
									<td class="text-lg-center">${order.orderRegisterTime}</td>
									<td class="text-lg-center">${order.orderStatus}</td>
									<td class="text-lg-center">${order.orderTotalPrice}</td>
									<td class="text-lg-center">${order.payStatus}</td>
<%-- 									<td class="text-lg-center">${order.customerBean.customerId}</td> --%>
									<td class="text-lg-center"><a class="theme-btn no-shadow style-two br-10 rmt-30"
										href="<c:url value='/mall/order/orderDetail/${order.orderId}'/>" >Detail</a>
									</td>



								</tr>

							</c:forEach>
						</tbody>

					</table>







					<!--==================================================================== 
                            End Content section
        ============


					<!--                         </div> -->




				</div>
			</div>
			
			<!-- =============================繼續購物============================================= -->
					<br>
					<div class="row text-center text-lg-right">
						<div class="col-lg-11">
							<div class="continue-shopping">
								<a class="theme-btn no-shadow bg-blue br-5"
									href="/soeasy/mall/lists"> Continue Shopping</a>
							</div>
						</div>

					</div>
<!-- =============================(ENd)繼續購物============================================= -->
			

		</section>








		<!--==================================================================== 
                            Start footer section
        =====================================================================-->
		<footer class="footer bg-black pt-100 text-lg-left text-center">
			<div class="container">
				<div class="row">

					<!--Footer Column-->
					<div class="col-lg-3 col-md-12 mb-30">
						<div class="footer-widget logo-widget mr-15">
							<div class="footer-logo">
								<br> <br> <a href="#"><img
									src="${pageContext.request.contextPath}/images/ICON.png"
									alt="footer logo"></a>
							</div>

						</div>
					</div>

					<!--                     Footer Column -->
					<div class="col-lg-4 col-md-5 mb-20">
						<div class="footer-widget form-widget ml-50 mr-20">
							<h5 class="footer-title mb-20">Subscribe Our News Letter</h5>
							<p>建置中</p>
							<form class="subscribe">
								<input type="email" placeholder="Your Email For Notify" required>
								<button type="submit">Send</button>
							</form>
						</div>
					</div>

					<!--Footer Column-->
					<div class="col-lg-3 col-md-4 mb-30">
						<div class="footer-widget pament-widget">
							<h5 class="footer-title mb-30">Payment</h5>
							<ul class="list">
								<li><a href="#"><img
										src="${pageContext.request.contextPath}/images/mall/pay-method/visa.png"
										alt=""></a></li>
								<li><a href="#"><img
										src="${pageContext.request.contextPath}/images/mall/pay-method/mastercard.png"
										alt=""></a></li>
								<li><a href="#"><img
										src="${pageContext.request.contextPath}/images/mall/pay-method/discover.png"
										alt=""></a></li>
								<li><a href="#"><img
										src="${pageContext.request.contextPath}/images/mall/pay-method/americanexpress.png"
										alt=""></a></li>
							</ul>
						</div>
					</div>
					<!--Footer Column-->
					<div class="col-lg-2 col-md-3 mb-30">
						<div class="footer-widget links-widget float-lg-right mr-40">
							<h6 class="footer-title mb-30">Map</h6>
							<ul class="list">
								<li><a href="<c:url value='/'></c:url>" title="Link">Index</a>
								</li>
								<li><a href="#" title="Link">園地</a></li>
								<li><a href="<c:url value='/postIndex'></c:url>"
									title="So Share">分享</a></li>
								<li><a href="<c:url value='/showSportMapIndex'></c:url>"
									title="SportMap">地圖</a></li>
								<li><a href="<c:url value='/nutritionist'></c:url>"
									title="Link">營養師</a>
							</ul>
						</div>
					</div>


				</div>
				<div class="row">
					<div class="col-lg-12">


						<!-- Copyright Area-->
						<div
							class="copyright text-center pl-10 pr-10 pt-30 pb-10 mt-55 rmt-35 mb-65">
							<p></p>
						</div>

					</div>
				</div>


			</div>

		</footer>
		<!--==================================================================== 
                                End footer section
        =====================================================================-->


		<!--End pagewrapper-->
	</div>


	<!--==================================================================== 
                              Start Script
        =====================================================================-->



	<!-- 用於將 POST 請求轉換為 DELETE請求 -->
	<!--     暫時放棄 先直接用Post請求 -->
	<form action="#" method="POST">
		<input type="hidden" value="DELETE" name="_method" />
	</form>
	<script type="text/javascript">
		//將 get 請求轉換為 post 請求提交
		function del(tag) {
			//獲取當前請求路徑
			var href = tag.href;
			//提交
			$("form").attr("action", href).submit();
			return delmag();

			function delmag() {
				var msg = "您確定要刪除這樣產品嗎？";
				if (confirm(msg) == true) {
					return true;
				} else {
					return false;
				}
			}
		}
	</script>

	<!-- ======================    綁定清除查詢 ================================-->


	<script type="text/javascript">
		function clearFilter() {
			window.location = '/soeasy/mall/lists';
		}
	</script>

	<!-- ==========================   (End) 綁定清除查詢========================-->




	<!--==================================================================== 
                              End Script
        =====================================================================-->

	<!-- Scroll Top Button -->
	<button class="scroll-top scroll-to-target" data-target="jsp">
		<span class="fa fa-angle-up"></span>
	</button>
	<!-- jequery plugins -->
	<script src="${pageContext.request.contextPath}/js/mall/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/mall/bootstrap-v4.1.3.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/mall/jquery.nice-select.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/mall/jquery.simpleLoadMore.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/mall/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/mall/appear.js"></script>
	<!-- Custom script -->
	<script src="${pageContext.request.contextPath}/js/mall/script.js"></script>



</body>
</html>

