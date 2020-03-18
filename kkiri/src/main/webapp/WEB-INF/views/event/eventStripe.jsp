<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<nav class="navbar navbar-expand-sm navbar-light" id="stripe">
		<div class="container" id="event-navi">
			<ul class="navbar-nav nav-ul ml-2">
				<li class="nav-item"><a class="nav-link active" href="#">정보</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">참가회원</a></li>
			</ul>

			<ul class="navbar-nav nav-ul ml-2">
				<c:choose>
					<c:when test="${(event.eventQuota - fn:length(partyList)-1) <= 0}">
						<li class="nav-item mt-2 text-muted"><b class="text-danger"> 모집 완료 </b></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item mt-2 text-muted"><b> ${event.eventQuota - fn:length(partyList)-1}자리 남음 </b></li>
					</c:otherwise>
				</c:choose>
				<li class=""><a class="nav-link" href="selectParty"
					id="event-participate"> 이벤트 참가 </a></li>
				<li class="nav-item dropdown" id="report-button"><a
					class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown"> ··· </a>
					<div class="declare-wrap">
						<a class="declare-btn" href="#">이벤트 신고하기</a>
					</div></li>
			</ul>
		</div>
	</nav>

</body>
</html>