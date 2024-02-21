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
	margin-top: 4%;
	color: #00B98E; 
	font-weight:bold; 
	font-size: 30px;
}
#userId{
	width: 400px;
	height: 70px; 
}
#email{
	width: 400px;
	height: 70px; 
}
#userPwd{
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
    <div class="container-xxl bg-white p-0" id="pwdchangeApp">
        <!-- 제목 -->
        <div id="title">
            <h2 class="text-center" id="title"></h2>
        </div>
        <!-- 패스워드 찾기 -->
        <div class="row row1">
            <table class="table" style="width: 40%;margin: 0px auto;border: 1px solid lightgrey;margin-bottom: 10%;">
            	<tr style="border: none;">
                    <td width="80%" class="text-center" style="margin-top: 2%">
                    </td>
                </tr>
                <tr style="border: none;">
                    <td width="80%" class="text-center" id="logintitle" style="margin-top: 2%">
                        비밀번호 변경
                    </td>
                </tr>
                <tr style="border: none;">
                    <td width="80%" class="text-center">
                        <input type=text class="input-sm" placeholder="아이디"
                        id="userId" name="userId" v-model="userId"
                        >
                    </td>
                </tr>
                <tr style="border: none;">
                    <td width="80%" class="text-center">
                        <input type=text class="input-sm" placeholder="이메일"
                        id="email" name="email" v-model="email" ref="email"
                        >
                    </td>
                </tr>
                <tr style="border: none;">
                    <td width="80%" class="text-center">
                        <input type=text class="input-sm" placeholder="변경할 비밀번호"
                        id="userPwd" name="userPwd" v-model="userPwd" ref="userPwd"
                        >
                    </td>
                </tr>
                <tr style="border: none;">
                    <td colspan="2" class="inline text-center" v-show="wrong">
                       <b  id="wrong" name="wrong">
                          <span class="text-danger">아이디 또는 이메일을 다시 입력하세요.</span>
                       </b>
                    </td>
                    <td colspan="2" class="inline text-center" v-show="success">
                       <b  id="success" name="success">
                          <span class="text-success">{{userId}}님의 비밀번호가 {{userPwd}}로 변경되었습니다.</span>
                       </b>
                    </td>
                </tr>
                <tr style="border: none;">
                    <td colspan="2" class="text-center inline">
                        <input type="button" value="확   인" class="btn-sm btn-danger" @click="pwdfind" id="newBtn">
                    </td>
                </tr>
                <tr style="border: none;">
      				<td colspan="2" class="text-center" style="padding-top: 0px">
      					<a onclick="javascript:history.back()" class="alink">취소</a>
			        </td>
      			</tr>
            </table>
        </div>
    </div>
<script>
 let pwdchangeApp=Vue.createApp({
     data(){
         return{
             userId:'',
             email:'',
             msg:'',
             wrong:false,
             success:false
         }
     },
     mounted(){
         
     },
     methods:{
         pwdfind(){
             if(this.userId.trim()=="")
             {
                 this.$refs.userId.focus();
                 return
             }
             if(this.email.trim()=="")
             {
                 this.$refs.email.focus();
                 return
             }
             let _this=this
             axios.get('../member/pwdfind_vue.do', {
                 params:{
                	 userId:this.userId,
                     email:this.email
                 }
             }).then(response=>{
                 _this.msg=response.data
                 console.log(_this.msg)
                 if(_this.msg==='NO'){
                      _this.wrong=true;
                      _this.success=false;
                 }
                 else{
                      _this.success=true;
                      _this.wrong=false;
                 }
             })
         }
     }
 }).mount('#pwdchangeApp')
</script>
</body>
</html>