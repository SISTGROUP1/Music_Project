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
		background-color: white;
		padding: 0 10px;
	}
	div.genre_a:hover{
		cursor: pointer;
		color: black;
	}
</style>
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
						<sub-genre :sub_genre_list="sub_genre_list_temp" :genre="genre" :style="{top: sub_genre_top,left: sub_genre_left,zIndex: '999',whiteSpace: 'nowrap',textOverflow: 'ellipsis',overflow: 'hidden'}" v-show="isShow" v-on:mouseleave="sub_genre_hide()"></sub-genre>
					</div>
				</div>
				<div class="col-lg-9 wow fadeIn" id="cdlpMainApp">
					<div class="row g-4">
	                	<!-- 발매일순으로 출력 -->
	                	<!-- 한 줄에 4개씩 출력 -->
	                    <div class="col-lg-3 col-sm-6 wow fadeInUp" v-for="vo in cdlp_list_recentM">
	                        <a class="cat-item d-block bg-light text-center p-3" href="">
	                               <div class="icon mb-3" style="border-radius: 0;">
	                                   <img :src="vo.poster" style="width: 100%">
	                               </div>
	                               <h6 style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">{{vo.subject}}</h6>
	                               <span>{{vo.dbday}}</span>
	                        </a>
	                    </div>
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
				isShow:false,
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
	
	let cdlpMainApp=Vue.createApp({
		data(){
			return{
				cdlp_list_recentM:[],
				recent_list_page:1
			}
		},
		mounted(){
			axios.get('../cdlp/list_recentM_vue.do',{
				params:{
					page:this.recent_list_page
				}
			}).then(response=>{
				console.log(response.data)
				this.cdlp_list_recentM=response.data
			})
		}
	}).mount('#cdlpMainApp')
</script>
</body>
</html>