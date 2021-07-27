<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
			style="background-image:url(${pageContext.request.contextPath}/images/mall/banner.jpg); margin-top:120px;">
			<div class="container">
				<div class="banner-inner text-center">
					<h2 class="page-title">Shop</h2>
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="<c:url value='/mall/lists'></c:url>" title="Mall">Mall</a></li>
							<li class="breadcrumb-item active" aria-current="page">Product</li>
						</ol>
					</nav>
				</div>
			</div>
		</section>
		<!--==================================================================== 
            End Banner Section
        =====================================================================-->


		<!--==================================================================== 
  
  						查詢用按鈕段落
        =====================================================================-->


		<div>

			<div>
				<form action="<c:url value='/mall/lists/1'/>" class="d-lg-block"
					style="margin-left: 150px; margin-top: 50px">
					<input type="hidden" name="sortField" value="${sortField}" /> <input
						type="hidden" name="sortDir" value="${sortDir}" /> <img
						src="${pageContext.request.contextPath}/images/mall/icon/search2.png"><input
						type="text" name="keyword" value="${keyword}"
						placeholder="Enter Searching" /> &nbsp;<input type="submit"
						value="Search" class="theme-btn no-shadow bg-blue" /> &nbsp; <input
						type="button" value="clear" onclick="clearFilter()"
						class="theme-btn no-shadow bg-blue">
				</form>
			</div>

			<!--==================================================================== 
								查詢用按鈕結束
    =====================================================================-->

			<!--==================================================================== 
           Start Shop Page
       =====================================================================-->
			<section class="shop-page mt-40 rmt-80 mb-90 rmb-50">
				<div class="container">
					<div class="row">

						<div class="col-xl-3 col-lg-4">
							<div class="shop-sidebar">
								<div class="shop-widget b1">
									<div class="shop-widget-title">
										<h5>
											<img
												src="${pageContext.request.contextPath}/images/mall/icon/list.png"
												style="weight: 30px; height: 30px"></i>Categories
										</h5>
									</div>
									<ul>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=1'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category1.png">
												Foods and Vegetables</a></li>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=2'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category5.png">
												Chickenen MealBox</a></li>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=3'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category6.png">
												Beef Meal Box</a></li>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=4'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category2.png">
												Pork Meal Boxl</a></li>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=5'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category7.png">
												Fish Meal Box</a></li>
										<li><a
											href="<c:url value='/mall/lists/1?sortField=category&sortDir=desc&category=7'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category8.png">
												Drinks</a></li>
										<li><a
											href="<c:url value='/mall/lists/${currentPage}?sortField=category&sortDir=${reverSortDir}&category=6'/>"><img
												src="${pageContext.request.contextPath}/images/mall/icon/category3.png">
												Meal Box for vagetarien</a></li>



									</ul>
								</div>

								<!-- 								=======best=========== -->
								<div class="shop-widget b1">
									<div class="shop-widget-title">
										<h5>
											<img
												src="${pageContext.request.contextPath}/images/mall/icon/list.png"
												style="weight: 30px; height: 30px">Newest Product
										</h5>
									</div>
									<c:forEach items="${productTop3}" var="productTop">
										<div
											class="product list-product d-flex align-items-center bg-white br-5 mb-30">
											<div class="product-img-wrap">
												<img
													src="<c:url value='/mall/getImage/${productTop.productId}' />"
													alt="img">
											</div>
											<div class="product-content-wrap">
												<div class="product-content">
													<p>
														<a
															href="<c:url value='/mall/lists/product/${productTop.productId}'/>">${productTop.productName}
														</a>
													</p>
												</div>
												<div class="product-action">
													<c:choose>
														<c:when test="${productTop.productAmount>=1}">

															<a
																href="<c:url value='/mall/cart/buy/${productTop.productId}'/>"
																class="add-to-btn small-btn"> <img
																src="${pageContext.request.contextPath}/images/mall/icon/cart1.png">

																<span>Add to Cart</span>
																<h5 class="product-price">$${productTop.productPrice}</h5>
															</a>
														</c:when>
														<c:when test="${productTop.productAmount<1}">
															<i class="add-to-btn small-btn"> <img
																src="${pageContext.request.contextPath}/images/mall/icon/cart1.png">

																<span>Sold Out</span>
																<h5 class="product-price">$${productTop.productPrice}</h5>
															</i>

														</c:when>
													</c:choose>
												</div>
											</div>
										</div>

									</c:forEach>
								</div>


							</div>
						</div>

						<!-- 						=====================product ===================--------------------------------->

						<div class="col-xl-9 col-lg-8">
							<div class="shop-items">


								<div class="search-result-header">
									<h5>
										Showing Result of
										<c:out value="${totalItems}" />
										Product
									</h5>
									<div class="sort-by">
										<a
											href="<c:url value='/mall/lists/${currentPage}?sortField=productPrice&sortDir=${reverSortDir}&category=${category}&keyword=${keyword}'/>">
											Sort By Price <svg xmlns="http://www.w3.org/2000/svg"
												width="15" height="15" viewBox="0 0 512 512">
															<path fill="currentColor"
													d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
										</a>
									</div>
								</div>
							</div>
							<div class="row">

								<c:forEach items="${product}" var="product">


									<!--single Product -->
									<div class="col-xl-4 col-lg-6 col-sm-6">
										<div class="product">
											<div class="product-img-wrap"
												style="weight: 70px; height: 100px">
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
												<!-- =============================加入購物車_是否完售 -==================-->
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
												<!-- =============================(E)加入購物車_是否完售 -==================-->

											</div>

										</div>
									</div>
									<!-- 										-----------singal product= -->
									<!--==================================== Start product-quick-view //product-modal  ================-->
									<div class="modal product-modal fade"
										id="quick-view${product.productId}" tabindex="-1"
										role="dialog" aria-hidden="true">
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
																				--&nbsp; product provider:
																				${product.shopBean.shopName} <img
																					src="${pageContext.request.contextPath}/images/mall/icon/market.png">
																			</p>
																			<br />
																		</div>
																		<!-- 	=============//判斷是否售完 ==================-->
																		<c:choose>
																			<c:when test="${product.productAmount>=1}">
																				<h6>
																					Availability: <span>InStock &nbsp;( Amount:
																						${product.productAmount})</span>
																				</h6>
																			</c:when>
																			<c:when test="${product.productAmount<1}">
																				<h5>我們正全力補貨中! &nbsp;也歡迎選購其他產品!</h5>

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
							</div>



							<!-- 								============== -->
						</div>

					</div>
				</div>
		</div>


		<!-- ---------------------------控制分頁用----------------------------------- -->
		<nav style="width: 400px; margin-bottom: 120px; margin-left: 720px">

			<div class="btn-group ">


				<!--  上頁 -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<a class="btn btn-info btn-sm"
							href="<c:url value='/mall/lists/${currentPage - 1}?sortField=${sortField}&sortDir=${SortDir}&category=${category}'/>">Previous</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-info btn-sm">Previous</a>
					</c:otherwise>
				</c:choose>
				<!-- 上頁結束 -->

				&nbsp; &nbsp;
				<p style="font-style: italic; color: #00477D">
					Page &nbsp;
					<c:out value="${currentPage}" />
					&nbsp; of &nbsp;&nbsp;
					<c:out value="${totalPages}" />
				</p>
				&nbsp; &nbsp;




				<!--  下頁 -->
				<c:choose>
					<c:when test="${currentPage < totalPages}">
						<a class="btn btn-info btn-sm"
							href="<c:url value='/mall/lists/${currentPage + 1}?sortField=${sortField}&sortDir=${SortDir}&category=${category}'/>">Next</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-info btn-sm">Next</a>
					</c:otherwise>
				</c:choose>
				<!-- 下頁結束 -->

			</div>
		</nav>

		<!-- ------------------------------控制分頁結束區塊--------------------------------- -->

		</section>
		<!--==================================================================== 
           End Shop Page
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
	<button class="scroll-top scroll-to-target" data-target="jsp">
		<span class="fa fa-angle-up"></span>
	</button>

	<!-- ======================    綁定清除查詢 ================================-->

	<script type="text/javascript">
		function clearFilter() {
			window.location = '/soeasy/mall/lists';
		}
	</script>
	<!-- ------------------------------用來接POST-------------------------------- -->
	<form method='POST'>
		<input type='hidden' name='_method' value='score'>
	</form>

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

