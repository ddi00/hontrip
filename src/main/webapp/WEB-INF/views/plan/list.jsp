<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan list</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h3>일정 목록</h3>
<button type="button" id="createBtn" name="createBtn">
  <a href="form" role="button">생성</a>
</button>
<ul>
  <c:forEach items="${list}" var="plan">
    <c:set var="now" value="<%=new java.util.Date()%>" />
    사용자 id : ${plan.userId} <br>
    제목 : <a href="one?id=${plan.id}">${plan.title}</a>  <br>
    시작일 : <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd" type="date"/> <br>
    종료일 : <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd" type="date"/> <br>
    메모 : ${plan.memo} <br>
    생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
    수정일시 : <fmt:formatDate value="${plan.updatedAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
    <br>
    <button type="button" id="updateBtn" name="updateBtn">
      <a href="update?id=${plan.id}" role="button">수정</a>
    </button>
    <button type="button" id="deleteBtn" name="deleteBtn">
      <a href="delete?id=${plan.id}" role="button">삭제</a>
    </button>
    <hr>
  </c:forEach>
</ul>
</body>
</html>