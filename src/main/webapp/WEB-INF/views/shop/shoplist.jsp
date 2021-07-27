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
<title>ShopList</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/malladmin/mall-bootstrap.min.css" href="${pageContext.request.contextPath}/css/mall/malladmin/mall-common.css" type="text/css">

 </head>

 <body>

<!-- 引入共同的頁首 -->  
<jsp:include page="/fragment/header.jsp" />
 


 <div class="container">
 <h2 class="page-header">商品列表</h2>
 

<div>
 
<span class="text-right"><a href="<c:url value='/shop/add'/>" class="btn btn-primary">New Product</a></span>
<%-- <span class="text-right" ><a href="<c:url value='/mall/category'/>" class="btn btn-primary">分類</a></span> --%>

</div>
&nbsp;

<div >
<form action="<c:url value='/shop/shoplist/1'/>">
<input type="hidden" name="sortField"  value="${sortField}"/>
<input type="hidden" name="sortDir"  value="${sortDir}"/>
查詢:
<input type="text" name="keyword"  value="${keyword}" required/>
&nbsp;
<input type="submit" value="Search"/>
&nbsp;
<input type="button" value="clear" onclick="clearFilter()">
</form>



</div>


 <table class="table table-border">

 	<thead>

 <tr>

 	<th> #ID</th>
 	<th>IMG</th>
 	<th>產品名稱</th>
 	<th >分類</th>
 	<th style="text-align:center">產品描述</th>
 	<th>熱量</th>
 	<th>產品庫存</th>
 	<th>產品價格</th>
 	<th> 產品上架日期</th>
 	<th>修改</th>
 	

 </tr>

 </thead>

 <tbody>

 <c:forEach items="${product}" var="product">
 
<%--   <c:forEach>標記如何可用於遍歷MallController books model屬性。 --%>

 <tr>

 <td>${product.productId}</td>
 <td style="weight:60px;height:50px"><img class="media-object" style="weight:50px;height:50px" src="<c:url value='/shop/getImage/${product.productId}' />"
	alt="Product Image"></td>
 <td>${product.productName}</td>
<%--  <td>${product.category}</td> --%>
 <td>
<div class="product-cell category">
							<c:choose>
								<c:when test="${product.category==1}">
									<span>生鮮食品</span>
								</c:when>
								<c:when test="${product.category==2}">
									<span>雞肉餐盒</span>
								</c:when>
								<c:when test="${product.category==3}">
									<span>牛肉餐盒</span>
								</c:when>
								<c:when test="${product.category==4}">
									<span>豬肉餐盒</span>
								</c:when>
								<c:when test="${product.category==5}">
									<span>海鮮餐盒</span>
								</c:when>
								<c:when test="${product.category==6}">
									<span>素食餐盒</span>
								</c:when>
								<c:when test="${product.category==7}">
									<span>飲品</span>
								</c:when>
								<c:otherwise>
									<span>未挑選</span>
								</c:otherwise>
							</c:choose>
 </td>
 
 <td>${product.productDescription}</td>
 <td>${product.productCalories}</td>
 <td>${product.productAmount}</td>
 <td>${product.productPrice}</td>
 <td>${product.productDate}</td>
 <td><a href="<c:url value='/shop/productdetail/${product.productId}'/>"><button>詳情</button></a>
 <a href="<c:url value='/shop/update/${product.productId}'/>"><button>更新</button></a>
 <a class="deleteShop" href="${pageContext.request.contextPath }/shop/delete/${product.productId}"><button >刪除</button></a></td>
 </tr>
 

 </c:forEach>

 </tbody>

 </table>
 
 
 

 
  <!-------------- end of container------------- -->
   </div>
  <!-- -------------end of container ------------------>
   
 
    <!-- 用於將 POST 請求轉換為 DELETE請求 -->
<!--     暫時放棄 先直接用Post請求 -->
<form action="#" method="POST">
    <input type="hidden" value="DELETE" name="_method" />
 </form>
 
 
<!--  ==================================================================== -->
  <script>
		$(document).ready(function() {
			$('.deleteShop').click(function() {
				if (confirm('確定刪除此筆紀錄? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

					console.log(href);
				}
				return false;

			});
		})
	</script>

  <!-- ======================    綁定清除查詢 ================================-->
  
  
  <script type="text/javascript">
    function clearFilter(){
		window.location='/soeasy/mall/lists';     
    }
  </script>
  
  <!-- ==========================   (End) 綁定清除查詢========================-->
  

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap.min.js" ></script>
 
 <script src="https//ajax.google"></script><!-- 載入 jQuery 套件 -->
 <script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap3.js"></script>


 <!-- 引入共同的頁尾  copy這行-->
<jsp:include page="/fragment/footer.jsp" />
 </body>

 </html>
