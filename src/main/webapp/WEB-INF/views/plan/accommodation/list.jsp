
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>accommodation list</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>숙소 목록</h1>
<%--주소와 이름으로 검색 부분 나중에 부트스트랩으로 하나로 합치기--%>

<form method="post" action="${pageContext.request.contextPath}/plan/accommodation/filter_list">
  주소 입력: <input type="text" name="addressName" value="">
  이름 입력: <input type="text" name="placeName" value="">
  <button type="submit" name="filterType" value="address_place">주소와 이름으로 검색</button>
  <button type="submit" name="filterType" value="address">주소 검색</button>
  <button type="submit" name="filterType" value="place_name">숙소 검색</button> <br>
  <button type="submit" name="categoryName" value="여행 > 숙박 > 호텔">호텔</button>
  <button type="submit" name="categoryName" value="여행 > 숙박 > 펜션">펜션</button>
  <button type="submit" name="categoryName" value="여행 > 숙박 > 콘도,리조트">콘도,리조트</button>
  <button type="submit" name="categoryName" value="여행 > 숙박 > 야영,캠핑장">야영,캠핑장</button>
</form>
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
