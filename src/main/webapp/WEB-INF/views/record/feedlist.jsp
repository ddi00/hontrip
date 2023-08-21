<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

</head>
<body>
피드 <br>
(공개여부 1인 게시물 모두)<br>
로그인 없이도 볼 수 있음
<hr color="red">


    <c:forEach items="${feedlist}" var="createPostDTO">

        썸네일 : ${createPostDTO.thumbnail},
        글제목 : ${createPostDTO.title},
        공개여부: ${createPostDTO.isVisible}<br>

    </c:forEach>

</body>
</html>
