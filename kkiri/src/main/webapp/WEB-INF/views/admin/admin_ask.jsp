<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		td{line-height: 31px;}
	</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../common/header.jsp" />
		<c:if test="${loginMember.memberGrade == 'A'}">
			<!-- content 시작 -->
			<div id="container" class="container">
				<div class="row mt-5">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link" href="member"
							tabindex="-1">회원</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							tabindex="-1">이벤트</a></li>
						<li class="nav-item"><a class="nav-link" href="report"
							tabindex="-1">신고</a></li>
						<li class="nav-item"><a class="nav-link active" href="ask"
							tabindex="-1">문의</a></li>
					</ul>
				</div>

				<div class="row justify-content-md-center">
					<div class="col-12 rounded-sm">
						<h2 class="mt-3 mb-3">문의 관리</h2>
						<table id="admin-table"
							class="table table-hover table-striped table-sm">
							<thead>
								<tr class="text-center">
									<th scope="col">문의번호</th>
									<th scope="col">작성자</th>
									<th scope="col">이메일</th>
									<th scope="col">제목</th>
									<th scope="col">일자</th>
									<th scope="col">답장여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="ask" items="${aList}" varStatus="vs">
								<tr class="text-center">
									<th scope="row">${ask.askNo}</th>
									<td>${ask.memberId}</td>
									<td>${ask.askEmail}</td>
									<td>${ask.askTitle}</td>
									<c:set var="enrollDate" value ="${fn:substring(ask.askEnrollDate, 0, 4)}년
										${fn:substring(ask.askEnrollDate, 5, 7)}월
										${fn:substring(ask.askEnrollDate, 8, 10)}일" />
									<td>
										${enrollDate}
									</td>
									<td>${ask.answerStatus}</td>
									<td style="display:none;">${ask.askContent}</td>
									<td style="display:none;">${fn:substring(ask.askEnrollDate, 0, 10)}</td>
									<td style="display:none;">${ask.askAnswer}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<form action="ask" method="get">
					<div class="row justify-content-md-center">
						<!-- 검색 -->
						<div class="col-md-2 col-sm-3">
							<div class="input-group">
								<select class="custom-select" id="inputGroupSelect04"
									name="searchKey" aria-label="Example select with button addon">
									<option value="writer">작성자</option>
									<option value="email">이메일</option>
									<option value="title">제목</option>
								</select>
							</div>
						</div>
						<div class="col-md-9 col-sm-7">
							<div class="input-group mb-3">
								<input type="text" class="form-control" placeholder=""
									name="searchValue" aria-label="Username" aria-describedby="basic-addon1">
							</div>
						</div>
						<div class="col-md-1 col-sm-2">
							<div class="input-group-append">
								<button class="green-radius-btn search-btn" type="submit">검색</button>
							</div>
						</div>
					</div>
				</form>
				<!-- 검색 끝 -->
				<!-- 페이징 바 -->
				<div class="row justify-content-center pagination-wrap">
					<ul class="pagination">
						<c:if test="${pInf.currentPage > 1}">
							<li>
								<!-- 맨 처음으로(<<) --> <a class="page-link"
								href="
		                    	<c:url value="ask">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>
	                    	">
									&lt;&lt; </a>
							</li>

							<li>
								<!-- 이전으로(<) --> <a class="page-link"
								href=" 
		                    	<c:url value="ask">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
		                    	</c:url>
	                    	">
									&lt; </a>
							</li>
						</c:if>

						<!-- 10개의 페이지 목록 -->
						<c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">


							<c:if test="${p == pInf.currentPage}">
								<li><a class="page-link">${p}</a></li>
							</c:if>

							<c:if test="${p != pInf.currentPage}">
								<li><a class="page-link"
									href=" 
			                    	<c:url value="ask">
			                    		<c:if test="${!empty param.searchKey }">
							        		<c:param name="searchKey" value="${param.searchKey}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.searchValue }">
							        		<c:param name="searchValue" value="${param.searchValue}"/>
							        	</c:if>
							        	
			                    		<c:param name="currentPage" value="${p}"/>
			                    	</c:url>
		                    	">
										${p} </a></li>
							</c:if>

						</c:forEach>

						<!-- 다음 페이지로(>) -->
						<c:if test="${pInf.currentPage < pInf.maxPage }">
							<li><a class="page-link"
								href=" 
		                    	<c:url value="ask">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    	</c:url>
	                    	">
									&gt; </a></li>

							<!-- 맨 끝으로(>>) -->
							<li><a class="page-link"
								href=" 
		                    	<c:url value="ask">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
		                    	</c:url>
	                    	">
									&gt;&gt; </a></li>

						</c:if>
					</ul>
				</div>
				<!-- 페이징 바 끝 -->
			</div>
		</c:if>
	</div>
	<!-- content 끝 -->

	<jsp:include page="../common/footer.jsp" />
	<!-- 팝업 start-->
	<div id="popup" class="popup">
	<form action="sendAnswer" method="post">
		<p class="popup-title">
			문의 내용 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<input id="thisAskNo" name="askNo" type="text" style="display:none;">
		<input id="thisAnswerEmail" name="askEmail" type="text" style="display:none;">
		<div class="popup-content">
			<div class="row mb-1">
				<div class="col-8 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">제목</span>
						</div>
						<input type="text" class="form-control" id="modal_askTitle" readonly>
					</div>
				</div>
				<div class="col-4 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">문의자</span>
						</div>
						<input type="text" name="memberId" class="form-control" id="modal_askId" readonly>
					</div>
				</div>
			</div>
			<div class="row mb-1">
				<div class="col-4 text-center"></div>
				<div class="col-4"></div>
				<div class="col-4 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">문의일</span>
						</div>
						<input type="text" class="form-control" id="modal_askEnrollDate"
							readonly>
					</div>
				</div>
			</div>
			<div class="row justify-content-md-center">
				<div class="col-11" id="modal_askContent"
					style="border: 2px solid lightgray; height: 9rem; overflow: auto;">
				</div>
			</div>
			<br>
			<div class="row justify-content-md-center">
				<textarea class="col-11" id="askAnswer" name="askAnswer"
					style="border: 2px solid lightgray; height: 9rem; overflow: auto; resize: none;" placeholder="답변 작성"></textarea>
			</div>
		</div>
		<button id="sendButton" class="popup-confirm-btn" type="submit" >확인</button>
	</form>
	</div>
	<div class="popup-shadow"></div>
	<!-- 로그인 팝업 end-->
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
		
		
		$("#admin-table td").not("#lastTd").on("click",	function() {
					$(".popup-shadow, #popup").show(0);
					var thisAskNo = $(this).parent().children().eq(0).text();
					var thisAnswerEmail = $(this).parent().children().eq(2).text();
					
					var thisAskId = $(this).parent().children().eq(1).text();
					var thisAskTitle = $(this).parent().children().eq(3).text();
					var thisAskEnrollDate = $(this).parent().children().eq(7).text();
					var thisAskContent = $(this).parent().children().eq(6).html();
					var thisAskAnswer = $(this).parent().children().eq(8).html();
					console.log(thisAskNo);
					$("#thisAskNo").val(thisAskNo);
					$("#thisAnswerEmail").val(thisAnswerEmail);
					
					$("#modal_askId").val(thisAskId);
					$("#modal_askTitle").val(thisAskTitle);
					$("#modal_askEnrollDate").val(thisAskEnrollDate);
					$("#modal_askContent").html(thisAskContent);
					
					if(thisAskAnswer != ""){
						$("#askAnswer").val(thisAskAnswer);
						$("#askAnswer").prop("readonly", true);
						$("#sendButton").css("display", "none");
					} else{
						$("#askAnswer").val("");
						$("#askAnswer").prop("readonly", false);
						$("#sendButton").removeAttr("style");
					}
				}).mouseenter(function() {
			$("#admin-table td").not("#lastTd").css("cursor", "pointer");
		});
		
		

		// 로그인 팝업 이벤트
		$(".close-popup, .popup-shadow, .popup-confirm-btn").on({
			click : function() {
				$(".popup-shadow, #popup").hide(0);
			}
		});
	</script>
</body>
</html>