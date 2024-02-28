<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('#showmain').click(function(){
		window.location.href = "../show/main.do";
	})
})
</script>
<style type="text/css">
a#notice:hover{
	cursor: pointer;
}
a#showmain:hover{
	cursor: pointer;
}
</style>
</head>
<body>

<!-- Navbar Start -->
        <div class="container-fluid nav-bar bg-transparent">
            <nav class="navbar navbar-expand-lg bg-white navbar-light py-0 px-4">
                <a href="../resources/views/index.html" class="navbar-brand d-flex align-items-center text-center" style="height: 1px">
                    
                    <h1 class="m-0 text-primary"><a href="../main/main.do">MU:MA</a></h1>
                </a>
                <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto">
                        <a href="../resources/views/index.html" class="nav-item nav-link active">Home</a>
                        <a href="../resources/views/about.html" class="nav-item nav-link">About</a>
                        
                        <!-- 게시판 header -->
                        <a href="../musicboard/notice.do" class="nav-item nav-link">게시판</a>
                        
                        <!-- 음악게시판 -->
                        <div class="nav-item dropdown">
                            <a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">음악</a>
                            <div class="dropdown-menu rounded-0 m-0">
                                <a href="../musicfind/list.do?cate=1" class="dropdown-item">TOP 200</a>
                                <a href="../musicfind/list.do?cate=2" class="dropdown-item">최신 음악</a>
                                <a href="../musicfind/list.do?cate=3" class="dropdown-item">장르 음악</a>
                            </div>
                        </div>
                        <!-- 끝 -->
                        
                        <!-- 공연게시판 -->
                        <div class="nav-item dropdown">
                           <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" id="showmain">공연</a>
                           <div class="dropdown-menu rounded-0 m-0">
                               <a href="../show/list.do" class="dropdown-item">콘서트</a>
                               <a href="../show/musical.do" class="dropdown-item">뮤지컬</a>
                               <a href="../show/classic.do" class="dropdown-item">클래식</a>
                           </div>
                        </div>
                        <!-- 공연까지 -->
                        
                        <a href="../cdlp/list.do?genre=OST" class="nav-item nav-link">CD/LP</a>
                        <a href="../musicnews/list.do" class="nav-item nav-link">매거진</a>
                        
                        <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">   
                        	<a href="../chat/chat.do" class="nav-item nav-link">실시간 채팅</a>
                        </sec:authorize>
                        
                        <sec:authorize access="hasRole('ROLE_USER')">        
	                    	<a href="../mypage/main.do" class="nav-item nav-link">마이페이지</a>   
	                    </sec:authorize>
	                    <sec:authorize access="hasRole('ROLE_ADMIN')">
		                    <a href="../admin/main.do" class="nav-item nav-link">관리자페이지</a>
	                    </sec:authorize>
                    </div>
                    
                    <c:if test="${sessionScope.userId==null }">
                     	<a href="../member/sclogin.do" class="btn btn-primary px-3 d-none d-lg-flex">Login</a>
                	</c:if>
                	<c:if test="${sessionScope.userId!=null }">
                     	<a href="../member/logout.do" class="btn btn-primary px-3 d-none d-lg-flex">Logout</a>
                	</c:if>
                	
                	
                </div>
                
                <c:if test="${sessionScope.userId==null }">
			      	
				</c:if>
				<c:if test="${sessionScope.userId!=null }">
				    <div class="fl_right">
				      	&nbsp;&nbsp;
				        ${sessionScope.userName }(
				        <sec:authorize access="hasRole('ROLE_ADMIN')">관리자</sec:authorize>
				        <sec:authorize access="hasRole('ROLE_USER')">일반사용자</sec:authorize>
				        )님 환영합니다.
				      
				    </div>
			    </c:if>
				 
            </nav>
        </div>
        <!-- Navbar End -->
</body>
</html>