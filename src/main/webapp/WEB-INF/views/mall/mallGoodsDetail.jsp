<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MALL-Goods Detail</title>
<link rel='short icon'
	href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mall/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mall/responsive.css">

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded",function(){
		let showFavorite = document.getElementById("showFavorite");
		let favoriteHeart = document.getElementById("favoriteHeart");
		
		//初始化XMLHttpRequest物件
		let xhr = new XMLHttpRequest();
		
		//收藏按鈕
		showFavorite.addEventListener("click",updateFavorite);
		//按下收藏按鈕，送出JSON字串資料
		function updateFavorite(){
			//建一支Object，裝收藏controller要的內容
			let favoriteInfo = {
				'favoriteCategory' : 'productFavorite'	,
				'favoriteItemId' : ${product.productId}
				
			}
			//將物件轉為json			
			let json = JSON.stringify(favoriteInfo);
			
			console.log(json);
			
			xhr.open('POST',"<c:url value='/favoriteController/addFavorite'/>");
			xhr.setRequestHeader("Content-Type","application/json;charset=UTF-8");
			xhr.send(json);
			
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status ==200){
					
					if(xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn"){
						location.href="/soeasy/customerController/customerSignIn";
					}
					
					let favoriteJson = JSON.parse(xhr.responseText);
// 	//				console.log(favoriteJson);
					//更改圖片
					if (favoriteJson.favoriteExist){
						favoriteHeart.src="${pageContext.request.contextPath}/images/mall/icon/like1.png";
					}else {
						favoriteHeart.src="${pageContext.request.contextPath}/images/mall/icon/like2.png";

					}
					
				}
				
				
			}
			
			
		}		
		
		
		
	} )
