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
#musicnewsrow{
	padding: 3%;
}
#cate{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: white;   
	font-weight:bold;   
	color:#00B98E;    
}
#cate:hover{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;    
}
.article-content {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin-bottom: 20px;
    font-size: 16px;
    color: #333;
}
</style>
</head>
<body>
	<div style="height: 100px"></div>
		<div class="container-xxl bg-white p-0" id="musicnewsDetailApp">
			 
		 <!-- 데이터 출력 -->
		 <div class="row" id="musicnewsrow">
			  <table class="table" style="border-left: none;border-right: none; ">
			  	<tr>
			   		<td class="text-center" style="font-size: 30px;font-weight: bold;color: #00B98E">{{musicnews_detail.title}}</td>
			   	</tr>
			   	<tr>
			   		<td class="text-left" style="border: none">{{musicnews_detail.regdate}}</td>
			   	</tr>
			   	<tr>
			   		<td class="text-center" style="border: none">
			   			<img :src="'https:'+musicnews_detail.poster" style="width: 100%;height: auto;border-radius: 20px;">
			   		</td>	
			   	</tr>
			   	<tr>
			   		<td class="text-center" style="border: none">
			   			<img :src="'https:'+musicnews_detail.poster2" style="width: 100%;height: auto;border-radius: 20px;">
			   		</td>
			   	</tr>
			   	<tr>
			   		<td style="border: none;" class="article-content">{{musicnews_detail.content}}</td>
			   	</tr>
			    <tr>
			   		<td class="text-center" style="border: none"><input type=button value="목록" id="cate" @click="goBack()"></td>
			   	</tr>
			  </table>
		 </div>
		 </div>
<script>
 let musicnewsDetailApp=Vue.createApp({
	 data(){
		 return{
			 musicnews_detail:{},
			 no: <%= request.getParameter("no") %>
		 }
	 },
	 mounted(){
		 axios.get('../musicnews/detail_vue.do',{
			 params:{
				 no:this.no
			 }
		 }).then(response=>{
			 console.log(response.data)
			 this.musicnews_detail=response.data
		 })
	 },
	 methods:{
		 goBack(){
			 window.history.back()
		 }
	 }
 }).mount('#musicnewsDetailApp')
</script>
</body>

</html>









