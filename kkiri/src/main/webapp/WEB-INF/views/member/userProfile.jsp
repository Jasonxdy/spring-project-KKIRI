<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../../../WEB-INF/views/common/header.jsp" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/userProfile.css">
		<div class="container my-4 card bg-light">
			<div class="row">
				<div class="col-md-12">
					<div class="row p-1 user-profile-first-wrap">
						<div class="col-md-3 p-4">
							<img class="profile-img" style="border-radius: 50%;" src="${contextPath }/resources/upProfileImage/${member.memberProfile }" alt="">
						</div>
						<div class="col-md-9 p-4">
							<h1>${member.memberNickname }</h1>
							<hr>
							<div class="row">
								<div class="col-md-5">
									<p class="h4">관심지역</p>
									<p>${member.memberPlace }</p>
									<jsp:useBean id="now" class="java.util.Date"/>
									<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />
									<fmt:formatDate value="${now}" pattern="yyyy" var="birthYear" />
									<fmt:formatDate value="${member.memberBirth}" pattern="yyyy" var="birthDate" />
									<p>성별 : ${member.memberGender}</p>
									<p>나이 : ${birthYear - birthDate +1 } 살</p>
								</div>
								<div id="category" class="col-md-6">
									<c:set var="mCategory" value="${fn:split(member.memberCategory,',')}"/>
									
									<p class="h4">관심 카테고리</p>
									<c:forEach var="cate" items="${mCategory }" varStatus="vs">
										<div class="text-center">${cate }</div>
									</c:forEach>
								</div>
								<c:if test='${loginMember.memberNo != member.memberNo }'>
									<div class="col-md-1 px-0">
										<div class="btn" onclick="theLove()">
											<img id="favor" src="${contextPath}/resources/img/undoFavor.png">
										</div>
									</div>
								</c:if>
							</div>
							<p class="mt-3 introduce-text">${member.memberIntroduce }</p>
						</div>
					</div>
				</div>
			</div>
			<hr class="mx-3">
			<div class="row p-3">
				<div class="col-md-2 event-tab-area">
					<button id="createBtn" class="event-btn-tab btn m-1"
						style="background-color: #00a185; border: none; color: white;" onclick="createBtn()">생성한 이벤트</button>
					<button id="joinBtn" class="event-btn-tab btn m-1"
						style="color: #00a185; border: 0.5px solid;" onclick="joinBtn()">참여한 이벤트</button>
				</div>
				<div class="col-md-10" id="eventArea">

				</div>
			</div>
		</div>

		<jsp:include page="../../../WEB-INF/views/common/footer.jsp" />
		