</script>



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
					<h2 class="page-title">Product Detail</h2>
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
           Start Shop Details Page
       =====================================================================-->
		<section class="shop-details-page"
			class="shop-details-page mt-120 rmt-70 mb-60 rmb-20">
			<div class="container" style="margin-top: 100px">
				<div class="row col-gap-60">

					<div class="col-xl-3 col-lg-4">
						<div class="shop-sidebar">
							<div class="shop-widget b1">
								<div class="shop-widget-title">
									<h5>
										<h5>
											<i><img
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
											style="weight: 30px; height: 30px">Others From Provider
									</h5>
								</div>
								<c:forEach items="${sameShop}" var="relatedShop">
									<div
										class="product list-product d-flex align-items-center bg-white br-5 mb-30">
										<div class="product-img-wrap">
											<img
												src="<c:url value='/mall/getImage/${relatedShop.productId}' />"
												alt="img">
										</div>
										<div class="product-content-wrap">
											<div class="product-content">
												<p>
													<a
														href="<c:url value='/mall/lists/product/${relatedShop.productId}'/>">${relatedShop.productName}
													</a>
												</p>
											</div>
											<!-- =============================加入購物車_是否完售 -==================-->
											<div class="product-action">
												<c:choose>
													<c:when test="${relatedShop.productAmount>=1}">

														<a
															href="<c:url value='/mall/cart/buy/${relatedShop.productId}'/>"
															class="add-to-btn small-btn"> <img
															src="${pageContext.request.contextPath}/images/mall/icon/cart1.png">

															<span>Add to Cart</span>
															<h5 class="product-price">$${relatedShop.productPrice}</h5>
														</a>
													</c:when>
													<c:when test="${relatedShop.productAmount<1}">
														<i class="add-to-btn small-btn"> <img
															src="${pageContext.request.contextPath}/images/mall/icon/cart1.png">

															<span>Sold Out</span>
															<h5 class="product-price">$${relatedShop.productPrice}</h5>
														</i>

													</c:when>
												</c:choose>
											</div>
											<!-- =============================(E)加入購物車_是否完售 -==================-->

										</div>
									</div>

								</c:forEach>
							</div>



						</div>
					</div>


					<!--      ================================================================= -->
					<!--      商品詳情   -->
					<!--      ================================================================= -->

					<div class="col-xl-9 col-lg-8">
						<div class="product-details-wrap">

							<div class="row col-gap-60">
								<div class="col-xl-5">
									<div class="product-preview-wrap">
										<div class="tab-content bg-white p-50 b1 br-5">
											<div class="tab-pane" id="preview1">
												<img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Preview Image"
													data-magnify-src="<c:url value='/mall/getImage/${product.productId}'/>" />
											</div>
											<div class="tab-pane active" id="preview2">
												<img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Preview Image"
													data-magnify-src="<c:url value='/mall/getImage/${product.productId}'/>" />
											</div>
											<div class="tab-pane" id="preview3">
												<img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Preview Image"
													data-magnify-src="<c:url value='/mall/getImage/${product.productId}'/>" />
											</div>
											<div class="tab-pane" id="preview4">
												<img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Preview Image"
													data-magnify-src="<c:url value='/mall/getImage/${product.productId}'/>" />
											</div>
										</div>

										<ul class="nav nav-tabs mt-30">
											<li><a data-toggle="tab" href="#preview1"> <img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Thumbnail Image" />
											</a></li>
											<li><a class="active" data-toggle="tab" href="#preview2">
													<img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Thumbnail Image" />
											</a></li>
											<li><a data-toggle="tab" href="#preview3"> <img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Thumbnail Image" />
											</a></li>
											<li><a data-toggle="tab" href="#preview4"> <img
													src="<c:url value='/mall/getImage/${product.productId}'/>"
													alt="Product Thumbnail Image" />
											</a></li>
										</ul>
									</div>
								</div>
								<div class="col-xl-7">
									<div
										class="product-details text-left bg-white px-50 py-45 b1 br-5">
										<h3 class="mb-25 rmt-25">${product.productName}</h3>
										<div class="rating mb-25">
											<div class="star mr-15">
												<img
													src="${pageContext.request.contextPath}/images/mall/line2.png"
													style="weight: 70px; height: 50px" />

											</div>
										</div>
										<div>

											<p>● 商品熱量:${product.productCalories} &nbsp;</p>
											<p>${product.productDescription}</p>
											<p style="text-align: right">
												--&nbsp; product provider: ${product.shopBean.shopName}<img
													src="${pageContext.request.contextPath}/images/mall/icon/market.png">
											</p>
											<br />
										</div>
										<!-- 	==========判斷是否售完 ===============-->
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
										<!-- 	==========(E)//判斷是否可以加入購物車 ===========-->

										<!-- 		===================愛心=================== -->
										<div class="add-wishlist">
											<c:choose>
												<c:when test="${product.favoriteStatus == true}">
													<div>
														<button id="showFavorite"
															STYLE="background-color: transparent;">
															<img id="favoriteHeart"
																src="${pageContext.request.contextPath}/images/mall/icon/like1.png">
															<!-- 																	2 是空心: 1 是實心 -->
														</button>
													</div>
												</c:when>
												<c:otherwise>
													<div>
														<button id="showFavorite"
															STYLE="background-color: transparent;">
															<img id="favoriteHeart"
																src="${pageContext.request.contextPath}/images/mall/icon/like2.png">
														</button>
													</div>

												</c:otherwise>
											</c:choose>

										</div>
										<!-- 		=================================(E)愛心=================================== -->

									</div>
								</div>
							</div>
						</div>

						<!-- product-details-tab/review -->
						<div
							class="product-details-review bg-white mt-60 px-50 pt-20 pb-30 b1 br-5">
							<ul class="nav nav-tabs mb-20 mt-10">
								<li><a href="#details" class="active" data-toggle="tab">Shop
										Description</a></li>
								<li><a href="#review" data-toggle="tab" class="">Reviews</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="details">
									<!--  廠商詳情 -->

									<h4>
										<img
											src="${pageContext.request.contextPath}/images/mall/icon/shop.png">&nbsp;&nbsp;${product.shopBean.shopName}
									</h4>
									<div>
										<img style="weight: 500px; height: 400px"
											src="<c:url value='/shopController/getShopImgById/${product.shopBean.shopId}'/>"
											alt="shop Thumbnail Image" />
									</div>
									<br>

									<h5>
										<img
											src="${pageContext.request.contextPath}/images/mall/icon/contact.png">
										Cotact Info:
									</h5>
									<p>
										- Email&nbsp;:&nbsp;<span>${product.shopBean.shopEmail}</span>
									</p>
									<p>
										- Phone&nbsp;:&nbsp;<span>${product.shopBean.shopPhone}</span>
									</p>

								</div>

								<div class="tab-pane" id="review">

									<!-- product-review-comments -->
									<div class="product-review-comments">

										<!-- singlepost-comments -->
										<div class="latest-comments">
											<div class="comments-box">
												<div class="comments-avatar"></div>
												<div class="comments-text">
													<div class="avatar-name">
														<h5>h188472r</h5>
																												</div> -->
													</div>
													<p>食材超新鮮，回購很多次了!</p>
												</div>
											</div>
										</div>

										<!-- singlepost-comments -->
										<div class="latest-comments">
											<div class="comments-box">
												<div class="comments-avatar"></div>
												<div class="comments-text">
													<div class="avatar-name">
																													</div> -->
													</div>
													<p>送貨超級快速~</p>
												</div>
											</div>
										</div>

									</div>

								</div>
							</div>
						</div>

					
				
				
					<!--      ================================================================= -->
					<!--      (E) 商品詳情   -->
					<!--      ================================================================= -->
				
				<!-- ========================================================================================= -->
				<!-- Related Product -->
				<!-- ========================================================================================= -->

				<div class="related-product mt-110 rmt-75">
					<h4 class="mb-35">Related Product</h4>
					<div class="row">

						<!--single Product -->
						<c:forEach items="${sameCategory}" var="relatedCategory">
							<div class="col-xl-4 col-md-6 col-md-4 mb-30">
								<div class="product">
									<div class="product-img-wrap"
										style="weight: 70px; height: 100px">
										<img
											src="<c:url value='/mall/getImage/${relatedCategory.productId}'/>"
											alt="img">
									</div>
									<div class="product-content-wrap">
										<div class="product-content">
											<p>
												<a
													href="<c:url value='/mall/lists/product/${relatedCategory.productId}'/>">${relatedCategory.productName}
												</a>
											</p>
										</div>
										<!-- =============================加入購物車_是否完售 -==================-->
										<div class="product-action">
											<c:choose>
												<c:when test="${relatedCategory.productAmount>=1}">

													<a
														href="<c:url value='/mall/cart/buy/${relatedCategory.productId}'/>"
														class="add-to-btn small-btn"> <img
														src="${pageContext.request.contextPath}/images/mall/icon/cart3.png">

														<span>Add to Cart</span>
														<h5 class="product-price">$${relatedCategory.productPrice}</h5>
													</a>
												</c:when>
												<c:when test="${relatedCategory.productAmount<1}">
													<i class="add-to-btn small-btn"> <img
														src="${pageContext.request.contextPath}/images/mall/icon/cart3.png">

														<span>Sold Out</span>
														<h5 class="product-price">$${relatedCategory.productPrice}</h5>
													</i>

												</c:when>
											</c:choose>
										</div>
										<!-- =============================(E)加入購物車_是否完售 -==================-->

									</div>
								</div>

							</div>
						</c:forEach>


					</div>
				</div>


				<!-- ========================================================================================= -->
				<!-- (E)  Related Product -->
				<!-- ========================================================================================= -->


		
	</div>
	</section>
	<!--==================================================================== 
           End Shop Details Page
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

