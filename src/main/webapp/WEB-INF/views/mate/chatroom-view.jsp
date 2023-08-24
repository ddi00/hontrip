<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 변수 -->
<div style="display:none">
    <c:if test="${not empty chatSessionInfo}">
        <input id="roomId" type="text" value="${chatSessionInfo.roomId}">
        <input id="senderId" type="text" value="${chatSessionInfo.senderId}">
        <input id="receiverId" type="text" value="${chatSessionInfo.receiverId}">
    </c:if>
    <c:if test="${not empty joinChatInfo}">
        <input id="roomId" type="text" value="${joinChatInfo.roomId}">
        <input id="senderId" type="text" value="${joinChatInfo.senderId}">
        <input id="receiverId" type="text" value="${joinChatInfo.receiverId}">
        <input id="newFlag" type="text" value="${joinChatInfo.newFlag}">
    </c:if>
</div>
<section class="wrapper bg-gray">
    <div class="container pt-10 pb-14 pb-md-16">
        <div>
            <div id="chat-room">
                <div class="chat-room-title">
                    <c:if test="${not empty chatSessionInfo}">
                        <span id="chat-title">${chatSessionInfo.chatRoomName}</span>
                    </c:if>
                    <c:if test="${not empty joinChatInfo}">
                        <span id="chat-title">${joinChatInfo.chatRoomName}</span>
                    </c:if>
                </div>
                <div class="chat-room-content">
                    <c:if test="${not empty joinChatInfo}"> <!--생성시에는 없음-->
                        <c:forEach var="chatMessage" items="${joinChatInfo.chatMessages}">
                            <c:choose>
                                <c:when test="${chatMessage.messageType eq 'JOIN'}">
                                    <p class="join-chat">${chatMessage.message}</p>
                                </c:when>
                                <c:when test="${chatMessage.messageType eq 'TALK'}">
                                    <c:choose>
                                        <c:when test="${chatMessage.senderId eq chatSessionInfo.senderId}">
                                            <p class="sender-chat">[${chatMessage.senderId}][${chatMessage.message}][${chatMessage.sendTime}]</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="receiver-chat">[${chatMessage.senderId}][${chatMessage.message}][${chatMessage.sendTime}]</p>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>

                        </c:forEach>
                    </c:if>
                </div>
                <div class="chat-input-area">
                    <input type="text" id="chat-input-text" placeholder="채팅을 입력하세요..." style="width: 300px;">
                    <button id="messge-send">전송</button>
                </div>
            </div>
        </div>
    </div>
</section>
