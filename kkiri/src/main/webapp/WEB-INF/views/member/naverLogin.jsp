<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>KKIRI(끼리)</title>
</head>

<body>
	<jsp:include page="../common/header.jsp"/>
	<a href="${token_url}"><button id="btnJoinGoogle" class="btn btn-primary btn-round"
                                style="width: 100%">
                                <i class="fa fa-google" aria-hidden="true"></i>naver login
                            </button></a> 
	<jsp:include page="../common/footer.jsp" />   

</body>

</html>
