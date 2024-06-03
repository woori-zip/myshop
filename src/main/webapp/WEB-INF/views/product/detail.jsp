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
		
/* 		$(document).ready(function() {
		    $("#cart").on("click", function(e) {
		        if ($("#qty").val() == "0") {
		            $("#qtynum").css("display", "block");
		            e.preventDefault();
		            document.productfrm.action = "/product/detail";
		            
		        } else if($("#qty").val() != "0"){
					$("#qtynum").css("display", "none");
				
				}//if end
		    });//on end
		});//ready end */
		
/* 		$(document).ready(function() {
			$("#qty").on("change",function(){
				if("#qty" != "0"){
					$("#qtynum").css("display", "none");
				}//if end
			})//on end
		});//ready on
 */
		$(document).ready(function() {
		    // qty 수량 선택 변경 이벤트
		    $("#qty").on("change", function() {
		        if ($(this).val() != "0") {
		            $("#qtynum").css("display", "none");
		        } else {
		            $("#qtynum").css("display", "block");
		        }
		    });//change end
		});//ready end
	
		// 상품 수량 확인 및 처리 함수
		function product_cart() {
			if ($("#qty").val() == "0") {
				$("#qtynum").css("display", "block");
				document.productfrm.action = "/product/detail";
	
			} else if ($("#qty").val() != "0") {
				document.productfrm.action = "/cart/insert";
				document.productfrm.submit();
			}//if end
		}//prduct_cart() end

	</script>
