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
<title>productList</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mall/malladmin/mall-bootstrap.min.css" href="${pageContext.request.contextPath}/css/mall/malladmin/mall-common.css" type="text/css">

 </head>

 <body>

<!-- 引入共同的頁首 -->  
<jsp:include page="/fragment/header.jsp" />
 


 <div class="container">
 <h2 class="page-header">分類列表</h2>
 
 <section class="container-header"></section>
  <p class="text-right"><a href="<c:url value='/mall/category/add'/>" class="btn btn-primary">Add</a><p>
 
 <c:if test="${error!=null}">
 <div class="alert alert-danger alert-dismissable">
		${error} 
 </div>
 </c:if>

<div class="box-body">
 <table id="CategoryList" class="table table-borded table-hover">
 	<thead>
 		<tr>
		 	<th>#ID</th>
		 	<th>Name</th>
		 	<th>Status</th>
		 	<th>Action</th>
		</tr>

 	</thead>

 <tbody>

 	<c:forEach var="c" items="${categories}">
 
 		<tr>
			 <td>${c.productCategoryId}</td>
			 <td>${c.productCategoryName}</td>
			 <td>${c.status? "Show":"Hide"}</td>
			 <td>	 
			 <a href="${pageContext.request.contextPath}/mall/category/update/${c.productCategoryId}"> EDIT</a>
			 <a onclick="return confirm('確定要刪除嗎?')" href="${pageContext.request.contextPath}/mall/category/delete/${c.productCategoryId}">DELETE</a>
 		</td>
 		</tr>
 

 	</c:forEach>

 </tbody>
 
 <tfoot>
 		<tr>

		 	<th>#ID</th>
		 	<th>Name</th>
		 	<th>Status</th>
		 	<th>Action</th>
		
		</tr>

 	</tfoot>

 </table>
 </div>
 
 
 <!-- ---------------------------控制分頁用----------------------------------- -->
 
<!--  <nav style="width:300px;margin:0px auto"> -->
<!--  <ul class=pager> -->
 
<!-- <!--  上頁 --> 
<!-- <li class=previous>  -->
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${currentPage > 1}"> --%>
<%-- 			<a href="<c:url value='/mall/lists?pageNo=${currentPage-1}'/>">Previous</a> --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<!-- 			<a>Previous</a> -->
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
<!-- </li> -->
<!-- <!-- 上頁結束 --> 

<%-- <li style="font-style:italic;color:	#00477D"><c:out value="${currentPage}"/></li> --%>

<!--  <!--  下頁 --> 
<!-- <li class=next>  -->
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${currentPage < totalPages}"> --%>
<%-- 			<a href="<c:url value='/mall/lists?pageNo=${currentPage + 1}'/>">Next</a> --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<!-- 			<a>Previous</a> -->
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
<!-- </li> -->
<!-- <!-- 下頁結束 --> 
 
<!-- </ul> -->
<!--  </nav> -->

<!-- ------------------------------控制分頁結束區塊--------------------------------- -->


 
  <!-------------- end of container------------- -->
   </div>
  <!-- -------------end of container ------------------>
   
 
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
      return false;
    }
  </script>
  
  <script type="text/javascript">
    $(function () {
      $('#categoryList')}.DataTable({
    	  'paging':true,
    	  'lengthChange':false,
    	  'searching':false,
    	  'ordering':true,
    	  'info':true,
    	  'autoWidth':false,  
      })
      
    })
  </script>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap.min.js" ></script>
 
 <script src="https//ajax.google"></script><!-- 載入 jQuery 套件 -->
 <script src="${pageContext.request.contextPath}/js/mall/malladmin/mall-bootstrap3.js"></script>


 <!-- 引入共同的頁尾  copy這行-->
<jsp:include page="/fragment/footer.jsp" />
 </body>

 </html>
