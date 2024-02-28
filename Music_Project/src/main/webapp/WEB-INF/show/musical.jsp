<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#scate1").click(function(){
		$('h2').hide()
		$('#scateTitle').append("<h2 class='mb-3'>콘서트</h2>")
	})
	$("#scate2").click(function(){
		$('h2').hide()
		$('#scateTitle').append("<h2 class='mb-3'>뮤지컬</h2>")
	})
	$("#scate3").click(function(){
		$('h2').hide()
		$('#scateTitle').append("<h2 class='mb-3'>클래식</h2>")
	})
})
</script>
<style type="text/css">
a.link:hover,img.img_click:hover{
	cursor:pointer;
}
#scate1,#scate2,#scate3{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: white;   
	font-weight:bold;   
	color:#00B98E;    
}
#scate1:hover,#scate2:hover,#scate3:hover{
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
<div class="container-xxl bg-white p-0" id="showApp">
<!-- 카테고리 선택 -->
	 <div class="cate text-center">
	 	<input type=button value="콘서트" id="scate1" @click="changeCategory(1)">
	 	<input type=button value="뮤지컬" id="scate2" @click="changeCategory(2)">
	 	<input type=button value="클래식" id="scate3" @click="changeCategory(3)">
	 </div>
	 <div style="height: 100px"></div>
<div class="container-fluid header bg-white p-0">
      <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;" id="scateTitle">
                    <h2 class="mb-3">뮤지컬</h2>
                </div>
                <div class="row g-4">
                    <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s" v-for="vo in show_list">
                        <a :href="'../show/detail.do?sno='+vo.sno" class="cat-item d-block bg-light text-center rounded p-3">
                            <div class="rounded p-4" style="width:268px;height:435px">
                                <div class="icon mb-3" style="padding: 0px;border:1px dashed white !important;">
                                    <img :src="vo.sposter"  style="width:216px;height:302px;border-radius: 40px">
                                </div>
                                <small class="fw-bold mb-0" style="color: black">{{vo.stitle}}</small>
                                <h6></h6>
                                <small class="fw-bold mb-0" style="color:#666565">{{vo.sloc}}</small>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        <table class="text-center">
        <ul class="text-center" style="list-style: none;margin-top:20px">
          <li v-if="startPage>1"><a class="link" @click="prev()" style="float: left">&laquo;&nbsp;&nbsp;</a></li>
          <li v-for="i in range(startPage,endPage)"><a class="link" @click="pageChange(i)" style="float: left;">{{i}}&nbsp;&nbsp;</a></li>
          <li v-if="endPage<totalpage"><a class="link" @click="next()" style="float: left">&raquo;</a></li>
        </ul>
        </table>
      </div>
  </div>
</div>
<script>
 let showApp=Vue.createApp({
	 data(){
		 return{
			 show_list:[],
			 curpage:1,
			 totalpage:0,
			 startPage:0,
			 endPage:0,
			 scate:2,
			 sno:1
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
			axios.get('../show/show_list_vue.do',{
				params:{
					page:this.curpage, 
					scate:this.scate
				}
			}).then(response=>{
				this.show_list=response.data
			})
			
			// 페이지 정보 받기
			axios.get('../show/show_page_vue.do',{
				params:{
					page:this.curpage,
					scate:this.scate
				}
			}).then(response=>{
				this.curpage=response.data.curpage
				this.totalpage=response.data.totalpage
				this.startPage=response.data.startPage
				this.endPage=response.data.endPage
				this.scate=response.data.scate
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
           changeCategory(scate){
               this.scate=scate
               this.dataRecv()
           }
	 }
 }).mount('#showApp')
</script>
</body>
</html>