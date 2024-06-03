<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>My Shop</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/jquery-3.7.1.min.js"></script>
<link href="/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<div class="p-5 bg-default text-white text-center">
		<h1>Book Store</h1>
		
		<p>Welcome! and Bye!</p>
	</div>
	<nav class="navbar navbar-expand-sm bg-light navbar-light">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="/product/list">상품</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="/cart/list">장바구니</a></li>
			</ul>
		</div>
	</nav>
    <div class="collapse navbar-collapse">
        <ul class="list-group">
            <li class="list-group-item">
           		<a class="nav-link active" href="/product/list">상품</a>
            </li>
            <li class="list-group-item">
            	<a class="nav-link active" href="/cart/list">장바구니</a>
            </li>
        </ul>
    </div>
     

	<div class="container text-center">
	<!-- 본문 시작 -->
		<div class="row">
			<div class="col-sm-12">
				<p><h3>상품목록</h3></p>
				<p>
					<button type="button" class="btn btn-white" onclick="location.href='write'">상품등록</button>
					<button type="button" class="btn btn-white">상품전체목록</button>
				</p>
			</div><!-- col end -->
		</div><!-- row end -->
		
		<div class="row">
			<div class="col-sm-12">

				<!-- 검색 -->
				<form action="search" method="get" class="input-group" style="width:600px; margin:auto;">
						<span class="input-group-text">
							<i class="fa-solid fa-magnifying-glass"></i>
						</span>
						<input type="text" name="product_name" class="form-control"> 
						<button type="submit" class="btn">검색</button>
				</form>
				<!-- 검색 끝 -->
				
				<hr>
				
			</div>
			<div style="clear:both"></div>
			<!-- col end -->

			<!-- items="${list}"는 productCont의 mav.addObject("list", ~); -->
			<c:forEach items="${list}" var="row" varStatus="vs">
				<div class="col-12 col-sm-6 col-md-3 mb-4">
					<c:choose>
						<c:when test="${row.FILENAME != '-'}">
							<a href="detail/${row.PRODUCT_CODE}"> 
							<img src="/storage/${row.FILENAME}" class="img-responsive margin" style="width: 80%;">
							</a>
						</c:when>
						<c:otherwise>
							등록된 사진 없음!!<br>
						</c:otherwise>
					</c:choose>
					<br>
					<%-- http://localhost:9095/product/detail?product_code=21 --%>
					<%-- <a href="detail?product_code=${row.PRODUCT_CODE}">${row.PRODUCT_NAME}</a> --%>

					<%-- RESTful Web Service URL 형식으로 서버에 요청 --%>
					<%-- http://localhost:9095/product/detail/21 --%>
					<a href="detail/${row.PRODUCT_CODE}" style="font-weight: bold;">${row.PRODUCT_NAME}</a> 
					<!-- getCommentCount -->
					<span class="font-orange"> [${row.COMMENT_COUNT}]</span>
					<br>
					가격 :
					<fmt:formatNumber value="${row.PRICE}" pattern="#,###원" />
				</div>

				<!-- 한 줄에 3칸씩 -->
				<c:if test="${vs.count mod 4 == 0 }">
		</div>
					<div style="height: 50px"></div>
					<div class="row">
				</c:if>
			</c:forEach>
		</div><!-- row end -->
	<!-- 본문 끝 -->
	</div><!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>

