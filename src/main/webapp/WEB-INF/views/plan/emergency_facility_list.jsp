<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>emergency_facility list</title>
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


  </style>
</head>
<body>
<div class="container">
  <h1 class="mt-4">응급시설 목록</h1>
  <form class="mt-3 left-aligned" method="post" action="${pageContext.request.contextPath}/plan/emergency_facility_filter_list">
    <div class="input-group mb-3">
      <select id="categorySelect" name="categoryGroupName" class="form-select">
        <option value="" selected>전체</option>
        <option value="병원">병원</option>
        <option value="약국">약국</option>
      </select>
      <input type="text" id="addressName" name="addressName" class="form-control me-2" placeholder="주소 입력" value="">
      <button type="submit" name="filterType" value="address" class="btn custom-orange">주소 검색</button>
    </div>
  </form>
  <ul class="emergency-facility-list left-aligned mt-4">
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
