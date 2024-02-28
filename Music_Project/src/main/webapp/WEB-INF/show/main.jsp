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
<div class="container-xxl bg-white p-0" id="showmainApp">
<div class="container-xxl py-5">
            <div class="container" style="height: 400px">
                <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
                    <div class="testimonial-item bg-light rounded p-3" style="background-color: white !important">

                            <div class="d-flex align-items-center">
                                <a href="../show/detail.do?sno=10"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202402/20240201/20240201-48529.jpg/dims/quality/70/" style="width: 264px; height: 400px;"></a>
                                <a href="../show/detail.do?sno=52"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202402/20240207/20240207-48693.jpg/dims/quality/70/" style="width: 264px; height: 400px;margin-left: 10px"></a>
                                <div class="ps-3">
                                </div>
                            </div>

                    </div>
                    <div class="testimonial-item bg-light rounded p-3" style="background-color: white !important">
                            <div class="d-flex align-items-center">
                                <a href="../show/detail.do?sno=78"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202401/20240118/20240118-48406.jpg/dims/quality/70/" style="width: 264px; height: 400px;"></a>
                                <a href="../show/detail.do?sno=122"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202401/20240108/20240108-48280.jpg/dims/quality/70/" style="width: 264px; height: 400px;margin-left: 10px"></a>
                                <div class="ps-3">
                                <div></div>
                                </div>
                            </div>
                    </div>
                    <div class="testimonial-item bg-light rounded p-3" style="background-color: white !important">

                            <div class="d-flex align-items-center">
                                <a href="../show/detail.do?sno=234"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202312/20231220/20231220-48129_1.jpg/dims/quality/70/" style="width: 264px; height: 400px;"></a>
                                <a href="../show/detail.do?sno=290"><img class="img-fluid flex-shrink-0" src="http://tkfile.yes24.com/upload2/PerfBlog/202401/20240122/20240122-48444.jpg/dims/quality/70/" style="width: 264px; height: 400px;margin-left: 10px"></a>
                                <div></div>
                                <div class="ps-3">
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div> 
     <div class="row g-4" style="margin-left: 0px;margin-right: 0px;">
      <h3 class="text-center wow fadeInUp" style="color: #00B98E;margin-bottom: 0px" data-wow-delay="0.1s">콘서트</h3> 
      <div style="margin-top: 0px"><a class="btn btn-primary py-1 px-3 mt-1 wow fadeInUp" href="../show/list.do" data-wow-delay="0.1s" style="margin-left: 87%;">공연 전체 보기</a></div>
        <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" v-for="vo in main_concert_list">
            <div class="team-item rounded overflow-hidden" style="width: 306px;height: 588.4px;">
                <div class="position-relative">
                  
                  <a :href="'../show/detail.do?sno='+vo.sno"><img class="img-fluid" :src="vo.sposter"></a>
                </div>
                <div class="text-center p-4 mt-3">
                 <a :href="'../show/detail.do?sno='+vo.sno"><small class="fw-bold mb-0" style="color: black">{{vo.stitle}}</small></a>
                 <div></div>
                 <small class="fw-bold mb-0">{{vo.sdate}}</small>
                </div>
            </div>
        </div>
     </div>
     <div style="height:20px"></div>
     <div class="row g-4" style="margin-left: 0px;margin-right: 0px;">
      <h3 class="text-center wow fadeInUp" style="color: #00B98E" data-wow-delay="0.25s">뮤지컬
      <!--
      <div style="margin-top: 0px"><a class="btn btn-primary py-1 px-3 mt-1 wow fadeInUp" href="../show/musical.do" data-wow-delay="0.1s" style="margin-left: 87%;">뮤지컬 전체 보기</a></div>
      -->
      </h3>
        <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.25s" v-for="vo in main_musical_list">
            <div class="team-item rounded overflow-hidden" style="width: 306px;height: 588.4px;">
                <div class="position-relative">
                  
                  <a :href="'../show/detail.do?sno='+vo.sno"><img class="img-fluid" :src="vo.sposter"></a>
                </div>
                <div class="text-center p-4 mt-3">
                 <a :href="'../show/detail.do?sno='+vo.sno"><small class="fw-bold mb-0" style="color: black">{{vo.stitle}}</small></a>
                 <div></div>
                 <small class="fw-bold mb-0">{{vo.sdate}}</small>
                </div>
            </div>
        </div>
     </div>
     <div style="height:20px"></div>
     <div class="row g-4" style="margin-left: 0px;margin-right: 0px;">
      <h3 class="text-center wow fadeInUp" style="color: #00B98E" data-wow-delay="0.1s">클래식
      <!--
      <div style="margin-top: 0px"><a class="btn btn-primary py-1 px-3 mt-1 wow fadeInUp" href="../show/classic.do" data-wow-delay="0.1s" style="margin-left: 87%;">클래식 전체 보기</a></div>
      -->
      </h3>
        <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" v-for="vo in main_classic_list">
            <div class="team-item rounded overflow-hidden" style="width: 306px;height: 588.4px;">
                <div class="position-relative">
                  
                  <a :href="'../show/detail.do?sno='+vo.sno"><img class="img-fluid" :src="vo.sposter"></a>
                </div>
                <div class="text-center p-4 mt-3">
                 <a :href="'../show/detail.do?sno='+vo.sno"><small class="fw-bold mb-0" style="color: black">{{vo.stitle}}</small></a>
                 <div></div>
                 <small class="fw-bold mb-0">{{vo.sdate}}</small>
                </div>
            </div>
        </div>
      <div></div> 
     </div> 
</div>
<script>
let showmainApp=Vue.createApp({
	data(){
		  return{
			  main_concert_list:[],
		  	  main_musical_list:[],
		  	  main_classic_list:[],
		  	  sno:1
		  }
	  },
	  mounted(){
		  this.dataRecv()
	  },
	  updated(){
		  
	  },
	  methods:{
		  // 공통으로 사용되는 함수 => 반복제거
		  dataRecv(){
			  axios.get('../show/main_concert_vue.do').then(response=>{
				  console.log(response.data)
				  this.main_concert_list=response.data
			  })
			  axios.get('../show/main_musical_vue.do').then(response=>{
				  console.log(response.data)
				  this.main_musical_list=response.data
			  })
			  axios.get('../show/main_classic_vue.do').then(response=>{
				  console.log(response.data)
				  this.main_classic_list=response.data
			  })			  
	 	 }
	  }
}).mount('#showmainApp')
</script>
</body>
</html>