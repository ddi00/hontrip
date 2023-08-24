<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    //*세션에서 유저아이디 불러옴 -> 없으면 no 있으면 유저아이디*//*
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("user", userId);
    }
%>
<input hidden id="mateLoginUserId" value="${user}">
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/resources/assets/img/favicon.png">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/plugins.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/mate.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/plan.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/user.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/chat.css"/>">
    <script type="text/javascript" src="<c:url value="/resources/assets/js/plugins.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/assets/js/theme.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.7.0.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/stomp.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/chat.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/user.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/mate.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/pagination.js"/>" defer></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        //이건 셀렉트원에서 -> 동행인신청버튼누르고 + 신청조건에 맞는사람일경우에 넣기
        let stompClient = null;
        $(document).ready(function () {
            if ($('#mateLoginUserId') != "" && stompClient == null) {
                connectStomp()
            }
        });

        //웹소켓 연결 + 알림을 받기 위해 자신의 아이디를 구독
        function connectStomp() {
            let socket = new SockJS('${pageContext.request.contextPath}/matews');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log(frame);
                stompClient.subscribe('/sub/' + $('#mateLoginUserId').val(), function (result) {
                    applyAlarm(JSON.parse(result.body));
                })
            })
        }

        //stomp 설정 끊음
        function stompDisconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            console.log('해제됨')
        }

        function applyAlarm(result) {
            $('#alertDiv').show();
            $('#alertSpan').text(result.senderNickname + "님이 동행을 신청했어요!");
        }
    </script>
</head>
<body>
<%--동행인 신청 알림창--%>
<div class="alert alert-warning alert-icon alert-dismissible fade show" role="alert" id="alertDiv"
     style="position: relative; z-index:4; width:25%;">
    <i class="uil uil-bell"></i><span id="alertSpan"></span> <a href="#" class="alert-link hover"></a>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<div class="content-wrapper">
    <tiles:insertAttribute name="header"/>
    <tiles:insertAttribute name="body"/>
</div>
<tiles:insertAttribute name="footer"/>
<div class="progress-wrap">
    <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"/>
    </svg>
</div>
</body>
</html>
