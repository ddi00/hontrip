<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>필터링된 숙박시설 목록</title>
</head>
<body>
<h1>필터링된 숙박시설 목록</h1>
<button onclick="location.href='/hontrip/plan/accommodation/list'">전체 숙박시설 보기</button>

<ul>
    <c:forEach items="${list}" var="accommodation">
        숙박 id : ${accommodation.id} <br>
        숙박 구분 : ${accommodation.categoryName}  <br>
        숙박 이름 : ${accommodation.placeName}  <br>
        숙박 주소 : ${accommodation.addressName} <br>
        숙박 전화번호 : ${accommodation.phone} <br>
        숙박 URL : <a href="${accommodation.placeUrl}" target="_blank">${accommodation.placeUrl}</a> <br>
        <br>
        <hr>
    </c:forEach>
</ul>
</body>
</html>
