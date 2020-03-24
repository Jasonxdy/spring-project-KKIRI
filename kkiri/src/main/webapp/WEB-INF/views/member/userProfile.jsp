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
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/resources/css/userProfile.css">
		<div class="container my-4 card bg-light">
			<div class="row">
				<div class="col-md-12">
					<div class="row p-1">
						<div class="col-md-3 p-4">
							<img class="w-100" style="border-radius: 50%;" src="${contextPath }/resources/upProfileImage/${member.memberProfile }" alt="">
						</div>
						<div class="col-md-9 p-4">
							<h1>${member.memberNickname }</h1>
							<hr>
							<div class="row">
								<div class="col-md-5">
									<p class="h4">관심지역</p>
									<p>${member.memberPlace }</p>
									<jsp:useBean id="now" class="java.util.Date"/>
									<fmt:formatDate value="${now}" pattern="yyyy" var="nowDate" />
									<fmt:formatDate value="${member.memberBirth}" pattern="yyyy" var="birthDate" />
									<p>성별 : ${member.memberGender}</p>
									<p>나이 : ${nowDate - birthDate +1 } 살</p>
								</div>
								<div id="category" class="col-md-7">
									<c:set var="mCategory" value="${fn:split(member.memberCategory,',')}"/>
									
									<p class="h4">관심 카테고리</p>
									<c:forEach var="cate" items="${mCategory }" varStatus="vs">
										<div class="text-center">${cate }</div>
									</c:forEach>
								</div>
							</div>
							<p class="mt-3 introduce-text">${member.memberIntroduce }</p>
						</div>
					</div>
				</div>
			</div>
			<hr class="mx-3">
			<div class="row p-3">
				<div class="col-md-2">
					<button class="event-btn-tab btn btn-primary m-1"
						style="background-color: #00a185; border: none;">생성한 이벤트</button>
					<button class="event-btn-tab btn btn-primary m-1"
						style="background-color: #00a185; border: none;">참여한 이벤트</button>
				</div>
				<div class="col-md-10">

					<div class="card shadow mb-4">
						<div class="col-md-12 ">
							<div class="row ">
								<div class="col-md-3 ">
									<img src="img/banner-alter-img.png" class="event-thumb"
										alt="이벤트 썸네일이미지">
								</div>
								<div class="col-md-6 p-3">
									<p class="mb-1" style="color: #00a185;">2020년 02월 21일 19:00</p>
									<h2 class="mb-3 event-title">[맛집 도장깨기 2기]</h2>
									<img class="mb-2" src="img/map-ping.png" alt="" style="width: 1rem; height: 1.5rem;">
									<span>서울 중구시 다산로</span>
									<p class="mb-0">내용ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
								</div>
								<div class="col-md-3">
									<div class="p-3">
										<div>
											<img style="width: 4rem; height: 4rem; border-radius: 50%;" src="img/profile-ex.png" alt="">
											<div style="display: inline-block;">
												<p class="mb-1">주최자 닉네임</p>
												<img style="width: 1rem; height: 1rem;" src="img/star-on.png" alt=""> <span>4.5</span>
											</div>
										</div>
										<p class="already-finish-event">종료된 이벤트</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row card shadow mb-4">
						<div class="col-md-12 ">
							<div class="row ">
								<div class="col-md-3 ">
									<img src="img/banner-alter-img.png" class="event-thumb" alt="이벤트 썸네일이미지">
								</div>
								<div class="col-md-6 p-3">
									<p class="mb-1" style="color: #00a185;">2020년 02월 21일 19:00</p>
									<h2 class="mb-3 event-title">[맛집 도장깨기 2기]</h2>
									<img class="mb-2" src="img/map-ping.png" alt="" style="width: 1rem; height: 1.5rem;">
										<span>서울 중구시 다산로</span>
									<p class="mb-0">내용ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
								</div>
								<div class="col-md-3">
									<div class="p-3">
										<div>
											<img style="width: 4rem; height: 4rem; border-radius: 50%;"
												src="img/profile-ex.png" alt="">
											<div style="display: inline-block;">
												<p class="mb-1">주최자 닉네임</p>
												<img style="width: 1rem; height: 1rem;"
													src="img/star-on.png" alt=""> <span>4.5</span>
											</div>
										</div>
										<p class="already-finish-event">종료된 이벤트</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row card shadow mb-4">
						<div class="col-md-12 ">
							<div class="row ">
								<div class="col-md-3 ">
									<img src="img/banner-alter-img.png" class="event-thumb"
										alt="이벤트 썸네일이미지">
								</div>
								<div class="col-md-6 p-3">
									<p class="mb-1" style="color: #00a185;">2020년 02월 21일 19:00</p>
									<h2 class="mb-3 event-title">[맛집 도장깨기 2기]</h2>
									<img class="mb-2" src="img/map-ping.png" alt=""
										style="width: 1rem; height: 1.5rem;"> <span>서울
										중구시 다산로</span>
									<p class="mb-0">내용ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
								</div>
								<div class="col-md-3">
									<div class="p-3">
										<div>
											<img style="width: 4rem; height: 4rem; border-radius: 50%;"
												src="img/profile-ex.png" alt="">
											<div style="display: inline-block;">
												<p class="mb-1">주최자 닉네임</p>
												<img style="width: 1rem; height: 1rem;"
													src="img/star-on.png" alt=""> <span>4.5</span>
											</div>
										</div>
										<p class="already-finish-event">종료된 이벤트</p>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 페이징 바 -->
					<div class="row justify-content-center pagination-wrap">
						<div>
							<ul class="pagination">
								<li><a class="page-link " href="#">&lt;&lt;</a></li>
								<li><a class="page-link " href="#">&lt;</a></li>
								<li><a class="page-link" href="#">1</a></li>
								<li><a class="page-link " href="#">2</a></li>
								<li><a class="page-link " href="#">3</a></li>
								<li><a class="page-link " href="#">4</a></li>
								<li><a class="page-link " href="#">5</a></li>
								<!-- 다음 페이지로(>) -->
								<li><a class="page-link " href="#">&gt;</a></li>
								<!-- 맨 끝으로(>>) -->
								<li><a class="page-link " href="#">&gt;&gt;</a></li>
							</ul>
						</div>
					</div>
					<!-- 페이징 바 끝 -->

				</div>
			</div>
		</div>

		<jsp:include page="../../../WEB-INF/views/common/footer.jsp" />
		
</body>
</html>