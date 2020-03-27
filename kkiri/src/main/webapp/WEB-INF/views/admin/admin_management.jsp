<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 회원</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin.css">
</head>
<body>
	<div id="wrapper">
	<jsp:include page="../common/header.jsp" />
	<!-- content 시작 -->
	<div id="container" class="container">
		<div class="row mt-5">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link"
					href="member" tabindex="-1">회원</a></li>
				<li class="nav-item"><a class="nav-link"
					href="event" tabindex="-1">이벤트</a></li>
				<li class="nav-item"><a class="nav-link"
					href="report" tabindex="-1">신고</a></li>
				<li class="nav-item"><a class="nav-link" href="ask"
					tabindex="-1">문의</a></li>
				<li class="nav-item"><a class="nav-link active" href="management"
					tabindex="-1">관리</a></li>
			</ul>
		</div>
		<br>
		<div class="row justify-content-md-center">
			<div id="uploadVideo" class="col-10">
			<form action="adminUploadVideo" method="post"
				enctype="multipart/form-data" role="form">
				<lable for="">영상 업로드</lable>
				<input name="inputVideo" type="file"> <br>
				<button class="btn btn-sm btn-outline-dark">업로드</button>
			</form>
			</div>
		</div>
		<div class="row justify-content-md-center">
			<div id="" class="col-10">
				<div class="videoDiv">
				<c:if test="${empty vList}">
					업로드된 영상이 없습니다.
				</c:if>
				<c:forEach var="video" items="${vList}" varStatus="vs">
					<input id="videoRadio${vs.count}" name="changeVideo" type="radio" value="${video}"> 
					<label for="videoRadio${vs.count}" class="videoLabel">
						<video class='adminVideo' preload="metadata" loop muted>
	    					<source src='${contextPath}/resources/uploadVideo/${video}' type='video/mp4'>
	    				</video>
					</label>
				</c:forEach>
				<br>
					<button id="selectVideo" class="btn btn-sm btn-outline-dark">선택</button>
				</div>
			</div>
			
		</div>
		
	</div>
	<!-- content 끝 -->
	</div>
	<jsp:include page="../common/footer.jsp" />
	

	<script>
		function scrollFunction() {
			if ($(window).scrollTop() >= 200) {
				$('#button-top').show(0);
			} else {
				$('#button-top').hide(0);
			}
		}
		$(function() {
			scrollFunction();
			$(window).scroll(function() {
				scrollFunction();
			});
			$('#button-top').on({
				click : function() {
					$('html,body').stop().animate({
						scrollTop : 0
					}, 600);
				}
			});
		});
		
		$(".videoLabel").on("click", function(){
			$(this).children().css("background-color", "rgba(0,161,133,.5)");
			$(".videoLabel").not($(this)).children().css("background-color", "white");
			console.log($(this).prev().val());
			fileName = $(this).prev().val();
		});
		
		$(".videoLabel").on("mouseenter", function(){
			$(this).children().prop("controls", "true");
			
		}).on("mouseleave", function(){
			$(this).children().removeAttr("controls", "true");
		});
		
		$("#selectVideo").on("click", function(){
			location.href = "adminChangeVideo?changeVideo=" + fileName;
		});

	</script>
</body>

</html>