<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
	div.sub_genre{
		position: absolute;
		width: 170px;
		background-color: white;
		padding: 0 10px;
	}
	div.genre_a:hover{
		cursor: pointer;
		color: black;
	}
	div.p-3 p{
		margin-bottom: 0;
	}
	ul.pagination a.link:hover,small.paymentBtns:hover{
		cursor: pointer;
	}
</style>
<link rel="stylesheet" href="../resources/css/pagination.css">
</head>
<body>
<div class="container-xxl bg-white p-0">
	<div class="container-xxl py-5">
		<div class="container">
			<div class="row g-5 align-items-start">
				<div class="col-lg-2 wow fadeIn" id="cdlpCateApp">
					<div class="panel panel-info" style="position: relative;">
						<div class="panel-heading">CD/LP</div>
						<div class="panel-body genre_a" v-for="(genres,index) in genre_list" v-on:mouseover="sub_genre_show(index)">
							<a :href="'../cdlp/list.do?genre='+genres">{{genres}}</a>
						</div>
						<sub-genre :sub_genre_list="sub_genre_list_temp" :genre="genre" :style="{top: sub_genre_top,left: sub_genre_left,zIndex: '999'}" v-show="isShow" v-on:mouseleave="sub_genre_hide()"></sub-genre>
					</div>
				</div>
				<div class="col-lg-9 wow fadeIn" id="cdlpListApp">
					<h5 class="text-primary mb-3">{{recv_genre}} <span v-if="recv_sub_genre!==''">&gt; {{recv_sub_genre}}</span></h5>
					<hr style="background: #009472;height: 2px;border: 0;">
					<div class="row g-0 gx-5 align-items-end">
	                    <div class="col-lg-6">
	                        <div class="text-start mx-auto mb-5 wow slideInLeft" data-wow-delay="0.1s">
	                            <p>
	                            	<input type="button" value="카트에 넣기" @click="addCartChecked(true)">
									<input type="button" value="바로 구매" @click="buyNowChecked()">
	                            </p>
	                        </div>
	                    </div>
	                    <div class="col-lg-6 text-start text-lg-end wow slideInRight" data-wow-delay="0.1s">
	                        <ul class="nav nav-pills d-inline-flex justify-content-end mb-5">
	                            <li class="nav-item me-2">
	                                <a :class="listType===1?'btn btn-outline-primary active':'btn btn-outline-primary'" data-bs-toggle="pill" @click="listTypeChange(1)">신상품순</a>
	                            </li>
	                            <li class="nav-item me-2">
	                                <a :class="listType===2?'btn btn-outline-primary active':'btn btn-outline-primary'" data-bs-toggle="pill" @click="listTypeChange(2)">최저가순</a>
	                            </li>
	                            <li class="nav-item me-0">
	                                <a :class="listType===3?'btn btn-outline-primary active':'btn btn-outline-primary'" data-bs-toggle="pill" @click="listTypeChange(3)">최고가순</a>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
					<div class="tab-content">
	                    <div id="tab-1" class="tab-pane fade show p-0 active">
	                        <div class="row g-4">
	                        	<div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" v-for="vo in list_data">
	                                <div class="property-item rounded overflow-hidden">
	                                    <div class="position-relative overflow-hidden">
	                                        <a :href="'../cdlp/detail.do?no='+vo.no"><img class="img-fluid" :src="vo.poster" :title="vo.subject" style="width: 100%;height: 241.5px"></a>
	                                    </div>
	                                    <div class="p-3 pb-0">
	                                        <a class="d-block h5 mb-2" :href="'../cdlp/detail.do?no='+vo.no" :title="vo.subject" style="font-size: 1rem;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">{{vo.subject}}</a>
	                                        <p><span style="font-size: 1rem;font-weight: bold;">{{vo.saleprice.toLocaleString()}}</span>원&nbsp;({{vo.discount}}% 할인)</p>
	                                        <p style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">{{vo.artist}} 노래</p>
	                                        <p style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">{{vo.publisher}}</p>
	                                        <p><input type="checkbox" :value="vo.no" v-model="checked"></p>
	                                    </div>
	                                    <div class="d-flex border-top">
	                                        <small class="flex-fill text-center border-end py-2 paymentBtns" @click="addCart(vo.no)">카트에 넣기</small>
	                                        <small class="flex-fill text-center py-2 paymentBtns" @click="buyNow(vo.no)">바로 구매</small>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
	                    <p class="mb-3">
	                    	<ul class="pagination" style="margin: 0;">
	                           	<li v-if="startPage>1"><a class="link" @click="firstPage()">&laquo;</a></li>
	                           	<li v-if="startPage>1"><a class="link" @click="prev()">&lt;</a></li>
	                           	<li v-for="i in range(startPage,endPage)" :class="i===curpage?'active':''"><a class="link" @click="pageChange(i)">{{i}}</a></li>
	                           	<li v-if="endPage<totalpage"><a class="link" @click="next()">&gt;</a></li>
	                           	<li v-if="endPage<totalpage"><a class="link" @click="lastPage()">&raquo;</a></li>
                            </ul>
	                	</p>
	                </div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <script src="../resources/js/cdlpCateApp.js"></script> -->
