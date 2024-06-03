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
</head>
<body>
	<div class="p-5 bg-primary text-white text-center">
		<h1>My First Bootstrap 5 Page</h1>
		<p>Resize this responsive page to see the effect!</p>
	</div>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="/product/list">상품</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="/cart/list">장바구니</a></li>
			</ul>
		</div>
	</nav>

	<div class="container text-center">
		<!-- 본문 시작 -->
		<div class="row">
			<div class="col-sm-12"></div><!-- col end -->
		</div><!-- row end -->
	<!-- 본문 끝 -->
	</div><!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>

</body>
</html>