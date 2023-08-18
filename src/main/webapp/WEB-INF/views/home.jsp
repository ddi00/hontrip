<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 버튼 추가 -->
<button id="goToPlanForm">일정 생성</button>
<button id="goToPlanList">일정 목록</button>
<button id="goToSpotSearchForm">여행지 검색</button>
<button id="goToFlightSearchForm">항공권 검색</button>

<script>
    $(document).ready(function() {
        // "일정 생성" 버튼 클릭 시
        $("#goToPlanForm").click(function() {
            window.location.href = "/hontrip/plan/create";
        });

        // "일정 목록" 버튼 클릭 시
        $("#goToPlanList").click(function() {
            window.location.href = "/hontrip/plan/list";
        });

        // "여행지 검색" 버튼 클릭 시
        $("#goToSpotSearchForm").click(function() {
            window.location.href = "/hontrip/plan/spot/search_form";
        });

        // "항공권 검색" 버튼 클릭 시
        $("#goToFlightSearchForm").click(function() {
            window.location.href = "/hontrip/plan/flight/search_form";
        });
    });
</script>
</body>
</html>