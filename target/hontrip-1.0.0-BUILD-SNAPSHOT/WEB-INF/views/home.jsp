<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <c:if test="${empty sessionScope.id}">		<!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
        <a href="/hontrip/user/sign-in">사용자 로그인</a>
    </c:if>
    <c:if test="${not empty sessionScope.id}"><!-- 세션에 ID값이 있는 경우, 로그아웃 링크 출력 -->
        <a href="/hontrip/user/logout">사용자 로그아웃</a>
    </c:if>
    <br>
    <a href="mate/bbs_list?page=1">
        <button class="bbs_list">
            게시물 전체 목록
        </button>
    </a>
    <br>
동행인 매칭<br>
<a href="mate/insert">동행인 매칭 게시글 작성</a><br>
<a href="mate/88">동행인 매칭 게시글 상세페이지</a>
</body>
</html>
