<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							<img class="w-100" style="border-radius: 50%;"
								src="img/profile-ex.png" alt="">
						</div>
						<div class="col-md-9 p-4">
							<h1>정환조</h1>
							<hr>
							<div class="row">
								<div class="col-md-5">
									<p class="h4">관심지역</p>
									<p>서울특별시 서대문구 북아현동</p>
									<p>나이 : 35세</p>
								</div>
								<div id="category" class="col-md-7">
									<p class="h4">관심 카테고리</p>
									<div class="text-center">여행</div>
									<div class="text-center">운동</div>
									<div class="text-center">독서</div>
									<div class="text-center">비즈니스</div>
									<div class="text-center">언어</div>
									<div class="text-center">음악</div>
									<div class="text-center">영화/공연</div>
									<div class="text-center">댄스</div>
									<div class="text-center">봉사활동</div>
									<div class="text-center">사교</div>
									<div class="text-center">차/오토바이</div>
									<div class="text-center">사진/영상</div>
									<div class="text-center">스포츠관람</div>
									<div class="text-center">게임</div>
									<div class="text-center">요리</div>
									<div class="text-center">반려동물</div>
									<div class="text-center">사회운동</div>
									<div class="text-center">뷰티</div>
									<div class="text-center">패션</div>
									<div class="text-center">기타</div>
								</div>
							</div>
							<p class="mt-3 introduce-text">반가워요 여러분!! 우리 친해져요.</p>
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