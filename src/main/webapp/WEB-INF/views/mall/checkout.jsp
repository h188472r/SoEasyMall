<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MALL checkout</title>
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
					<h2 class="page-title">Cart</h2>
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="<c:url value='/mall'></c:url>" title="Mall">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Cart</li>
						</ol>
					</nav>
				</div>
			</div>
		</section>
		<!--==================================================================== 
            End Banner Section
        =====================================================================-->



		<!--==================================================================== 
           Start Checkout Page
       =====================================================================-->
		<section class="checkout-page mt-120 rmt-80 mb-120 rmb-80">
			<div class="container">
				<div class="row col-gap-60">
					<div class="col-xl-8 col-lg-6">
						<div class="checkout-form-wrap rmb-50">

							<div class="cart-title">
								<h4>CheckOut Details</h4>
							</div>

							<!-- Form Area Start -->
							<form id="checkout-form" name="checkout-form"
								class="checkout-form" action="sendmail.php" method="POST">
								<div class="row col-gap-50 clearfix">
									<div class="col-md-6">
										<div class="form-group">
											<label for="f-name">姓名:</label> <input type="text"
												class="form-control" id="f-name" value="陳小明" required>
										</div>
									</div>


									<div class="col-md-12">
										<div class="form-group">
											<label for="street-address">Shipping Address*</label> <input
												type="text" class="form-control" id="street-address"
												placeholder="Enter Your Delivery Address"
												value="台北市復興南路一段390號2樓" required>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label for="phone-number">Phone Number*</label> <input
												type="text" class="form-control" id="phone-number"
												value="02 6631 6666">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label for="email">Email <span>(optional)</span></label> <input
												type="email" class="form-control" id="email"
												value="soeasyeeit127@gmail.com" required>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label for="email">Other Note <span>(optional)</span></label>
											<textarea class="form-control mb-0" placeholder="備註......"
												rows="8" required></textarea>
										</div>
									</div>
								</div>
							</form>
							<!-- Form Area End -->
						</div>
					</div>
					<div class="col-xl-4 col-lg-6">
						<div class="checkout-cart-total clearfix">
							<div class="cart-title">
								<h4>Order Summary</h4>
							</div>


							<div class="total-item-wrap clearfix">
								<c:forEach var="item" items="${sessionScope.cart}" varStatus="i">
									<div class="total-item">

										<span class="product-name">${item.product.productName}</span>

										<span class="price">${item.product.productPrice*item.cartQuantity}</span>

									</div>
								</c:forEach>

								<div class="total-item">
									<span class="title">Shipping Cost</span> <span class="price">60</span>
								</div>

								<div class="total-item total">
									<span class="title">Total</span> <span class="price">${total+60}</span>
								</div>
							</div>


							<div class="cart-title">
								<h4 class="mb-25 mt-10">Payment</h4>
							</div>
							<!-- 							<ul id="accordionExample" class="mb-40"> -->



							<!-- 								Default unchecked -->


							<!-- 								Default unchecked -->
							<!-- 								<li class="custom-control custom-radio"><input type="radio" -->
							<!-- 									class="custom-control-input" id="methodtwo" -->
							<!-- 									name="defaultExampleRadios"> <label -->
							<!-- 									class="custom-control-label collapsed" for="methodtwo" -->
							<!-- 									data-toggle="collapse" data-target="#collapseTwo" -->
							<!-- 									aria-controls="collapseTwo">Credit Card / Master Card</label> -->

							<!-- 									<div id="collapseTwo" class="collapse" -->
							<!-- 										data-parent="#accordionExample" style=""> -->
							<!-- 										<ul> -->
							<!-- 											<li><a href="#"><img -->
							<!-- 													src="assets/img/pay-method/visa.png" alt=""></a></li> -->
							<!-- 											<li><a href="#"><img -->
							<!-- 													src="assets/img/pay-method/mastercard.png" alt=""></a></li> -->
							<!-- 											<li><a href="#"><img -->
							<!-- 													src="assets/img/pay-method/discover.png" alt=""></a></li> -->
							<!-- 											<li><a href="#"><img -->
							<!-- 													src="assets/img/pay-method/americanexpress.png" alt=""></a></li> -->
							<!-- 										</ul> -->
							<!-- 									</div></li> -->

							<!-- 								Default unchecked -->
							<!-- 								<li class="custom-control custom-radio"><input type="radio" -->
							<!-- 									class="custom-control-input" id="methodthree" -->
							<!-- 									name="defaultExampleRadios"> <label -->
							<!-- 									class="custom-control-label collapsed" for="methodthree" -->
							<!-- 									data-toggle="co llapse" data-target="#collapsethree" -->
							<!-- 									aria-controls="collapsethree">Cash On Delivery</label> -->

							<!-- 									<div id="collapsethree" class="collapse" -->
							<!-- 										data-parent="#accordionExample" style=""> -->

							<!-- 									</div></li> -->
							</ul>
							<!-- ===========paypal==================================== -->
							<form method="post"
								action="${pageContext.request.contextPath}/mall/pay">
								<div class="checkout-btn text-center">
									<button class="theme-btn br-5 w-70" type="submit" style="">PALPAL</button>
								</div>
							</form>
							<form method="post"
								action="${pageContext.request.contextPath}/mall/deliverPay">

								<br>
								<div class="checkout-btn text-center">
									<button class="theme-btn br-5 w-70" type="submit">貨到付款</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- ===========paypal==================================== -->

		<!--==================================================================== 
           End Checkout Page
       =====================================================================-->


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
	<!-- Scroll Top Button -->
	<button class="scroll-top scroll-to-target" data-target="html">
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

