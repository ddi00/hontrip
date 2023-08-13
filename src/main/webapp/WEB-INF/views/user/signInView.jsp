<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>소셜 로그인 테스트</title>
</head>
<body>
	<h1>소셜 로그인 테스트</h1>
	<!-- 소셜로그인 버튼을 순서대로 뿌려준다 -->
		<c:forEach items="${urls}" var="loginUrl">
			<a href="${loginUrl.loginHref}">
				<img src="<c:url value='${loginUrl.imgSrc}'/>" width="183" alt="${loginUrl.provider} 로그인">
			</a><br>
		</c:forEach>
</body>
</html>
