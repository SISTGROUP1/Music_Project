<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('#logBtn').click(function(){
		let id=$('#id').val()
		if(id.trim()==="")
		{
			$('#id').focus()
			return
		}
		let pwd=$('#pwd').val()
		if(pwd.trim()==="")
		{
			$('#pwd').focus()
			return
		}
		
		$('#frm').submit()
	})
})
</script>
<style type="text/css">
a.alink:hover{
	cursor: pointer;
}
#title{
	padding-top: 3%;
}
#logBtn{
	margin: 0px auto;
	margin-bottom: 2%;
	border:1px solid #00B98E;   
	border-radius: 5px;     
	background-Color: #00B98E;   
	font-weight:bold; 
	font-size: 20px;  
	color: white;
	width: 400px;
	height: 67px;  
}
#logintitle{
	margin-top: 2%;
	color: #00B98E; 
	font-weight:bold; 
	font-size: 50px;
}
#id, #pwd{
	width: 400px;
	height: 70px; 
}
.table>:not(caption)>*>* {
    border-bottom-width: 0px;
}
input:focus {
    outline: 1px solid #00B98E;
}
input: {
    outline: 1px solif lightgrey;
}
</style>
</head>
<body>
<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title"></h2>
		</div>
		<!-- 로그인 -->
		<div class="row row1">
		  <form method="POST" action="../member/login.do" id="frm">
      		<table class="table" style="width: 40%;margin: 0px auto;border: 1px solid lightgrey;margin-bottom: 10%;">
      			<tr style="border: none;">
      				<td width="80%" class="text-center" id="logintitle">
      					MU:MA
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td width="80%" class="text-center">
      					<input type=text class="input-sm" name="userId" placeholder="아이디" id="id">
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td width="80%" class="text-center">
      					<input type=password class="input-sm" name="userPwd" placeholder="비밀번호" id="pwd">
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td colspan="2" class="text-center">
			             <input type="checkbox" name="remember-me">&nbsp;자동 로그인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			             <a href="../member/idfind.do">아이디 찾기</a>&nbsp;
			     		 <a href="../member/pwdchange.do">비밀번호 변경</a>
			        </td>
      			</tr>
      			<tr>
          			<td colspan="2" class="text-center" style="color: red">${message }</td>
          		</tr>
      			<tr style="border: none;">
      				<td colspan="2" class="text-center inline">
      					<input type="button" value="로그인" class="btn-sm btn-danger" id="logBtn">
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td colspan="2" class="text-center" style="padding-top: 0px">
      					<a onclick="javascript:history.back()" class="alink">취소</a>
			        </td>
      			</tr>
      		</table>
      	  </form>
      	</div>
	</div>
<script>
 
</script>
</body>
</html>