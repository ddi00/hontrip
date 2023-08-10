<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>소셜 로그인 테스트</h1>
	<c:forEach items="${urls}" var="loginUrl">
		<a href="${loginUrl.loginHref}">
			<img src="<c:url value='${loginUrl.imgSrc}' />" alt="${loginUrl.provider} 로그인">
		</a>
	</c:forEach>
</body>
</html>