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
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
	div#cdlpDetailApp p{
		margin-bottom: 0;
	}
	span.review_btns{
		padding: 2px 5px;
		border: 1px solid #fff;
		border-radius: 3px;
		cursor: pointer;
		margin-right: 5px;
	}
	img.star{
		width: 15px;
		height: 15px;
	}
	div.reviewLayout{
		background-color: #e3e3e3;
		padding: 20px;
		width: 100%;
	}
	div.noreview{
		text-align: center;
		padding: 50px 0
	}
</style>
<link rel="stylesheet" href="../resources/css/pagination.css">
</head>
<body>
<div class="container-xxl bg-white p-0">
	<div class="container-xxl py-5">
		<div class="container">
			<div class="row g-5 align-items-start" id="cdlpDetailApp">
				<div class="col-lg-10 wow fadeIn">
					<div class="row g-4">
						<div class="col-lg-5 wow fadeIn">
							<img :src="cdlp_detail.poster" style="width: 100%;">
						</div>
						<div class="col-lg-7 wow fadeIn">
							<div class="mb-4">
								<!-- 제목,가수명,출판사,발매일,별점,리뷰건수 -->
								<h5 class="text-primary mb-3" style="font-size: 1.4rem;">{{cdlp_detail.subject}}</h5>
								<p>{{cdlp_detail.artist}} 노래 | {{cdlp_detail.publisher}} | {{cdlp_detail.dbday}}</p>
								<p v-if="cdlp_detail.score===0">첫번째 리뷰어가 되어주세요.</p>	
								<p v-if="cdlp_detail.score>0">
									<div v-for="index in 5" style="float: left;">
										<span v-if="index>=(cdlp_detail.score/2)+1">
											<img src="../resources/img/star_zero.png" class="star" style="cursor: pointer;">
										</span>
										<span v-if="index<(cdlp_detail.score/2)+1">
											<img src="../resources/img/star_one.png" class="star" style="cursor: pointer;">
										</span>
									</div>
									<span style="font-size: 20px;font-weight: bold;margin-left: 5px;">{{cdlp_detail.score}}</span>
								</p>
								<hr>					
							</div>
							<div class="mb-4">
								<div class="row g-4">
									<div class="col-lg-12 wow">
										<p>판매가&nbsp;&nbsp;&nbsp; {{cdlp_detail_price.toLocaleString()}}원</p>
										<p>할인가&nbsp;&nbsp;&nbsp; <span style="color: #ff6666;"><span style="font-weight: bold;"><span style="font-size: 1.4rem;">{{cdlp_detail_saleprice.toLocaleString()}}</span>원</span>({{cdlp_detail.discount}}% 할인)</span></p>
									</div>
								</div>
								<hr>
							</div>
							<div class="mb-4">
								<div class="row g-4">
									<div class="col-lg-12 wow">
										<div style="padding: 15px 30px;">
											<p v-if="inventory!==0" style="color: black;font-weight: bold;margin-bottom: 16px;">판매중</p>
											<p v-if="inventory===0" style="color: black;font-weight: bold;margin-bottom: 16px;">품절</p>
											<table v-if="inventory!==0">
												<tr>
													<td>수량</td>
													<td style="padding-left: 16px;">
														<input type="button" value="-" @click="amountDecrease()">
														<input type="text" ref="amount" size="2" value="1">
														<input type="button" value="+" @click="amountIncrease()">
													</td>
													<td style="padding-left: 16px;">
														<input type="button" value="카트에 넣기" @click="addCart(cdlp_detail.no)">
													</td>
													<td style="padding-left: 16px;">
														<input type="button" value="바로 구매" @click="buyNow(cdlp_detail.no)">
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<div class="row g-4">
						<div class="col-lg-12 wow fadeIn">
							<h5 class="text-dark mb-3" style="font-size: 1.4rem;">음반소개</h5>
							<p v-html="cdlp_detail.content" style="margin-bottom: 16px;"></p>
							<h5 class="text-dark mb-3" style="font-size: 1.4rem;">상세이미지</h5>
							<img :src="vo" v-for="vo in cdlp_images" style="width: 100%;">
						</div>
					</div>
					<div style="height: 20px;"></div>
					<div class="row g-4">
						<div class="col-lg-12 wow fadeIn">
							<h5 class="text-dark mb-3" style="font-size: 1.4rem;">회원리뷰({{reply_cnt}}건)</h5>
							<div class="reviewLayout">
								<span style="float: left;font-weight: bold;margin-right: 10px;">평점</span>
								<div v-for="index in 5" @click="star(index)" style="float: left;">
									<span v-if="index>=score">
										<img src="../resources/img/star_zero.png" class="star" style="cursor: pointer;">
									</span>
									<span v-if="index<score">
										<img src="../resources/img/star_one.png" class="star" style="cursor: pointer;">
									</span>
								</div>
								<div style="clear: both;"></div>
								<div style="margin-top: 20px;">
									<textarea rows="2" cols="89" style="float: left;resize: none;" @click="isLogin()" ref="msg" v-model="msg"></textarea>
									<input type="button" value="리뷰 등록" style="width: 160px;height: 70px;margin-left: 10px;" @click="replyInsert()">
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<div class="row g-4" v-if="reply_cnt===0">
						<div class="col-lg-12 wow fadeIn">
							<div class="reviewLayout noreview">
								<p style="color: black;font-weight: bold;">등록된 리뷰가 없습니다.</p>
								<p style="font-size: 0.9rem;margin-top: 10px;">첫번째 리뷰를 남겨주세요.</p>
							</div>
						</div>
					</div>
					<div class="row g-4" v-if="reply_cnt>0">
						<div class="col-lg-12 wow fadeIn">
							<div class="reviewLayout" style="padding-top: 10px;padding-bottom: 0;" v-for="reply in reply_list">
								<div v-for="index in 5" style="float: left;">
									<span v-if="index-1>=(reply.score/2)">
										<img src="../resources/img/star_zero.png" class="star">
									</span>
									<span v-if="index-1<(reply.score/2)">
										<img src="../resources/img/star_one.png" class="star">
									</span>
								</div>
								&nbsp;|&nbsp;{{reply.userId}}
								&nbsp;|&nbsp;{{reply.dbday}}
								<pre style="padding: 10px 0;margin-bottom: 0;" :id="'review_'+reply.no">{{reply.msg}}</pre>
								<p style="padding: 10px 0;display: none;" :id="'updateForm_'+reply.no">
									<textarea rows="2" cols="89" style="float: left;resize: none;" :id="'updateMsg_'+reply.no">{{reply.msg}}</textarea>
									<input type="button" value="리뷰 수정" style="width: 160px;height: 70px;margin-left: 10px;" @click="replyUpdate(reply.no)"></p>
								<p>
									<span v-if="reply.userId!==sessionId" class="review_btns" @click="likeBtn(reply.no)">
										<img :src="isLiked(reply.no)?'../resources/img/heart2.png':'../resources/img/heart1.png'">&nbsp;{{likecount(reply.no)}}
									</span>
									<span v-if="reply.userId===sessionId" class="review_btns" :id="'updateBtn_'+reply.no" @click="replyUpdateForm(reply.no)">수정</span>
									<span v-if="reply.userId===sessionId" class="review_btns" @click="replyDelete(reply.no)">삭제</span>
								</p>
								<hr style="margin-top: 16px;margin-bottom: 0">
							</div>
						</div>
					</div>
					<div style="height: 10px;"></div>
					<div class="row g-4" v-if="reply_cnt>0">
						<div class="col-lg-12 wow fadeIn">
							<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
			                    <p class="mb-3">
			                    	<ul class="pagination" style="margin: 0;">
			                           	<li v-if="startPage>1"><a class="link" @click="firstPage()">&laquo;</a></li>
			                           	<li v-if="startPage>1"><a class="link" @click="prev()">&lt;</a></li>
			                           	<li v-for="i in range(startPage,endPage)" :class="i===review_page?'active':''"><a class="link" @click="pageChange(i)">{{i}}</a></li>
			                           	<li v-if="endPage<totalpage"><a class="link" @click="next()">&gt;</a></li>
			                           	<li v-if="endPage<totalpage"><a class="link" @click="lastPage()">&raquo;</a></li>
		                            </ul>
			                	</p>
			                </div>
						</div>
					</div>
				</div>
				<div class="col-lg-2 wow fadeIn">
				
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	let cdlpDetailApp=Vue.createApp({
		data(){
			return{
				no:${no},
				cdlp_detail:{},
				cdlp_detail_price:0,
				cdlp_detail_saleprice:0,
				cdlp_images:[],
				cdlp_content:'',
				score:0,
				sessionId:'',
				msg:'',
				reply_list:[],
				reply_cnt:0,
				review_page:1,
				startPage:0,
				endPage:0,
				totalpage:0,
				isShow:true,
				like_list:[],
				cdlp_amount:0,
				checked:[],
				check:''
			}
		},
		mounted(){
			this.dataRecv()
		},
		methods:{
			dataRecv(){
				axios.get('../cdlp/detail_vue.do',{
					params:{
						no:this.no
					}
				}).then(response=>{
					console.log(response.data)
					this.cdlp_detail=response.data.cdlp_detail
					this.cdlp_detail_price=response.data.cdlp_detail.price
					this.cdlp_detail_saleprice=response.data.cdlp_detail.saleprice
					this.cdlp_content=response.data.cdlp_detail.content
					this.cdlp_images=response.data.cdlp_detail.image.split(',')
					this.sessionId=response.data.sessionId
				})
				this.replyList()
				this.cdlp_amount=this.$refs.amount.value
			},
			amountDecrease(){
				let amount=this.$refs.amount.value
				if(amount==='1'){
					alert('1개 이상 구매 가능합니다.')
				}else{
					amount=Number(amount)-1
					this.$refs.amount.value=String(amount)
				}
				this.cdlp_amount=this.$refs.amount.value=String(amount)
			},
			amountIncrease(){
				let amount=this.$refs.amount.value
				amount=Number(amount)+1
				this.$refs.amount.value=String(amount)
				this.cdlp_amount=this.$refs.amount.value=String(amount)
			},
			star(index){
				this.score=index+1
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
					return true
				}
			},
			replyInsert(){
				if(this.isLogin()){
					if(this.msg===''){
						this.$refs.msg.focus()
						return
					}
					axios.get('../reply/reply_insert.do',{
						params:{
							fno:this.no,
							msg:this.msg,
							typeno:1,
							score:(this.score-1)*2,
							page:1
						}
					}).then(response=>{
						this.replyList()
						this.msg=''
						this.score=0
						this.dataRecv()
					})
				}
			},
			replyUpdateForm(no){
				if(this.isShow){
					this.isShow=false
					$('#review_'+no).hide()
					$('#updateForm_'+no).show()
					$('#updateBtn_'+no).text('취소')
				}else{
					this.isShow=true
					$('#review_'+no).show()
					$('#updateForm_'+no).hide()
					$('#updateBtn_'+no).text('수정')
				}
			},
			replyUpdate(no){
				let msg=$('#updateMsg_'+no).val()
				if(msg===''){
					alert('리뷰를 작성해주시기 바랍니다.')
					$('#updateMsg_'+no).focus()
					return
				}
				
				axios.post('../reply/reply_update.do',null,{
					params:{
						no:no,
						msg:msg,
						fno:this.no,
						typeno:1,
						page:this.review_page
					}
				}).then(response=>{
					this.replyList()
					this.isShow=false
					this.replyUpdateForm(no)
				})
			},
			replyDelete(no){
				let result=confirm('리뷰를 삭제하시겠습니까?')
				if(result){
					axios.get('../reply/reply_delete.do',{
						params:{
							no:no,
							typeno:1,
							fno:this.no,
							page:1
						}
					}).then(response=>{
						this.replyList()
						this.dataRecv()
					})
				}else{
					return
				}
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
			replyList(){
				axios.get('../reply/reply_list.do',{
					params:{
						fno:this.no,
						typeno:1,
						page:this.review_page
					}
				}).then(response=>{
					this.reply_list=response.data.reply_list
					this.reply_cnt=response.data.reply_cnt
					this.like_list=response.data.like_list
					
					console.log(this.reply_list)
					console.log(this.like_list)
				})
				
				axios.get('../reply/reply_page.do',{
					params:{
						fno:this.no,
						typeno:1,
						page:this.review_page
					}
				}).then(response=>{
					this.review_page=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
				})
			},
			pageChange(page){
				this.review_page=page
				this.replyList()
			},
			prev(){
				this.review_page=this.startPage-1
				this.replyList()
			},
			next(){
				this.review_page=this.endPage+1
				this.replyList()
			},
			firstPage(){
				this.review_page=1
				this.replyList()
			},
			lastPage(){
				this.review_page=this.totalpage
				this.replyList()
			},
			isLiked(no){
				console.log(this.like_list.some(obj=>obj.pno===no))
				console.log(this.like_list.some(obj=>obj.userId===this.sessionId))
				return this.like_list.some(obj=>obj.pno===no) && this.like_list.some(obj=>obj.userId===this.sessionId)
			},
			likecount(no){
				return this.like_list.filter(item=>item.pno===no).length
			},
			likeBtn(no){
				let type='insert'
				if(this.isLogin()){
					if(this.isLiked(no)){
						type='delete'
					}
					axios.get('../reply/reply_like.do',{
						params:{
							pno:no,
							fno:this.no,
							typeno:1,
							type:type
						}
					}).then(response=>{
						this.replyList()
					})
				}
			},
			addCart(no){
				if(this.isLogin()){
					// 상품을 Cart 테이블에 추가하고 cdlp_cart로 넘어간다
					axios.get('../cart/insert.do',{
						params:{
							clno:no,
							amount:this.cdlp_amount,
							userId:this.sessionId
						}
					}).then(response=>{
						if(confirm('상품이 카트에 담겼습니다.\n바로 확인하시겠습니까?')){
							location.href='../cart/cart.do'	
						}
					})
				}
			},
			buyNow(no){
				if(this.isLogin()){
					this.checked.push(this.cdlp_detail.no)
					for(let i=0;i<this.checked.length;i++){
						this.check+=this.checked[i]+','
					}
					this.check=this.check.substring(0,this.check.lastIndexOf(','))
					axios.get('../cart/insert.do',{
						params:{
							checked:this.check,
							amount:this.cdlp_amount,
							userId:this.sessionId
						}
					}).then(response=>{
						console.log('insert 완료')
						location.href='../cart/payment.do?check='+this.check
					})
					
				}
			}
		}
	}).mount('#cdlpDetailApp')
</script>
</body>
</html>