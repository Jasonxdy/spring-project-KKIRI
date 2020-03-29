<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/questionWrite.css">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../common/header.jsp" />
		<!-- content 시작 -->
		<div id="container" class="container">
			<div class="row mt-5">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link" href="${contextPath }/notice/noticeList"
						tabindex="-1">공지사항</a></li>
					<li class="nav-item"><a class="nav-link active" href="ask"
						tabindex="-1">1:1문의 작성</a></li>
				</ul>
			</div>

			<div class="row justify-content-md-center questionWriteSection">
				<div class="col-12 rounded-sm">
					<h2 class="mt-3 mb-3">1:1문의 작성</h2>
					<form action="askWrite" method="post" class="questionForm">
					<c:if test="${!empty loginMember}">
						<input type="text" name="askEmail" id="contactEmail" 
						value="${loginMember.memberEmail}" style="display:none;">
						<input type="text" name="memberNo" 
						value="${loginMember.memberNo}" style="display:none;">
					</c:if>
					
					<c:if test="${empty loginMember}">
						<label for="contactEmail">답변을 받으실 이메일 주소를 입력해주세요.</label> 
						<input type="email" name="askEmail" id="contactEmail" required> <br> 
					</c:if>
						
						<label for="questionTitle">제목</label>
						<input type="text" name="askTitle" id="questionTitle" required> <br> 
						
						<label for="questionContent">내용</label>
						<textarea id="questionContent" name="askContent" required></textarea>

						<button class="green-radius-btn">제출</button>
						&nbsp;
						<button type="reset" class="green-radius-btn">취소</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- content 끝 -->
	<jsp:include page="../common/footer.jsp" />
	<!-- 팝업 start-->



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
	</script>
</body>

</html>