<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#cate{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: white;   
	font-weight:bold;   
	color:#00B98E;    
}
#cate:hover{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;    
}
#title{
	padding-top: 3%;
}
</style>
</head>
<body>
<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="noticeApp">
		<!-- 제목 -->
		<h3 class="text-center" id="title">공지사항</h3>
		<!-- 카테고리 선택 -->
		 <div class="cate text-center">
		 	<input type=button value="공지사항" id="cate" @click="changeCategory(2)">
		 	<input type=button value="문의하기" id="cate" @click="changeCategory(3)">
		 	<input type=button value="중고거래" id="cate" @click="changeCategory(4)">
		 </div>
	</div>
</body>
</html>