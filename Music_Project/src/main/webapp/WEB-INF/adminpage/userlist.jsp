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
a.alink:hover{
	cursor: pointer;
}
.cate1, .cate2, .cate3{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: white;   
	font-weight:bold;   
	color:#00B98E;    
}
.cate1:hover, .cate2:hover, .cate3:hover{
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
#newBtn{
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;  
}
#musicboardrow{
	padding: 3%;
}
</style>
</head>
<body>
<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="adminpageApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title">관리자 페이지</h2>
		</div>
		<!-- 카테고리 선택 -->
		 <div class="cate text-center">
		 	<a href="../adminpage/userlist.do"><input type=button value="회원관리" class="cate1"></a>
		 	<a href="../adminpage/adminpage.do"><input type=button value="예매현황" class="cate1"></a>
		 </div>
		 
		 <!-- 리스트 출력 -->
		  <div class="row" style="width: 70%;margin: 0px auto">
	 
	      <table class="table">
	        <tr class="success">
	         <th class="text-center" width=20%>아이디</th>
	         <th class="text-center" width=15%>이름</th>
	         <th class="text-center" width=10%>성별</th>
	         <th class="text-center" width=55%>이메일</th>
	        </tr>
	        <tr v-for="vo in user_list">
	         <th class="text-center" width=20%>{{vo.userId}}</th>
	         <th class="text-center" width=15%>{{vo.userName}}</th>
	         <td class="text-center" width=10%>{{vo.gender}}</td>
	         <td class="text-center" width=55%>{{vo.email}}</td>
	        </tr>
	      </table>
    	</div>
    	
        </div>
	   <div style="height: 50px"></div>
	</div>
<script>
let adminpageApp=Vue.createApp({
	// 멤버변수 
	data(){
		return {
			 // 변수 선언 
			 user_list:[]
		}
	},
	// Callback
	mounted(){
		this.dataRecv()
		
	},
	// 멤버메소드
	methods:{
		dataRecv(){
			axios.get('../adminpage/userlist_vue.do',{
				params:{
				}
			}).then(response=>{
				console.log(response.data)
				this.user_list=response.data
			})
			
		}
	}
}).mount('#adminpageApp')
</script>
</body>
</html>