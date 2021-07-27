<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>check out success</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/responsive.css">

</head>
<body >	

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
        <section class="banner-section" style="background-image:url(${pageContext.request.contextPath}/images/mall/indexbanner3.jpg); margin-top:150px">
            <div class="container">
                <div class="banner-inner text-center">
                    <h3 class="page-title">Thank you for your order</h3>
                    <nav aria-label="breadcrumb">
                    <br>
                       <a href="<c:url value='/mall/order/history'/>" class="theme-btn no-shadow bg-blue">Order History</a>
                       
                    </nav>
                </div>
            </div>
        </section>
        <!--==================================================================== 
            End Banner Section
        =====================================================================-->
        <div style="margin-bottom:200px">
        
        
        
        </div>
        
        
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
                            <br>
                            <br>
                                <a href="#"><img src="${pageContext.request.contextPath}/images/ICON.png" alt="footer logo"></a>
                            </div>
                            
                        </div>
                    </div>
                   
<!--                     Footer Column -->
                    <div class="col-lg-4 col-md-5 mb-20">
                        <div class="footer-widget form-widget ml-50 mr-20">
                            <h5 class="footer-title mb-20">Subscribe Our News Letter</h5>
                            <p></p>
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
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/mall/pay-method/visa.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/mall/pay-method/mastercard.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/mall/pay-method/discover.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/mall/pay-method/americanexpress.png" alt=""></a></li>
                            </ul>
                        </div>
                    </div>
                     <!--Footer Column-->
                    <div class="col-lg-2 col-md-3 mb-30">
                        <div class="footer-widget links-widget float-lg-right mr-40">
                        <h6 class="footer-title mb-30">Map</h6>
                            <ul class="list">
                                <li> <a href="<c:url value='/'></c:url>" title="Link">Index</a> </li>
                                <li><a href="#" title="Link">園地</a> </li>
                                <li><a href="<c:url value='/postIndex'></c:url>" title="So Share">分享</a> </li>
                           		<li><a href="<c:url value='/showSportMapIndex'></c:url>" title="SportMap">地圖</a> </li>
                         		  <li><a href="<c:url value='/nutritionist'></c:url>" title="Link">營養師</a>
                            </ul>
                        </div>
                    </div>
                    
                    
                </div>
                <div class="row">
                    <div class="col-lg-12">


                        <!-- Copyright Area-->
                        <div class="copyright text-center pl-10 pr-10 pt-30 pb-10 mt-55 rmt-35 mb-65">
                            <p> </p>
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
    <button class="scroll-top scroll-to-target" data-target="jsp"><span class="fa fa-angle-up"></span></button>
<!-- jequery plugins -->
<script src="${pageContext.request.contextPath}/js/mall/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/bootstrap-v4.1.3.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/jquery.simpleLoadMore.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/appear.js"></script>
<!-- Custom script -->
<script src="${pageContext.request.contextPath}/js/mall/js/script.js"></script>
 


</body>
</html>

