<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-07
  Time: 오후 5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>HonTrip</h1>

<!-- 버튼 추가 -->
<button id="goToPlanForm">여행일정생성</button>
<button id="goToPlanList">일정리스트</button>

<script>
    $(document).ready(function() {
        // "여행일정생성" 버튼 클릭 시
        $("#goToPlanForm").click(function() {
            window.location.href = "/hontrip/plan/plan_form";
        });

        // "일정리스트" 버튼 클릭 시
        $("#goToPlanList").click(function() {
            window.location.href = "/hontrip/plan/plan_list";
        });
    });
</script>
</body>
</html>
