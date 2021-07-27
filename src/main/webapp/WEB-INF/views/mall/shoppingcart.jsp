<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ShoppingCart</title>
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
           Start Cart Page
       =====================================================================-->
		<section class="cart-page mt-120 rmt-80 mb-120 rmb-80">
			<div class="container">
				<div class="row col-gap-60">
					<div class="col-xl-8">

						<form method="post"
							action="${pageContext.request.contextPath}/mall/cart/update">
							<div class="cart-total-product rmb-80 b1 br-5 p-50">
								<h4 class="cart-heading">Shopping Cart</h4>

								<div class="cart-title d-none d-md-flex">
									<h5 class="product-title">Product</h5>
									<h5 class="quantity-title">Quantity</h5>
									<h5 class="price-title">Price</h5>
									<h5 class="total-title">Total</h5>
								</div>
								<c:forEach var="item" items="${sessionScope.cart}" varStatus="i">

									<div class="cart-items pb-15">
										<div class="cart-single-item">

											<!-- 			刪除紐 -->


											<a class="btn "
												href="${pageContext.request.contextPath}/mall/cart/remove/${i.index}">X<i
												class="icon-remove icon-white"></i></a>
											<div class="product-img">
												<img class="media-object"
													src="<c:url value='/mall/getImage/${item.product.productId}' />"
													alt="Product Image">
											</div>
											<h6 class="product-name">${item.product.productName}</h6>
											<div class="number-input">
												<input class="quantity" min="1" max="50" name="quantities"
													id="appendedInputButtons" value="${item.cartQuantity}"
													type="number">
											</div>
											<h6 class="product-price">${item.product.productPrice}</h6>
											<h6 class="product-total-price">${item.product.productPrice*item.cartQuantity}</h6>
										</div>
									</div>
								</c:forEach>


								<div class="row text-center text-lg-left">
									<div class="col-lg-5">
										<div class="continue-shopping">
											<a class="theme-btn no-shadow bg-blue br-5"
												href="/soeasy/mall/lists"> Continue Shopping</a>
										</div>
									</div>


									<div class="col-lg-7">
										<div class="update-shopping text-lg-right">
											<c:if test="${sessionScope.cart!=null}">
												<button type="submit"
													class="theme-btn no-shadow style-two br-10 rmt-30">Update
													Cart</button>
											</c:if>

										</div>
									</div>



								</div>
							</div>

						</form>
					</div>


					<div class="col-xl-4">
						<div class="cart-total-price p-50 ">
							<h4 class="cart-heading">Order Summary</h4>
							<div class="total-item-wrap">
								<div class="total-item sub-total">
									<span class="title">Total Item: &nbsp;${countItems} </span> <span
										class="price">${total}</span>
								</div>
								<div class="total-item shipping">
									<span class="title">Shipping Cost</span> <span class="price">60</span>
								</div>
								<form action="#" class="d-lg-block">
									<h6 class="mb-25 mt-30">Promo Code</h6>
									<input class="w-100 br-5" type="text"
										placeholder="Enter Discount Code">
									<button class="theme-btn no-shadow bg-blue br-2" type="submit">Apply</button>
								</form>
								<div class="total-item discount">
									<span class="title">Discount</span> <span class="price">0</span>
								</div>
								<div class="total-item total">
									<span class="title mb-0">Total</span> <span class="price mb-0">${total+60}</span>
								</div>
							</div>
							<div><br></div>
							<div class="proceed-btn mt-30">
								<a href="<c:url value='/mall/cart/checkout'/>"
									class="theme-btn w-100 text-center br-10">Proceed Checkout</a>
							</div>
						</div>
					</div>

				</div>

			</div>
		</section>

		<!--==================================================================== 
           End Cart Page
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

