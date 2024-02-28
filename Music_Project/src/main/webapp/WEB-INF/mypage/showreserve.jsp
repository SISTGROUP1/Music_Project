<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div style="height: 100px"></div>
<div class="container-xxl bg-white p-0" id="showDetailApp" style="padding: 4% !important">
  <div class="wrapper row3" id="mypageApp">
    <main class="container clear"> 
      <h2 class="sectiontitle text-center" style="color: rgb(0, 185, 142)">공연 예매 목록</h2>
      <div style="height: 30px;"></div>
      <table class="table">
        <tr>
         <th class="text-center">번호</th>
         <th></th>
         <th class="text-center">공연명</th>
         <th class="text-center">공연날짜</th>
         <th class="text-center">공연시간</th>
         <th class="text-center">좌석</th>
         <th class="text-center">예매 상태</th>
         <th></th>
        </tr>
        <tr v-for="vo in reserve_list">
          <td class="text-center">{{vo.srno}}</td>
          <td class="text-center">
           <img :src="vo.svo.sposter" style="width: 30px;height: 30px">
          </td>
          <td class="text-center">{{vo.svo.stitle}}</td>
          <td class="text-center">{{vo.rdate}}</td>
          <td class="text-center">{{vo.rtime}}</td>
          <td class="text-center">R석&nbsp;{{vo.rseat}}번</td>
          <td class="text-center">
            <span :class="vo.reserve_ok==1?'btn btn-xs btn-default':'btn btn-xs btn-warning'" v-text="vo.reserve_ok==0?'예약대기':'예약완료'" style="border: 1px solid #00B98E;margin-left: 2%"></span>
            &nbsp;<span class="btn btn-xs btn-danger" @click="reserveCancel(vo.srno)">취소</span>
          </td>
          <td>
            <a :href="'../show/detail.do?sno='+vo.sno" v-text="vo.reserve_ok==1?'▶리뷰 쓰기':''" style="margin-left: 33%;color: #00B98E"></a>
		  </td>
        </tr>
      </table>
    </main>
  </div>
</div>
  <script>
   let mypageApp=Vue.createApp({
	   data(){
		   return {
			   reserve_list:[],
			   reviewShow:false,
		   }
	   },
	   mounted(){
		   axios.get('../reserve/mypage_list_vue.do')
		   .then(response=>{
			   console.log(response.data)
			   this.reserve_list=response.data
		   })
	   },
	   methods:{
		   reserveCancel(srno){
			   axios.get('../reserve/reserve_cancel_vue.do',{
				   params:{
					   srno:srno
				   }
			   }).then(response=>{
				   if(response.data==='yes')
				   {
					   alert("취소 하시겠습니까?")
					   axios.get('../reserve/mypage_list_vue.do')
					   .then(response=>{
						   console.log(response.data)
						   this.reserve_list=response.data
					   })
				   }
				   else
				   {
					   alert("예매 취소가 실패하셨습니다\n다시 취소바랍니다")
				   }
			   })
		   }
	   }
   }).mount("#mypageApp")
  </script>
</body>
</html>