<script>
	let sub_genre={
		props:['sub_genre_list','genre'],
		template:
			`
			<div class="panel panel-default sub_genre">
				<div class="panel-body" v-for="sub_genre in sub_genre_list">
					<a :href="'../cdlp/list.do?genre='+encodeURIComponent(genre)+'&sub_genre='+encodeURIComponent(sub_genre)">
						{{sub_genre}}
					</a>
				</div>
			</div>
			`
	}
	let cdlpCateApp=Vue.createApp({
		data(){
			return{
				genre_list:[],
				sub_genre_list:[],
				sub_genre_list_temp:[],
				sub_genre_top:'',
				sub_genre_left:'75px',
				genre:'',
				isShow:false
			}
		},
		mounted(){
			axios.get('../cdlp/cate_vue.do').then(response=>{
				for(let i=0;i<response.data.length;i++){
					if(i%5===0){
						if(this.genre_list.length<1){
							this.genre_list[0]=response.data[i].genre	
						}else{
							this.genre_list[this.genre_list.length]=response.data[i].genre
						}
					}
					this.sub_genre_list[i]=response.data[i].sub_genre
				}
				console.log(response.data)
			})
		},
		methods:{
			sub_genre_show(index){
				if(this.isShow){
					this.isShow=false
					this.sub_genre_list_temp=[]
				}
				this.isShow=true
				let top=(index+1)*24
				this.sub_genre_top=top+'px'
				let start=index*5
				let end=start+4
				for(let i=start;i<=end;i++){
					this.sub_genre_list_temp[this.sub_genre_list_temp.length]=this.sub_genre_list[i]
				}
				this.genre=this.genre_list[index]
			},
			sub_genre_hide(){
				this.isShow=false
				this.sub_genre_list_temp=[]
			}
		},
		components:{
			'sub-genre':sub_genre
		}
	}).mount('#cdlpCateApp')
	
	let cdlpListApp=Vue.createApp({
		data(){
			return{
				recv_genre:'${genre}',
				recv_sub_genre:'${sub_genre}',
				list_data:[],
				listType:1,
				curpage:1,
				totalpage:0,
				startPage:0,
				endPage:0,
				sessionId:'',
				checked:[],
				check:''
			}
		},
		mounted(){
			this.dataRecv()
		},
		methods:{
			dataRecv(){
				axios.get('../cdlp/list_sort_vue.do',{
					params:{
						page:this.curpage,
						genre:this.recv_genre,
						sub_genre:this.recv_sub_genre,
						listType:this.listType
					}
				}).then(response=>{
					console.log(response.data)
					this.list_data=response.data.list
					this.sessionId=response.data.sessionId
				})
				
				axios.get('../cdlp/list_page_vue.do',{
					params:{
						page:this.curpage,
						genre:this.recv_genre,
						sub_genre:this.recv_sub_genre
					}
				}).then(response=>{
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
				})
			},
			range(start,end){
				let arr=[]
				let length=end-start
				for(let i=0;i<=length;i++){
					arr[i]=start
					start++
				}
				return arr
			},
			pageChange(page){
				this.curpage=page
				this.dataRecv()
			},
			prev(){
				this.curpage=this.startPage-1
				this.dataRecv()
			},
			next(){
				this.curpage=this.endPage+1
				this.dataRecv()
			},
			firstPage(){
				this.curpage=1
				this.dataRecv()
			},
			lastPage(){
				this.curpage=this.totalpage
				this.dataRecv()
			},
			listTypeChange(listType){
				this.listType=listType
				this.curpage=1
				this.dataRecv()
			},
			isLogin(){
				if(this.sessionId===null || this.sessionId===''){
					let result=confirm('로그인이 필요합니다.\n로그인 하시겠습니까?')
					if(result){
						location.href='../member/sclogin.do'
					}else{
						return false
					}
				}else{
					console.log('로그인중')
					return true
				}
			},
			addCart(no){
				if(this.isLogin()){
					// 상품을 Cart 테이블에 추가하고 cdlp_cart로 넘어간다
					axios.get('../cart/insert.do',{
						params:{
							clno:no,
							amount:1,
							userId:this.sessionId
						}
					}).then(response=>{
						if(confirm('상품이 카트에 담겼습니다.\n바로 확인하시겠습니까?')){
							location.href='../cart/cart.do'	
						}
					})
				}
			},
			addCartChecked(type){
				if(this.checked.length===0) {
					alert('상품을 1개 이상 선택해주시기 바랍니다.')
				}else{
					for(let i=0;i<this.checked.length;i++){
						this.check+=this.checked[i]+','
					}
					this.check=this.check.substring(0,this.check.lastIndexOf(','))
					
					if(this.isLogin()){
						axios.get('../cart/insert.do',{
							params:{
								checked:this.check,
								amount:1,
								userId:this.sessionId
							}
						}).then(response=>{
							console.log(this.check)
							if(type){
								console.log('type은 TRUE')
								this.checked=[]
								this.check=''	
								if(confirm('상품이 카트에 담겼습니다.\n바로 확인하시겠습니까?')){
									location.href='../cart/cart.do'	
								}
							}
						})
					}
				}
			},
			buyNow(no){
				if(this.isLogin()){
					
				}
			},
			buyNowChecked(){
				console.log('1')
				if(this.checked.length===0) {
					alert('상품을 1개 이상 선택해주시기 바랍니다.')
				}else{
					for(let i=0;i<this.checked.length;i++){
						this.check+=this.checked[i]+','
					}
					this.check=this.check.substring(0,this.check.lastIndexOf(','))
					console.log('선택한 상품 : '+this.check)
					
					if(this.isLogin()){
						axios.get('../cart/insert.do',{
							params:{
								checked:this.check,
								amount:1,
								userId:this.sessionId
							}
						}).then(response=>{
							console.log('insert 완료')
							location.href='../cart/payment.do?check='+this.check
						})
						
					}
				}
			}
		}
	}).mount('#cdlpListApp')
</script>
</body>
</html>