<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">가수 관련 뉴스</h5>
                        <c:forEach var="vo" items="${findArtistList }" begin="0" end="4">
                        	<a class="btn btn-link text-white-50" href="${vo.link }" target="_blank" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${vo.title }</a>
                        </c:forEach>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">신곡 관련 뉴스</h5>
                        <c:forEach var="vo" items="${findNewSongList }" begin="0" end="4">
                        	<a class="btn btn-link text-white-50" href="${vo.link }" target="_blank" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${vo.title }</a>
                        </c:forEach>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">CD/LP 베스트셀러</h5>
                        <div class="row g-2 pt-2">
                        	<c:forEach var="vo" items="${cdlpSalesTopList }">
	                            <div class="col-4">
	                                <img class="img-fluid rounded bg-light p-1" src="${vo.poster }" alt="">
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">인기 뮤직비디오</h5>
                        <div class="row g-2 pt-2">
                        	<c:forEach var="mv" items="${mvList }">
	                            <div class="col-4">
	                                <a href="../musicfind/mvdetail.do?gnum=${mv.gnum }"><img class="img-fluid rounded bg-light p-1" src="${ mv.image}" alt=""></a>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="https://github.com/SISTGROUP1/Music_Project" target="_blank">https://github.com/SISTGROUP1/Music_Project</a> 
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="#">Home</a>
                                <a href="#">Cookies</a>
                                <a href="#">Help</a>
                                <a href="#">FQAs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
</body>
</html>