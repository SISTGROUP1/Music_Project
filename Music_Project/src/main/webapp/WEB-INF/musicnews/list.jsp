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
</style>
</head>
<body>
  <div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="musicnewsApp">
	  <div class="row">
		<div class="col-md-6" v-for="vo in musicnews_list">
			<a :href="'../musicnews/detail.do?no='+vo.no">
				<img :src="'https:'+vo.poster" class="img-fluid mb-3" style="width: 290px;height: 200px">
			</a>
		</div>
	  </div>
		<div style="height: 20px"></div>
			<div class="text-center">
				<ul class="pagination d-inline-flex justify-content-center">
				  <li v-if="startPage>1"><a class="alink" @click="prev(i)">&laquo;</a></li>
				  <li v-for="i in range(startPage, endPage)" :class="i===curpage?'active':''"><a class="alink" @click="pageChange(i)">{{i}}</a></li>
				  <li v-if="endPage<totalpage"><a class="alink" @click="next(i)">&raquo;</a></li>
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
				 endPage:0
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
						page:this.curpage 
					}
				}).then(response=>{
					console.log(response.data); 
					this.musicnews_list=response.data
				})
				
				// 페이지 정보 받기
				axios.get('../musicnews/page_vue.do',{
					params:{
						page:this.curpage
					}
				}).then(response=>{
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
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
			}
		 }
	 }).mount('#musicnewsApp')
	</script>
</body>
</html>