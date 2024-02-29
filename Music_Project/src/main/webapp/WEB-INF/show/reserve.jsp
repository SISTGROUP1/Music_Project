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
<style type="text/css">
.rounded {
      -moz-border-radius:20px 20px 20px 20px; 
      border-radius:20px 20px 20px 20px;
      border:solid 1px #ffffff;
      background-color:#2b6bd1;
      padding:10px;
      color:#ffffff;
    }
td.link:hover,tr.tr_link:hover{
    cursor: pointer;
  }
#showSeat{
	display:inline-block;
	width:50px;
	height:50px;
	vertical-align: top;
}
#showSeat:checked{
	border-color: red
}
</style>
</head>
<body>
<div style="height: 100px"></div>
<div class="container-xxl bg-white p-0" id="reserveApp">
<table class="table" style="width:1320px;height: 660px;border: 1">
  <tr>
    <td width=15% colspan="2" style="border-bottom-width:0px;"><img :src="reserve_detail.sposter" style="height: 500px"></td>
    <td width=45% style="border-bottom-width:0px;margin-left: 5%">
    <div class="calendar">
				      <h2 class="text-center">
				        <a href="#" v-on:click="onClickPrev(currentMonth)">◀</a>
				        {{currentYear}}년 {{currentMonth}}월
				        <a href="#" v-on:click="onClickNext(currentMonth)">▶</a>
				      </h2>
				      <table class="table table-hover">
				          <thead>
				            <tr>
				              <td v-for="(weekName, index) in weekNames" v-bind:key="index">
				                {{weekName}}
				              </td>
				            </tr>
				          </thead>
				          <tbody>
				            <tr v-for="(row, index) in currentCalendarMatrix" :key="index">
				              <td v-for="(day, index2) in row" :key="index2" style="padding:20px;" :class="day>=realDay?'link':''">
				                <span v-if="day>=realDay" @click="change(day)" style="color:black">
					                <span v-if="day===currentDay" class="rounded">
					                  {{day}}
					                </span>
					                <span v-else>
					                  {{day}}
					                </span>
				                </span>
				                <span v-else style="color:gray">
				                   {{day}}
				                </span>
				              </td>
				            </tr>
				          </tbody>
				      </table>    
				  </div>
    </td>
    
  </tr>
  <tr>
    <td style="border-bottom-width:0px;font-weight:700;">공연명</td>
    <td style="border-bottom-width:0px;width: 270px">{{reserve_detail.stitle}}</td>
    <td rowspan="4" style="border-bottom-width:0px;" v-show="tShow" class="text-center">
      <h2>시간</h2>
      <span class="btn btn-xs" v-for="time in time_list" style="margin-right: 3%;background-color: #00B98E;color: white;" @click="timeSelect(time)">{{time}}</span>
    </td>
  </tr>
  <tr>
    <td style="border-bottom-width:0px;font-weight:700;">공연장소</td>
    <td style="border-bottom-width:0px;width: 270px">{{reserve_detail.sloc}}</td>
  </tr>
  <tr>
    <td style="border-bottom-width:0px;font-weight:700;">등급</td>
    <td style="border-bottom-width:0px;width: 270px">{{reserve_detail.sgrade}}</td>
  </tr>
  <tr>
    <td style="border-bottom-width:0px;font-weight:700;">관람시간</td>
    <td style="border-bottom-width:0px;width: 270px">{{reserve_detail.shour}}</td>
  </tr>
</table>
<table style="margin-left: 39%;" v-show="sShow">

<!-- 
     style="margin-left: 150.3px"
-->
  <tr>
    
    <td width="10%" style="font-weight:700;">R</td>
    <h2 class="text-center" style="padding-left: 34%" v-show="seatShow">좌석</h2>
    <td width=90% style="border-bottom-width:0px;" rowspan="3">
        <br/>
        <% for(int i=1;i<=6;i++) { %>
            <small>
              <%=i%2==0?"2":"1" %>
            </small>
            <% for(int c=1;c<=10;c++){ %>
               <input style="margin-right: 10px;margin-bottom: 10px" type="checkbox" id="showSeat" name="seat" value="<%=c %>-<%=i %>" @click="seatSelect(<%=c%>)">
        <% } %>
        <br/>
        <%= i%2==0?"<br/>":"" %>
        <% } %>
        <br>
    </td> 
  </tr>
  <tr>
    <td width="10%" style="font-weight:700;">S</td>
  </tr>
  <tr>
    <td width="10%" style="padding-bottom: 2%;font-weight:700;">A</td>
  </tr>
  <tr>
    <td colspan="2" class="text-center" v-show="okShow">
     <a class="btn btn-primary py-1 px-3 wow " @click="reserveOk()">예매하기</a></div>
     <a class="btn btn-primary py-1 px-3 wow " style="margin-left:3%" @click="goback()">취소</a></div> 
    </td>
  </tr>
