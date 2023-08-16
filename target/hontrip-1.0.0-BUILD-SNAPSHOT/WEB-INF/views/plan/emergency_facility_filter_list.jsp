<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-14
  Time: 오후 7:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>필터링된 응급시설 목록</title>
</head>
<body>
<h1>필터링된 응급시설 목록</h1>
<button onclick="location.href='/hontrip/plan/emergency_facility_list'">전체 응급시설 보기</button>
<ul>
  <c:forEach items="${list}" var="emergency_facility">
    응급시설 id : ${emergency_facility.id} <br>
    응급시설 카테고리 그룹 : ${emergency_facility.categoryGroupName} <br>
    응급시설 이름 : ${emergency_facility.placeName} <br>
    응급시설 주소 : ${emergency_facility.addressName} <br>
    응급시설 전화번호 : ${emergency_facility.phone} <br>
    응급시설 URL : <a href="${emergency_facility.placeUrl}" target="_blank">${emergency_facility.placeUrl}</a> <br>
    <br>
    <hr>
  </c:forEach>
</ul>
</body>
</html>

