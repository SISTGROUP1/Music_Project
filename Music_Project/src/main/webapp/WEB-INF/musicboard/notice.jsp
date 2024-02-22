<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
$(function(){
   $(".cate1").click(function(){
      $('h2').hide()
      $('#title').append("<h2 class='text-center' id='title'>공지사항</h2>")
   })
   $(".cate2").click(function(){
      $('h2').hide()
      $('#title').append("<h2 class='text-center' id='title'>문의하기</h2>")
   })
   $(".cate3").click(function(){
      $('h2').hide()
      $('#title').append("<h2 class='text-center' id='title'>중고거래</h2>")
   })
})
</script>
<style type="text/css">
a.alink:hover{
	cursor: pointer;
}
.cate1, .cate2, .cate3{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: white;   
	font-weight:bold;   
	color:#00B98E;    
}
.cate1:hover, .cate2:hover, .cate3:hover{
	margin: 2%;
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;    
}
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
</style>
</head>
<body>
<!-- 인증된 상태 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<div style="height: 100px"></div>
	<div class="container-xxl bg-white p-0" id="noticeApp">
		<!-- 제목 -->
		<div id="title">
			<h2 class="text-center" id="title">공지사항</h2>
		</div>
		<!-- 카테고리 선택 -->
		 <div class="cate text-center">
		 	<input type=button value="공지사항" class="cate1" @click="changeCategory(2)">
		 	<input type=button value="문의하기" class="cate2" @click="changeCategory(3)">
		 	<input type=button value="중고거래" class="cate3" @click="changeCategory(4)">
		 </div>
		 <!-- 리스트 출력 -->
		  <div class="row" style="width: 90%;margin: 0px auto">
	      <table class="table">
	       
	       <tr>
	        <td>
	        	<sec:authorize access="hasRole('ROLE_ADMIN')">
	        		<a v-if="typeno === 2" :href="'../musicboard/noticeInsert.do'" class="btn btn-sm btn-danger" id="newBtn">글쓰기</a>
	        	</sec:authorize>
	        	<sec:authorize access="hasRole('ROLE_USER')">
                	<a v-if="typeno === 3" :href="'../musicboard/queInsert.do'" class="btn btn-sm btn-danger" id="newBtn">글쓰기</a>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_USER')">
                	<a v-if="typeno === 4" :href="'../musicboard/schInsert.do'" class="btn btn-sm btn-danger" id="newBtn">글쓰기</a>
                </sec:authorize>
	        </td>
	       </tr>
	       
	      </table>
	      <table class="table">
	        <tr class="success">
	         <th class="text-center" width=10%>번호</th>
	         <th class="text-center" width=45%>제목</th>
	         <th class="text-center" width=15%>이름</th>
	         <th class="text-center" width=20%>작성일</th>
	         <th class="text-center" width=10%>조회수</th>
	        </tr>
	        <tr v-for="(vo, index) in musicboard_list" :key="vo.no">
	         <td class="text-center" width=10%>{{count-index}}</td>
	         <td width=45%><a :href="'detail.do?no='+vo.no">{{vo.title}}</a></td>
	         <td class="text-center" width=15%>{{vo.name}}</td>
	         <td class="text-center" width=20%>{{vo.dbday}}</td>
	         <td class="text-center" width=10%>{{vo.hit}}</td>
	        </tr>
	      </table>
    	</div>
    	<!-- pagination -->
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
let noticeApp=Vue.createApp({
	// 멤버변수 
	data(){
		return {
			 // 변수 선언 
			 musicboard_list:[],
			 curpage:1,
			 totalpage:0,
			 startPage:0,
			 endPage:0,
			 typeno:2,
			 count:0
		}
	},
	// Callback
	mounted(){
		this.dataRecv()
		
	},
	// 멤버메소드
	methods:{
		dataRecv(){
			axios.get('../musicboard/notice_vue.do',{
				params:{
					page:this.curpage,
					typeno:this.typeno
				}
			}).then(response=>{
				console.log(response.data)
				this.musicboard_list=response.data
				this.count = this.musicboard_list.length;
			})
			
			// 페이지 
			axios.get("../musicboard/page_vue.do",{
				params:{
					page:this.curpage,
					typeno:this.typeno
				}
			}).then(response=>{
				console.log(response.data)
				this.curpage=response.data.curpage
				this.totalpage=response.data.totalpage
				this.startPage=response.data.startPage
				this.endPage=response.data.endPage
				this.typeno=response.data.typeno
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
        changeCategory(typeno){
            this.typeno=typeno
            this.dataRecv() 
        }
	}
}).mount('#noticeApp')
</script>
</body>
</html>