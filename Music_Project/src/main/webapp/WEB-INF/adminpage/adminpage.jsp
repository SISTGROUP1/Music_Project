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
  <div class="wrapper row3" id="adminApp">
    <main class="container clear"> 
      <h2 class="sectiontitle text-center" style="color: rgb(0, 185, 142)">예매 현황</h2>
      <div style="height: 30px"></div>
      <table class="table">
        <tr>
         <th class="text-center">번호</th>
         <th></th>
         <th class="text-center">아이디</th>
         <th class="text-center">공연명</th>
         <th class="text-center">공연날짜</th>
         <th class="text-center">공연시간</th>
         <th class="text-center">좌석</th>
         <th class="text-center">예매 상태</th>
        </tr>
        <tr v-for="vo in reserve_list">
          <td class="text-center">{{vo.srno}}</td>
          <td class="text-center">
           <img :src="vo.svo.sposter" style="width: 30px;height: 30px">
          </td>
          <td class="text-center">{{vo.userId}}</td>
          <td class="text-center">{{vo.svo.stitle}}</td>
          <td class="text-center">{{vo.rdate}}</td>
          <td class="text-center">{{vo.rtime}}</td>
          <td class="text-center">{{vo.rseat}}</td>
          <td class="text-center">
            <span class="btn btn-xs btn-danger" v-if="vo.reserve_ok==0" @click="ok(vo.srno)">승인대기</span>
            <span class="btn btn-xs btn-default" v-else style="border: 1px solid #00B98E">승인완료</span>
          </td>
        </tr>
      </table>
    </main>
</div>
</div>
<script>
  let adminApp=Vue.createApp({
	  data(){
		  return {
			  reserve_list:[]
		  }
	  },
	  mounted(){
		  axios.get('../reserve/reserve_admin_vue.do')
		  .then(response=>{
			  console.log(response.data)
			  this.reserve_list=response.data
		  })
	  },
	  methods:{
		  // 승인 버튼 => UPDATE , Mail
		  ok(srno){
			  axios.get('../reserve/reserve_ok_vue.do',{
				  params:{
					  srno:srno
				  }
			  }).then(response=>{
				  if(response.data=='yes')
				  {
					  axios.get('../reserve/reserve_admin_vue.do')
					  .then(response=>{
						  console.log(response.data)
						  this.reserve_list=response.data
					  })
				  }
				  else
				  {
					  alert(response.data)
				  }
			  })
		  }
	  }
  }).mount("#adminApp")
</script>
</body>
</html>