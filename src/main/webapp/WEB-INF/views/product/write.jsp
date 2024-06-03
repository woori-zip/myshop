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

	<div class="container text-center">
		<!-- 본문 시작 -->
		<div class="row">
			<div class="col-sm-12">
				<p>
				<h3>상품등록</h3>
				</p>
				<p>
					<button type="button" onclick="location.href='list'"
						class="btn btn-white">상품전체목록</button>
				</p>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->

		<div class="row">
			<div class="col-sm-12">
				<form name="productfrm" id="productfrm" method="post"
					action="insert" enctype="multipart/form-data">
					<table class="table table-hover">
						<tbody style="text-align: left;">
							<tr>
								<td>
									<i class="fa-solid fa-book"></i>
									상품명
								</td>
								<td>
									<input type="text" name="product_name" class="form-control">
									<span id="nmalarm" style="color:red; display:none;">* 상품명을 입력해주세요</span>
								</td>
							</tr>
							<tr>
								<td>
									<i class="fa-solid fa-barcode"></i>
									상품가격
								</td>
								<td><input type="number" name="price" class="form-control" step="1" min="0">
								</td>
							</tr>
							<tr>
								<td>
									<i class="fa-solid fa-caret-down"></i>
									상품설명
								</td>
								<td><textarea rows="5" name="description"
										class="form-control"></textarea></td>
							</tr>
							<tr>
								<td>
									<i class="fa-regular fa-image"></i>
									상품사진
								</td>
								<td><input type="file" name="img" class="form-control">
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center"><input type="submit"
									value="상품등록" class="btn btn-white"></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->
		
		
	</div>
	<!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>

</body>
</html>