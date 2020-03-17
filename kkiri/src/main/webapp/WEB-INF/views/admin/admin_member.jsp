<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">

<title>관리자페이지 - 회원</title>
<!-- <style>
    input[type="number"]::-webkit-outer-spin-button,
    input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
    }
     </style> -->
</head>
<body>
	<div id="wrapper">
	<jsp:include page="../common/header.jsp" />
	<!-- content 시작 -->
	<div id="container" class="container">
		<div class="row mt-5">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					href="member" tabindex="-1">회원</a></li>
				<li class="nav-item"><a class="nav-link"
					href="event" tabindex="-1">이벤트</a></li>
				<li class="nav-item"><a class="nav-link"
					href="report" tabindex="-1">신고</a></li>
				<li class="nav-item"><a class="nav-link" href="ask"
					tabindex="-1">문의</a></li>
			</ul>
		</div>

		<div class="row justify-content-md-center">
			<div class="col-12">
				<h2 class="mt-3 mb-3">회원관리</h2>
				<table id="admin-table"
					class="table table-hover table-striped table-sm">
					<thead>
						<tr class="text-center">
							<th scope="col">회원번호</th>
							<th scope="col">아이디</th>
							<th scope="col">닉네임</th>
							<th scope="col">이메일</th>
							<th scope="col">생년월일</th>
							<th scope="col">전화번호</th>
							<th scope="col">티켓수</th>
							<th scope="col">환불</th>
							<th scope="col">삭제/복구</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${empty mList}">
						<tr>
							<td> 회원이 없습니다. </td>
						</tr>
					</c:if>
					<c:if test="${!empty mList}">
						<c:forEach var="member" items="${mList}" varStatus="vs">
							<tr class="text-center">
								<th scope="row">${member.memberNo}</th>
								<td>${member.memberId}</td>
								<td>${member.memberNickname}</td>
								<td>${member.memberEmail}</td>
								<td>
									${fn:substring(member.memberBirth, 0, 4)}년
									${fn:substring(member.memberBirth, 5, 7)}월
									${fn:substring(member.memberBirth, 8, 10)}일
								</td>
								<%-- ${member.memberBirth} --%>
								<td>${member.memberPhone}</td>
								<td>${member.memberTicket}</td>
								<c:if test="${member.memberAccount != null}">
									<td><button class="btn btn-sm btn-outline-primary btn-refund">환불</button></td>
								</c:if>
								<c:if test="${member.memberAccount == null}">
									<td><button class="btn btn-sm btn-outline-secondary">환불</button></td>
								</c:if>
								<c:if test="${member.memberStatus == 'Y'}">
									<td><button class="btn btn-sm btn-outline-danger btn-delete">삭제</button></td>
								</c:if>
								<c:if test="${member.memberStatus == 'N'}">
									<td><button class="btn btn-sm btn-outline-success btn-delete">복구</button></td>
								</c:if>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<form action="member" method="GET">
			<div class="row justify-content-md-center">
				<!-- 검색 -->
				<div class="col-md-2 col-sm-3">
					<div class="input-group">
						<select name="searchKey" class="custom-select" id="inputGroupSelect04"
							aria-label="Example select with button addon">
							<option value="id">아이디</option>
							<option value="nickname">닉네임</option>
						</select>
					</div>
				</div>
				<div class="col-md-9 col-sm-7">
					<div class="input-group mb-3">
						<input type="text" name="searchValue" class="form-control inputSection">
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
		                	<!-- 맨 처음으로(<<) -->
		                    <a class="page-link"
		                    	href="
		                    	<c:url value="member">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>
	                    	">
			                    &lt;&lt;
			                </a>
		                </li>
		                
		                <li>
		                	<!-- 이전으로(<) -->
	                   		<a class="page-link"
		                    	href=" 
		                    	<c:url value="member">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
		                    		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
		                    	</c:url>
	                    	">
			                    &lt;
			                </a>
		                </li>
	                </c:if>
	                
	                <!-- 10개의 페이지 목록 -->
	                <c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">
	                
	                
	                	<c:if test="${p == pInf.currentPage}">
			                <li>
			                    <a class="page-link">${p}</a>
			                </li>
		                </c:if>
	                	
	                	<c:if test="${p != pInf.currentPage}">
	                		<li>
		                    	<a  class="page-link"
			                    	href=" 
			                    	<c:url value="member">
			                    		<c:if test="${!empty param.searchKey }">
							        		<c:param name="searchKey" value="${param.searchKey}"/>
							        	</c:if>
							        	
							        	<c:if test="${!empty param.searchValue }">
							        		<c:param name="searchValue" value="${param.searchValue}"/>
							        	</c:if>
							        	
			                    		<c:param name="currentPage" value="${p}"/>
			                    	</c:url>
		                    	">
				                    ${p}
				                </a>
		                	</li>
	                	</c:if>
	                	
                	</c:forEach>
	                
	                <!-- 다음 페이지로(>) -->
	                <c:if test="${pInf.currentPage < pInf.maxPage }">
		                <li>
							<a class="page-link"
		                    	href=" 
		                    	<c:url value="member">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    	</c:url>
	                    	">
			                    &gt;
			                </a>
		                </li>
		                
		                <!-- 맨 끝으로(>>) -->
		                <li>
		                    <a class="page-link"
		                    	href=" 
		                    	<c:url value="member">
		                    		<c:if test="${!empty param.searchKey }">
						        		<c:param name="searchKey" value="${param.searchKey}"/>
						        	</c:if>
						        	<c:if test="${!empty param.searchValue }">
						        		<c:param name="searchValue" value="${param.searchValue}"/>
						        	</c:if>
						        	
		                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
		                    	</c:url>
	                    	">
			                    &gt;&gt;
			                </a>
		                </li>
	                
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
		<form action="refund" method="POST">
			<p class="popup-title">
				티켓 환불 <img src="${contextPath}/resources/img/close-btn.png"
					alt="닫기버튼" class="close-popup">
			</p>
			<input id="thisMemberNo" name="thisMemberNo" type="text" style="display:none;">
			<div class="popup-content">
				<div class="row justify-content-md-center mb-2">
					<div class="col-3 text-center">현재 티켓 수</div>
					&nbsp;&nbsp;
					<div class="col-3 text-center">취소 티켓 수</div>
					&nbsp;&nbsp;
					<div class="col-3 text-center">남은 티켓 수</div>
				</div>
				<div class="row justify-content-md-center">
					<div class="col-3">
						<input id="current-ticket" type="text" class="form-control" readonly>
					</div>
					<b style="line-height: 2rem;">-</b>
					<div class="col-3">
						<input id="canceled-ticket" name="canceledTicket" type="number" class="form-control">
					</div>
					<b style="line-height: 2rem;">=</b>
					<div class="col-3">
						<input id="remained-ticket" type="text" class="form-control">
					</div>
				</div>
			</div>
			<button id="refund" class="popup-confirm-btn" >확인</button>
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

		$(function () {
	      $("#admin-table td").not("#admin-table td:nth-child(8), #admin-table td:nth-child(9)").on("click", function () {
	        location.href="#";
	      }).mouseenter(function () {
	        $("#admin-table td").not("#admin-table td:nth-child(8), #admin-table td:nth-child(9)").css("cursor", "pointer");
	      });
	    });
		
		// 팝업 이벤트
		$(".btn-refund").on({
			click : function() {
				$(".popup-shadow, #popup").show(0);
				$("#current-ticket").val($(this).parent().parent().children().eq(6).text());
				$("#canceled-ticket").val("");
				$("#remained-ticket").val("");
				$("#thisMemberNo").val($(this).parent().parent().children().eq(0).text());
			}
		});
		$(".close-popup, .popup-shadow").on({
			click : function() {
				$(".popup-shadow, #popup").hide(0);
			}
		});

		$("#canceled-ticket").on("input", function() {
			$("#remained-ticket").val($("#current-ticket").val() - $("#canceled-ticket").val());
			if($("#remained-ticket").val()<0){
				alert("티켓 수가 부족합니다.");
		        $("#canceled-ticket").val("");
		        $("#remained-ticket").val("");
			}
		});
		
		// 환불 기능
		/* $("#refund").click(function(){
			var memberNo = $("#thisMemberNo").val();
			var canceledTicket =  $("#canceled-ticket").val(); 
			// 쿼리스트링을 이용하여 get 방식으로 글 번호를 server로 전달
			location.href="refund?memberNo=" + memberNo + "&canceledTicket=" + (-canceledTicket);
		});
 */
		$(".btn-delete").on("click", function() {
			var memberNo = $(this).parent().parent().children().eq(0).text();
			var memberThis = $(this);
			//console.log($(".btn-delete").text())
			if ($(this).text() == "삭제") {
				if (confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
                		url : "delete",
                		data : {memberNo: memberNo},
                		type : "post",
                		success : function(result){
                			if(result == "true"){
                				memberThis.text("복구");
                				memberThis.addClass("btn-success");
                				memberThis.removeClass("btn-danger");
                			}else{
                			}
                		},
                		error : function(e){
                			console.log("ajax 통신 실패");
                			console.log(e);
                		}
                	});
				}
			} else {
				$.ajax({
            		url : "recover",
            		data : {memberNo: memberNo},
            		type : "post",
            		success : function(result){
            			if(result == "true"){
            				memberThis.addClass("btn-danger");
            				memberThis.removeClass("btn-success");
            				memberThis.text("삭제");
            			}else{
            			}
            		},
            		error : function(e){
            			console.log("ajax 통신 실패");
            			console.log(e);
            		}
            	});
			}
		})
	</script>
</body>

</html>