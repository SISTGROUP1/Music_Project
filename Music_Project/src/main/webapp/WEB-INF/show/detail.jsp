<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
$(function() {
	  $("#review").click(function(event) {
		    event.preventDefault();
		    $("#info.active").removeClass("active"); // 이전에 클릭한 링크에서 clicked 클래스 제거
		    $(this).addClass("active"); // 현재 클릭한 링크에 clicked 클래스 추가
		  });
});
</script>
<style type="text/css">
  #info,#review{
    cursor:pointer;
  	font-size: large;
  	margin-left: 0.5%;
  	font-weight: bold;
  }
  #info:hover,#review:hover{
  	color: #26c49f;
  }
</style>
</head>
<body>
<div style="height: 100px"></div>
<div class="container-xxl bg-white p-0" id="showDetailApp" style="padding: 4% !important">
  <div v-if="show_detail.scate===1" style="margin-left: 2%">콘서트</div>
  <div v-if="show_detail.scate===2" style="margin-left: 2%">뮤지컬</div>
  <div v-if="show_detail.scate===3" style="margin-left: 2%">클래식</div>
<table class="table">
 <tr>
  <td>
    <h1 id="title" style="margin-left: 1%">{{show_detail.stitle}}</h1>
    <span style="margin-left: 1.4%">{{show_detail.sdate}}&nbsp;&nbsp;|&nbsp;&nbsp;{{show_detail.sloc}}</span>
  </td>
</tr>
</table>
<table class="table">
  <tr>
    <td width="35%" align="center" rowspan="4">
      <img :src="show_detail.sposter">
    </td>
  </tr>
  <tr>
    <td width="60%" style="margin-left: 5%">
      <a style="color:black;font-weight: bold">등급</a>
      <span id="price2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{show_detail.sgrade}}</span>
<div style="height: 30px"></div>
      <a style="color:black;font-weight: bold">관람시간</a>
      <span id="price2">&nbsp;&nbsp;&nbsp;{{show_detail.shour}}</span>
<div style="height: 30px"></div>
      <a style="color:black;font-weight: bold">출연</a>
      <span id="price2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{show_detail.sperformer}}</span>
<div style="height: 30px"></div>
      <a style="color:black;font-weight: bold">가격</a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../resources/img/seat.png">
<div style="height: 30px"></div>
      <div style="margin-top: 0px"><a class="btn btn-primary py-1 px-3 mt-1 wow fadeInUp" :href="'../show/reserve.do?sno='+show_detail.sno" data-wow-delay="0.1s" style="margin-left: 85%;">예매하기</a></div>
    </td>
  </tr>
  <tr>
    <td width="65%">
      <a style="color:black;font-weight: bold">공연시간 안내</a><br>
      <span id="price2">{{show_detail.stime}}</span>
<div style="height: 30px"></div>
      <a style="color:black;font-weight: bold">배송정보</a><br>
      <span id="price2">{{show_detail.sdelivery}}</span>
    </td>
  </tr>
  </table>
<div style="height: 30px"></div>
  </table>
<a @click="showInfo" id="info" style="font-size: x-large;margin-left: 41%;">상세정보&nbsp;|&nbsp;</a>
<a @click="showReview" id="review" style="font-size: x-large;">리뷰<small>({{reply_cnt}}건)</small></a>
<div style="height: 30px;"></div>
  <table class="table text-center" v-show="isShowInfo">
    <tr v-for="dp in sdeposter">
      <td style="padding: 0%;border-bottom-width: 0px">
        <img :src="dp" style="width: 80%;height: 80%">
      </td>
    </tr>
  </table>
<div style="height: 50px"></div>
  <table class="table" v-show="isShowloc1">
    <tr>
      <td>
        <h3 id="sloc" class="text-center"><i class="fa fa-map-marker" aria-hidden="true" style="color:#666565;margin-right: 5px"></i>{{show_detail.sloc}}</h3>
          <h6 class="text-center" style="color: #666565;background-color: ">{{show_detail.saddress}}&nbsp;&nbsp;|&nbsp;&nbsp;{{show_detail.sphone}}</h6>
      </td>
    </tr>
  </table>
  <div id="map"style="height:500px;width: 920.317px;margin-left: 10.7%" v-show="isShowloc2"></div>
  <table class="table" v-show="isShowReview" v-for="rvo in reply_list" style="border: 1px solid #00B98E;border-radius:1rem">
    <tr>
          <td class="text-left">♬{{rvo.userName}}({{rvo.dbday}})</td>
          <td class="text-right">
           <span class="inline" v-if="rvo.userId===sessionId">
            <input type=button class="btn-xs btn-danger" value="수정" @click="updateForm(rvo.no)" :id="'up'+rvo.no">&nbsp;
            <input type=button class="btn-xs btn-info" value="삭제" @click="replyDelete(rvo.no)">
           </span>
          </td>
         </tr>
         <tr>
           <td colspan="2" class="text-left" valign="top">
            <pre style="white-space: pre-wrap;background-color: white;border:none">{{rvo.msg}}</pre>
           </td>
         </tr>
         <tr style="display:none" :id="'u'+rvo.no" class="ups">
	       <td colspan="2">
	         <textarea rows="4" cols="85" :id="'u_msg'+rvo.no" style="float: left">{{rvo.msg}}</textarea>
	         <input type=button value="댓글수정" class="btn-danger"
	          style="float: left;width: 80px;height: 86px" @click="replyUpdate(rvo.no)">
	       </td>
	      </tr>
	</table>       
	<table class="table" v-if="sessionId">
    <tr>
      <td>
      <textarea rows="2" cols="85" ref="msg" style="float: left" v-model="msg"></textarea>
      <a class="btn btn-primary py-1 px-3" style="float: left;height:50px;padding-top:10px !important" @click="replyInsert()">리뷰쓰기</a>
      </td>
	</tr>
	</table>
  
