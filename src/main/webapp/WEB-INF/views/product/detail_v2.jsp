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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
				<h3>상품 수정 및 삭제</h3>
				</p>
				<p>
					<button type="button" onclick="location.href='/product/list'" class="btn btn-white">상품전체목록</button>
				</p>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->

		<div class="row">
			<div class="col-sm-12">
				<form name="productfrm" id="productfrm" method="post" enctype="multipart/form-data">
					<table class="table table-condensed">
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
										<img src="/storage/${product.FILENAME}" width="100px">
									</c:if>
									<input type="file" name="img" class="form-control">
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
									<input type="submit" value="상품수정" 		onclick="product_update()"  class="btn btn-white">
									<input type="submit" value="상품삭제" 		onclick="product_delete()"  class="btn btn-white">
									<input type="submit" value="장바구니담기" 	onclick="product_cart()" 	class="btn btn-white">
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

		<div class="row">
			<!-- 댓글 쓰기 -->
			<div class="col-sm-12">
				<label for="content">댓글</label>
				<form action="commentInsertForm" id="commentInsertForm">
					<!-- 부모글번호 -->
					<input type="hidden" name="product_code" id="product_code" value="${product.PRODUCT_CODE}">
					<table class="table table-borderless">
						<tr>
							<td><input type="text" name="content" id="content" placeholder="댓글을 입력해 주세요" class="form-control"></td>
							<td>
								<button type="button" name="commentInsertBtn" id="commentInsertBtn" class="btn btn-white">등록</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->

		<div class="row"><!-- 댓글 목록 -->
			<div class="col-sm-12">
				<div class="commentlist"></div>
			</div><!-- col end -->
		</div><!-- row end -->
		
		<!-- 댓글 끝 -->
	
	<!-- 댓글 관련 자바스크립트 시작 -->
	<script>
		let product_code = '${product.PRODUCT_CODE}'; //전역변수, 부모 글 번호
		
		$(document).ready(function(){//상세페이지 로딩 시점의 댓글 목록 출력
			commentList();
		});//ready end
		
		//댓글등록 버튼을 클릭했을 때
		$("#commentInsertBtn").click(function(){
			//alert($);
			let content = $("#content").val().trim();
			if(content.length == 0){
				alert("댓글을 입력해주세요");
				$("#content").focus();
			} else {
				//1)
				//let params = "product_code=" + $("#product_code").val() + "&content=" + $("#content").val().trim();
				//alert(params);
				
				//2)
				let insertData = $("#commentInsertForm").serialize();
				//alert(insertData);
				commentInsert(insertData);//댓글등록 함수 호출
			}//if end
		});//click end
		
		function commentInsert(insertData) { // 댓글등록 함수
            //alert("댓글등록함수 호출: " + insertData);
            $.ajax({
                url		: '/comment/insert' // 요청명령어
                ,type	: 'post'
                ,data	: insertData // 전달값
                ,error	: function(error) {
                    alert('댓글 등록에 실패했습니다.');
                }
                ,success: function(result) {
                    //alert('댓글 등록에 성공했습니다.');
                    commentList(); //댓글 작성 후 댓글 목록 함수 호출
                    $('#content').val('');
                }
            });// ajax() end
		}
		
		function commentList() {
		    $.ajax({
		        url: '/comment/list',
		        type: 'get',
		        data: {'product_code': product_code}, //부모글번호(전역변수 선언 되어 있음)
		        error: function(error) {
		            alert("댓글 조회 실패");
		        },
		        success: function(result) {
		            let a = ''; //출력할 결과값
		            $.each(result, function(key, value) {
		                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom:15px;">';
		                a += '    <div class="commentInfo">';
		                a += '        <p>' + value.cno + " | " + value.wname + " | " + value.regdate;
		                a += '         <a href="javascript:commentUpdate(' + value.cno + ', \'' + value.content + '\')">[수정]</a>';
		                a += '        <a href="javascript:commentDelete(' + value.cno + ')">[삭제]</a>';
		                a += '        </p>';
		                a += '    </div>';
		                a += '    <div class="commentContent commentContent_' + value.cno + '">';
		                a += '        <p>' + value.content + '</p>';
		                a += '    </div>';
		                a += '</div>';
		            }); // each() end
		            $(".commentlist").html(a);
		        } // success end
		    }); // ajax() end
		} // commentList() end
		
		function commentDelete(cno){
			alert(cno + " 번 댓글 삭제");
			$.ajax({
				url		: '/comment/delete/' + cno
				,type	: 'post'
				,success: function(result){
					if(result==1){
						alert("댓글을 삭제했습니다");
						commentList(cno);//댓글 삭제 후 목록 함수 출력
					} else {
						alert("댓글 삭제 실패 : 로그인 후 사용해주세요");
					}//if end
				}//sucess end
				,error: function(xhr, status, error) {
		            console.log("AJAX request failed. Status: ", status, " Error: ", error); // Debugging line
		            alert("댓글 삭제 중 오류 발생: " + error);
		        }//error end
			});//ajax() end
		}//cmmentDelete() end
	
		//[수정] : 댓글수정-전달받은 댓글내용을 <input type=text>에 출력함
		function commentUpdate(cno, content) {
			//alert(cno + content);
			let a = '';
			a += '<div class="input-group">';
			a += '    <input type="text" value="' + content + '" id="content_' + cno + '">';
			a += '    <button type="button" onclick="commentUpdateProc(' + cno + ')">수정</button>';
			a += '</div>';
			//alert(a);
			$(".commentContent_" + cno).html(a);
		} // commentUpdate() end

		//댓글수정 후 댓글목록 함수 호출
		function commentUpdateProc(cno) {
		    //alert(cno);
		    let updateContent = $("#content_" + cno).val();
		    //alert("수정된 댓글내용 : " + updateContent);
		    let params = "cno=" + cno + "&content=" + updateContent
		    
		    $.ajax({
		    	url		: '/comment/updateproc'
				,type	: 'post'
				,data	: {'cno':cno, 'content':updateContent} //또는 params
				,success: function(result){
					if(result==1){
						alert("댓글 수정 성공");
						commentList();//댓글 삭제 후 목록 함수 출력
					} else {
						alert("댓글 수정 실패");
					}//if end
				}//sucess end
		    });//ajax() end
		}//commentUpdateProc() end
		
	</script>
	<!-- 댓글 관련 자바스크립트 끝 -->
	
	</div>
	<!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>

</body>
</html>