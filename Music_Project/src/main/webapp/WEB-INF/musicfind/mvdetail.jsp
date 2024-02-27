<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
	a#like{
		padding:0 10px;
		background-color: white;
		border: 1px solid #ccc;
		border-radius: 0 3px 3px 0;
		color:#666;
	}
	a#likeon{
		padding:0 10px;
		background-color: white;
		border: 1px solid #ccc;
		border-radius: 0 3px 3px 0;
		color:#666;
	}
	a#like:hover {
		cursor:pointer;
		border: 1px solid #666;
	}
	a#likeon:hover {
		cursor:pointer;
		border: 1px solid #666;
	}
	a#like>img{
		content: url("../resources/img/likeoff.png")
	}
	a#likeon>img{
		content: url("../resources/img/likeon.png")
	}
	#desc-cont{
		transition: height 1s;
	}
	#openLyrics:hover{
		cursor:pointer;
		border: 1px solid #666;
	}
	#openLyrics{
		padding:0 10px;
		color:#999;
		border:1px solid #c7c7c7;
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
		<div class="container-fluid header bg-white p-0" id="mvdetailApp">
			<div class="row g-0 align-items-center flex-column-reverse flex-md-row">
				<div class="col-md-12 p-5 mt-lg-5">
					<h1 class="display-5 animated fadeIn mb-4">{{artist_data.song}}</h1>
					<div class="text-center">
						<iframe :src="'https://www.youtube.com/embed/'+detail_data.link" width=70%; height=550px;></iframe>
					</div>
				</div>
				<div class="col-md-7 p-5 mt-lg-5">
						<h3>{{artist_data.song}}</h3>
						<h6>{{artist_data.artist}} | {{artist_data.gtitle}}</h6>
						<h6>{{detail_data.regdate}}</h6>
						<div>
							<a :href="'../musicfind/tagfind.do?tag='+i" v-for="i in tag" style="margin-right: 5px;">&num;{{i}}</a>
						</div>
					</div>
				<div class="col-md-5 p-5 mt-lg-5">
					<div style="text-align:right;">
						<a id="like" class="like" @click="likeChange()"><img> 좋아요 {{allLike}}</a>
					</div>
				</div>
				<div class="col-md-12 p-5">
					<hr>
					<h6>가사/영상 정보</h6>
					<div id="desc-cont" style="overflow:hidden;height:100px;white-space: nowrap;">
						<pre>
							<p>{{lyrics}}</p>
						</pre>
					</div>
					<div style="text-align: right;pointer:cursor;">
						<a @click="openLyrics()" id="openLyrics">펼쳐보기</a>
					</div>
				</div>
				<div class="col-md-12 p-5">
					<hr>
					<h6>댓글</h6>
					<table class="table">
						<tr>
							<th width=90%>
								<textarea id="commentArea" style="width:100%;height:80px;" placeholder="명예훼손, 개인정보 유출, 인격권 침해, 허위사실 유포 등은 이용약관 및 관련법률에 의해 제재를 받을 수 있습니다.건전한 댓글문화 정착을 위해 이용에 주의를 부탁드립니다." v-model="commentArea" @click="LoginCheck()"></textarea>
							</th>
							<td width=10%>
								<input type="button" value="댓글 등록" style="border:1px solid #0096FF;background-color: #0096FF;color:white;height:80px;font-weight: bold" @click="commentInsert()">
							</td>
						</tr>
					</table>
					<table class="table">
						<tr v-for="vo in comment_list">
							<td width=5%>
								<img src="https://image.genie.co.kr/imageg/web/common/blank.gif" style="width:40.6px;height:40.6px;"/>
							</td>
							<td width=95%>
								<table style="width:100%">
									<tr>
										<td>
											<div style="float:left;margin-bottom: 5px;">
												{{vo.userId}} | {{vo.dbday}}
											</div>
											<div style="text-align:right;" v-if="vo.userId==user_id">
												<a style="border: 1px solid #666;cursor: pointer;padding:0 10px;margin-right:5px;text-align:right" :id="'subreply'+vo.no" @click="subreplyShow(vo.no)">댓글</a>
												<a style="border: 1px solid #666;cursor: pointer;padding:0 10px;margin-right:5px;text-align:right" :id="'comment_find'+vo.no" @click="commentChange(vo.no)">수정</a>
												<a style="border: 1px solid #666;cursor: pointer;padding:0 10px;margin-right:5px;text-align:right" @click="commentDelete(vo.no)">삭제</a>
											</div>
											<div style="text-align:right;" v-if="vo.userId!=user_id && user_id!==''">
												<a style="border: 1px solid #666;cursor: pointer;padding:0 10px;margin-right:5px;text-align:right" :id="'subreply'+vo.no" @click="subreplyShow(vo.no)">댓글</a>
											</div>
										</td>
									</tr>
									<tr>
										<td width=80%>
											<div :id="'comment_'+vo.no">
												<pre>{{vo.msg}}</pre>
											</div>
											<div :id="'comment_change'+vo.no" style="display:none;">
												<textarea :id="'pre_msg'+vo.no" style="width:80%;height:80px;float:left;"></textarea>&nbsp;&nbsp;
												<input type="button" value="댓글 수정" style="border:1px solid #0096FF;background-color: #0096FF;color:white;height:80px;font-weight: bold;" @click="commentreWrite(vo.no)">
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<input :id="'AllSubreplyOn'+vo.no" type="button" style="background-color: #00B98E;color:white;border:2px solid #00B98E;border-radius: 5px;" value="댓글 더보기" @click="AllSubreplyOn(vo.no)">
										</td>
									</tr>
									<tr>
										<td :id="'subComment_open'+vo.no" style="display:none;">
											<textarea :id="'subComment_'+vo.no" style="width:80%;height:80px;float:left;"></textarea>&nbsp;&nbsp;
											<input type="button" value="댓글 달기" style="border:1px solid #0096FF;background-color: #0096FF;color:white;height:80px;font-weight: bold;" @click="commentsubReplyInsert(vo.no)">
										</td>
									</tr>
									<tr :id="'showAllsubReply'+vo.no">
										<td>
											<div v-for="svo in data_list">
												<div v-if="svo.no===vo.no">
													<hr style="margin:3px 0">
													<div style="font-size:10px;color:gray;">
														{{svo.userId}}|{{svo.dbday}}&nbsp;&nbsp;&nbsp;<a v-if="user_id===svo.userId" style="border: 1px solid #666;font-size:10px;cursor: pointer;padding:0 10px;margin-right:5px;text-align:right" @click="subReplyDelete(svo.sno,vo.no)">삭제</a>
													</div>
													<div style="font-size:10px;color:gray;">
														{{svo.msg}}
													</div>
												</div>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<div style="height:20px;"></div>
	                <div class="text-center wow fadeInUp">
	                	<a v-if="startPage>1" id="pageChange" @click="prev()">&laquo;</a>
						<a v-for="i in range(startPage,endPage)" :id="i==curpage?'currentpage':'pageChange'" @click="changePage(i)">{{i}}</a>
						<a v-if="endPage<totalpage" id="pageChange" @click="next()">&raquo;</a>
	                </div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let mvdetailApp = Vue.createApp({
			data(){
				return {
					detail_data:{},
					gnum:${gnum},
					artist_data:{},
					tag:[],
					lyrics:"",
					height:'100px',
					user_id:'${principal.username}',
					allLike:0,
					nowLike:0,
					curpage:1,
					totalpage:0,
					startPage:0,
					endPage:0,
					commentArea:'',
					text_change:'',
					comment_list:[],
					data_list:[],
					temp_no:0
				}
			},
			mounted(){
				this.data_recv()
			},
			methods:{
				LoginCheck(){
					if(this.user_id==='' || this.user_id===null){
						$(':focus').blur(); 
						if(confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")){
							location.href="../member/sclogin.do";
						}
					}
				},
				commentInsert(){
					if(this.user_id==='' || this.user_id===null){
						if(confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")){
							location.href="../member/sclogin.do";
						}
					}
					else{
						let comment = this.commentArea;
						if(comment.trim()===''){
							$('#commentArea').focus();
							return;
						}
						
						axios.get('../musicfind/mvdetailInsert_vue.do',{
							params:{
								id:this.user_id,
								comment:comment,
								fno:this.gnum
							}
						}).then(res=>{
							this.commentArea = '';
							$(':focus').blur();
							this.data_recv();
						})
						
					}
				},
				openLyrics(){
					if($('#openLyrics').text() === '펼쳐보기'){
						let height = $('#desc-cont p').height();
						$('#desc-cont').css('height',height);
						$('#openLyrics').text('닫기');
					}
					else{
						$('#desc-cont').css('height','100');
						$('#openLyrics').text('펼쳐보기');
					}
				},
				data_recv(){
					axios.get('../musicfind/mvdetailfind.do',{
						params:{
							gnum:this.gnum,
							page:this.curpage
						}
					}).then(res=>{
						this.detail_data = res.data.vo
						
						if(res.data.nowLike === 1){
							document.querySelector('.like').id ='likeon'
						}
						else{
							document.querySelector('.like').id = 'like'
						}
						
						if(res.data.vo.tag.split(",").length!=0){
							for(let i = 0;i<res.data.vo.tag.split(",").length;i++){
								this.tag[i] = res.data.vo.tag.split(",")[i].replace("#","");	
							}
						}
						if(res.data.vo.lyric.split("\t").length!=0){
							this.lyrics = res.data.vo.lyric.replaceAll("\t","\n");
						}
						
						this.allLike = res.data.allLike;
						this.nowLike = res.data.nowLike;
						this.curpage = res.data.curpage;
						this.totalpage = res.data.totalpage;
						this.startPage = res.data.startPage;
						this.endPage = res.data.endPage;
						this.comment_list = res.data.Rvo;
						
					})
					
					axios.get('../musicfind/mvArtistDetail_vue.do',{
						params:{
							gnum:this.gnum
						}
					}).then(res=>{
						this.artist_data = res.data;
					})
				},
				likeChange(){
					if(this.user_id==='' || this.user_id===null){
						if(confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")){
							location.href="../member/sclogin.do";
						}
					}
					else{
						axios.get('../musicfind/likeChange_vue.do',{
							params:{
								id:this.user_id,
								gnum:this.gnum,
								nowLike:this.nowLike
							}
						}).then(res=>{
							this.nowLike = res.data.nowLike;
							this.allLike = res.data.AllLike;
							if(res.data.nowLike === 1){
								document.querySelector('.like').id ='likeon'
							}
							else{
								document.querySelector('.like').id = 'like'
							}
						})
					}
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
					this.data_recv()
				},
				next(){
					this.curpage = this.endPage+1
					this.data_recv()
				},
				prev(){
					this.curpage = this.startPage-1
					this.data_recv()
				},
				commentDelete(no){
					axios.get('../musicfind/CommentDelete_vue.do',{
						params:{
							no:no
						}
					}).then(res=>{
						this.data_recv()
					})
				},
				commentChange(no){
					let btn_text = $('#comment_find'+no).text();
					if(btn_text==='수정'){
						axios.get('../musicfind/BringMsg_vue.do',{
							params:{
								no:no
							}
						}).then(res=>{
							this.pre_msg = res.data;
							$('#pre_msg'+no).html(this.pre_msg);
							$('#comment_find'+no).text('취소');
							$('#comment_'+no).hide();
							$('#comment_change'+no).show();
						})
					}
					else{
						$('#comment_find'+no).text('수정');
						$('#comment_'+no).show();
						$('#comment_change'+no).hide();
					}
				},
				commentreWrite(no){
					
					let comment = $('#pre_msg'+no).val();
					axios.get('../musicfind/CommentChange_vue.do',{
						params:{
							no:no,
							comment:comment
						}
					}).then(res=>{
						$('#comment_find'+no).text('수정');
						$('#comment_'+no).show();
						$('#comment_change'+no).hide();
						this.data_recv()
					})
				},
				subreplyShow(no){
					let temp = $('#subreply'+no).text();
					if(temp === '댓글'){
						$('#subComment_open'+no).show();
						$('#subreply'+no).text('취소');
					}
					else{
						$('#subreply'+no).text('댓글');
						$('#subComment_open'+no).hide();
					}
				},
				commentsubReplyInsert(no){
					let msg = $('#subComment_'+no).val();
					if(msg.trim()===''){
						$('#subComment_'+no).focus();
						return;
					}
					axios.get('../musicfind/CommentsubReplyInsert_vue.do',{
						params:{
							no:no,
							userId:this.user_id,
							typeno:0,
							fno:this.gnum,
							msg:msg
						}
					}).then(res=>{
						$('#subreply'+no).text('댓글');
						$('#subComment_open'+no).hide();
						$('#subComment_'+no).val('');
						this.AllsubreplyData(no);
						$('#showAllsubReply'+no).hide();
					})
				},
				AllsubreplyData(no){
					axios.get('../musicfind/subreplyAllSelect_vue.do',{
						params:{
							no:no,
							fno:this.gnum,
							typeno:0
						}
					}).then(res=>{
						this.data_list = res.data;
					})
				},
				AllSubreplyOn(no){
					if(this.temp_no===0){
						this.temp_no=no;
					}
					if($('#AllSubreplyOn'+no).val()==='댓글 더보기'){
						if(this.temp_no===no){
							this.AllsubreplyData(no);
							$('#showAllsubReply'+no).show();
							$('#AllSubreplyOn'+no).val("댓글 닫기");
						}
						else{
							$('#showAllsubReply'+this.temp_no).hide();
							$('#AllSubreplyOn'+this.temp_no).val("댓글 더보기");
							this.AllsubreplyData(no);
							$('#showAllsubReply'+no).show();
							$('#AllSubreplyOn'+no).val("댓글 닫기");
							this.temp_no=no;
						}
					}
					else{
						$('#showAllsubReply'+no).hide();
						$('#AllSubreplyOn'+no).val("댓글 더보기");
					}
				},
				subReplyDelete(sno,no){
					axios.get('../musicfind/subreplyDelete_vue.do',{
						params:{
							sno:sno
						}
					}).then(res=>{
						this.AllsubreplyData(no);
					})
				}
			}
		}).mount("#mvdetailApp")
	</script>
</body>
</html>