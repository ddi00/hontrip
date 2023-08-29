<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="myMateAlarmModal" class="mateAlarmModal">
    <div class="mateAlarmModal-content">
        <span style="text-align: center; font-weight: bold; display: inline-block; width: 95%; font-size:15px; margin-top: 8px; margin-bottom: 10px;">알림</span><span
            class="mateAlarmListClose">&times;</span>
        <ul id="notificationList" class="mateAlarmUl">
        </ul>
    </div>
</div>

<div id="myMateRealTimeAlarmModal" class="mateRealTimeAlarmModal">
    <div class="mateRealTimeAlarmModal-content">
        <span id="mateRealTimeAlarmContent">
        </span>
        <span class="mateAlarmListClose">x</span>
    </div>
</div>


<header class="wrapper bg-soft-primary">
    <jsp:include page="nav.jsp" />
</header>