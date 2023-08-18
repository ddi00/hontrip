<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <title>Disaster Message API Search</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    /* 추가 스타일링을 위한 CSS */
    .form-container {
      max-width: 600px;
      margin: auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    /* 버튼의 배경색을 #FF9F1C로 설정 */
    .custom-btn {
      background-color: #FF9F1C;
    }
  </style>
  <script>
    // 폼 제출 시 자바스크립트 함수 호출
    function submitForm() {
      // 수신지역 이름 입력란의 값을 가져옴
      var locationName = document.getElementById("locationName").value;
      // 한글을 인코딩
      var encodedLocationName = encodeURIComponent(locationName);
      // 결과 페이지로 이동
      window.location.href = "/hontrip/plan/safety_result?locationName=" + encodeURIComponent(locationName);
    }
  </script>
</head>
<body class="bg-light">
<div class="container py-5">
  <div class="text-center">
    <h1 class="mb-4">안전정보 조회</h1>
    <form class="mb-3">
      <div class="input-group">
        <input type="text" id="locationName" class="form-control" placeholder="수신지역 이름">
        <!-- custom-btn 클래스를 추가하여 배경색 적용 -->
        <button class="btn btn-primary custom-btn" type="button" onclick="submitForm()">조회</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>