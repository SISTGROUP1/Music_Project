<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
#musicboardrow{
	padding: 3%;
}
#boardBtn{
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;  
}
</style>
</head>
<body>
<!-- 인증된 상태 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

	<div style="height: 100px"></div>
		<div class="container-xxl bg-white p-0" id="noticeInsertApp">
		 <div class="row" id="musicboardrow">
		 <!-- template -->
		 <div class="bg-light rounded p-3">
             <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 185, 142, .3)">
                 <div class="row g-5 align-items-center">
                     <!-- 데이터 출력 -->
					 <table class="table" style="width: 90%;margin: 0px auto;margin-top: 3%">
				           <tr>
					         <th width=10%>이름</th>
					         <td width=90%>
					         	<input type=text ref="name" size=15 v-model="name" class="input-sm">
					         </td>
					        </tr>
					        
					        <tr>
					         <th width=10%>제목</th>
					         <td width=90%><input type=text ref="title" size=120 v-model="title" class="input-sm"></td>
					        </tr>
					        <tr>
					         <th width=10%>내용</th>
					         <td width=90%><textarea rows="16" cols="120" ref="content" v-model="content"></textarea></td>
					        </tr>
					        <tr>
					         <th width=10%>비밀번호</th>
					         <td width=90%><input type=password ref="pwd" size=15 v-model="pwd" class="input-sm"></td>
					        </tr>
					        <tr>
					         <td colspan="2" class="text-center inline" style="border-bottom: none">
					           <input type=button value="글쓰기" class="btn-sm btn-danger" @click="write()" id="boardBtn">&nbsp;
					           <input type=button value="취   소" class="btn btn-sm btn-success"
					            onclick="javascript:history.back()" id="boardBtn">
					         </td>
					        </tr>
				      </table>
                 </div>
             </div>
         </div>
	    </div>
	    </div>
<script>
let noticeInsertApp=Vue.createApp({
	data(){
		return {
			name:'',
			title:'',
			content:'',
			pwd:''
		}
	},
	methods:{
		write(){
			if(this.name==="")
			{
				this.$refs.name.focus()
				return
			}
			if(this.title==="")
			{
				this.$refs.title.focus()
				return
			}
			if(this.content==="")
			{
				this.$refs.content.focus()
				return
			}
			if(this.pwd==="")
			{
				this.$refs.pwd.focus()
				return
			}
			
			axios.post('../musicboard/queInsert_vue.do',null,{
				params:{
					name:this.name,
					title:this.title,
					content:this.content,
					pwd:this.pwd
				}
			}).then(response=>{
				if(response.data==="yes")
				{
				   location.href="../musicboard/notice.do";	
				}
				else
				{
					alert(response.data)
				}
			})
		}
	}
}).mount("#noticeInsertApp")
</script>
</body>
</html>