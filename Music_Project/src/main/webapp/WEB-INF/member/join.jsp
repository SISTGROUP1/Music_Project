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
	<div class="container-xxl bg-white p-0" id="memberApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title"></h2>
		</div>
		<div class="row" id="joinrow">
		 <!-- template -->
		 <div class="bg-light rounded p-3" style="width: 70%;margin: 0px auto;margin-bottom: 10%">
             <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 180, 142, .3);margin: 0px auto">
                 <div class="row g-5 align-items-center" style="margin: 0px auto;margin-bottom: 10%">
		<!-- 회원가입 -->
		
		<form method="post" action="../member/join_ok.do" @submit="submitForm()">
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
            v-bind:readonly="isReadOnly" name="userId"
          >&nbsp;
          <input type=button value="아이디 중복체크" @click="idCheck" id="idBtn">
          <p>{{idOk}}</p>
        </td>
       </tr>
       <th width=20% class="text-center">비밀번호</th>
        <td width=80% class="inline">
          <input type=password ref=userPwd size=20 class="input-sm" v-model="userPwd"
            @keyup="pwdValidate" name="userPwd">&nbsp;
          <input type=password ref=userPwd1 size=20 class="input-sm" placeholder="비밀번호 재입력" v-model="userPwd1"
           @keyup="pwdValidate2"
          >
          <p>{{pwdOk}}</p>
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
        <th width=20% class="text-center">성별</th>
        <td width=80% class="inline">
          <input type="radio"  value="남자" checked v-model="gender" name="gender">남자
          <input type="radio"  value="여자" v-model="gender" name="gender">여자
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">생년월일</th>
        <td width=80% class="inline">
          <input type=date ref="birth" size=35 v-model="birth" name="birth">
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
        <th width=20% class="text-center">우편번호</th>
        <td width=80% class="inline">
          <input type=text ref=post size=20 readonly class="input-sm" v-model="post" name="post">&nbsp;
          <input type=button value="우편번호검색" id="idBtn" @click="postFind()">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">주소</th>
        <td width=80% class="inline">
          <input type=text ref=addr1 size=50 readonly class="input-sm" v-model="addr1" name="addr1">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">상세주소</th>
        <td width=80% class="inline">
          <input type=text ref=addr2 size=50 class="input-sm" v-model="addr2" name="addr2">
        </td>
       </tr>
       <tr>
        <th width=20% class="text-center">전화번호</th>
        <td width=80% class="inline">
          <select ref="phone1" class="input-sm" v-model="phone1" name="phone1">
            <option>010</option>
          </select>&nbsp;
          <input type=text ref=phone2 size=7 class="input-sm" v-model="phone2" name="phone2">&nbsp;
          <input type=text ref=phone3 size=7 class="input-sm" v-model="phone3" name="phone3">
        </td>
       </tr>
       <tr>
         <td colspan="2" class="text-center inline">
           <input type="submit" value="회원가입" id="idBtn">&nbsp;
           <input type=button value="취소" id="idBtn" onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
      </form>
       </div>
       </div>
    </div>
  </div>
</div>
<script>
  let memberApp=Vue.createApp({
	  data(){
		  return {
			  post:'',
			  addr1:'',
			  userPwd:'',
			  userPwd1:'',
			  pwdOk:'',
			  userName:'',
			  phone1:'',
			  phone2:'',
			  phone3:'',
			  email:'',
			  content:'',
			  birth:'',
			  userId:'',
			  idOk:'',
			  isReadOnly:false,
			  gender:'',
			  addr2:''
		  }
	  },
	  methods:{
		  submitForm(e){
			  alert("환영합니다.")
			if(this.userId && this.userName && this.userPwd && this.gender && this.userPwd1
			   && this.birth && this.email && this.post && this.addr1
			   && this.content && this.phone1 && this.phone2 && this.phone3 && this.idOk!=''
			   && this.pwdOk!='' && this.addr2 && this.gender
			) 
			{
				return true
			}
			
			if(this.userId==='' || this.idOk!='')
			{
				this.$refs.userId.focus()
				
			}
			else if(this.userName==='')
			{
				this.$refs.userName.focus()
				
			}
			else if(this.userPwd==='')
			{
				this.$refs.userPwd.focus()
				
			}
			else if(this.userPwd1==='')
			{
				this.$refs.userPwd1.focus()
				
			}
			else if(this.userPwd!=this.userPwd1)
			{
				this.userPwd1='';
				this.userPwd2=''
				
			}
			else if(this.phone2=='')
			{
				this.$refs.phone2.focus()
				
			}
			else if(this.phone3=='')
			{
				this.$refs.phone3.focus()
				
			}
			else if(this.email=='')
			{
				this.$refs.email.focus()
				
			}
			e.preventDefault()
		  },
		  idCheck(){
			  if(this.userId==='')
			  {
				  this.$refs.userId.focus()
				  return
			  }
			  axios.get('../member/idcheck_vue.do',{
				  params:{
					  userId:this.userId
				  }
			  }).then(response=>{
				 if(response.data=="0")  
			     {
					 this.idOk='사용 가능한 아이디입니다.'
					 this.isReadOnly=true
			     }
				 else
				 {
					 this.idOk='이미 사용중인 아이디입니다.' 
				 }
			  })
		  },
		  postFind(){
			  let _this=this
			  //Vue
			  new daum.Postcode({
				 oncomplete:function(data)
				 {
					 _this.post=data.zonecode;
					 _this.addr1=data.address;
				 }
			  }).open()
		  },
		  pwdValidate(){
			  let pwd=String(this.userPwd)
			  let num=pwd.search(/[0-9]/g)
			  let eng=pwd.search(/[a-z]/ig)
			  // 알파벳 / 숫자가 존재 
			  // 8자리 이상  20이하 
			  if(pwd==='')
			  {
				  this.pwdok='';
				  return
			  }
			  if(pwd.length<8 || pwd.length>20)
			  {
				  this.pwdOk='8자리~20자리 이내로 입력하세요.'
				  return
			  }
			  else if(pwd.search(/\s/)!=-1)
			  {
				  // \s => 공백 
				  this.pwdOk='비밀번호는 공백없이 입력하세요.'
				  return
			  }
			  else if(num<0 || eng>0)
			  {
				  this.pwdOk="영문,숫자를 혼합해서 입력히세요."
				  return
			  }
			  else
			  {
				  this.pwdOk=''
				  return
			  }
			  
		  },
		  pwdValidate2(){
			  if(this.userPwd!==this.userPwd1)
			  {
				  this.pwdOk="비밀번호가 일치하지 않습니다."
			  }
			  else
			  {
				  this.pwdOk=''
			  }
		  }
	  }
  }).mount("#memberApp")
</script>
</body>
</html>










