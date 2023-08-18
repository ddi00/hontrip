<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Disaster Messages</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    /* 추가 스타일링을 위한 CSS */
    .container {
      text-align: center;
    }
    .table th,
    .table td {
      text-align: left;
    }
  </style>
</head>
<body>

<div class="container mt-5 text">
  <h1>${locationName} 지역 안전정보 검색 결과</h1>

  <table class="table table-striped table-bordered mt-3">
    <thead class="thead-dark">
    <tr>
      <th scope="col" class="text-center">날짜</th>
      <th scope="col" class="text-center">지역명</th>
      <th scope="col" class="text-center">메세지</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="entry" items="${result}">
      <c:forEach var="message" items="${entry.row}">
        <tr>
          <td>${message.create_date}</td>
          <td>${message.location_name}</td>
          <td>${message.msg}</td>
        </tr>
      </c:forEach>
    </c:forEach>
    </tbody>
  </table>

  <div class="row mt-3">
    <div class="col-md-12 text-center">
      <button class="btn btn-primary" style="background-color: #FF9F1C;" onclick="location.href='/hontrip/plan/safety_search'">다시 검색하기</button>
    </div>
  </div>
</div>

</body>
</html>




