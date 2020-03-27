<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 이벤트</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin.css">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../common/header.jsp" />
			<!-- content 시작 -->
			<div id="container" class="container">
				<div class="row mt-5">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link" href="member"
							tabindex="-1">회원</a></li>
						<li class="nav-item"><a class="nav-link active" href="event"
							tabindex="-1">이벤트</a></li>
						<li class="nav-item"><a class="nav-link" href="report"
							tabindex="-1">신고</a></li>
						<li class="nav-item"><a class="nav-link" href="ask"
							tabindex="-1">문의</a></li>
						<li class="nav-item"><a class="nav-link" href="management"
					tabindex="-1">관리</a></li>
					</ul>
				</div>

				<div class="row justify-content-md-center">
					<div class="col-12 rounded-sm">
						<h2 class="mt-3 mb-3">이벤트 관리</h2>
						<table id="admin-table"
							class="table table-hover table-striped table-sm">
							<thead>
								<tr class="text-center">
					                <th scope="col">이벤트번호</th>
					                <th scope="col">주최자</th>
					                <th scope="col">제목</th>
					                <th scope="col">장소</th>
					                <th scope="col">정원</th>
					                <th scope="col">참석인원</th>
					                <th scope="col">입장티켓</th>
					                <th scope="col">
				                	<select id="eventStatus" 
										<c:if test="${!empty param.eventStatus}">
											<c:if test="${param.eventStatus != 'no'}">
												style="background-color: rgba(0,161,133,.6)"
											</c:if>
										</c:if> 
									>
									
									
									
										<option value="no">상태▽</option>
										<option value="end">종료</option>
										<option value="in">진행중</option>
										<option value="expect">예정</option>
									</select>
					                </th>
					            </tr>
							</thead>
							<tbody>
								<c:forEach var="event" items="${eList}" varStatus="vs">
								<tr class="text-center">
									<th scope="row">${event.eventNo}</th>
									<td>${event.eventCategory}</td>
									<c:if test="${fn:length(event.eventTitle) gt '20'}">
									<td>${fn:substring(event.eventTitle, 0, 20)}...</td>
									</c:if>
									<c:if test="${fn:length(event.eventTitle) lt '21'}">
										<td>${event.eventTitle}</td>
									</c:if>
									<td>${event.eventLocation}</td>
									<td>${event.eventQuota}</td>
									<td>${event.memberNo}</td>
									<td>${event.eventTicket}</td>
									<!-- eventThumbnail에 종료여부 담음 -->
									<c:if test="${event.eventThumbnail == 'end'}">
										<td style="color:red;">종료</td>
									</c:if>
									<c:if test="${event.eventThumbnail == 'in'}">
										<td style="color:green;">진행중</td>
									</c:if>
									<c:if test="${event.eventThumbnail == 'expect'}">
										<td style="color:grey;">예정</td>
									</c:if>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<form action="event" method="get">
					<div class="row justify-content-md-center">
						<!-- 검색 -->
						<div class="col-md-2 col-sm-3">
							<div class="input-group">
								<select class="custom-select" id="inputGroupSelect04"
									name="searchKey" aria-label="Example select with button addon">
									<option value="sponsor">주최자</option>
									<option value="title"
										<c:if test="${param.searchKey == 'title'}">
										selected
										</c:if>
									>제목</option>
								</select>
							</div>
						</div>
						<div class="col-md-9 col-sm-7">
							<div class="input-group mb-3">
								<input type="text" class="form-control" placeholder=""
									name="searchValue" aria-label="Username" aria-describedby="basic-addon1"
									<c:if test="${!empty param.searchValue }">
									value="${param.searchValue}"
									</c:if>
									>
								<c:if test="${!empty param.eventStatus }">
									<input type="text" name="eventStatus" value="${param.eventStatus}" style="display:none;">
		        				</c:if>
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
		                    	<c:url value="event">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.eventStatus }">
						        		<c:param name="eventStatus" value="${param.eventStatus}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>
	                    	">
									&lt;&lt; </a>
							</li>

							<li>
								<!-- 이전으로(<) --> <a class="page-link"
								href=" 
		                    	<c:url value="event">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.eventStatus }">
						        		<c:param name="eventStatus" value="${param.eventStatus}"/>
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
			                    	<c:url value="event">
			                    		<c:if test="${!empty param.searchKey }">
							        		<c:param name="searchKey" value="${param.searchKey}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.searchValue }">
							        		<c:param name="searchValue" value="${param.searchValue}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.eventStatus }">
							        		<c:param name="eventStatus" value="${param.eventStatus}"/>
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
		                    	<c:url value="event">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.eventStatus }">
						        		<c:param name="eventStatus" value="${param.eventStatus}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    	</c:url>
	                    	">
									&gt; </a></li>

							<!-- 맨 끝으로(>>) -->
							<li><a class="page-link"
								href=" 
		                    	<c:url value="event">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.eventStatus }">
						        		<c:param name="eventStatus" value="${param.eventStatus}"/>
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
	</div>
	<!-- content 끝 -->

	<jsp:include page="../common/footer.jsp" />
	
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
		
		// 상태 검색 기능
		$(function () {
		      $("#eventStatus").on("change", function () {
		    	  var eventStatus = $("#eventStatus").val();
		    	  <c:url var="event" value="event">
        			<c:if test="${!empty param.searchKey }">
	        			<c:param name="searchKey" value="${param.searchKey}"/>
		        	</c:if>
		        	<c:if test="${!empty param.searchValue }">
		        		<c:param name="searchValue" value="${param.searchValue}"/>
		        	</c:if>
	               	<c:param name="currentPage" value="${param.currentPage}"/>
	             </c:url>
				//console.log(reportC);
				location.href="${event}&eventStatus=" + eventStatus;
		      })
	      });
		// select 유지
        $(function(){
			var eventStatus = $("#eventStatus").children();
			for(var i=0; i<eventStatus.length; i++){
				//console.log(select[i].innerHTML + "${param.reportC}");
				if(eventStatus[i].value == "${param.eventStatus}"){
					eventStatus[i].setAttribute("selected", "true");
				}
			}
			//console.log($("#reportC").children().eq(0).val());
		})
		
		
		$("#admin-table td").not("#lastTd").on("click",	function() {
			var eventNo = $(this).parent().children().eq(0).text();
			
			location.href="${contextPath}/event/detail?no="+eventNo;
				
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