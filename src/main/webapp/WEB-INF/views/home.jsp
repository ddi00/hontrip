<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>HonTrip</h1>

<!-- 버튼 추가 -->
<button id="goToPlanForm">일정 생성</button>
<button id="goToPlanList">일정 목록</button>
<button id="goToFlightForm">항공권 검색</button>

<script>
    $(document).ready(function() {
        // "일정 생성" 버튼 클릭 시
        $("#goToPlanForm").click(function() {
            window.location.href = "/hontrip/plan/form";
        });

        // "일정 목록" 버튼 클릭 시
        $("#goToPlanList").click(function() {
            window.location.href = "/hontrip/plan/list";
        });

        // "항공권 검색" 버튼 클릭 시
        $("#goToFlightForm").click(function() {
            window.location.href = "/hontrip/plan/flight/search_form";
        });
    });
</script>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-gray">
    <div class="container pt-10 pb-14 pb-md-16">
        <c:if test="${empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
            <a href="/hontrip/user/sign-in">사용자 로그인</a>
        </c:if>
        <br>
        <a href="mate/bbs_list?page=1">
            <button class="bbs_list">
                게시물 전체 목록
            </button>
        </a>
        <br>
        동행인 매칭<br>
        <a href="mate/insert">동행인 매칭 게시글 작성</a><br>
        <a href="mate/88">동행인 매칭 게시글 상세페이지</a>
    </div>
</section>