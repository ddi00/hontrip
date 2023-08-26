<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="<c:url value="/resources/css/record.css"/>">


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
        /* $(document).ready(function () {
             $('#alertDiv').hide();
         });*/

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
                stompClient.subscribe('/sub/' + <c:out value="${sessionScope.id}"/>, function (result) {
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
            alert(result.senderNickname + "님이 동행을 신청했어요!");
        }
    </script>
</head>
<body>
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
