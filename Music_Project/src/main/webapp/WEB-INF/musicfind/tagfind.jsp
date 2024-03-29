<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
	#pageChange{
		border:1px solid #ccc;
		color:#666;
		width:28px;
		height:28px;
		border-radius: 4px;
		margin:0 4px;
		display: inline-block;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
	}
	#currentpage{
		border:1px solid #0096FF;
		color:#0096FF;
		font-weight:bold;
		width:28px;
		height:28px;
		border-radius: 4px;
		margin:0 4px;
		display: inline-block;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        
         <div class="container-xxl py-5" id="tagApp">
            <div class="container">
                <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                    <h1 class="mb-3"><span class="text-primary">&num;{{tag}}</span> 태그 검색 결과</h1>
                </div>
                <div class="row g-4">
                    <div v-for="vo in tag_data" class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s">
                        <a class="cat-item d-block bg-light text-center rounded p-3" :href="'../musicfind/mvdetail.do?gnum='+vo.gnum">
                            <div class="rounded p-4">        
                                <div class="icon mb-3">
                                    <img class="img-fluid" :src="vo.image" alt="Icon">
                                </div>
                                <h6>{{vo.song}}</h6>
                                <span>{{vo.artist}}</span>
                            </div>
                        </a>
                    </div>
                </div>
                <div style="height:20px;"></div>
                <div class="text-center wow fadeInUp">
                	<a v-if="startPage>1" id="pageChange" @click="prev()">&laquo;</a>
					<a v-for="i in range(startPage,endPage)" :id="i==curpage?'currentpage':'pageChange'" @click="changePage(i)">{{i}}</a>
					<a v-if="endPage<totalpage" id="pageChange" @click="next()">&raquo;</a>
                </div>
            </div>
        </div>
     </div>
     <script>
     	let tagApp = Vue.createApp({
     		data(){
     			return{
     				tag:'${tag}',
     				tag_data:[],
     				curpage:1,
     				totalpage:0,
     				endPage:0,
     				startPage:0,
     				tagName:''
     			}
     		},
     		mounted(){
     			this.dataRecv()
     		},
     		methods:{
     			dataRecv(){
	     			axios.get('../musicfind/tagFindData_vue.do',{
	     				params:{
	     					tag:this.tag,
	     					page:this.curpage
	     				}
	     			}).then(res=>{
	     				this.tag_data = res.data.list;
	     				this.curpage = res.data.curpage;
	     				this.totalpage = res.data.totalpage;
	     				this.endPage = res.data.endPage;
	     				this.startPage = res.data.startPage;
	     			})
     			},
				range(start,end){
					let arr = []
					let lang=end-start;
					for(let i=0;i<=lang;i++){
						arr[i] = start;
						start++;
					}
					
					return arr;
					
				},
				changePage(i){
					this.curpage = i;
					this.dataRecv()
				},
				next(){
					this.curpage = this.endPage+1
					this.dataRecv()
				},
				prev(){
					this.curpage = this.startPage-1
					this.dataRecv()
				}
     		}
     	}).mount('#tagApp')
     </script>
</body>
</html>