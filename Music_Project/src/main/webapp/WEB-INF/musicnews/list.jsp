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
</style>
</head>
<body>
  <div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="musicnewsApp">
	 <!-- 카테고리 선택 -->
	 <div class="cate text-center">
	 	<input type=button value="스페셜" id="cate" @click="changeCategory(1)">
	 	<input type=button value="OST PICK" id="cate" @click="changeCategory(2)">
	 	<input type=button value="POP" id="cate" @click="changeCategory(3)">
	 	<input type=button value="공연" id="cate" @click="changeCategory(4)">
	 	<input type=button value="클래식" id="cate" @click="changeCategory(5)">
	 </div>
	 <!-- 매거진 리스트 출력 -->
	  <div class="row" id="musicnewsrow">
		<div class="col-md-6" v-for="vo in musicnews_list">
		  <table class="table" style="border: none">
		   <tr>
		   <td rowspan="4" width="55%" style="border: none">
			<a :href="'../musicnews/detail.do?no='+vo.no">
				<img :src="'https:'+vo.poster" class="img-fluid mb-3" style="width: 100%;height: 200px;border-radius: 20px;">
			</a>
		   </td>
		   </tr>
		   
		   <tr> 
				<td style="margin-top: 5%;font-size: 20px;font-weight: bold;color: #00B98E;border: none">
					<a :href="'../musicnews/detail.do?no='+vo.no">{{vo.title}}</a>
				</td>
		   </tr>
		   <tr>
				<td style="border-top: 0.5px solid lightgrey;border-bottom: none">{{vo.regdate}}</td>
		   </tr>
		  </table>
		</div>
	  </div>
		<div style="height: 20px"></div>
			<div class="text-center">
				<ul class="pagination d-inline-flex justify-content-center">
				  <li v-if="startPage>1"><a class="alink" @click="prev()">&laquo;</a></li>
				  <li v-for="i in range(startPage, endPage)" :class="i===curpage?'active':''"><a class="alink" @click="pageChange(i)">{{i}}</a></li>
				  <li v-if="endPage<totalpage"><a class="alink" @click="next()">&raquo;</a></li>
				</ul>	
			</div>
	</div>
	<script>
	 let musicnewsApp=Vue.createApp({
		 data(){
			 return{
				 // 멤버변수
				 musicnews_list:[],
				 curpage:1,
				 totalpage:0,
				 startPage:0,
				 endPage:0,
				 cateno:1
			 }
		 },
		 mounted(){
			 this.dataRecv()
		 },
		 updated(){
			 
		 },
		 methods:{
			dataRecv(){
				// 데이터 목록
				axios.get('../musicnews/list_vue.do',{
					params:{
						page:this.curpage, 
						cateno:this.cateno
					}
				}).then(response=>{
					console.log(response.data); 
					this.musicnews_list=response.data
				})
				
				// 페이지 정보 받기
				axios.get('../musicnews/page_vue.do',{
					params:{
						page:this.curpage,
						cateno:this.cateno
					}
				}).then(response=>{
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
					this.cateno=response.data.cateno
				})
			},
			range(start, end){
				let arr=[];
				let len=end-start
				for(let i=0;i<=len;i++)
				{
					arr[i]=start;
					start++;
				}
				return arr;
			},
			prev(){
				this.curpage=this.startPage-1
				this.dataRecv()
			},
			next(){
				this.curpage=this.endPage+1
				this.dataRecv()
			},
			pageChange(page){
				this.curpage=page
				this.dataRecv()
			},
            changeCategory(cateno){
                this.cateno=cateno
                this.dataRecv()
            }
		 }
	 }).mount('#musicnewsApp')
	</script>
</body>
</html>