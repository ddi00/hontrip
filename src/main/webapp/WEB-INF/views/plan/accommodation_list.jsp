<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-12
  Time: 오후 3:52
  To change this template use File | Settings | File Templates.
--%>
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
<ul>
  <c:forEach items="${list}" var="accommodation">
    숙박 id : ${accommodation.id} <br>
    숙박 구분 : ${accommodation.categoryName}  <br>
    숙박 이름 : ${accommodation.placeName}  <br>
    숙박 주소 : ${accommodation.addressName} <br>
    숙박 전화번호 : ${accommodation.phone} <br>
    <br>
    <hr>
  </c:forEach>
</ul>
</body>
</html>
