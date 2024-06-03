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
	<script>
		function product_update() {
			//<form name="productfrm">를 가리킴
			document.productfrm.action="/product/update";
			document.productfrm.submit();
		}//product_update() end
		
		function product_delete() {
			if(confirm("첨부된 파일은 영구히 삭제됩니다\n진행할까요?")){
				document.productfrm.action="/product/delete";
				document.productfrm.submit();
			}//if end
		}//product_delete() end
	</script>
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
			<div class="col-sm-12">
				<p>
				<h3>상품 수정 및 삭제</h3>
				</p>
				<p>
					<button type="button" onclick="location.href='/product/list'" class="btn primary">상품전체목록</button>
				</p>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->

		<div class="row">
			<div class="col-sm-12">
				<form name="productfrm" id="productfrm" method="post" enctype="multipart/form-data">
					<table class="table table-hover">
						<tbody style="text-align: left;">
							<tr>
								<td>
									<i class="fa-solid fa-book"></i>
									상품명
								</td>
								<td><input type="text" name="product_name" value="${product.PRODUCT_NAME}"
									class="form-control"></td>
							</tr>
							<tr>
								<td>
									<i class="fa-solid fa-barcode"></i>
									상품가격
								</td>
								<td><input type="number" name="price" value="${product.PRICE}" class="form-control">
								</td>
							</tr>
							<tr>
								<td>
									<i class="fa-solid fa-caret-down"></i>
									상품설명
								</td>
								<td><textarea rows="5" name="description" 
										class="form-control">${product.DESCRIPTION}</textarea></td>
							</tr>
							<tr>
								<td>
									<i class="fa-regular fa-image"></i>
									상품사진
								</td>
								<td>
									<c:if test="${product.FILENAME != '-' }">
										<input src="/storage/${product.FILENAME}" width="100px">
									</c:if>
									<input type="file" name="img" class="form-control">
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
									<input type="submit" value="상품수정" 		onclick="product_update()"  class="btn btn-white">
									<input type="submit" value="상품삭제" 		onclick="product_delete()"  class="btn btn-danger">
									<input type="submit" value="장바구니담기" 	onclick="product_cart()" 	class="btn btn-info">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->
		
		<!-- 댓글 시작 -->
		<div>
			<div class="col-sm-12">
			
			</div><!-- col end -->
		</div><!-- row end -->
		<!-- 댓글 끝 -->
		
	</div>
	<!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>

</body>
</html>