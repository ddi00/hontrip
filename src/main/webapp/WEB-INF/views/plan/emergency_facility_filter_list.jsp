<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>필터링된 응급시설 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .custom-orange {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }

    .emergency-facility-list {
      list-style-type: none;
      padding: 0;
    }

    .emergency-facility-item {
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 20px;
    }

    .emergency-facility-item strong {
      display: inline-block;
      width: 180px;
      font-weight: bold;
    }

    .emergency-facility-item a {
      color: #007BFF;
    }

    .container {
      text-align: center;
    }

    .left-aligned {
      text-align: left;
    }

    .view-all-button {
      background-color: #FF9F1C;
    }

    .view-all-button {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }

  </style>
</head>
<body>
<div class="container">
  <h1 class="mt-4">필터링된 응급시설 목록</h1>
  <button class="btn custom-orange mt-3 view-all-button" onclick="location.href='/hontrip/plan/emergency_facility_list'">전체 응급시설 보기</button>
  <ul class="emergency-facility-list mt-4 left-aligned">
    <c:forEach items="${list}" var="emergency_facility">
      <li class="emergency-facility-item">
        <strong>응급시설 id:</strong> ${emergency_facility.id}<br>
        <strong>응급시설 카테고리 그룹:</strong> ${emergency_facility.categoryGroupName}<br>
        <strong>응급시설 이름:</strong> ${emergency_facility.placeName}<br>
        <strong>응급시설 주소:</strong> ${emergency_facility.addressName}<br>
        <strong>응급시설 전화번호:</strong> ${emergency_facility.phone}<br>
        <strong>응급시설 URL:</strong> <a href="${emergency_facility.placeUrl}" target="_blank">${emergency_facility.placeUrl}</a><br>
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>

