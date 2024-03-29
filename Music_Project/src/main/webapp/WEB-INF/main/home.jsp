<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->
<!-- Header Start -->
        <div class="container-fluid header bg-white p-0">
            <div class="row g-0 align-items-center flex-column-reverse flex-md-row">
                <div class="col-md-6 p-5 mt-lg-5">
                    <h1 class="display-5 animated fadeIn mb-4">차트 <span class="text-primary">200</span> 위</h1>
                    <table class="table">
                    	<c:forEach var="vo" items="${mfList }">
	                    	<tr>
	                    		<td class="text-center">${vo.grank }</td>
	                    		<td class="text-center">
	                    			<c:choose>
	                    				<c:when test="${vo.rank_change eq '유지'}">
	                    					-
	                    				</c:when>
	                    				<c:when test="${vo.rank_change eq '상승'}">
	                    					<span style="color: red; ">▲ ${vo.rank_value }</span>
	                    				</c:when>
	                    				<c:when test="${vo.rank_change eq '하강'}">
	                    					<span style="color: blue; ">▼ ${vo.rank_value }</span>
	                    				</c:when>
	                    				<c:otherwise>
	                    					new
	                    				</c:otherwise>
	                    			</c:choose>
	                    		</td>
	                    		<td>${vo.song }</td>
	                    		<td>${vo.artist }</td>
	                    		<td><img src="${vo.image }" style="width:30px;height:30px;"></td>
	                    	</tr>
                    	</c:forEach>
                    </table>
                   <div class="text-center"> <a href="../musicfind/list.do?cate=1" class="btn btn-primary py-3 px-5 me-3 animated fadeIn">TOP200 바로가기 ></a></div>
                </div>
                <div class="col-md-6 animated fadeIn">
                	<div class="col-md-12 p-5 mt-lg-5">
                	<h4 class="display-5 animated fadeIn mb-4">HOT &amp; NEW</h4>
                    <div class="owl-carousel header-carousel">
                    	<%-- <c:forEach var="vo" items="${mfList }">
	                        <div class="owl-carousel-item">
	                            <img class="img-fluid" src="${vo.image }" alt="">
	                        </div>
                        </c:forEach> --%>
                        <div class="owl-carousel-item">
	                         <img class="img-fluid" src="https://image.genie.co.kr/Y/IMAGE/IMG_MUZICAT/IV2/Event/2024/2/21/ban_26596_202422110554.jpg" alt="">
	                    </div>
                        <div class="owl-carousel-item">
	                         <img class="img-fluid" src="https://image.genie.co.kr/Y/IMAGE/IMG_MUZICAT/IV2/Event/2024/2/27/ban_26592_2024227112422.jpg" alt="">
	                    </div>
	                    <div class="owl-carousel-item">
	                       	<img class="img-fluid" src="https://image.genie.co.kr/Y/IMAGE/IMG_MUZICAT/IV2/Event/2024/2/27/ban_26593_2024227112454.jpg" alt="">
	                    </div>
	                    <div class="owl-carousel-item">
	                       	<img class="img-fluid" src="https://image.genie.co.kr/Y/IMAGE/IMG_MUZICAT/IV2/Event/2024/2/21/ban_26588_2024221105654.jpg" alt="">
	                    </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header End -->
