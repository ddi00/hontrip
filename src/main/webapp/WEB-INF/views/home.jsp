<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/sockjs-0.3.4.js"></script>
    <script src="resources/js/stomp.js"></script>
    <script>
        /* let stompClient = null;
         $(document).ready(function () {
             if($('mateLoginUserId') != "" && stompClient == null){
                 connectStomp()
             }
         });

         //웹소켓 연결 + 알림을 받기 위해 자신의 아이디를 구독
         function connectStomp() {
             let socket = new SockJS('${pageContext.request.contextPath}/matews');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log(frame);
                stompClient.subscribe('/sub/'+$('#mateLoginUserId').val(), function (result) {
                    applyAlarm(JSON.parse(result.body));
                })
            })
        }*/
    </script>
</head>
<body>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-gray">
    <div class="container pt-10 pb-14 pb-md-16">
        <a href="mate/bbs_list?page=1">게시물 전체 목록</a>
        <br>
        동행인 매칭<br>
        <a href="mate/insert">동행인 매칭 게시글 작성</a><br>
        <a href="mate/9">동행인 매칭 게시글 상세페이지</a><br>
        <a href="mate/chat-view">채팅</a><br>
        <br>
        <a href="plan/create">일정 생성</a><br>
        <a href="plan/list">일정 목록</a><br>
        <a href="plan/flight/search">항공권 검색</a><br>
        <a href="plan/spot/search">여행지 검색</a><br>
        <a href="plan/accommodation/list">숙소 검색</a><br>
        <a href="plan/emergency_facility/list">응급 시설 정보</a><br>
        <a href="plan/safety_search">안전 정보</a><br>
        <br>
        <a href="record/mylist">내 기록 게시물 보기</a><br>
        <a href="record/feedlist">피드 게시물 보기</a><br>
    </div>
</section>