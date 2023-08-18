<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>여행지 검색</title>
  <style>
    .btn-custom {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }
  </style>
</head>
<body>
<div class="container-fluid container my-5 w-50 p-3">
  <h2>여행지 검색</h2><br>
  <h4>지역명으로 검색</h4>
  <form id="searchSpotWithAreaName" action="search-area" method="post">
    <input type="text" id="areaName" name="areaName" class="form-control">
    <input type="submit" value="검색" class="btn btn-yellow rounded-pill mt-3">
  </form>

  <h4>키워드 검색</h4>
  <form id="searchSpotWithKeyword" action="search-keyword" method="post">
    <input type="text" id="title" name="title" class="form-control">
    <input type="submit" value="검색" class="btn btn-custom rounded-pill mt-3">
  </form>
</div>
</body>
</html>
