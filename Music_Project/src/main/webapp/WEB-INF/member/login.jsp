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
#text{
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
	<div class="container-xxl bg-white p-0" id="loginApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title"></h2>
		</div>
		<!-- 로그인 -->
		<div class="row row1">
      		<table class="table" style="width: 40%;margin: 0px auto;border: 1px solid lightgrey;margin-bottom: 10%;">
      			<tr style="border: none;">
      				<td width="80%" class="text-center" id="logintitle">
      					MU:MA
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td width="80%" class="text-center">
      					<input type=text ref="id" class="input-sm" v-model="id" placeholder="아이디" id="text">
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td width="80%" class="text-center">
      					<input type=password ref="pwd" class="input-sm" v-model="pwd" placeholder="비밀번호" id="text">
      				</td>
      			</tr>
      			<tr style="border: none;">
      				<td colspan="2" class="inline text-center">
			             <input type="checkbox" ref="ck" v-model="ck">&nbsp;ID저장
			        </td>
      			</tr>
      			<tr style="border: none;">
      				<td colspan="2" class="text-center inline">
      					<input type="button" value="로그인" class="btn-sm btn-danger" @click="login()" id="newBtn">
      				</td>
      			</tr>
      		</table>
      	</div>
	</div>
<script>
 let loginApp=Vue.createApp({
	 data(){
		 return{
			 id:'${userId}',
			 pwd:'',
			 ck:true
		 }
	 },
	 methods:{
		 login(){
			 if(this.id==='')
			 {
				 alert("ID를 입력하세요.")
				 this.$refs.id.focus()
				 return
			 }
			 if(this.pwd==='')
			 {
				 alert("패스워드를 입력하세요.")
				 this.$refs.pwd.focus()
				 return
			 }
			 axios.get('../member/login_ok_vue.do',{
				 params:{
					 userId:this.id,
					 userPwd:this.pwd,
					 ck:this.ck
				 }
			 }).then(response=>{
				 if(response.data==='NOID')
				 {
					alert("ID가 존재하지 않습니다.")
					this.id=''
					this.pwd=''
					this.ck=false
					this.$refs.id.focus()
				 }
				 else if(response.data==='NOPWD')
			     {	
					alert("비밀번호가 일치하지 않습니다.")
					this.pwd=''
					this.$refs.pwd.focus()
			     }
				 else
				 {
					location.href='../main/main.do' 
				 }
			 })
		 }
	 }
 }).mount('#loginApp')
</script>
</body>
</html>