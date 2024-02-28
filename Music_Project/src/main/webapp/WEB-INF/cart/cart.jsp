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
	.delBtn{
		margin-top: 4px;
		height: 20px;
		background-color: white;
		font-size: 11px;
	}
	.amountBtn{
		width: 25px;
		height: 30px;
		background-color: transparent;
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
</head>
<body>
<div class="container-xxl bg-white p-0">
	<div class="container-xxl py-5">
		<div class="container">
			<div class="row g-5 align-items-start">
				<div class="col-lg-1 wow fadeIn">
				
				</div>
				<div class="col-lg-10 wow fadeIn">
					<div class="cate text-center">
					 	<a href="../mypage/main.do"><input type=button value="내정보" class="cate1"></a>
					 	<a href="../mypage/mywrite.do"><input type=button value="내가 쓴 글" class="cate2"></a>
					 	<a href="../mypage/showreserve.do"><input type=button value="예매 내역" class="cate2"></a>
					 	<a href="../cart/cart.do"><input type=button value="장바구니" class="cate2"></a>
					 	<a href="../mypage/payment.do"><input type=button value="구매내역" class="cate2"></a>
					</div>
					<div id="cdlpCartApp">
						<h5 class="text-primary mb-3">장바구니</h5>
						<hr style="background: #009472;height: 2px;border: 0;">
						<table width="100%">
							<tr style="background-color: #f8f8f8;;">
								<th width="65%" colspan="3">상품정보</th>
								<th width="15%">수량</th>
								<th width="10%">상품금액</th>
								<th width="10%">주문</th>
							</tr>
							<tr v-if="cart_list.length===0">
								<th colspan="6" style="padding: 65px 0;">카트에 담긴 상품이 없습니다.</th>
							</tr>
							<tr v-if="cart_list.length>0" v-for="vo in cart_list" class="cartData">
								<td>
									<input type="checkbox" :value="vo.no" v-model="checked" @change="cartList(false)">
								</td>
								<td style="padding: 5px 10px;">
									<img :src="vo.cvo.poster" style="width: 80px;height: 80px;">
								</td>
								<td style="padding-right: 10px;text-align: left;">
									<p>{{vo.cvo.subject}}</p>
									<p>
										<del style="color: #eee;">{{vo.cvo.price.toLocaleString()}}원</del>&nbsp;
										{{vo.cvo.saleprice.toLocaleString()}}원&nbsp;
										({{vo.cvo.discount}}% 할인)
									</p>
								</td>
								<td>
									<input type="button" value="-" class="amountBtn" @click="amountDecrease(vo.clno)">
									<input type="text" :id="'amount_'+vo.clno" size="2" :value="vo.amount" disabled>
									<input type="button" value="+" class="amountBtn" @click="amountIncrease(vo.clno)">
								</td>
								<td>
									<p>{{(vo.cvo.saleprice*vo.amount).toLocaleString()}}원</p>
								</td>
								<td style="padding: 0px 7.5px;">
									<input type="button" value="주문하기" class="paymentBtns buyBtn" @click="buyNow()">
									<input type="button" value="삭제" class="paymentBtns delBtn" @click="del(vo.no)">
								</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: right;padding: 10px;">
									<span style="color: #a13b66;">최종 결제금액 <span style="font-size: 24px;">{{totalprice.toLocaleString()}}</span>원</span>
								</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: center;padding: 10px;">
									<input type="button" value="주문하기" class="paymentBtns buyBtn paymentBtn" @click="buyNow()">
									<input type="button" value="메인화면으로" class="paymentBtns buyBtn paymentBtn" style="margin-left: 10px;border-color: #ebebeb;background-color: white;color: #333;">
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="col-lg-1 wow fadeIn">
				
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	let cdlpCartApp=Vue.createApp({
		data(){
			return{
				cart_list:[],
				sessionId:'${sessionId}',
				totalprice:0,
				checked:[]
			}
		},
		mounted(){
			this.cartList(true)
		},
		methods:{
			cartList(check){
				console.log(this.checked)
				axios.get('../cart/list.do',{
					params:{
						userId:this.sessionId
					}
				}).then(response=>{
					this.cart_list=response.data
					
					if(check){
						for(let i=0;i<this.cart_list.length;i++){
							console.log(i)
							this.checked.push(this.cart_list[i].no)
						}						
					}
					
					this.totalprice=0
					for(let i=0;i<this.cart_list.length;i++){
						for(let j=0;j<this.checked.length;j++){
							if(this.cart_list[i].no===this.checked[j]){
								this.totalprice+=this.cart_list[i].cvo.saleprice*this.cart_list[i].amount								
							}	
						}
					}
				})
			},
			amountDecrease(no){
				let amount=$('#amount_'+no).val()
				if(amount==='1'){
					alert('1개 이상 구매 가능합니다.')
				}else{
					amount=amount-1
					$('#amount_'+no).val(amount)
					this.amountUpdate(no,amount)
				}
			},
			amountIncrease(no){
				let amount=$('#amount_'+no).val()
				amount=Number(amount)+1
				$('#amount_'+no).val(amount)
				this.amountUpdate(no,amount)
			},
			amountUpdate(no,amount){
				axios.get('../cart/update.do',{
					params:{
						clno:no,
						userId:this.sessionId,
						amount:amount
					}
				}).then(response=>{
					this.cartList(false)
				})
			},
			del(no){
				if(confirm('상품을 삭제하시겠습니까?')){
					axios.get('../cart/del.do',{
						params:{
							no:String(no)
						}
					}).then(response=>{
						this.cartList(false)
					})
				}
			},
			buyNow(){
				console.log('asd')
				if(this.checked.length===0){
					alert('주문할 상품을 선택하여 주세요. ')
				}else{
					location.href='../cart/payment.do?checked='+this.checked+'&type=0'
				}
			}
		}
	}).mount('#cdlpCartApp')
</script>
</body>
</html>