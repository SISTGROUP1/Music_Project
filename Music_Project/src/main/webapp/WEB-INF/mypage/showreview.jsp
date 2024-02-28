<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue-router@3.0.1/dist/vue-router.js"></script>
</head>
<body>
  <div class="wrapper row3 row1" id="sReviewApp">
    <main class="container clear"> 
      <h2 class="sectiontitle">수정하기</h2>
      <table class="table">
        <tr>
         <th width=10%>아이디</th>
         <td width=90%><input type=text ref="userid" size=15  class="input-sm" v-model="userid"></td>
        </tr>
        <tr>
         <th width=10%>내용</th>
         <td width=90%><textarea rows="10" cols="52" ref="content" v-model="content"></textarea></td>
        </tr>
        <tr>
         <td colspan="2" class="text-center inline">
           <input type=button value="작성하기" class="btn-sm btn-danger" @click="write()">
           <input type=button value="취소" class="btn btn-sm btn-success" onclick="javascript:history.back()">
         </td>
        </tr>
      </table>
    </main>
  </div>
  <script>
   let sReviewApp=Vue.createApp({
	   data(){
		   return {
			   show_detail:{},
			   sno:${sno},
			   userid:'',
			   msg:''
			   
		   }
	   },
	   methods:{
			   write(){
	    			if(this.name==="")
	    			{
	    				this.$refs.name.focus()
	    				return
	    			}
	    			if(this.content==="")
	    			{
	    				this.$refs.content.focus()
	    				return
	    			}
	    			
	    			axios.post('../mypage/showreview_vue.do',null,{
	    				params:{
	    					userid:this.userid,
	    					content:this.content
	    				}
	    			}).then(response=>{
	    				if(response.data==="yes")
	    				{
	    				   location.href="'../show/detail.do?sno='+response.data.sno";	
	    				}
	    				else
	    				{
	    					alert(response.data)
	    				}
	    			})
	    		}
	    	}
   }).mount("#sReviewApp")
  </script>
</body>
</html>