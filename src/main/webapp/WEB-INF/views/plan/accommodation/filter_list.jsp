숙소리스트

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>accommodation list</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            padding: 20px;
        }
        .accommodation-card {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
            padding: 15px;
        }
        .accommodation-card h4 {
            margin-top: 0;
        }
        .btn-custom {
            background-color: #FF9F1C;
            border-color: #FF9F1C;
        }
        .center-text {
            text-align: center;
        }
        .list-unstyled {
            list-style: none;
            padding-left: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="center-text">
        <h1 class="mt-4">숙소 목록</h1>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/plan/accommodation/filter_list">
        <div class="row mb-3">
            <div class="col">
                <input type="text" name="addressName" class="form-control" placeholder="주소 입력">
            </div>
            <div class="col">
                <input type="text" name="placeName" class="form-control" placeholder="이름 입력">
            </div>
            <div class="col-auto">
                <button type="submit" name="filterType" value="address_place" class="btn btn-primary btn-custom">검색</button>
            </div>
        </div>
        <%--카테고리 현재 검색 필터 적용이 잘 안 되어서 추후에 개발할 예정--%>
        <%--  <div class="row mb-3">
            <div class="col">
              <select class="form-select" name="categoryName">
                <option value="">카테고리 선택</option>
                <option value="여행 > 숙박 >">전체</option>
                <option value="여행 > 숙박 > 호텔">호텔</option>
                <option value="여행 > 숙박 > 펜션">펜션</option>
                <option value="여행 > 숙박 > 콘도,리조트">콘도,리조트</option>
                <option value="여행 > 숙박 > 야영,캠핑장">야영,캠핑장</option>
              </select>
            </div>
            <div class="col-md-2">
              <button type="submit" class="btn btn-secondary">카테고리 검색</button>
            </div>
          </div>--%>
    </form>
    <ul class="list-unstyled">
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