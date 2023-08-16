<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-10
  Time: 오후 5:09
  To change this template use File | Settings | File Templates.
--%>

<%--일정 하나--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan list</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<ul>
  사용자 id : ${plan.userId} <br>
  제목 : ${plan.title} <br>
  시작일 : <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd" type="date"/> <br>
  종료일 : <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd" type="date"/> <br>
  메모 : ${plan.memo} <br>
  생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
  수정일시 : <fmt:formatDate value="${plan.updatedAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
  <br>
  <button type="submit" id="updateBtn" name="updateBtn">
    <a href="plan_update?id=${plan.id}" role="button">수정</a>
  </button>
  <button type="button" id="deleteBtn" name="deleteBtn">
    <a href="plan_delete?id=${plan.id}" role="button">삭제</a>
  </button>
</ul>
</body>
</html>
