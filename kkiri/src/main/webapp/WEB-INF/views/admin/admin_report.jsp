<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 신고</title>
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
					<li class="nav-item"><a class="nav-link" href="event"
						tabindex="-1">이벤트</a></li>
					<li class="nav-item"><a class="nav-link active" href="report"
						tabindex="-1">신고</a></li>
					<li class="nav-item"><a class="nav-link" href="ask"
						tabindex="-1">문의</a></li>
				</ul>
			</div>

			<div class="row justify-content-md-center">
				<div class="col-12 rounded-sm">
					<h2 class="mt-3 mb-3">신고 관리</h2>
					<table id="admin-table"
						class="table table-hover table-striped table-sm">
						<thead>
							<tr class="text-center">
								<th scope="col">신고번호</th>
								<th scope="col">신고자</th>
								<th scope="col">신고대상</th>
								<th scope="col">
									<!-- 신고유형 -->
									<select id="reportC" 
										<c:if test="${!empty param.reportC}">
											<c:if test="${param.reportC != 'no'}">
												style="background-color: rgba(0,161,133,.6);"
											</c:if>
										</c:if>
									>
										<option value="no">신고유형▽</option>
										<option value="A">선정적,불법</option>
										<option value="B">부적합 주제</option>
										<option value="C">욕설,광고,저작권</option>
										<option value="D">정보 부족</option>
										<option value="E">불참,괴롭힘,폭력</option>
										<option value="F">기타</option>
									</select>
								</th>
								<th scope="col">이벤트명</th>
								<th scope="col">신고일자</th>
								<th scope="col">상세</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty rList}">
							<tr class="text-center">
								<td>신고 내역이 없습니다.</td>
							</tr>
							</c:if>
							<c:if test="${!empty rList}">
							<c:forEach var="report" items="${rList}" varStatus="vs">
							<tr class="text-center">
								<th scope="row">${report.reportNo}</th>
								<td>${report.reportMember}</td>
								<td>${report.reportedMember}</td>
								<c:if test="${report.reportCategory == 'A'}">
								<td>선정적, 불법</td>
								</c:if>
								<c:if test="${report.reportCategory == 'B'}">
								<td>부적합 주제</td>
								</c:if>
								<c:if test="${report.reportCategory == 'C'}">
								<td>욕설, 광고, 저작권</td>
								</c:if>
								<c:if test="${report.reportCategory == 'D'}">
								<td>정보 부족</td>
								</c:if>
								<c:if test="${report.reportCategory == 'E'}">
								<td>불참, 괴롭힘, 폭력</td>
								</c:if>
								<c:if test="${report.reportCategory == 'F'}">
								<td>기타</td>
								</c:if>
								<c:if test="${fn:length(report.eventTitle) gt '20'}">
									<td>${fn:substring(report.eventTitle, 0, 20)}...</td>
								</c:if>
								<c:if test="${fn:length(report.eventTitle) lt '21'}">
									<td>${report.eventTitle}</td>
								</c:if>
								<td>${report.reportDate}</td>
								<td style="display:none;">${report.reportContent}</td>
								<td style="display:none;">${report.eventNo}</td>
								<td id="lastTd"><button class="btn btn-sm btn-outline-dark moveEvent">이동</button></td>
							</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

			<form action="report" method="get">
			<div class="row justify-content-md-center">
				<!-- 검색 -->
				<div class="col-md-2 col-sm-3">
					<div class="input-group">
						<select class="custom-select" id="inputGroupSelect04" name="searchKey"
							aria-label="Example select with button addon">
							<option value="report">신고자</option>
							<option value="reported"
								<c:if test="${param.searchKey == 'reported'}">
								selected
								</c:if>
							>신고대상</option>
						</select>
					</div>
				</div>
				<div class="col-md-9 col-sm-7">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="" name="searchValue"
							aria-label="Username" aria-describedby="basic-addon1"
							<c:if test="${!empty param.searchValue }">
							value="${param.searchValue}"
							</c:if>
							>
						<c:if test="${!empty param.reportC }">
							<input type="text" id="reportC" name="reportC" value="${param.reportC}" style="display:none;">
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
		                    	<c:url value="report">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.reportC }">
						        		<c:param name="reportC" value="${param.reportC}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>
	                    	">
								&lt;&lt; </a>
						</li>

						<li>
							<!-- 이전으로(<) --> <a class="page-link"
							href=" 
		                    	<c:url value="report">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.reportC }">
						        		<c:param name="reportC" value="${param.reportC}"/>
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
			                    	<c:url value="report">
			                    		<c:if test="${!empty param.searchKey }">
							        		<c:param name="searchKey" value="${param.searchKey}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.searchValue }">
							        		<c:param name="searchValue" value="${param.searchValue}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.reportC }">
							        		<c:param name="reportC" value="${param.reportC}"/>
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
		                    	<c:url value="report">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.reportC }">
						        		<c:param name="reportC" value="${param.reportC}"/>
						        	</c:if>
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    	</c:url>
	                    	">
								&gt; </a></li>

						<!-- 맨 끝으로(>>) -->
						<li><a class="page-link"
							href=" 
		                    	<c:url value="report">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.reportC }">
						        		<c:param name="reportC" value="${param.reportC}"/>
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
		<!-- content 끝 -->
	</div>

	<jsp:include page="../common/footer.jsp" />
	<!-- 팝업 start-->
	<div id="popup" class="popup">
		<p class="popup-title">
			신고 내용 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<div class="popup-content">
			<div class="row mb-1">
				<div class="col-6 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">카테고리</span>
						</div>
						<input id="modal_category" type="text" class="form-control" readonly>
					</div>
				</div>
				<div class="col-2"></div>
				<div class="col-4 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">신고자</span>
						</div>
						<input id="modal_reportId" type="text" class="form-control" readonly>
					</div>
				</div>
			</div>
			<div class="row mb-1">
				<div class="col-4 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">신고대상</span>
						</div>
						<input id="modal_reportedId" type="text" class="form-control" readonly>
					</div>
				</div>
				<div class="col-4"></div>
				<div class="col-4 text-center">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">신고일</span>
						</div>
						<input id="modal_reportDate" type="text" class="form-control"	readonly>
					</div>
				</div>
			</div>
			<div class="row justify-content-md-center">
				<div id="modal_reportContent" class="col-11"
					style="border: 2px solid lightgray; height: 20rem; overflow: auto;">
				</div>
			</div>
		</div>
		<button class="close-popup popup-confirm-btn">확인</button>
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

		$(function() {
			$("#admin-table td").not("#lastTd").on("click", function() {
				$(".popup-shadow, #popup").show(0);
				//var thisReportNo = $(this).parent().children().eq(0).text();
				var thisReportId = $(this).parent().children().eq(1).text();
				var thisReportCategory = $(this).parent().children().eq(3).text();
				var thisReportedId = $(this).parent().children().eq(2).text();
				var thisReportDate = $(this).parent().children().eq(5).text();
				var thisReportContent = $(this).parent().children().eq(6).html();
				$("#modal_reportId").val(thisReportId);
				$("#modal_category").val(thisReportCategory);
				$("#modal_reportedId").val(thisReportedId);
				$("#modal_reportDate").val(thisReportDate);
				$("#modal_reportContent").html(thisReportContent);
				
			}).mouseenter(function() {
				$("#admin-table td").not("#lastTd").css("cursor", "pointer");
			});
		});
		
		// 유형 검색
		$(function () {
		      $("#reportC").on("change", function () {
		    	  var reportC = $("#reportC").val();
		    	  <c:url var="report" value="report">
          			<c:if test="${!empty param.searchKey }">
	        			<c:param name="searchKey" value="${param.searchKey}"/>
		        	</c:if>
		        	<c:if test="${!empty param.searchValue }">
		        		<c:param name="searchValue" value="${param.searchValue}"/>
		        	</c:if>
	               	<c:param name="currentPage" value="1"/>
	             </c:url>
				//console.log(reportC);
				location.href="${report}&reportC=" + reportC;
		      }).mouseenter(function () {
		        $("#admin-table th").eq(8).css("cursor", "pointer");
		      });
		    });
		
		$(function(){
			var select = $("#reportC").children();
			for(var i=0; i<select.length; i++){
				//console.log(select[i].innerHTML + "${param.reportC}");
				if(select[i].value == "${param.reportC}"){
					select[i].setAttribute("selected", "true");
				}
			}
			//console.log($("#reportC").children().eq(0).val());
		})
		
		$(".moveEvent").on("click", function(){
			var eventNo = $(this).parent().parent().children().eq(7).text();
			console.log(eventNo);
			location.href = "${contextPath}/event/detail?eventNo=" + eventNo 
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