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


<div id="myMateChatModal" class="mateChatModal">
    <input hidden id="mateHeaderReceiverId">
    <input hidden id="mateHeaderChaRoomId">
    <input hidden id="mateHeaderChaRoomName">
    <div class="mateChatModal-content">
        <%--채팅방 목록--%>
        <div class="mateChatList-wrap">
            <span class="chatModalAlarmLetter">채팅 목록</span>
            <br>
            <div class="mateChatListDiv">
                <ul id="mateChatListUl" class="mateChatListUl">
                </ul>
            </div>
        </div>

        <%--채팅창--%>
        <div class="mateChatHistory-wrap">
            <span id="mateChatRoomTitle">채팅방 제목</span>
            <div class="mateChatHistoryDiv">
                <ul id="mateChatHistoryUl" class="mateChatHistoryUl">
                </ul>
            </div>
            <div><input type="text" id="mateChatInputMessage" placeholder="메세지를 입력해주세요.">
                <button id="mateChatSendButton" onclick="mateChatSend(this)">전송</button>
            </div>
        </div>
    </div>
</div>

<header class="wrapper bg-gray">
    <jsp:include page="nav.jsp"/>
</header>


<%--채팅 아이콘--%>
<%--<c:if test="${not empty sessionScope.id}">
    <div class="chatIcon">
        <span hidden class="unreadChatCount"></span>
        <a onclick="clickChatIcon()">
            <svg xmlns="http://www.w3.org/2000/svg" width="31" height="31" fill="currentColor" class="bi bi-chat-dots"
                 viewBox="0 0 16 16" id="IconChangeColor">
                <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"
                      id="mainIconPathAttribute" fill="#ff5a46"></path>
                <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"
                      id="mainIconPathAttribute" fill="#ff5a46"></path>
            </svg>
        </a>
    </div>
</c:if>--%>

