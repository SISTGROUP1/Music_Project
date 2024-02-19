<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
#title{
	padding-top: 3%;
}
#newBtn{
	margin: 0px auto;
	margin-bottom: 2%;
	border:1px solid #00B98E;   
	border-radius: 10px;     
	background-Color: #00B98E;   
	font-weight:bold; 
	font-size: 20px;  
	color: white;
	width: 400px;
	height: 80px;  
}
#kakaoBtn{
	margin: 0px auto;
	margin-top: 8%;
	border:1px solid #FEEA0D;
	border-radius: 10px;    
	background-Color: #FEEA0D;   
	font-weight:bold;
	font-size: 20px;
	color: #2A1B0A;  
	width: 400px;
	height: 80px;
}
#toJoin{
	color: #2A1B0A; 
	margin-bottom: 8%;
}
</style>
</head>
<body>
<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="scloginApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title"></h2>
		</div>
		<!-- 선택 -->
		<table class="table" style="width: 40%;margin: 0px auto;border: 1px solid lightgrey;margin-bottom: 10%">
		  <tr style="border: none;">
			<td colspan="1" class="text-center" style="border: none;">
				<input type="button" id="kakaoBtn" value="카카오계정 로그인">
			</td>
		  </tr>
		  <tr style="border: none;">
			<td colspan="1" class="text-center" style="border: none;">
				<a href="../member/login.do"><input type="button" id="newBtn" value="MU:MA 아이디 로그인"></a>
			</td>
		  </tr>
		  <tr>
		  	<td class="text-center" id="toJoin"><a href="../member/join.do" style="color: #2A1B0A;">회원가입</a></td>
		  </tr>
		</table>
		<div style="height: 10px"></div>
	</div>
</body>
</html>