<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
	#mvon:hover{
		cursor:pointer;
		content: url('../resources/img/mvon.png')
	}
	#albumon:hover{
		cursor:pointer;
		content: url('../resources/img/albumon.png')
	}
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
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="principal"/>
	</sec:authorize>
	<div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
		<div class="container-fluid header bg-white p-0" id="chartApp">
			<div class="row g-0 align-items-start flex-column-reverse flex-md-row">
				<div class="col-md-9 p-5 mt-lg-5">
					<h1 class="display-5 animated fadeIn mb-4">${name }</h1>
					<c:if test="${cateNum=='2' || cateNum=='3'}">
						<div class="text-center" style="margin-bottom: 25px;">
							<a class="btn btn-primary" style="margin: 10px;" v-for="g in genre_data" @click="changeList(g.genre)">{{g.genre}}</a>
						</div>
					</c:if>
						<table class="table">
							<tr class="text-center">
								<th width="5%"></th>
								<th width="10%">순위</th>
								<th width="5%"></th>
								<th width="60%">곡정보</th>
								<th width="10%">담기</th>
								<th width="10%">뮤비</th>
							</tr>
							<tr v-for="vo in music_data">
								<td></td>
								<td class="text-center">
									<span style="font-weight: bold;">{{vo.grank}}</span>
									<br>
                    				<div v-if="vo.rank_change == '유지'">
                    					<span style="font-size:15px;">-</span>
                    				</div>
                    				<div v-if="vo.rank_change == '상승'">
                    					<span style="color: red;font-size: 15px;">▲ {{vo.rank_value }}</span>
                    				</div>
                    				<div v-if="vo.rank_change == '하강'">
                    					<span style="color: blue;font-size: 15px;">▼ {{vo.rank_value }}</span>
                    				</div>
                    				<div v-if="vo.rank_change == 'new'">
                    					<span style="font-size:15px;">new</span>
                    				</div>
								</td>
								<td>
									<img :src="vo.image" style="width:30px;height:30px;">
								</td>
								<td>
									<span style="font-weight: bold;color:black;">{{vo.song}}</span>
									<br>
									<span style="font-size:10px;color:gray;">{{vo.artist}} | {{vo.gtitle}}</span>
								</td>
								<td class="text-center" style="vertical-align: middle">
									<a :href="'../musicfind/mymusic.do?gnum='+vo.gnum" target="_blank"><img src="../resources/img/albumoff.png" id="albumon" @click="albumInsert(vo.gnum)"></a>
								</td>
								<td class="text-center" style="vertical-align: middle">
									<div v-if="vo.mv==='없음'">
										<img src="../resources/img/mvoff.png" style="opacity: 0.5">
									</div>
									<div v-if="vo.mv==='뮤비'">
										<a :href="'../musicfind/mvdetail.do?gnum='+vo.gnum"><img src="../resources/img/mvoff.png" id="mvon"></a>
									</div>
								</td>
							</tr>
						</table>
						<c:if test="${cateNum=='1' }">
							<div class="text-center inline">
								<a class="btn btn-primary" style="width:130px;margin: 10px;" @click="cate1(1,50)">1 ~ 50위</a>
								<a class="btn btn-primary" style="width:130px;margin: 10px;" @click="cate1(50,100)">50 ~ 100위</a>
								<a class="btn btn-primary" style="width:130px;margin: 10px;" @click="cate1(100,150)">100위 ~ 150위</a>
								<a class="btn btn-primary" style="width:130px;margin: 10px;" @click="cate1(150,200)">150위 ~ 200위</a>
							</div>
						</c:if>
						<c:if test="${cateNum=='2' || cateNum=='3'}">
							<div class="text-center">
								<a v-if="startPage>1" id="pageChange" @click="prev()">&laquo;</a>
								<a v-for="i in range(startPage,endPage)" :id="i==curpage?'currentpage':'pageChange'" @click="changePage(i)">{{i}}</a>
								<a v-if="endPage<totalpage" id="pageChange" @click="next()">&raquo;</a>
							</div>
						</c:if>
				</div>
				<div class="col-md-3 p-5 mt-lg-5">
					<div>
					  <div>
					  	<label for="tags">Tag 검색 </label>
					  </div>
					  <div>
						  <input type="text" v-model="taginput" @keydown.enter="tagFind()" id="tags" style="width:90%" placeholder="태그 검색">&nbsp;
					  </div>
					</div>
					<hr>
					<div>
						<span style="font-weight: bold;color:black;">오늘의 날씨</span>
						<div class="text-left">
							<img src= "http://openweathermap.org/img/wn/${ wVo.icon}.png"/>
							<span style="font-size:10px;color:gray;">${wVo.desc} | ${wVo.temp}°C</span>
						</div>
					</div>
					<hr>
					<div>
						<span style="font-weight: bold;color:black;font-size:12px;"><span style="font-weight: bold;color:#00B98E;font-size:12px;">${wVo.desc} </span>, 이런 음악은 어때?</span>
					</div>
					<div>
						<c:forEach var="mVo" items="${mVo }">
							<div style="margin:10px;">
								<img src="${mVo.link }" style="width:100%;height:150px;">
								<figcaption style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;font-size:10px;color:gray;">${mVo.title }</figcaption>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let chartApp = Vue.createApp({
			data(){
				return{
					music_data:[],
					curpage:1,
					totalpage:0,
					startPage:0,
					endPage:0,
					genre:'',
					curRank200start:1,
					curRank200end:50,
					cateNum:${cateNum},
					taginput:'',
					genre_data:[],
					user_id:'${principal.username}'
				}
			},
			mounted(){
				if(this.cateNum===1){
					this.cate1(this.curRank200start,this.curRank200end)
				}
				else if(this.cateNum===2){
					this.cateAll('가요')
				}
				else if(this.cateNum===3){
					this.cateAll('발라드')
				}
			},
			methods:{
				cate1(curRank200start,curRank200end){
					axios.get('../musicfind/musicfind_cate1_vue.do',{
						params:{
							start:curRank200start,
							end:curRank200end,
							cate:this.cateNum
						}
					}).then(res=>{
						this.music_data = res.data.list
					})
				},
				cateAll(genre){
					axios.get('../musicfind/musicfind_cateAll_vue.do',{
						params:{
							cate:this.cateNum,
							page:this.curpage,
							genre:genre
						}
					}).then(res=>{
						this.music_data = res.data.gmList;
						this.curpage = res.data.curpage;
						this.totalpage = res.data.totalpage;
						this.endPage = res.data.endPage;
						this.startPage = res.data.startPage;
						this.genre = res.data.genre;
					})
					
					axios.get('../musicfind/musicfind_gtype_vue.do',{
						params:{
							cate:this.cateNum
						}
					}).then(res=>{
						this.genre_data = res.data
					})
				},
				changeList(genre){
					this.curpage = 1;
					this.cateAll(genre)
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
					this.cateAll(this.genre)
				},
				next(){
					this.curpage = this.endPage+1
					this.cateAll(this.genre)
				},
				prev(){
					this.curpage = this.startPage-1
					this.cateAll(this.genre)
				},
				albumInsert(gnum){
					if(this.user_id==='' || this.user_id===null){
						$(':focus').blur(); 
						if(confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")){
							location.href="../member/sclogin.do";
						}
						else{
							location.href="../musicfind/list.do?cate="+this.cateNum;
						}
					}
					else{
						axios.get('../musicfind/mymusicInsert_vue.do',{
								params:{
									gnum:gnum,
									userId:this.user_id
								}
							}).then(res=>{
							})
					}
				},
				tagFind(){
					location.href="../musicfind/tagfind.do?tag="+this.taginput
				}
			}
		}).mount("#chartApp")
	</script>
</body>
</html>