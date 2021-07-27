<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>MALL</title>
<link rel='short icon'
	href="${pageContext.request.contextPath}/favicon.ico" />
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
				<jsp:include page="/fragment/header.jsp" />
				<!-- 引入共同的頁首 -->
			</div>
		</header>
		<!--==================================================================== 
                                End Header area
        =====================================================================-->


		<!--==================================================================== 
            Start Hero Section
        =====================================================================-->
		<section class="hero-section">
			<div class="hero-slider">
				<!-- hero-slide-item -->
				<div class="hero-slide-item"
					style="background-image:url(${pageContext.request.contextPath}/images/mall/indexbanner3.jpg); margin-top:150px;height:550px">
					<div class="container">

						<div class="hero-inner">
							<h1 class="mb-20 light">
								YOU <span>Are</span> <BR> What <span>You </span>EAT
							</h1>
							<p class="mb-40 mr-120 light">
								最健康的飲食都在這裡<br> 一場精心給予您的味蕾饗宴
							</p>
							<div class="hero-btn">
								<a href="<c:url value='/mall/lists' />" class="theme-btn">Order
									Now</a>
							</div>
						</div>

					</div>
				</div>
				<!--  End of hero-slide-item -->



			</div>
		</section>

		<!--==================================================================== 
            End Hero Section
        =====================================================================-->




		<!--==================================================================== 
           Start Delivery Process Section
       =====================================================================-->
		<section class="how-work text-center pt-60 pb-60 rpt-20 rpb-20">
			<div class="container">
				<div class="section-title">
					<h2>Delivery Process</h2>
					<p>不忽略每個步驟，為您把關每個細節</p>

				</div>
				<div class="row">
					<div class="col-md-3">
						<div class="work-box down-dashed">
							<span class="work-number"><img
								src="${pageContext.request.contextPath}/images/mall/icon/index1.png">
							</span>
							<h5>Step 1</h5>
							<span class="line"></span>
							<p>Choose Your Product</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="work-box up-dashed">
							<span class="work-number"><img
								src="${pageContext.request.contextPath}/images/mall/icon/index2.png"></span>
							<h5>Step 2</h5>
							<span class="line"></span>
							<p>Local Farm Product It</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="work-box down-dashed">
							<span class="work-number"><img
								src="${pageContext.request.contextPath}/images/mall/icon/index3.png"></span>
							<h5>Step 3</h5>
							<span class="line"></span>
							<p>Pick Up From Local Spot</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="work-box">
							<span class="work-number"><img
								src="${pageContext.request.contextPath}/images/mall/icon/index4.png"></span>
							<h5>Step 4</h5>
							<span class="line"></span>
							<p>We Can Delivery it Fast</p>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--==================================================================== 
           End Delivery Process Section
       =====================================================================-->


		<!--==================================================================== 
            Start Made For You Section
        =====================================================================-->
		<section class="made-for-product text-center pt-45 pb-20">
			<div class="container">
				<div class="section-title mb-45 ml-70 mr-70">
					<h2>Made For You</h2>
				</div>
				<div class="row"">

					<!--single Product -->
					<c:forEach items="${newlist}" var="product">


						<!--single Product -->
						<div class="col-xl-4 col-lg-6 col-sm-6">
							<div class="product">
								<div class="product-img-wrap" style="weight: 70px; height: 50px">
									<img class="media-object"
										src="<c:url value='/mall/getImage/${product.productId}' />"
										alt="Product Image">
									<!-- Button trigger modal -->
									<button class="quick-view" type="button" data-toggle="modal"
										data-target="#quick-view${product.productId}">Quick
										View</button>
								</div>

								<div class="product-content-wrap">
									<div class="product-content">
										<p>
											<a
												href="<c:url value='/mall/lists/product/${product.productId}'/>">${product.productName}
												<br>
											</a>
										</p>
									</div>
									<!-- 	===========//判斷是否可以加入購物車========== -->

									<div class="product-action">
										<c:choose>
											<c:when test="${product.productAmount>=1}">

												<a
													href="<c:url value='/mall/cart/buy/${product.productId}'/>"
													class="add-to-btn small-btn"> <img
													src="${pageContext.request.contextPath}/images/mall/icon/cart3.png">

													<span>Add to Cart</span>
													<h5 class="product-price">$${product.productPrice}</h5>
												</a>
											</c:when>
											<c:when test="${product.productAmount<1}">
												<i class="add-to-btn small-btn"> <img
													src="${pageContext.request.contextPath}/images/mall/icon/cart3.png">

													<span>Sold Out</span>
													<h5 class="product-price">$${product.productPrice}</h5>
												</i>

											</c:when>
										</c:choose>
									</div>
									<!-- 	===========(E) 判斷是否可以加入購物車========== -->

								</div>

							</div>
						</div>


						<!-- 										-----------singal product= -->
						<!--==================================== Start product-quick-view //product-modal  ================-->
						<div class="modal product-modal fade"
							id="quick-view${product.productId}" tabindex="-1" role="dialog"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body p-35 pt-0">


										<div class="product-quick-view">
											<div class="container">
												<div class="row">
													<div class="col-lg-6">
														<div class="product-preview-wrap">
															<div class="tab-content bg-white p-50 b1 br-5">
																<div class="tab-pane" id="preview1">
																	<img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Preview Image"
																		data-magnify-src="<c:url value='/mall/getImage/${product.productId}' />" />
																</div>
																<div class="tab-pane active" id="preview2">
																	<img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Preview Image"
																		data-magnify-src="<c:url value='/mall/getImage/${product.productId}' />" />
																</div>
																<div class="tab-pane" id="preview3">
																	<img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Preview Image"
																		data-magnify-src="<c:url value='/mall/getImage/${product.productId}' />" />
																</div>
																<div class="tab-pane" id="preview4">
																	<img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Preview Image"
																		data-magnify-src="<c:url value='/mall/getImage/${product.productId}' />" />
																</div>
															</div>

															<ul
																class="nav nav-tabs flex-nowrap align-content-between mt-30">
																<li><a data-toggle="tab" href="#preview1"> <img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Thumbnail Image" />
																</a></li>
																<li><a class="active" data-toggle="tab"
																	href="#preview2"> <img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Thumbnail Image" />
																</a></li>
																<li><a data-toggle="tab" href="#preview3"> <img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Thumbnail Image" />
																</a></li>
																<li><a data-toggle="tab" href="#preview4"> <img
																		src="<c:url value='/mall/getImage/${product.productId}' />"
																		alt="Product Thumbnail Image" />
																</a></li>
															</ul>
														</div>
													</div>
													<div class="col-lg-6">
														<div
															class="product-details text-left bg-white ml-25 px-50 py-45 b1 br-5">
															<h3 class="mb-25 rmt-25">${product.productName}</h3>
															<div class="rating mb-25">

																<div class="star mr-15">
																	<img
																		src="${pageContext.request.contextPath}/images/mall/line2.png"
																		style="weight: 50px;" />

																</div>
															</div>
															<div>

																<p>● 商品熱量:${product.productCalories} &nbsp;</p>
																<p>${product.productDescription}</p>

																<p style="text-align: right">
																	--&nbsp; product provider: ${product.shopBean.shopName}
																	<img
																		src="${pageContext.request.contextPath}/images/mall/icon/market.png">
																</p>
																<br />
															</div>
															<!-- 	//判斷是否售完 -->
															<c:choose>
																<c:when test="${product.productAmount>=1}">
																	<h6>
																		Availability: <span>InStock &nbsp;( Amount:
																			${product.productAmount})</span>
																	</h6>
																</c:when>
																<c:when test="${product.productAmount<1}">
																	<h5>我們正全力補貨中! &nbsp;也歡迎選購其他產品</h5>

																</c:when>
															</c:choose>
															<!-- =========	(E)//判斷是否售完 =============-->


															<h4 class="price">$${product.productPrice}</h4>

															<!-- 	===========//判斷是否可以加入購物車========== -->

															<div class="product-spinner mt-20">
																<c:choose>
																	<c:when test="${product.productAmount>=1}">
																		<a
																			href="<c:url value='/mall/cart/buy/${product.productId}'/>"
																			class="theme-btn br-30 ml-20">Add to Cart</a>
																	</c:when>
																	<c:when test="${product.productAmount<1}">
																		<i class="theme-btn no-shadow bg-blue">Sold Out</i>
																	</c:when>
																</c:choose>
															</div>
															<!-- 	==========(E)//判斷是否可以加入購物車 ===========-->

														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>

						</div>

						<!--==================================== end product-quick-view //product-modal  ================-->
					</c:forEach>
					<!-- 					進入商品頁 -->
					<div class="blog-btn text-center w-100 mt-25 mb-30">
						<a href="<c:url value='/mall/lists' />" class="theme-btn br-30">Browse
							More</a>
					</div>


					<!--==================================== end product-quick-view //product-modal  ================-->


				</div>
		</section>

		<!--==================================================================== 
            End Made For You Section
        =====================================================================-->



		<!--==================================================================== 
            Start categories-product Section
        =====================================================================-->
		<section class="categories-section text-center pt-60 pb-30">
			<div class="container">
				<div class="section-title mb-45">
					<h2>Shop By Categories</h2>
				</div>
				<div class="row">

					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=1'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index5.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>Foods and Vegetables</span>
							</div>
						</a>
					</div>
					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=$desc&category=2'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index6.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>Chicken</span>
							</div>
						</a>
					</div>
					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=3'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index7.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>Beef</span>
							</div>
						</a>
					</div>
					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=4'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index8.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>Pork</span>
							</div>
						</a>
					</div>
					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=5'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index9.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>SeaFoods</span>
							</div>
						</a>
					</div>
					<!-- 				分類 -->

					<div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-30">
						<a
							href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=7'/>"
							class="categori-item bg-white br-5"> <img
							src="${pageContext.request.contextPath}/images/mall/icon/index10.png"
							alt="img"> <br>
							<div class="categori-name">
								<br> <span>Drinks</span>
							</div>
						</a>
					</div>


				</div>

			</div>
		</section>
		<!--==================================================================== 
            End categories-product Section
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
								<li><img
									src="${pageContext.request.contextPath}/images/mall/pay-method/visa.png"
									alt=""></li>
								<li><img
									src="${pageContext.request.contextPath}/images/mall/pay-method/mastercard.png"
									alt=""></li>
								<li><img
									src="${pageContext.request.contextPath}/images/mall/pay-method/discover.png"
									alt=""></li>
								<li><img
									src="${pageContext.request.contextPath}/images/mall/pay-method/americanexpress.png"
									alt=""></li>
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
	<script src="${pageContext.request.contextPath}/js/mall/js/script.js"></script>


</body>
</html>

