<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div style="height: 100px"></div>
		<div class="container-xxl bg-white p-0" id="musicboardDetailApp">
		 <div class="row" id="musicboardrow">
		 <!-- template -->
		 <div class="bg-light rounded p-3">
             <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 185, 142, .3)">
                 <div class="row g-5 align-items-center">
                     <!-- 데이터 출력 -->
					 <table class="table" style="width: 90%;margin: 0px auto;margin-top: 3%">
				        <tr>
				          <th width=20% class="text-center">No</th>
				          <td width=30% class="text-center" v-text="detail_data.no"></td>
				          <th width=20% class="text-center">작성일</th>
				          <td width=30% class="text-center" v-text="detail_data.dbday"></td>
				        </tr>
				        <tr>
				          <th width=20% class="text-center">이름</th>
				          <td width=30% class="text-center" v-text="detail_data.name"></td>
				          <th width=20% class="text-center">조회수</th>
				          <td width=30% class="text-center" v-text="detail_data.hit"></td>
				        </tr>
				        <tr>
				          <th width=20% class="text-center">제목</th>
				          <td colspan="3" v-text="detail_data.title"></td>
				        </tr>
				        <tr>
				          <td colspan="4" valign="top" height="450">
				           <pre style="white-space: pre-wrap;border:none;background-color: white;">{{detail_data.content}}</pre>
				          </td>
				        </tr>
				        <tr>
				          <td colspan="4" class="text-center">
				            <input type="button" class="btn-xs btn-success" value="수정" @click="updateForm()" id="boardBtn">&nbsp;
				            <input type="button" class="btn-xs btn-info" value="삭제" ref="delBtn" @click="boardDeleteForm()" id="boardBtn">&nbsp;
				            
				            <input type=button value="목록" class="btn-xs btn-warning"
					            onclick="javascript:history.back()" id="boardBtn">
				          </td>
				        </tr>
				        <tr v-show="isShow">
				          <td colspan="4" class="text-right inline">
				            비밀번호:&nbsp;<input type="password" ref="pwd" v-model="pwd" class="input-sm" size=15>&nbsp;
				            <input type="button" class="btn-sm btn-primary" value="삭제" @click="boardDelete()" id="boardBtn">
				          </td>
				        </tr>
				      </table>
                 </div>
             </div>
         </div>
	    </div>
	    </div>
<script>
   let musicboardDetailApp=Vue.createApp({
	   data(){
		   return {
			   no:${no},
			   detail_data:{},
			   pwd:'',
			   isShow:false,
			   check:0
		   }
	   },
	   mounted(){
		   axios.get('../musicboard/detail_vue.do',{
			   params:{
				   no:this.no
			   }
		   }).then(response=>{
			   console.log(response.data)
			   this.detail_data=response.data
		   })
	   },
	   methods:{
		   boardDeleteForm(){
			   if(this.check===0)
			   {
				   this.check=1;
				   this.isShow=true
				   this.$refs.delBtn.value="취소"
				   this.$refs.pwd.focus()
			   }
			   else
			   {
				   this.check=0;   
				   this.isShow=false
				   this.pwd=''
				   this.$refs.delBtn.value="삭제"
			   }
		   },
		   boardDelete(){
			   if(this.pwd==="")
			   {
				   this.$refs.pwd.focus()
				   return;
			   }
			   axios.get('../musicboard/delete_vue.do',{
				   params:{
					   no:this.no,
					   pwd:this.pwd
				   }
			   }).then(response=>{
				   if(response.data==="yes")
				   {
					   location.href="../musicboard/notice.do"
				   }
				   else
				   {
					   alert("비밀번호를 다시 입력하세요.")
					   this.pwd=""
					   this.$refs.pwd.focus()
				   }
			   })
		   },
		   updateForm(){
			   location.href="../musicboard/update.do?no="+this.no
		   }
	   }
   }).mount("#musicboardDetailApp")
</script>
</body>
</html>