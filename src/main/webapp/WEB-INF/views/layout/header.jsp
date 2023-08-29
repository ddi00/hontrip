<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div id="myMateAlarmModal" class="mateAlarmModal">
    <div class="mateAlarmModal-content">
        <span class="alarmModalAlarmLetter">알림</span><span class="mateAlarmListClose">&times;</span>
        <ul id="notificationList" class="mateAlarmUl">
        </ul>
    </div>
</div>

<div id="myMateRealTimeAlarmModal" class="mateRealTimeAlarmModal">
    <div class="mateRealTimeAlarmModal-content">
        <ul id="mateRealTimeAlarmUl">
        </ul>
    </div>
</div>


<header class="wrapper bg-gray">
    <jsp:include page="nav.jsp" />
</header>