<script>
	//임시
	<c:if test='${loginMember != null}'>
		var loginMemberNo = ${loginMember.memberNo};
	</c:if>
	<c:if test='${loginMember == null}'>
		var loginMemberNo = -1;
	</c:if>
	
	var memberNo = ${member.memberNo};
	
	// 생성한 이벤트는 0, 참여한 이벤트는 1으로 구분한다
	var flag = 0;
	var currentPage = 1;
	
	var startPage=1;
	var endPage=1;
	var maxPage=1;
	
	function eventList(){
		$.ajax({
			url : "eventList",
			type : "POST",
			data : {"memberNo" : memberNo,
					"currentPage" : currentPage,
					"flag" : flag},
			dataType : "json",
			success : function(data){
				var content ="";
				
				if(data.eList == ""){
					$("#eventArea").empty();
					content = "<div class='text-center h2' style='margin:100px 0;'>존재하는 이벤트가 없습니다.</div>";
					$(content).appendTo("#eventArea");
				} else{
					$("#eventArea").empty();
					maxPage = data.pInf.maxPage;
					
					$.each(data.eList, function(i){
						// 시작 시간 포맷 변경
						startDate = data.eList[i].eventStart.substring(0,4) +
									 "년 " + 
									 data.eList[i].eventStart.substring(4,6) +
									 "월 "+
									 data.eList[i].eventStart.substring(6,8) +
									 "일 " +
									 data.eList[i].eventStart.substring(8,10) +
									 ":" +
									 data.eList[i].eventStart.substring(10,12);
									 
						content += 
									"<div class='card shadow mb-4'>" +
										"<div class='col-md-12 eventBar' onclick=\"location.href= '${contextPath}/event/detail?no="+ data.eList[i].eventNo +"'\" >" +
											"<div class='row'>" +
												"<div class='col-md-3'>" +
													"<img src='${contextPath}/resources/upEventThumbnail/" + data.eList[i].eventThumbnail + "' class='event-thumb' alt='이벤트 썸네일이미지'>" +
												"</div>" +
												"<div class='col-md-6 p-3'>" +
													"<p class='mb-1' style='color: #00a185;''>" + startDate + "</p>" +
													"<h2 class='mb-3 event-title'>" + data.eList[i].eventTitle + "</h2>" +
													"<img class='mb-2' src='${contextPath}/resources/img/map-ping.png' alt='' style='width: 1rem; height: 1.5rem;'>" +
													"<span>" + data.eList[i].eventAddress + "</span>" +
													"<p>"+ data.eList[i].eventLocation+"</p>" +
													"<p class='mb-0'>" + data.eList[i].eventCategory + "</p>" +
												"</div>" +
												"<div class='col-md-3'>" +
													"<div class='p-3'>" +
														"<div>" +
															"<img style='width: 4rem; height: 4rem; border-radius: 50%;' src='${contextPath}/resources/upProfileImage/"+ data.eList[i].memberProfile +"' alt=''>" +
															"<div style='display: inline-block; vertical-align: middle;'>" +
																"<p class='mb-1'>" + data.eList[i].memberNickname + "</p>" +
																"<img style='width: 1rem; height: 1rem;' src='${contextPath}/resources/img/star-on.png' alt=''>" +
																"<span>" + data.eList[i].eventScore.toFixed(1) + "</span>" +
															"</div>" +
														"</div>";
										if(${nowDate} < data.eList[i].eventEnd){
													content += "<p id='join' class='text-center float-right' style='margin-top: 5rem;'>티켓"+ data.eList[i].eventTicket + "장</p>" +
															"</div>" +
														"</div>" +
													"</div>" +
												"</div>" +
											"</div>";
										} else{
													content += "<p class='already-finish-event float-right' style='margin-top: 5rem;'>종료된 이벤트</p>" +
													"</div>" +
												"</div>" +
											"</div>" +
										"</div>" +
										"</div>";
						}
					});
					
					content += 	"<div style='clear: both;' class='row justify-content-center'>" +
									"<ul class='pagination'>";
					if(data.pInf.currentPage > 1){
					content +=			"<li>" +
											"<a class='page-link' onclick='pageClick(this)'>&lt;&lt;</a>" +
										"</li>" +
										"<li>" +
											"<a class='page-link' onclick='pageClick(this)'>&lt;</a>" +
										"</li>";
					}
					for(var p = data.pInf.startPage ; p <= data.pInf.endPage ; p++ ){
						if(p === data.pInf.currentPage){
							content +=	
								"<li>" +
									"<a class='page-link active' onclick='pageClick(this)'>" + p + "</a>" +
								"</li>";
						}
						if(p != data.pInf.currentPage){
							content += 	
								"<li>" +
									"<a class='page-link' onclick='pageClick(this)'>" + p + "</a>" +
								"</li>";
						}
					}
					
					if(data.pInf.currentPage < data.pInf.maxPage){
						content +=
							"<li>" +
								"<a class='page-link' onclick='pageClick(this)'>&gt;</a>" +
							"</li>" +
							"<li>" +
								"<a class='page-link' onclick='pageClick(this)'>&gt;&gt;</a>" +
							"</li>";
					}
					content += 
						"</ul>" +
					"</div>";

					$(content).appendTo("#eventArea");
				}
			}, error : function(){
    			alert("이벤트 리스트 호출 ajax 실패");
    		}
		});
	}
	
	function theLove(){
		if(loginMemberNo == -1){
			alert("로그인 해주세요");
			return false;
		}
		
		$.ajax({
			url : "theLove",
			type : "POST",
			data : { "memberNo" : loginMemberNo,
						"favoriteNo" : ${member.memberNo}},
			dataType : "json",
			success : function(result){
				if(result==1){
					$("#favor").prop("src","${contextPath}/resources/img/doFavor.png");
				} else{
					$("#favor").prop("src","${contextPath}/resources/img/undoFavor.png");
				}
			} , error : function(){
    			alert("즐겨찾기 등록 ajax 실패");
    		}
		});
	}
	
	function createBtn(){
		$("#joinBtn").prop('style','color: #00a185; border: 0.5px solid;');
		$("#createBtn").prop('style','background-color: #00a185; border: none; color: white;');
		flag = 0;
		currentPage = 1;
		eventList();
	}
	
	function joinBtn(){
		$("#joinBtn").prop('style','background-color: #00a185; border: none; color: white;');
		$("#createBtn").prop('style','color: #00a185; border: 0.5px solid;');
		flag = 1;
		currentPage = 1;
		eventList();
	}
	
	function pageClick(test){
		var temp = $(test).text();
		
		currentPage *= 1;
		switch(temp){
		case '<<': currentPage = 1; break;
		case '<': currentPage -= 1; break;
		case '>': currentPage += 1; break;
		case '>>': currentPage = maxPage; break;
		default: currentPage = temp; break;
		}
		eventList();
	};
	
	$(function(){
		<c:if test='${checkFavorite == 1}'>
			$("#favor").prop("src","${contextPath}/resources/img/doFavor.png");
		</c:if>
			
		eventList();
	});
	
</script>
</body>
</html>