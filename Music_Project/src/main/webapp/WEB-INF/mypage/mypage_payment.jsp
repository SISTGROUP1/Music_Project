<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
	#cdlpCartApp p{
		margin-bottom: 0;
	}
	table th{
		text-align: center;
	}
	tr.cartData{
		 border-bottom: 1px solid #eee;
		 text-align: center;
	}
	.paymentBtns{
		display: block;
		width: 90px;
		height: 30px;
		border-radius: 5px;
		font-size: 12px;
	}
	.buyBtn{
		border-color: #196ab3;
		background-color: #196ab3;
		color: white;
	}
	.paymentBtn{
		display: inline;
		width: 180px;
		height: 40px;
		font-size: 15px;
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
</style>
<link rel="stylesheet" href="../resources/css/pagination.css">
</head>
<body>
<div class="container-xxl bg-white p-0">
	<div class="container-xxl py-5">
		<div class="container">
			<div class="row g-5 align-items-start">
				<div class="col-lg-1 wow fadeIn">
				
				</div>
				<div class="col-lg-10 wow fadeIn" id="myPagePaymentApp">
					<div class="cate text-center">
					 	<a href="../mypage/main.do"><input type=button value="내정보" class="cate1"></a>
					 	<a href="../mypage/mywrite.do"><input type=button value="내가 쓴 글" class="cate2"></a>
					 	<a href="../mypage/showreserve.do"><input type=button value="예매 내역" class="cate2"></a>
					 	<a href="../cart/cart.do"><input type=button value="장바구니" class="cate2"></a>
					 	<a href="../mypage/payment.do"><input type=button value="구매내역" class="cate2"></a>
					</div>
					<div>
						<h5 class="text-primary mb-3">결제내역</h5>
						<hr style="background: #009472;height: 2px;border: 0;">
						<table width="100%">
							<tr style="background-color: #f8f8f8;;">
								<th width="55%" colspan="2">상품정보</th>
								<th width="15%">수량</th>
								<th width="10%">합계금액</th>
								<th width="10%">결제날짜</th>
							</tr>
							<tr v-for="vo in payment_list" class="cartData">
								<td style="padding: 5px 10px;">
									<img :src="vo.cvo.poster" style="width: 80px;height: 80px;">
								</td>
								<td style="padding-right: 10px;text-align: left;">
									<p>{{vo.cvo.subject}}</p>
								</td>
								<td>
									{{vo.amount}}
								</td>
								<td>
									<p>{{vo.price.toLocaleString()}}원</p>
								</td>
								<td>
									<p>{{vo.dbday}}</p>
								</td>
							</tr>
						</table>
					</div>
					<div style="height: 10px;"></div>
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
				<div class="col-lg-1 wow fadeIn">
				
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	let myPagePaymentApp=Vue.createApp({
		data(){
			return{
				payment_list:[],
				curpage:1,
				totalpage:0,
				startPage:0,
				endPage:0
			}
		},
		mounted(){
			this.dataRecv()
		},
		methods:{
			dataRecv(){
				axios.get('../mypage/payment_list.do',{
					params:{
						page:this.curpage
					}
				}).then(response=>{
					console.log(response.data)
					this.payment_list=response.data
				})
				
				axios.get('../mypage/payment_list_page.do',{
					params:{
						page:this.curpage
					}
				}).then(response=>{
					console.log(response.data)
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
			}
		}
	}).mount('#myPagePaymentApp')
</script>
</body>
</html>