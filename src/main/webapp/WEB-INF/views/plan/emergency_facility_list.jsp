<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>emergency_facility list</title>
</head>
<body>
<h1>응급시설 목록</h1>
<form method="post" action="${pageContext.request.contextPath}/plan/emergency_facility_filter_list">
  주소 입력: <input type="text" name="addressName" value="">
  <button type="submit" name="filterType" value="address">주소 검색</button>
  <button type="submit" name="categoryGroupName" value="병원">병원만 보기</button>
  <button type="submit" name="categoryGroupName" value="약국">약국만 보기</button>
</form>
<ul>
  <c:forEach items="${list}" var="emergency_facility">
    응급시설 id : ${emergency_facility.id} <br>
    응급시설 카테고리 그룹 : ${emergency_facility.categoryGroupName}  <br>
    응급시설 이름 : ${emergency_facility.placeName}  <br>
    응급시설 주소 : ${emergency_facility.addressName} <br>
    응급시설 전화번호 : ${emergency_facility.phone} <br>
    응급시설 URL : <a href="${emergency_facility.placeUrl}" target="_blank">${emergency_facility.placeUrl}</a> <br>
    <br>
    <hr>
  </c:forEach>
</ul>
</body>
</html>