</div>
<script>
  let showDetailApp=Vue.createApp({
	  data(){
		  return {
			  show_detail:{},
			  sno:${sno},
			  sdeposter:[],
			  isShowInfo:true,
			  isShowReview:false,
			  isShowloc1:true,
			  isShowloc2:true,
			  isShowReview:false,
			  reply_list:[],
	    	  sessionId:'${sessionId}',
	    	  msg:'',
	    	  u:0,
	    	  reply_cnt:0,
	    	  score:0
		  }
	  },
	  mounted(){
		  axios.get('../show/detail_vue.do',{
			  params:{
				  sno:this.sno
			  }
		  }).then(response=>{
			  console.log(response.data)
			  this.show_detail=response.data.show_detail
			  this.sdeposter=response.data.show_detail.sdeposter.split(",")
			  if(window.kakao && window.kakao.maps)
			  {
				  this.initMap()
			  }
			  else
			  {
				  this.addScript()
			  }
		  })
		  this.replyList()
	  },
	  methods:{
		  replyList(){
				axios.get('../reply/reply_list.do',{
					params:{
						fno:this.sno,
						typeno:5,
						page:this.review_page
					}
				}).then(response=>{
					this.reply_list=response.data.reply_list
					this.reply_cnt=response.data.reply_cnt					
					console.log(this.reply_list)
				})
				
				axios.get('../reply/reply_page.do',{
					params:{
						fno:this.sno,
						typeno:5,
						page:this.review_page
					}
				}).then(response=>{
					this.review_page=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
				})
			},
	    	 updateForm(no){
	    		$('.ups').hide();
	    		$('#up'+no).val('수정')
	    		if(this.u==0)
	    		{
	    		    this.u=1;
	    		    $('#u'+no).show();
	    		    $('#up'+no).val('취소')
	    		    
	    		}
	    		else
	    		{
	    			this.u=0;
	    			$('#u'+no).hide();
	    		    $('#up'+no).val('수정')
	    		}
	    	 },
	    	 
	    	 replyDelete(no){
	    		axios.get('../reply/reply_delete.do',{
	    		  params:
	    			  {
	    			      no:no,
	    			      sno:this.no,
	    			      typeno:5
	    			  }
	    			
	    		}).then(response=>{
	    			this.replyList()
	    		}) 
	    	 },
	    	 replyInsert(){
	    		if(this.msg==="")
	    		{
	    			this.$refs.msg.focus()
	    			return
	    		}
	    		
	    		axios.get('../reply/reply_insert.do',{
	    			params:{
	    				fno:this.sno,
	    				msg:this.msg,
	    				typeno:5
	    			}
	    		}).then(response=>{
	    			console.log(response.data)
	    			this.replyList()
	    			this.msg=''
	    		})
	    	 },
		  showReview(){
			  this.isShowInfo=false
			  this.isShowReview=true
			  this.isShowloc1=false
			  this.isShowloc2=false
		  },
		  showInfo(){
			  this.isShowInfo=true
			  this.isShowloc1=true
			  this.isShowloc2=true
			  this.isShowReview=false
		  },
		  addScript(){
			  const script=document.createElement("script")
			  
			  /* global kakao */
			  script.onload=()=>kakao.maps.load(this.initMap)
			  script.src="http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=d2619d279eb9fac7ba95f6d01b516779&libraries=services"
			  document.head.appendChild(script)
		  },
		  initMap(){
			  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(this.show_detail.saddress, function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+$("#sloc").text()+'</div>'
			        });
			        infowindow.open(map, marker);

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});
		  }
	  }
  }).mount('#showDetailApp')
</script>
</body>
</html>