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
    <input hidden id="mateHeaderSenderNickname">
    <div class="mateChatModal-content">
        <%--채팅방 목록--%>
        <div class="mateChatList-wrap">
            <div class="chatModalAlarmLetter">채팅 목록</div>
            <div class="mate-chat-list-container">
            <div class="mateChatListDiv">
                <ul id="mateChatListUl" class="mateChatListUl">
                </ul>
            </div>
        </div>
        </div>

        <%--채팅창--%>
            <div id="mateChatHistory-wrap" class="mateChatHistory-wrap">
                <div id="mateChatRoomTop" class="mateChatRoomTop">
                    <a class="chatRoomCloseIcon" id="chatRoomCloseIcon" onclick="unsubscribeChatRoom(this)"><span><svg
                            xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor"
                            class="bi bi-arrow-left-short" viewBox="0 0 16 16" id="IconChangeColor"> <path
                            fill-rule="evenodd"
                            d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z"
                            id="mainIconPathAttribute" fill="#ffffff"></path> </svg></span></a>
                    <span id="mateChatRoomTitleLetter" class="mateChatRoomTitleLetter">
                    채팅방 제목
                </span>
                    <%--<a id="chatRoomDownArrow" class="chatRoomDownArrow" onclick="clickDownArrow()"><svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-caret-down" viewBox="0 0 16 16" id="IconChangeColor"> <path d="M3.204 5h9.592L8 10.481 3.204 5zm-.753.659 4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z" id="mainIconPathAttribute" fill="#ffffff"></path> </svg></a>--%>
                    <%--<button id="deleteButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0" data-bs-toggle="modal"
                            data-bs-target="#acceptMateApply"> 동행인 수락
                    </button>--%>
                    <span class="ownerAcceptButton"><button type="button" class="acceptMateButton" id="acceptMateButton"
                                                            onclick="accompanyPopup()">동행 수락</button></span>
                    <span class="accompanyConfirmedButton"><i class="uil uil-users-alt"></i>동행 확정</span>
                </div>
                <!--/.card-header -->
                <div class="mateChatHistoryDiv">
                    <div id="acceptMatePopup" class="acceptMatePopup"><span class="mateGuestName"></span>님의 동행 신청을
                        수락하시겠습니까?<br>
                        <button class="mate-cancel-button" onclick="cancelMatePopup()">취소</button>
                        <button class="mate-accept-button" onclick="acceptMatePopup()">수락</button>
                    </div>
                    <div id="mateSuccessMessagePopup" class="mateSuccessMessagePopup"><span
                            class="mateGuestName"></span>과 동행 매칭이 완료되었습니다!
                        <button class="mate-confirm-button" onclick="deleteConfirmButton(this)">x</button>
                    </div>
                    <ul id="mateChatHistoryUl" class="mateChatHistoryUl">
                    </ul>
                </div>
                <div class="mateChatBottomDiv"><input type="text" id="mateChatInputMessage" class="mateChatInputMessage"
                                                      placeholder="메세지를 입력해주세요.">
                    <button id="mateChatSendButton" class="mateChatSendButton" onclick="mateChatSend(this)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor"
                             class="bi bi-send" viewBox="0 0 16 16" id="IconChangeColor">
                            <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"
                                  id="mainIconPathAttribute" fill="#ffffff"></path>
                        </svg>
                    </button>
                </div>
            </div>
    </div>
</div>

<header class="wrapper bg-gray">
    <jsp:include page="nav.jsp"/>
</header>

<%--채팅 아이콘--%>
<c:if test="${not empty sessionScope.id}">

    <div class="chatIcon">
        <span id="unreadChatCount" class="unreadChatCount"></span>
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
</c:if>


<%--채팅창에서 엔터누르면 채팅 전송--%>
<script>
    const inputElement = document.querySelector('#mateChatInputMessage');
    const mateChatSendButton = document.querySelector('#mateChatSendButton');
    inputElement.addEventListener('keydown', (event) => {
        let key = event.key || event.keyCode;

        if (key === 'Enter' && !event.shiftKey) {
            mateChatSendButton.click();
        }
    })
</script>