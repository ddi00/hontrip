<%@ page import="com.multi.hontrip.mate.dto.MateMatchingAlarmDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%
    List<MateMatchingAlarmDTO> mateApplyAlarmList = (List<MateMatchingAlarmDTO>) request.getAttribute("alarmList");
    request.setAttribute("mateApplyAlarmList",mateApplyAlarmList);
%>--%>


<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Dropdown</a>
<ul class="dropdown-menu" style="padding: 2px 2px 2px 2px;">
    <c:forEach items="${alarmList}" var="alarm" varStatus="status">
        <li class="nav-item">
                ${alarm.senderNickname}님이 동행을 신청했어요!
            <span class="row justify-content-between align-items-center" style="width:100%;">
                    <span class="d-none d-lg-block col-1 text-right text-body">
                        <img class="avatar w-6" src="${alarm.senderProfileImage}" alt="프로필이미지"/>
                    </span>
                    <span class="d-none d-lg-block col-1 text-right text-body"
                          style="width:60%; word-wrap: normal; font-size: 12px;">
                            ${alarm.content}
                    </span>
                    <span class="mb-2 mb-md-0 d-flex align-items-center text-body">
                       <a href="../mate/1">채팅</a>
                    </span>
                    <span class="mb-2 mb-md-0 d-flex align-items-center text-body">
                       <a href="../mate/delete_alarm">삭제</a>
                    </span>
                </span>
        </li>
        <hr style="margin: 0">
    </c:forEach>
</ul>

<%--
<li class="nav-item dropdown" style="width:30%;"><a class="nav-link dropdown-toggle" href="#"
                                                    data-bs-toggle="dropdown">Dropdown</a>
    <ul class="dropdown-menu" style="padding: 2px 2px 2px 2px;">

        <li class="nav-item">
            (양혜원)님이 동행을 신청했어요!
            <span class="row justify-content-between align-items-center" style="width:100%;">
                    <span class="d-none d-lg-block col-1 text-right text-body">
                        <img class="avatar w-6" src="..." alt="프로필이미지"/>
                    </span>
                    <span class="d-none d-lg-block col-1 text-right text-body"
                          style="width:60%; word-wrap: normal; font-size: 12px;">
                        저랑 같이가요!!!!!!! 정말 가고싶습니다!!!!
                    </span>
                    <span class="mb-2 mb-md-0 d-flex align-items-center text-body">
                       <a id="mateBoardChatButton" href="../mate/1">채팅</a>
                    </span>
                    <span class="mb-2 mb-md-0 d-flex align-items-center text-body">
                       <a id="mateBoardAlarmDelete" href="../mate/1">채팅</a>
                    </span>
                </span>
        </li>

        <li class="nav-item">
            <div class="p-3">
                <br>
                <span class="justify-content-between col-md-5 mb-2 mb-md-0 d-flex align-items-center text-body">
                    <img class="avatar w-5" src="..." alt="프로필이미지"/>
                        <span class=" mb-2 mb-md-0 d-flex align-items-center text-body">같이 여행가요!!와아와 정말재밌겠다 하하하하하핳하</span>
                        <span class="mb-2 mb-md-0 d-flex align-items-center text-body"><i
                                class="uil uil-comments"></i></span>
                    </span>
            </div>
            <!-- /.card-body -->
        </li>
        <hr style="margin: 0">


    </ul>
</li>--%>


