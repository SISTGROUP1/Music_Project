<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
   $('#notice').click(function(){
      window.location.href = "../musicboard/notice.do";
   })
})
</script>
<style type="text/css">
a#notice:hover{
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
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" id="notice">게시판</a>
                            <div class="dropdown-menu rounded-0 m-0">
                                <a href="../musicboard/notice.do" class="dropdown-item">공지사항</a>
                                <a href="../musicboard/question.do" class="dropdown-item">문의하기</a>
                                <a href="../musicboard/schand.do" class="dropdown-item">중고거래</a>
                            </div>
                        </div>
                        
                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                            <div class="dropdown-menu rounded-0 m-0">
                                <a href="../resources/views/testimonial.html" class="dropdown-item">Testimonial</a>
                                <a href="../resources/views/404.html" class="dropdown-item">404 Error</a>
                            </div>
                        </div>
                        <a href="../musicnews/list.do" class="nav-item nav-link">매거진</a>
                    </div>
                    <c:if test="${sessionScope.userId==null }">
                     	<a href="../member/sclogin.do" class="btn btn-primary px-3 d-none d-lg-flex">Login</a>
                	</c:if>
                	<c:if test="${sessionScope.userId!=null }">
                     	<a href="../member/logout.do" class="btn btn-primary px-3 d-none d-lg-flex">Logout</a>
                	</c:if>
                </div>
            </nav>
        </div>
        <!-- Navbar End -->
</body>
</html>