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
<!-- 결제 API -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략 가능
	IMP.init("imp43344546"); // 예: imp00000000
	function requestPay() {
	  // IMP.request_pay(param, callback) 결제창 호출
		IMP.request_pay({
		    pg : 'html5_inicis', // version 1.1.0부터 지원.
		    
		        /*
		            'kakao':카카오페이,
		            'inicis':이니시스, 'html5_inicis':이니시스(웹표준결제),
		            'nice':나이스,
		            'jtnet':jtnet,
		            'uplus':LG유플러스
		        */
		    pay_method : 'card', // 'card' : 신용카드 | 'trans' : 실시간계좌이체 | 'vbank' : 가상계좌 | 'phone' : 휴대폰소액결제
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : $('#subject').val(),
		    amount : String($('#price').val()),
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		    app_scheme : 'iamporttest' //in app browser결제에서만 사용 
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        /* 닫기 버튼 눌렀을시 결제 */
		       	$.ajax({
		       		type: 'POST',
		       		url: '../cart/buy.do',
		       		data: {"nos":String($('#nos').val()),"type":String($('#type').val())},
		       		success:function(){
		       			alert('구매 완료')
		       			location.href='../mypage/payment.do'
		       		}
		       	})
		    }
		});
	}
	$(function() {
		$('#buy').click(function() {
			requestPay()
		})
	})
</script>
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
					<div id="cdlpPaymentApp">
						<h5 class="text-primary mb-3">결제하기</h5>
						<hr style="background: #009472;height: 2px;border: 0;">
						<table width="100%">
							<tr style="background-color: #f8f8f8;;">
								<th width="65%" colspan="2">상품정보</th>
								<th width="15%">수량</th>
								<th width="10%">합계금액</th>
							</tr>
							<tr v-for="vo in cart_list" class="cartData">
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
									{{vo.amount}}
								</td>
								<td>
									<p>{{(vo.cvo.saleprice*vo.amount).toLocaleString()}}원</p>
								</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: right;padding: 10px;">
									<span style="color: #a13b66;">최종 결제금액 <span style="font-size: 24px;">{{totalprice.toLocaleString()}}</span>원</span>
								</td>
							</tr>
							<tr>
								<th>배송지</th>
								<td colspan="3">배송지 : ${sessionScope.address }</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: right;padding: 10px;">
									<input type="button" value="결제하기" class="paymentBtns buyBtn paymentBtn" id="buy">
									<input type="hidden" id="subject" v-model="subjects">
									<input type="hidden" id="price" v-model="totalprice">
									<input type="hidden" id="nos" v-model="nos">
									<input type="hidden" id="type" v-model="type">
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
	let cdlpPaymentApp=Vue.createApp({
		data(){
			return{
				checked:'${checked}',
				cart_list:[],
				totalprice:0,
				subjects:'',
				nos:'',
				type:'${type}'
			}
		},
		mounted(){
			console.log('payment jsp로 넘어온 값 : '+this.checked+', '+this.type)
			if(this.type==='' || this.type===null) this.type="0"
			axios.get('../cart/payment_list.do',{
				params:{
					checked:this.checked,
					type:this.type
				}
			}).then(response=>{
				this.cart_list=response.data
				console.log(response.data)
				
				for(let i=0;i<this.cart_list.length;i++){
					this.totalprice+=this.cart_list[i].cvo.saleprice*this.cart_list[i].amount
					this.subjects+=this.cart_list[i].cvo.subject+','
					if(this.type==='0'){
						this.nos+=this.cart_list[i].no+','	
					}else{
						this.nos+=this.cart_list[i].clno+','						
					}
				}
				this.subjects=this.subjects.substring(0,this.subjects.lastIndexOf(','))
				this.nos=this.nos.substring(0,this.nos.lastIndexOf(','))
				console.log('구매하는 상품번호 : '+this.nos)
			})
		}
	}).mount('#cdlpPaymentApp')
</script>
</body>
</html>