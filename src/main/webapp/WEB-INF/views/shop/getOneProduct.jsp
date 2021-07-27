<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1;charset=utf-8">
<title>餐盒詳情</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<!-- 載入CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/malladmin/mall-bootstrap.min.css" href="${pageContext.request.contextPath}/css//mall/malladmin/mall-common.css" type="text/css">
</head>

 <body>

<!-- 引入共同的頁首 -->  
<jsp:include page="/fragment/header.jsp" />
 
 
 <div class="container">
<c:set var="product" value="${product}" ></c:set>
 <h1 class="page-header" style="margin-top:50px;">商品資訊 (
 <c:out value="${product.productName}"/> )</h1>
 
 
<!--  ======圖片======================================= -->
 
 <div style="display:inline-block;margin-left: 60px">
 <img src="<c:url value='/mall/getImage/${product.productId}' /> " style="height:350px;width:350px;"/>
 </div>
 
<!--   ======(End)圖片====================================== -->
 
 
 
 <div class="well" style="display:inline-block; height:600px;width:600px;margin-left: 20px;margin-top: 50px">

<p><strong>產品ID:</strong><c:out value=" ${product.productId}"/></p>
<p><strong>產品名稱:</strong><c:out value="${product.productName}"/></p>
<p><strong>產品分類:</strong>
<c:choose>
<c:when test="${product.category==1}"><span>生鮮食品</span></c:when>
<c:when test="${product.category==2}"><span>雞肉餐盒</span></c:when>
<c:when test="${product.category==3}"><span>牛肉餐盒</span></c:when>
<c:when test="${product.category==4}"><span>豬肉餐盒</span></c:when>
<c:when test="${product.category==5}" ><span>海鮮餐盒</span></c:when>
<c:when test="${product.category==6}" ><span>素食餐盒</span></c:when>
<c:when test="${product.category==7}" ><span>飲品</span></c:when>
<c:otherwise> <span>未挑選</span></c:otherwise>
</c:choose>

<%-- <c:out value="${product.category}"/></p> --%>

<p><strong>產品描述:</strong><c:out value="${product.productDescription}"/></p>
<p><strong>產品標示:</strong><c:out value="${product.productCalories}"/></p>
<p><strong>產品庫存:</strong><c:out value="${product.productAmount}"/></p>
<p><strong>產品價格:</strong><c:out value="${product.productPrice}"/></p>
<p><strong>產品上架日期:</strong><c:out value="${product.productDate}"/></p>
<p><strong>產品成本:</strong><c:out value="${product.productCost}"/></p>
<p><strong></strong></p>
 </div>
 </div>
 
 <br>
 <div class="next" style="margin-bottom:70px auto;margin-left: 100px">
  <a href="<c:url value='/mall/lists/'/>"><button>previous page</button></a>
 </div>
 <br>
 
 
<!-- ================================================================ -->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap.min.js" ></script>
 
 <script src="https//ajax.google"></script><!-- 載入 jQuery 套件 -->
 <script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap3.js"></script>


 <!-- 引入共同的頁尾  copy這行-->
<jsp:include page="/fragment/footer.jsp" />
 </body>

 </html>