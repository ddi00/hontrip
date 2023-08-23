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


    <c:forEach items="${feedlist}" var="postInfoDTO">
        <div id="publicfeed">
            <img src="<c:url value='/${postInfoDTO.thumbnail}'/>"width="300" height="180"><br>,
            글제목 : <a href="postinfo?id=${postInfoDTO.boardId}">${postInfoDTO.boardId}</a>,/
            공개여부: ${postInfoDTO.isVisible}/
            유저닉네임: ${postInfoDTO.nickName}/
            좋아요개수: ${postInfoDTO.likeCount}/
            지역명 : ${postInfoDTO.city}/
        </div>
    </c:forEach>

</body>
</html>
