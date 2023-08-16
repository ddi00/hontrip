<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-13
  Time: 오후 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Disaster Message API Search</title>
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
<body>
<h1>재난문자방송 발령현황 조회</h1>
<form>
  수신지역 이름: <input type="text" id="locationName"><br>
  <!-- 폼 제출 시 submitForm 함수 호출 -->
  <input type="button" value="조회" onclick="submitForm()">
</form>
</body>
</html>

