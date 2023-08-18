<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<a href="/hontrip" role="button" class="btn btn-light mx-4 mt-4">홈</a>
<div class="container-fluid container my-5 w-50 p-3">
  <h4>지역명으로 검색</h4>
  <form id="mySpot" action="search" method="post">
    <label name="areaName">지역명</label>
    <input type="text" id="areaName" name="areaName">
    <input type="submit" value="여행지 검색" class="btn btn-primary">
  </form>
</div>
</body>
</html>
