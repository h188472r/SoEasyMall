<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SOEASY</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/style.css">
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />
	
<!-- 	<section class="hero-section" style="margin-bottom:50px"> -->
<%--             	<div style="display: flex;justify-content:center;height: 950px;background-image: url('${pageContext.request.contextPath}/images/indexImg.jpg');background-repeat: no-repeat;background-position: center;background-size: cover"> --%>
            
<!--                     <div class="container" style="weight:500px"> -->
                          
<!--                         <div  style="padding-left:610px;padding-top:200px;"> -->
<!--                             <h1 style="color: #FFFFFF;">  <BR> -->
<!--                              <span style="color: #3DCA79;">Health</span> <br>SO <br>EASY</h1><br> -->
<!--                             <span style="font-weight: bold;">為您的健康量身打造的綜合平台 -->
<!--                                </span> -->
                            
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!-- 	 </section> -->
	<section class="hero-section" style="margin-bottom:50px">
            	<div style="display: flex;justify-content:center;height: 900px;background-image: url('${pageContext.request.contextPath}/images/indexImg2.jpg');background-repeat: no-repeat;background-position: center;background-size: cover">
            
                    
                </div>
	 </section>
	 
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp"/>
	    

<!-- jequery plugins -->
<script src="${pageContext.request.contextPath}/js/mall/bootstrap-v4.1.3.min.js"></script>
        <!-- Custom script -->
<script src="${pageContext.request.contextPath}/js/mall/js/script.js"></script>
	
</body>
</html>