숙소 필터 리스트

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>필터링된 숙박시설 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      padding: 20px;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
    }
    .btn-custom {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }
    .mb-3 {
      margin-bottom: 15px;
    }
    .accommodation-card {
      background-color: white;
      border: 1px solid #dee2e6;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
    }
    .accommodation-card h4 {
      margin-top: 0;
    }
    .text-center-custom {
      text-align: center;
    }
    .text-left-custom {
      text-align: left;
    }
  </style>
</head>
<body>
<div class="container">
  <h1 class="mt-4 text-center-custom">필터링된 숙박시설 목록</h1>
  <a href="/hontrip/plan/accommodation/list" class="btn btn-custom mb-3 text-left-custom">전체 숙박시설 보기</a>

  <ul class="list-unstyled text-left-custom">
    <c:forEach items="${list}" var="accommodation">
      <li class="accommodation-card">
        <p><strong>숙박 id:</strong> ${accommodation.id}
        <p><strong>숙박 구분:</strong> ${accommodation.categoryName}</p>
        <p><strong>숙박 이름:</strong> ${accommodation.placeName}</p>
        <p><strong>숙박 주소:</strong> ${accommodation.addressName}</p>
        <p><strong>숙박 전화번호:</strong> ${accommodation.phone}</p>
        <p><strong>숙박 URL:</strong> <a href="${accommodation.placeUrl}" target="_blank">${accommodation.placeUrl}</a></p>
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>