</head>
<body>
	<div class="p-5 bg-default text-white text-center">
		<h1>농수산물 팔아요</h1>
		
		<p>야채 머겅</p>
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
 	   	<p><h3>상세보기</h3></p>
	    <p>
	        <button type="button" onclick="location.href='/product/list'" class="btn btn-white">상품전체목록</button>
	    </p> 
    </div><!-- col end -->
  </div><!-- row end -->
  
  <div class="row">
    <div class="col-sm-12">
		<form name="productfrm" id="productfrm" method="post" enctype="multipart/form-data">
		 	<table class="table table-hover">
			    <tbody style="text-align: left;">
			    <tr>
					<td>상품명</td>
					<td> <input type="text" name="product_name" value="${product.PRODUCT_NAME}" class="form-control"> </td>
			    </tr>
			    <tr>
					<td>상품가격</td>
					<td> <input type="number" name="price" value="${product.PRICE}" class="form-control"> </td>
			    </tr>
			    <tr>
					<td>상품설명</td>
					<td> 
					    <textarea rows="5" name="description" class="form-control">${product.DESCRIPTION}</textarea>     
					 </td>
			    </tr>
			    <tr>
					<td>상품사진</td>
					<td>
						<c:if test="${product.FILENAME != '-'}">
							 <img src="/storage/${product.FILENAME}" width="100px">
						</c:if>
						<input type="file" name="img" class="form-control" style="margin-top:10px">						
					</td>
			    </tr>
			    <tr>
					<td>상품수량</td>
					<td>
			            <select name="qty" id="qty" class="form-control">
			            	<option value="0">-선택-</option>
			            	<option value="1">1</option>
			            	<option value="2">2</option>
			            	<option value="3">3</option>
			            	<option value="4">4</option>	            	
			            	<option value="5">5</option>	            	
			            </select>
			            <span id="qtynum" style="color:red; display:none;">* 상품수량을 선택해주세요</span>				
					</td>
			    </tr>
			    <tr>
					<td colspan="2" align="center">
					    <input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
					    <input type="submit" value="상품수정"    onclick="product_update()" class="btn btn-white">
					    <input type="button" value="상품삭제"    onclick="product_delete()" class="btn btn-white"> 
			            <input type="button" value="장바구니담기" onclick="product_cart()"   class="btn btn-white" id="cart">
					</td>
			    </tr>   
			    </tbody> 
		    </table>		
		</form>
    </div><!-- col end -->
  </div><!-- row end -->  
  
  <!-- 댓글 시작 -->
  <div class="row"><!-- 댓글 쓰기 -->
    <div class="col-sm-12">
		<form name="commentInsertForm" id="commentInsertForm">
			<!-- 부모글번호 -->
			<input type="hidden" name="product_code" id="product_code" value="${product.PRODUCT_CODE}">
			<table class="table table-borderless">
			<tr>
				<td>
					<input type="text" name="content" id="content" placeholder="댓글 내용 입력해 주세요" class="form-control">
				</td>
				<td>
					<button type="button" name="commentInsertBtn" id="commentInsertBtn" class="btn btn-white">댓글등록</button>
				</td>
			</tr>
			</table>
		</form>
    </div><!-- col end -->
  </div><!-- row end -->

  <div class="row"><!-- 댓글 목록 -->
    <div class="col-sm-12">
		<div class="commentList"></div>
    </div><!-- col end -->
  </div><!-- row end -->
  <!-- 댓글 끝 -->
  
  <!-- 댓글 관련 자바스크립트 시작 -->
  <script>
  
  	  let product_code = '${product.PRODUCT_CODE}'; //전역변수. 부모글 번호 
 
      $(document).ready(function(){ //상세페이지 로딩시 댓글 목록 함수 출력
          commentList(); 
      });//ready() end
  	  
  	  
  	  //댓글등록 버튼을 클릭했을때
  	  $("#commentInsertBtn").click(function(){
  		  //alert($);
  		  let content = $("#content").val().trim();
  		  if(content.length==0) {
  			  alert("댓글 내용 입력해주세요~");
  			  $("#content").focus();
  		  } else {
  			  //1)
  			  //let params = "product_code=" + $("#product_code").val() + "&content=" + $("#content").val();
  			  //alert(params);     //product_code=1&content=apple
  	  		  
  			  //2) <form id="commentInsertForm"></form>의 컨트롤 요소들을 전부 가져옴
  	  		  let insertData = $("#commentInsertForm").serialize();
  	  		  //alert(insertData); //product_code=1&content=apple
  			  commentInsert(insertData); //댓글등록 함수 호출
  		  }//if end  		  
  	  });//click end
  	  
  	  function commentInsert(insertData) { //댓글등록 함수
  		  //alert("댓글등록함수호출:" + insertData); //product_code=1&content=apple
  		  $.ajax({
  			  url    : '/comment/insert' //요청명령어
  			 ,type   : 'post' 
  			 ,data   : insertData        //전달값
  			 ,error  :function(error){
  				 alert(error);
  			 }//error end
  		     ,success:function(result){
  		    	 //alert(result);
  		    	 if(result==1){ //댓글등록 성공했다면
  		    		alert("댓글이 등록되었습니다");
  		    	 	commentList(); //댓글등록후 댓글목록 함수 호출
  		    	 	$("#content").val('');//기존 댓글내용을 빈 문자열로 대입(초기화)
  		    	 }//if end
  		     }
  		  });//ajax() end		
	  }//commentInsert() end
	  
	  
	  function commentList() {
		  //alert("commentList() 댓글목록 함수 호출");
		  $.ajax({
			  url    : '/comment/list'
			 ,type   : 'get'
			 ,data   : {'product_code' : product_code} //부모글번호(전역변수 선언되어 있음)
			 ,error  : function(error){
				 alert(error)
			 }
			 ,success: function(result){
				 //alert(result);
				 //console.log(result);
				 let a = ''; //출력할 결과값
				 $.each(result, function(key, value){
					 //console.log(key);  //순서 0 1
					 //console.log(value);//{cno: 1, product_code: 1, content: '비싸요~~', wname: 'test', regdate: '2024-05-23 12:09:40'}
					 //console.log(value.cno);
					 //console.log(value.product_code);
					 //console.log(value.content);
					 //console.log(value.wname);
					 //console.log(value.regdate);
					 
					 a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom:10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">';
					 a += '    <div class="commentInfo' + value.cno + '" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">';
					 a += '        <span>no. : ' + value.cno + " | 작성자 : " + value.wname + " | " + value.regdate + '</span>';
					 a += '        <span>';
					 a += '            <a href="javascript:commentUpdate(' + value.cno + ',\'' + value.content + '\')" style="margin-left: 10px;">수정</a>';
					 a += '            <a href="javascript:commentDelete(' + value.cno + ')" style="margin-left: 10px;">삭제</a>';
					 a += '        </span>';
					 a += '    </div>';
					 a += '    <div class="commentContent' + value.cno + '" style="width: 100%; display: flex; align-items: center;">';
					 a += '        <p style="margin: 0;"><i class="fa-regular fa-comment"></i> ' + value.content + '</p>';
					 a += '    </div>';
					 a += '</div>';

				 });//each() end
				 
				 $(".commentList").html(a);
				 
			 }
		  });//ajax() end
	  }//commentList() end
	  
  
	  //[수정] : 댓글수정-전달받은 댓글내용을 <input type=text>에 출력함
	  function commentUpdate(cno, content) {
		  //alert(cno + content);
		  let a = '';
		  a += '<div class="input-group">';
		  a += '	<input type="text" value="' + content + '" id="content_' + cno + '">';
		  a += '    <button type="button" onclick="commentUpdateProc(' + cno + ')">수정</button>';
		  a += '</div>';
		  //alert(a);
		  $(".commentContent" + cno).html(a);
	  }//commentUpdate() end
	  
	  
	  //댓글수정후 댓글목록 함수 호출
	  function commentUpdateProc(cno) {
		  //alert("댓글번호:" + cno);
		  let updateContent = $("#content_" + cno).val();
		  //alert("수정된 댓글내용:" + updateContent);
		  let params = "cno=" + cno + "&content=" + updateContent
		  
		  $.ajax({
			  url    : '/comment/updateproc'
			 ,type   : 'post'
			 ,data   : {'cno':cno, 'content':updateContent} //또는 params
			 ,success: function(result){
				 if(result==1){
					 alert("댓글이 수정되었습니다");
					 commentList(); //댓글수정후 목록 출력
				 }//if end
			 }//success end
		  });//ajax() end
	  }//commentUpdateProc() end
	  
	  
	  function commentDelete(cno) {
		  //alert("댓글삭제:" + cno);
		  $.ajax({
			  url    : '/comment/delete'
			 ,type   : 'post'
			 ,data   : {'cno' : cno}
		     ,success: function(result){
		    	 if(result==1){
		    		 alert("댓글이 삭제되었습니다");
		    		 commentList(); //댓글삭제후 목록 함수 출력
		    	 } else {
		    		 alert("댓글삭제실패:로그인후 사용이 가능합니다");
		    	 }//if end
		     }//success end
		  });//ajax() end
	  }//commentDelete() end
	  
	  
  </script>
  <!-- 댓글 관련 자바스크립트 끝 -->
  
  
  <!-- 본문 끝 -->
	</div>
	<!-- container end -->

	<div class="mt-5 p-4 bg-dark text-white text-center">
		<p>ITWILL 아이티윌 교육센터</p>
	</div>

</body>
</html>