</table>
<div style="height: 50px"></div>
</div>
<script>
let reserveApp=Vue.createApp({
	  data(){
		  return {
			  reserve_detail:{},
			  sno:${sno},
			  weekNames: ["월요일", "화요일", "수요일","목요일", "금요일", "토요일", "일요일"],
		      rootYear: 1904,
		      rootDayOfWeekIndex: 4, // 2000년 1월 1일은 토요일
		      currentYear: new Date().getFullYear(),
		      currentMonth: new Date().getMonth()+1,
		      currentDay: new Date().getDate(),
		      currentMonthStartWeekIndex: null,
		      currentCalendarMatrix: [],
		      endOfDay: null,
		      memoDatas: [],
		      realDay:new Date().getDate(),
		      time_list:['15:00','19:00','22:00'],
		      tShow:false,
		      time:'',
		      sShow:false,
		      seatShow:false,
		      okShow:false,
		      c:0
		  }
	  },
	  mounted(){
		  this.init()
		  axios.get('../show/reserve_vue.do',{
			  params:{
				  sno:this.sno
			  }
		  }).then(response=>{
			  console.log(response.data)
			  this.reserve_detail=response.data
		  })
	  },
	  methods:{
		  reserveOk(){
				 axios.post('../show/reserve_ok.do',null,{
					 params:{
						 sno:this.sno,
						 rDate:this.currentYear+"년도 "+this.currentMonth+"월 "+this.currentDay,
						 rTime:this.time,
						 rSeat:this.c
					 }
				 }).then(response=>{
					 console.log(response.data)
					 if(response.data==='yes')
				     {
						 location.href="../mypage/showreserve.do" 
				     }
					 else
				     {
						 alert("공연 예매에 실패하셨습니다")
				     }
				 }).catch(error=>{
					 console.log(error)
				 });
			   },
		  timeSelect(time){
				 this.time=time;
				 this.sShow=true;
				 this.seatShow=true;
			   },
		  seatSelect(c){
				this.c=c;
				console.log(c);
				this.okShow=true;
			   },
		  init(){
		        this.currentMonthStartWeekIndex = this.getStartWeek(this.currentYear, this.currentMonth);
		        this.endOfDay = this.getEndOfDay(this.currentYear, this.currentMonth);
		        this.initCalendar();
		      },
		      initCalendar(){
		        this.currentCalendarMatrix = [];
		        let day=1;
		        for(let i=0; i<6; i++){
		          let calendarRow = [];
		          for(let j=0; j<7; j++){
		            if(i==0 && j<this.currentMonthStartWeekIndex){
		              calendarRow.push("");
		            }
		            else if(day<=this.endOfDay){
		              calendarRow.push(day);
		              day++;
		            }
		            else{
		              calendarRow.push("");
		            }
		          }
		          this.currentCalendarMatrix.push(calendarRow);
		        }
		      },
		      getEndOfDay(year, month){
		          switch(month){
		              case 1:
		              case 3:
		              case 5:
		              case 7:
		              case 8:
		              case 10:
		              case 12:
		                return 31;
		                break;
		              case 4:
		              case 6:
		              case 9:
		              case 11:
		                return 30;
		                break;
		              case 2:
		                if( (year%4 == 0) && (year%100 != 0) || (year%400 == 0) ){
		                return 29;   
		                }
		                else{
		                    return 28;
		                }
		                break;
		              default:
		                console.log("unknown month " + month);
		                return 0;
		                break;
		          }
		      },
		      getStartWeek(targetYear, targetMonth){
		        let year = this.rootYear;
		        let month = 1;
		        let sumOfDay = this.rootDayOfWeekIndex;
		        while(true){
		          if(targetYear > year){
		            for(let i=0; i<12; i++){
		              sumOfDay += this.getEndOfDay(year, month+i);
		            }
		            year++;
		          }
		          else if(targetYear == year){
		            if(targetMonth > month){
		              sumOfDay += this.getEndOfDay(year, month);
		              month++;
		            }
		            else if(targetMonth == month){
		              return (sumOfDay)%7;
		            }
		          }
		        }
		      },
		      onClickPrev(month){
		        month--;
		        if(month<=0){
		          this.currentMonth = 12;
		          this.currentYear -= 1;
		        }
		        else{
		          this.currentMonth -= 1;
		        }
		        this.init();
		      },
		      onClickNext(month){
		        month++;
		        if(month>12){
		          this.currentMonth = 1;
		          this.currentYear += 1;
		        }
		        else{
		          this.currentMonth += 1;
		        }
		        this.init();
		      },
		      isToday: function(year, month, day){
		        let date = new Date();
		        return year == date.getFullYear() && month == date.getMonth()+1 && day == day; 
		      },
		      change(day){
		    	 this.currentDay=day;
		    	 this.tShow=true
		      },
		      goback(){
				  location.href="../show/list.do"
			  }
	  }
}).mount('#reserveApp')
</script>
</body>
</html>