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
	<div class="container-xxl bg-white p-0" id="mypageApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title">마이페이지</h2>
		</div>
		<!-- 카테고리 선택 -->
		 <div class="cate text-center">
		 	<a href="../mypage/main.do"><input type=button value="내정보" class="cate1"></a>
		 	<a href="../mypage/mywrite.do"><input type=button value="내가 쓴 글" class="cate2"></a>
		 	<a href="../mypage/showreserve.do"><input type=button value="예매 내역" class="cate2"></a>
		 </div>
		 <div class="row" id="musicboardrow" style="justify-content: center">
		  <!-- template -->
		 <div class="bg-light rounded p-3" style="width: 70%">
             <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 185, 142, .3)">
                 <div class="row g-5 align-items-center">
		 
		 <!-- 데이터 출력 -->
		 <table class="table" style="width: 90%;margin: 0px auto;margin-top: 4%">
		    <tr>
		    	<th style="font-weight: bold;font-size: 25px">{{mypage_list.userName}}&nbsp;&nbsp;님</th>
		    </tr>
		 	<tr style="border: none;">
		        <th width=30% style="border: none;">아이디</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.userId}}
		        </td>
		    </tr>

		     <tr style="border: none;"> 
		        <th width=30% style="border: none;">성별</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.gender}}
		        </td>
		      </tr>
		      <tr style="border: none;"> 
		        <th width=30% style="border: none;">생년월일</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.birth}}
		        </td>
		       </tr>
		       <tr style="border: none;">
		        <th width=30% style="border: none;">이메일</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.email}}
		        </td>
		       </tr>
		       <tr style="border: none;">
		        <th width=30% style="border: none;">우편번호</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.post}}
		        </td>
		      </tr>
		      <tr style="border: none;">
		        <th width=30% style="border: none;">주소</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.addr1}}&nbsp;
		          {{mypage_list.addr2}}
		        </td>
		      </tr>
		      <tr style="border: none;"> 
		        <th width=30% style="border: none;">전화번호</th>
		        <td width=70% class="inline" style="border: none;">
		          {{mypage_list.phone}}
		        </td>
	          </tr>
		 </table>
		 
		 </div>
		 </div>
		 </div>
		 </div>
		 <div style="height: 5px"></div>
		 <!-- 버튼 -->
		 <div class="text-center">
		 <tr>
	         <td colspan="2" class="text-center inline" style="border-bottom: none">
	           <a href="../mypage/update.do"><input type=button value="정보수정" class="btn-sm btn-danger" id="newBtn"></a>&nbsp;
	           <input type=button value="회원탈퇴" class="btn btn-sm btn-success" @click="deleteBtn()" id="newBtn">
	         </td>
        </tr>
        </div>
	   <div style="height: 50px"></div>
	</div>
<script>
let mypageApp=Vue.createApp({
	data(){
		return{
			mypage_list:{}
		}
	},
	mounted(){
		axios.get('../mypage/main_vue.do')
		.then(response=>{
			console.log(response.data)
			this.mypage_list=response.data
		})
	},
	methods:{
		updateBtn(){
			
		},
		deleteBtn(){
			
		}
	}
}).mount('#mypageApp')
</script>
</body>
</html>