<!-- Search Start -->
         <div class="container-fluid bg-primary mb-5 wow fadeIn" data-wow-delay="0.1s" style="padding: 35px;" id="dataSearchForm">
            <div class="container">
                <div class="row g-2">
                    <div class="col-md-10">
                        <div class="row g-2">
                        	<div class="col-md-3">
                                <select class="form-select border-0 py-3" ref="type">
                                    <option value="0" selected>가수</option>
                                    <option value="1">CD/LP</option>
                                    <option value="2">공연</option>
                                </select>
                            </div>
                            <div class="col-md-9">
                                <input type="text" class="form-control border-0 py-3" placeholder="Search Keyword" ref="search" v-model="search">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-dark border-0 w-100 py-3" @click="dataSearch()">Search</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Search End -->
        <!-- Category Start -->
        <!-- 음악 카테고리 -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                    <h1 class="mb-3">최신 음악</h1>
                </div>
                <div class="row g-4">
                	<c:forEach var="vo" items="${newMusicList }" begin="1" end="8" varStatus="i">
	                    <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s">
	                        <a class="cat-item d-block bg-light text-center rounded p-3" href="">
	                            <div class="rounded p-4">        
	                                <div class="icon mb-3">
	                                    <img class="img-fluid" src="${vo.image }" alt="Icon">
	                                </div>
	                                <h6>${vo.song }</h6>
	                                <span>${vo.artist }</span>
	                            </div>
	                        </a>
	                    </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- Category End -->
        <!-- /////////////// CD/LP 출력 구간 Start /////////////// -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                    <h1 class="mb-3">CD/LP</h1>
                    <!-- <p>Eirmod sed ipsum dolor sit rebum labore magna erat. Tempor ut dolore lorem kasd vero ipsum sit eirmod sit. Ipsum diam justo sed rebum vero dolor duo.</p> -->
                </div>
                <div class="row g-4">
                	<!-- 발매일순으로 출력 -->
                	<!-- 한 줄에 4개씩 출력 -->
                	<c:forEach var="vo" items="${cdlpList }">
                    <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s">
                        <a class="cat-item d-block bg-light text-center p-3" href="../cdlp/detail.do?no=${vo.no }">
                            <div class="icon mb-3" style="border-radius: 0;">
                                <img src="${vo.poster }" style="width: 100%">
                            </div>
                            <h6 style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${vo.subject }</h6>
                            <!-- <span>123 Properties</span> -->
                        </a>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- /////////////// CD/LP 출력 구간 End /////////////// -->
        <!-- Category End -->
        
        <!-- About Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="row g-5 align-items-center">
                <c:forEach var="showvo" items="${ Topshow}">
                    <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                        <div class="about-img position-relative overflow-hidden p-5 pe-0">
                            <img class="img-fluid w-100" src="${showvo.sposter }" style="height:560px;width: 480px !important">
                            </img>
                        </div>
                    </div>
                    <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                        <h1 class="mb-4" style="font-size: 2rem">${showvo.stitle }</h1>
                        <p><i class="fa fa-check text-primary me-3">&nbsp;${showvo.sdate }</i></p>
                        <p><i class="fa fa-check text-primary me-3">&nbsp;${showvo.sloc }</i></p>
                        <p><i class="fa fa-check text-primary me-3">&nbsp;R석 : 70,000원</i></p>
                        <a class="btn btn-primary py-3 px-5 mt-3" href="../show/detail.do?sno=${ showvo.sno}" style="width: 201.933px;margin-left: 30%;">예매하기</a>
                        <a class="btn btn-primary py-3 px-5 mt-3" href="../show/main.do">공연 전체 보기</a>
                    </div>
                  </c:forEach>
                </div>
            </div>
        </div>
        <!-- About End -->
        
        <!-- Property List Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="row g-0 gx-5 align-items-end">
                    <div class="col-lg-6">
                        <div class="text-start mx-auto mb-5 wow slideInLeft" data-wow-delay="0.1s">
                            <h1 class="mb-3">What's in MU:MA</h1>
                            <p>MU:MA의 최신 음악 소식을 만나보세요.</p>
                        </div>
                    </div>
                    <div class="col-lg-6 text-start text-lg-end wow slideInRight" data-wow-delay="0.1s">
                        
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                      
                        <div class="row g-4">
                        
                          <c:forEach var="mnvo" items="${ musicNewsList}">
                            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="property-item rounded overflow-hidden" style="width: 408px;height: 374px">
                                    <div class="position-relative overflow-hidden">
                                        <a href="../musicnews/detail.do?no=${ mnvo.no}"><img class="img-fluid" src="https:${ mnvo.poster}" alt=""></a>
                                   
                                        <div class="bg-white rounded-top text-primary position-absolute start-0 bottom-0 mx-4 pt-1 px-3">${mnvo.regdate }</div>
                                    </div>
                                    <div class="p-4 pb-0">
                                        <h5 class="text-primary mb-3"></h5>
                                        <a class="d-block h5 mb-2" href="../musicnews/detail.do?no=${ mnvo.no}">${mnvo.title }</a>   	
                                    </div>
                                </div>
                            </div>
                         </c:forEach>
                         
                            <div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
                                <a class="btn btn-primary py-3 px-5" href="../musicnews/list.do">매거진 전체보기 &raquo;</a>
                            </div>
                        </div>
                    </div>
                
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Property List End -->
        
        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
</div>
<script>
	let dataSearchForm=Vue.createApp({
		data(){
			return{
				type:0,
				search:''
			}
		},
		methods:{
			dataSearch(){
				if(this.search===null || this.search===''){
					this.$refs.search.focus()
					return
				}else{
					location.href='../main/search.do?type='+this.$refs.type.value+'&search='+this.search	
				}
			}
		}
	}).mount('#dataSearchForm')
</script>
</body>
</html>