<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
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
#idBtn{
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;  
}
#joinrow{
	margin: 0px auto;
	margin-bottom: 10%
}
#logintitle{
	color: #00B98E; 
	font-weight:bold; 
	font-size: 50px;
}
</style>
</head>
<body>
<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="updateApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title"></h2>
		</div>
		<div class="row" id="joinrow">
		 <!-- template -->
		 <div class="bg-light rounded p-3" style="width: 70%;margin: 0px auto;margin-bottom: 10%">
             <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 180, 142, .3);margin: 0px auto">
                 <div class="row g-5 align-items-center" style="margin: 0px auto;margin-bottom: 10%">
		<!-- 회원 정보 수정 -->
		
      <table class="table" style="width: 70%;margin: 0px auto;margin-top: 3%">
      
        <tr style="border: none;">
			<td width="80%" class="text-center" id="logintitle" style="border: none;margin: 0px auto">
				MU:MA
			</td>
		</tr>
       <tr>
        <th width=20% class="text-center">아이디</th>
        <td width=80% class="inline">
          <input type=text ref=userId size=20 class="input-sm" v-model="userId"
            readonly="isReadOnly" name="userId"
          >&nbsp;아이디는 수정이 불가능합니다.
        </td>
       </tr>
       
       <tr>
        <th width=20% class="text-center">이름</th>
        <td width=80% class="inline">
          <input type=text ref=userName size=20 class="input-sm" v-model="userName"
           name="userName"
          >
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">생년월일</th>
        <td width=80% class="inline">
          <input type=date ref="birth" size=35 v-model="birth" name="birth">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">주소</th>
        <td width=80% class="inline">
          <input type=text ref=addr1 size=50 class="input-sm" v-model="addr1" name="addr1">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">상세주소</th>
        <td width=80% class="inline">
          <input type=text ref=addr2 size=50 class="input-sm" v-model="addr2" name="addr2">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">이메일</th>
        <td width=80% class="inline">
          <input type=text ref=email size=50 class="input-sm" v-model="email" name="email">
          <p></p>
        </td>
       </tr>
       
       <tr>
         <td colspan="2" class="text-center inline">
           <input type="button" value="확  인" id="idBtn" @click="update()">&nbsp;
           <input type=button value="취  소" id="idBtn" onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
       </div>
       </div>
    </div>
  </div>
</div>
<script>
let updateApp=Vue.createApp({
	data(){
		return {
			update_data:{},
			userId:'${userId}',
			userName:'',
			birth:'',
			email:'',
			addr1:'',
			addr2:''
		}
	},
	mounted(){
		console.log(this.userId)
		axios.get('../mypage/update_vue.do',{
			   params:{
				   userId:this.userId
			   }
		   }).then(response=>{
			   
			   this.update_data=response.data
			   this.userName=response.data.userName
			   this.birth=response.data.birth
			   this.email=response.data.email
			   this.addr1=response.data.addr1
			   this.addr2=response.data.addr2
			
		   })
	},
	methods:{
		update(){
			
			axios.post('../mypage/update_ok_vue.do',null,{
				params:{
					userId:this.userId,
					userName:this.userName,
					birth:this.birth,
					email:this.email,
					addr1:this.addr1,
					addr2:this.addr2
				}
			}).then(response=>{
				if(response.data==="yes")
				{
				   location.href="../mypage/main.do";
				}
			})
		}
	}
}).mount("#updateApp")
</script>
</body>
</html>