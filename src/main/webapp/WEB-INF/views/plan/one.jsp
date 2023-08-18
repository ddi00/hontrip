<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title></title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    #container ul {
      list-style: none;
      padding-left: 0;
    }
    #container ul > li {
      border: 1px solid #dee2e6;
      border-radius: 8px;
      margin-bottom: 20px;
      padding: 15px;
      background-color: white;
    }
    .btn-custom {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }
    .full-width-btn {
      width: 100%;
    }
    a {
      text-decoration: none;
      color: black;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container" id="container">
  <ul>
    <li>
      사용자 id : ${plan.userId} <br>
      제목 : ${plan.title} <br>
      시작일 : <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd" type="date"/> <br>
      종료일 : <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd" type="date"/> <br>
      메모 : ${plan.memo} <br>
      생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
      수정일시 : <fmt:formatDate value="${plan.updatedAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
      <br>
      <button type="button" class="btn btn-custom">
        <a href="update?id=${plan.id}" role="button">수정</a>
      </button>
      <button type="button" class="btn btn-custom">
        <a href="delete?id=${plan.id}" role="button">삭제</a>
      </button>
    </li>
  </ul>
  <button type="button" class="btn btn-light">
    <a href="list" role="button">목록</a>
  </button>
</div>
</body>
</html>