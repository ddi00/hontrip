<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<c:url value="/resources/img/common/favicon1.png"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/plugins.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/mate.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/plan.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/alarm.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/user.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/chat.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/record.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/alarm.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/mate_list.css"/>">

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
        let stompClient = null;
        let subscribedChatRoomId = new Array();

        $(document).ready(function () {
            if ('<c:out value="${sessionScope.id}"/>' != "") {
                connectStompAlarm()
            }
        });

        //웹소켓 연결 + 알림을 받기 위해 자신의 아이디를 구독
        function connectStompAlarm() {
            let socket = new SockJS('${pageContext.request.contextPath}/matews');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                stompClient.subscribe('/sub/<c:out value="${sessionScope.id}"/>', function (result) {
                    let alarmBody = JSON.parse(result.body);
                    console.log(alarmBody.alarmType);
                    console.log(subscribedChatRoomId.includes(alarmBody.roomId));

                    //채팅 알림이고 + 현재 내가 그 채팅방을 구독하고 있다면 -> 채팅 알림 받지 않음
                    //채팅알림이 아니고 현재 내가 그 채팅방을 구독하고 있지 않다면 -> 채팅 알림을 받음
                    if (alarmBody.alarmType == 'MATE_CHAT' && subscribedChatRoomId.includes(alarmBody.roomId)) {

                    } else {
                        applyAlarm(JSON.parse(result.body));
                        $('#unreadChatCount').css('display', 'block');
                    }
                })
            })
        }


        //----------------------------------- stompClient.send 모음 ---------------------------------//

        //동행인 신청 메세지 작성 후 '전송'버튼을 눌렀을 때 -> send
        function sendAlarm(mateBoardId, senderId, senderNickname, senderProfileImage, receiverId, content) {
            stompClient.send('/pub/mate', {},
                JSON.stringify({
                    'mateBoardId': mateBoardId,
                    'senderId': senderId,
                    'senderNickname': senderNickname,
                    // 'senderProfileImage':senderProfileImage,
                    'receiverId': receiverId,
                    'content': content,
                    'alarmType': 'MATE_APPLY'
                })
            )
        }

        //채팅 알림 -> send
        function sendChatAlarm(roomId, receiverId, senderNickname, content) {
            stompClient.send('/pub/chat', {},
                JSON.stringify({
                    'roomId': roomId,
                    'receiverId': receiverId,
                    'senderNickname': senderNickname,
                    'content': content,
                    'alarmType': 'MATE_CHAT'
                })
            )
        }


        //채팅방 첫 참가시(join) -> send
        function join(chatMessageDTO) {
            stompClient.send('/app/mate/chat', {},
                JSON.stringify({
                    'roomId': chatMessageDTO.roomId,
                    'senderId': chatMessageDTO.senderId,
                    'senderNickname': chatMessageDTO.senderNickname,
                    'receiverId': chatMessageDTO.receiverId,
                    'messageType': 'JOIN'
                })
            )
        }


        //채팅창에서 전송버튼을 눌렀을 때(chat) -> send
        function mateChatSend(ths) {
            if ($('#mateChatInputMessage').val() != '') {
                stompClient.send('/app/mate/chat', {},
                    JSON.stringify({
                        'message': $('#mateChatInputMessage').val(),
                        'roomId': $(ths).val(),
                        'senderId': $('#mateAlarmUserId').val(),
                        'senderNickname': $('#mateAlarmUserNickname').val(),
                        'senderProfileImage': $('#mateAlarmUserProfileImage').val(),
                        'messageType': 'TALK'
                    })
                );

                sendChatAlarm($(ths).val(), $('#mateHeaderReceiverId').val(), $('#mateAlarmUserNickname').val(), $('#mateChatInputMessage').val());
                $('#mateChatInputMessage').val('');
                setTimeout(function () {
                    scrollUl()
                }, 100);
            }
        }

        function scrollUl() {
            let chatUl = document.querySelector('.mateChatHistoryUl');
            chatUl.scrollTop = chatUl.scrollHeight;
        }


        //----------------------------------- stompClient.send 모음 ---------------------------------//

        //채팅방 구독 subscribe -> pub에서 받아온 메세지를 처리
        function subscribeChatRoom(roomId) {
            stompClient.subscribe('/topic/chat/roomId/' + roomId, function (result) {
                    showChatMessage(JSON.parse(result.body))
                }, {'id': 'chat' + roomId}
            )
            subscribedChatRoomId.push(roomId);
        }

        //채팅창에 메세지를 보여줌
        function showChatMessage(chatMessageDTO) {
            if (chatMessageDTO.messageType == "JOIN" || chatMessageDTO.messageType == "LEAVE") {
                $('#mateChatHistoryUl').append('<li class="joinOrLeaveMessageLi">' + chatMessageDTO.message + '</li>')
            } else {
                if (chatMessageDTO.senderId == $('#mateAlarmUserId').val()) {
                    //오른쪽에 배치
                    $('#mateChatHistoryUl').append("<li class='myChatLi'><span class='myChatTime'>" + chatMessageDTO.sendTime.hour + ":" + chatMessageDTO.sendTime.minute + "</span>" +
                        "<span class='myChatMessage'>" + chatMessageDTO.message + "</span></li>");
                } else {
                    //왼쪽에 배치
                    $('#mateChatHistoryUl').append("<li class='opponentChatLi'><span class='opponentChatSenderNickname'>" + chatMessageDTO.senderNickname + "</span><br style='margin: 0;'>" +
                        "<span><img class='opponentProfileImg' src='" + chatMessageDTO.senderProfileImage + "' alt='상대방 프로필'></span><span class='opponentChatMessage'>" + chatMessageDTO.message + "</span>" +
                        "<span class='opponentChatTime'>" + chatMessageDTO.sendTime.hour + ":" + chatMessageDTO.sendTime.minute + "</span></li>");
                }
            }
            setTimeout(function () {
                scrollUl()
            }, 100);
        }


        //채팅방리스트 모달 펼치기
        function clickChatIcon() {
            if ($('.mateChatModal').css('display') == 'none') {
                $('.mateChatList-wrap').css('display', 'block');
                $('.mateChatHistory-wrap').css('display', 'none');
                $.ajax({
                    url: "${pageContext.request.contextPath}/mate/chat-room-list",
                    method: "POST",
                    success: function (chatRoomList) {
                        $('#mateChatListUl').html('');
                        if (chatRoomList.length == 0) {
                            $('#mateChatListUl').append("불러올 채팅 내역이 없습니다.");
                        }

                        for (let i = 0; i < chatRoomList.length; i++) {
                            let lastMessage = chatRoomList[i].lastMessage;
                            if (lastMessage.length > 20) {
                                lastMessage = lastMessage.substring(0, 20) + "...";
                            }
                            $('#mateChatListUl').append('<li class="mateChatListLi"><a class="mateChatroomAtag" onclick="clickOneChatRoom(this)" data-value="' + chatRoomList[i].roomId + '">' +
                                '<div class="imgContainer"><img class="chatListOpponentImg" src="' +
                                chatRoomList[i].opponentProfileImg + '"></div><div class="customRoomnameMessageTime"><div class="customChatRoomName" style="font-size: 15px; font-weight: bold;">' + chatRoomList[i].chatRoomName + '</div><div class="customChatLastMessage">' + lastMessage
                                + '</div><div class="lastMessageCreatedAt">' + chatRoomList[i].lastMessageCreatedAt + '</div></div></a></li>');
                            /*
                                                            '</span><br><img class="chatListOpponentImg" src="' +
                                                            chatRoomList[i].opponentProfileImg + '"><span class="customChatSenderNickname">' + chatRoomList[i].senderNickname + '  : </span>' +
                                                            lastMessage + '<br>  <span style="margin-left: 50px; text-align: right; font-size: 12px; color: #777;">' + chatRoomList[i].lastMessageCreatedAt + '</span></a></li>');
                            */
                        }

                    },
                    error: function (e) {
                        console.log(e)
                    }
                })
                $('.mateChatModal').css('display', 'block');
            } else if ($('.mateChatModal').css('display') == "block") {
                //만약 모달창이 열려있으면서 채팅창이 열려있으면(즉, 하나의 채팅창을 구독하고 있으면)
                if ($('.mateChatHistory-wrap').css('display') == "block") {
                    let roomId = $('#mateHeaderChaRoomId').val();
                    $.ajax({
                        url: "${pageContext.request.contextPath}/mate/update_last_join_at",
                        data: {
                            userId: $('#mateAlarmUserId').val(),
                            roomId: roomId
                        },
                        success: function () {
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    })
                    subscribedChatRoomId.pop(roomId);
                    stompClient.unsubscribe('chat' + roomId);
                }
                $('.mateChatModal').css('display', 'none');
            }
            $('#unreadChatCount').css('display', 'none');
            cancelMatePopup();
        }

        //채팅방 생성(알람리스트에서 채팅 아이콘을 클릭했을 때)
        function mateChatCreate(ths) {
            /* 순서대로 -> 모집자닉네임(0), 작성자닉네임(1), 동행게시글 제목(2), 게시글 아이디(3), 모집자 아이디(4), 신청자 아이디(5)*/
            let chatInfo = $(ths).data('value').split(",");
            /*console.log("밸류 : "+$(ths).data('value'))*/
            let ownerNickname = chatInfo[0];
            let guestNickname = chatInfo[1];
            let postTitle = chatInfo[2];
            let postId = chatInfo[3];
            let ownerId = chatInfo[4];
            let guestId = chatInfo[5];
            let liNum = chatInfo[6];
            let chatRoomName = "";

            console.log(liNum)
            //해당 알람 li disabled하기
            /* $('#mateAlarm' + liNum).css('pointer-events', 'none');
             $('#mateAlarm' + liNum).css("opacity", 0.6);*/


            if (postTitle.length > 15) {
                chatRoomName = postTitle.substring(0, 16) + "···";
            } else {
                chatRoomName = postTitle;
            }

            /*console.log('글 작성자 닉네임 :' +postWriterNickname +
                '신청자 닉네임: ' + senderNickname +
                '게시글 제목: ' + postTitle +
                '게시글 아이디: ' + postId +
                '게시글 작성자 아이디: ' +  postWriterId +
                '신청자 아이디: ' + senderId +
                '채팅방 제목: ' + chatRoomName)*/

            $.ajax({
                url: "${pageContext.request.contextPath}/mate/create-chatroom",
                method: "POST",
                data: {
                    chatRoomName: chatRoomName,
                    postId: postId,
                    ownerId: ownerId,
                    guestId: guestId,
                    mateMatchingAlarmId: liNum
                },
                success: function (result) {
                    $('#mateHeaderChaRoomId').val(result.roomId);
                    $('#mateChatSendButton').val(result.roomId);
                    $('#mateHeaderChaRoomName').val(result.chatRoomName);
                    $('#mateHeaderReceiverId').val(result.guestId);
                    //writer, sender 둘다 pub/sub해야함
                    let writerChatMessageDTO = {
                        roomId: result.roomId,
                        senderId: result.ownerId,
                        senderNickname: ownerNickname,
                        receiverId: result.guestId,
                    }
                    let senderChatMessageDTO = {
                        roomId: result.roomId,
                        senderId: result.guestId,
                        senderNickname: guestNickname,
                        receiverId: result.ownerId,
                    }

                    subscribeChatRoom(result.roomId)
                    //writer 먼저 조인
                    join(writerChatMessageDTO);
                    //sender 조인
                    join(senderChatMessageDTO);

                    let dataId = $(ths).data('id').split(",");
                    let mateLiId = dataId[0];
                    let currentPg = dataId[1];
                    let str = '#mateAlarm' + dataId[0];


                    //해당 알람 is_read 1로 변경
                    $.ajax({
                        url: "${pageContext.request.contextPath}/mate/read-alarm",
                        data: {
                            alarmId: mateLiId
                        },
                        success: function (result) {
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    })

                    alarmPageClick(currentPg, 5, 5)

                    //채팅모달 펼치기
                    $('.mateChatModal').css('display', 'block');
                    $('.mateChatList-wrap').css('display', 'none');
                    $('.mateChatHistory-wrap').css('display', 'block');
                    $('#mateChatHistoryUl').html('');
                    $('#mateChatRoomTitleLetter').text(result.chatRoomName);
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }

        //하나의 채팅방을 클릭했을 때
        function clickOneChatRoom(ths) {

            let roomId = parseInt($(ths).data('value'));
            $('#mateHeaderChaRoomId').val(roomId)
            createOwnerPopupButton(roomId, $('#mateAlarmUserId').val())
            subscribeChatRoom(roomId);
            //채팅창 열기
            $('.mateChatList-wrap').css('display', 'none');
            $('.mateChatHistory-wrap').css('display', 'block');
            $('#mateHeaderReceiverId').val();
            $('#chatRoomCloseIcon').attr('data-value', roomId);
            $('#mateChatHistoryUl').html('');


            //채팅목록 출력하기
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/join-chat/" + roomId,
                data: {
                    roomId: roomId,
                    user_id: $('#mateAlarmUserId').val()
                },
                success: function (result) {
                    $('#mateHeaderReceiverId').val(result.receiverId);
                    $('#mateChatSendButton').val(result.roomId);
                    $('#mateChatRoomTitleLetter').text(result.chatRoomName);
                    for (let i = 0; i < result.chatMessages.length; i++) {
                        if (result.chatMessages[i].messageType == "JOIN" || result.chatMessages[i].messageType == "LEAVE") {
                            $('#mateChatHistoryUl').append("<li class='joinOrLeaveMessageLi'>" + result.chatMessages[i].message + "</li>");
                        } else {
                            if (result.chatMessages[i].senderId != $('#mateAlarmUserId').val()) {
                                $('#mateChatHistoryUl').append("<li class='opponentChatLi'><span class='opponentChatSenderNickname'>" + result.chatMessages[i].senderNickname + "</span><br>" +
                                    "<span><img class='opponentProfileImg' src='" + result.chatMessages[i].senderProfileImage + "' alt='상대방 프로필'></span><span class='opponentChatMessage'>" + result.chatMessages[i].message + "</span>" +
                                    "<span class='opponentChatTime'>" + result.chatMessages[i].sendTime.hour + ":" + result.chatMessages[i].sendTime.minute + "</span></li>");
                            } else {
                                $('#mateChatHistoryUl').append("<li class='myChatLi'><span class='myChatTime'>" + result.chatMessages[i].sendTime.hour + ":" + result.chatMessages[i].sendTime.minute + "</span>" +
                                    "<span class='myChatMessage'>" + result.chatMessages[i].message + "</span></li>");
                            }
                        }
                    }
                    scrollUl()
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }

        //뒤로가기 화살표버튼을 누르면 -> 해당 채팅방 구독을 끊고, 채팅리스트로 돌아간다.
        function unsubscribeChatRoom(ths) {
            let roomId = $(ths).data('value');
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/update_last_join_at",
                data: {
                    userId: $('#mateAlarmUserId').val(),
                    roomId: roomId
                },
                success: function () {
                },
                error: function (e) {
                    console.log(e);
                }
            })
            subscribedChatRoomId.pop(roomId);
            stompClient.unsubscribe('chat' + roomId);
            $('.mateChatHistory-wrap').css('display', 'none');
            $('.mateChatList-wrap').css('display', 'block');
            cancelMatePopup();
        }


        //stomp 설정 끊음
        function stompDisconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
        }


        //실시간 알림 삭제
        function deleteRealTimeAlarm(ths) {
            let deleteA = $(ths);
            deleteA.parents("li").remove();
        }


        //동행인 신청을 받으면 하단에 실시간 알림이 3초간 지속된 후 소멸함
        //알람리스트에도 알람이 추가됨
        function applyAlarm(result) {
            document.getElementById("myMateRealTimeAlarmModal").style.display = "block";
            if (document.getElementById("mateRealTimeAlarmUl").childElementCount >= 5) {
                document.getElementById("mateRealTimeAlarmUl").firstChild.remove();
            }

            if (result.alarmType == 'MATE_APPLY') {
                $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 동행을 신청했어요!💨<span class='closeRealTimeAlarm' onclick='deleteRealTimeAlarm(this)'>x</span> </li>");

            } else if (result.alarmType == 'MATE_CHAT') {
                $('#mateRealTimeAlarmUl').append("<li class='mateChatRealTimeAlarmLi' style='width: 95%;'>💌 " + result.senderNickname + "님이 메세지를 보냈어요!<span class='closeRealTimeAlarm' onclick='deleteRealTimeAlarm(this)'>x</span></li>");

            } else if (result.alarmType == 'MATE_COMMENT') {
                $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 댓글을 작성했어요!<span class='closeRealTimeAlarm' onclick='deleteRealTimeAlarm(this)'>x</span> </li>");
            } else if (result.alarmType == 'MATE_ACCOMPANY_CONFIRMED') {
                $('#mateRealTimeAlarmUl').append("<li class='mateConfirmedRealTimeAlarmLi' style='width: 95%;'>🎉 " + result.senderNickname + "님과 동행이 확정되었어요!<span class='closeRealTimeAlarm' onclick='deleteRealTimeAlarm(this)'>x</span> </li>");
            }
            document.getElementsByClassName("mateAlarmListClose")[0].addEventListener("click", function () {
                document.getElementById("myMateRealTimeAlarmModal").style.display = "none";
            });

            setTimeout(function () {
                document.getElementById("mateRealTimeAlarmUl").lastChild.remove();
            }, 10000);
        }

        //알람리스트에서 알람을 삭제하면 다시 페이지를 불러옴
        function mateAlarmOneDelete(element) {
            $('#mateAlarm' + element.getAttribute('data-id')).remove();
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/delete_alarm",
                data: {
                    alarmId: element.getAttribute('data-id')
                },
                success: function (result) {
                },
                error: function (e) {
                    console.log(e);
                }
            })
            let current = element.id.substring(element.id.length - 1)
            alarmPageClick(current, 5, 5)
        }

        //알림 개수 표시 -> 헤더 append에 문제가 있어서 사용 보류
        function alarmCountPrint(totalCount) {
            if (totalCount == 0) {
                $('#alarmCount').hide();
            }

            if (totalCount >= 1 && totalCount < 10) {
                $('#alarmCount').text(totalCount);
                $('#alarmCount').show();
            }

            if (totalCount >= 10) {
                $('#alarmCount').text('9+');
                $('#alarmCount').show();
            }
        }

        //헤더에 알람을 클릭하면 1페이지가 표시됨
        function clickAlarm() {
            alarmPageClick(1, 5, 5);
        }

        //현재페이지, 한 페이지당 알람개수, 한 화면당 페이지 개수를 입력하면 해당 페이지의 알람들이 출력됨
        function alarmPageClick(cPage, aPerPage, aPerPage) {
            let hasBefore = null;
            let hasAfter = null;
            let startPageNum = null;
            let endPageNum = null;
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/alarm_page",
                data: {
                    currentPage: cPage,
                    alarmNumPerPage: aPerPage,
                    pageNumPerPagination: aPerPage
                },
                success: function (pagination) {
                    let pages = '<nav class="d-flex" aria-label="pagination" style="justify-content: center; margin-top:15px;"> <ul class="pagination pagination-alt mb-0">';
                    hasBefore = pagination.hasBefore;
                    hasAfter = pagination.hasAfter;
                    startPageNum = pagination.startPageNum;
                    endPageNum = pagination.endPageNum;
                    let totalAlarmCount = pagination.totalCount;


                    /*//알림개수표시
                    alarmCountPrint(totalAlarmCount);*/
                    if (hasBefore == true) {
                        pages +=
                            '<li class="page-item" style="width: 15px; height: 15px;"> <a class="page-link" style="width: 15px; height: 15px; font-size: 12px;"onclick="alarmPageClick(' + (startPageNum - 1) + ',5,5)" aria-label="Previous">' +
                            '<span aria-hidden="true"><i class="uil uil-arrow-left"></i></span>' + '</a></li>';
                    }

                    for (let i = startPageNum; i <= endPageNum; i++) {
                        pages += '<li class="page-item" id="mateAlarmPageClick' + i + '" style="width: 15px; height: 15px;"><a class="page-link"  style="width: 15px; height: 15px; font-size: 12px;" onclick="alarmPageClick(' + i + ',5,5)" >' + i + '</a></li>'
                    }
                    if (hasAfter == true) {
                        pages += '<li class="page-item" style="width: 15px; height: 15px;"><a class="page-link" style="width: 15px; height: 15px; font-size: 12px;" onclick="alarmPageClick(' + (endPageNum + 1) + ',5,5)" aria-label="Next">' +
                            '<span aria-hidden="true"><i class="uil uil-arrow-right"></i></span></a></li>';
                    }

                    pages += '</ul></nav>';
                    $.ajax({
                        url: '${pageContext.request.contextPath}/mate/alarm_list',
                        data: {
                            currentPage: cPage,
                            userId: $('#mateAlarmUserId').val(),
                            alarmNumPerPage: aPerPage
                        },
                        success: function (list) {
                            $('#notificationList').html('');
                            document.getElementById("myMateAlarmModal").style.display = "block";
                            document.getElementsByClassName("mateAlarmListClose")[0].addEventListener("click", function () {
                                document.getElementById("myMateAlarmModal").style.display = "none";
                            });

                            if (list.length == 0) {
                                $('#notificationList').append('<span style="font-size: 12px;">불러올 알람이 없습니다.</span>')
                            } else {
                                for (let i = 0; i < list.length; i++) {
                                    if (i == list.length - 1) {
                                        $('#notificationList').append('<li id="mateAlarm' + list[i].id + '" class="mateAlarmListLi" xmlns="http://www.w3.org/1999/html"><span style="font-weight: bold; font-size: 12px; width: 100%; "> ' + list[i].senderNickname + '님이 동행 신청을 했어요!</span><br><span class="spanAlarmList">' +
                                            '<img style="border-radius: 70%;" src="' +
                                            list[i].senderProfileImage + '" alt="신청자프로필이미지" width="30px;" height="30px;"> <span style="display:-webkit-box; white-space:normal; overflow: hidden;-webkit-line-clamp: 2; -webkit-box-orient: vertical; width:65%; height:40px; font-size: 13px; ">' +
                                            list[i].content + '</span><a style="width:8%;" data-currentPg="' + pagination.currentPage + '"  data-id="' + list[i].id + ',' + pagination.currentPage + '" onclick="mateChatCreate(this)"  data-value="' + $('#mateAlarmUserNickname').val() + ',' + list[i].senderNickname + ',' + list[i].mateBoardTitle + ',' + list[i].mateBoardId + ',' + $('#mateAlarmUserId').val() + ',' + list[i].senderId + ',' + list[i].id + '"><i class="uil uil-comments"></i></a>' +
                                            '<a id="mateAlarmCurrentPage' + pagination.currentPage + '"onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span></li>');
                                    } else {
                                        $('#notificationList').append('<li id="mateAlarm' + list[i].id + '"class="mateAlarmListLi" xmlns="http://www.w3.org/1999/html"><span style="font-weight: bold; font-size: 12px; width: 100%; "> ' + list[i].senderNickname + '님이 동행 신청을 했어요!</span><br><span class="spanAlarmList">' +
                                            '<img style="border-radius: 70%;" src="' +
                                            list[i].senderProfileImage + '" alt="신청자프로필이미지" width="30px;" height="30px;"> <span style="display:-webkit-box; white-space:normal; overflow: hidden;-webkit-line-clamp: 3; -webkit-box-orient: vertical; width:65%; height:45px; font-size: 12px; ">' +
                                            list[i].content + '</span><a style="width:8%;" data-id="' + list[i].id + ',' + pagination.currentPage + '" onclick="mateChatCreate(this)" data-value="' + $('#mateAlarmUserNickname').val() + ',' + list[i].senderNickname + ',' + list[i].mateBoardTitle + ',' + list[i].mateBoardId + ',' + $('#mateAlarmUserId').val() + ',' + list[i].senderId + ',' + list[i].id + '"><i class="uil uil-comments"></i></a>' + '<a id="mateAlarmCurrentPage' + pagination.currentPage + '" onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span> <hr style="margin:0px;"> </li>')
                                    }
                                }
                                $('#notificationList').append(pages);
                            }
                        }
                    })
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }

        function createOwnerPopupButton(roomId, userId) {
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/owner_check",
                data: {
                    roomId: roomId,
                    userId: userId
                },
                success: function (result) {
                    console.log("방장:" + result.isOwner)
                    console.log("동행 수락:" + result.isAccepted)
                    if (result.isOwner == 1 && result.isAccepted == 0) {
                        $('.accompanyConfirmedButton').css('display', 'none')
                        $('.ownerAcceptButton').css('display', 'block');
                    } else if (result.isOwner == 1 && result.isAccepted == 1) {
                        $('.ownerAcceptButton').css('display', 'none');
                        $('.accompanyConfirmedButton').css('display', 'block')
                    } else if (result.isOwner == 0 && result.isAccepted == 1) {
                        $('.ownerAcceptButton').css('display', 'none');
                        $('.accompanyConfirmedButton').css('display', 'block')
                    } else if (result.isOwner == 0 && result.isAccepted == 0) {
                        $('.ownerAcceptButton').css('display', 'none');
                        $('.accompanyConfirmedButton').css('display', 'none')
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }

        function cancelMatePopup() {
            $('#acceptMatePopup').css('display', 'none')
            $('.mateChatHistory-wrap').css('background', 'transparent')
        }

        function accompanyPopup() {
            getGuestNickname()
            $('#acceptMatePopup').css('display', 'block')
            $('.mateChatHistory-wrap').css('background', 'rgba(0,0,0,0.1)')
        }

        //동행 수락
        function acceptMatePopup() {
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/accept_matching_application",
                data: {
                    roomId: $('#mateHeaderChaRoomId').val()
                },
                success: function () {
                },
                error: function (e) {
                    console.log(e);
                }
            })
            $('#acceptMatePopup').css('display', 'none')
            $('.mateChatHistory-wrap').css('background', 'transparent')
            //000님과 동행 매칭이 완료되었습니다. 모달창 띄우기
            $('#mateSuccessMessagePopup').css('display', 'block')
            $('.mateChatHistory-wrap').css('background', 'rgba(0,0,0,0.1)')

            console.log($('#mateHeaderReceiverId').val());

            let alarmContent = $('#mateAlarmUserNickname').val() + '님과 동행이 확정되었습니다!'

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/mate/insertMatchingAlarm",
                data: {
                    senderId: $('#mateAlarmUserId').val(),
                    content: alarmContent
                },
                success: function () {
                    //상대방에게 실시간 알람을 보냄 (000님과 동행이 확정되었습니다!)
                    stompClient.send('/pub/chat', {},
                        JSON.stringify({
                            'receiverId': $('#mateHeaderReceiverId').val(),
                            'senderNickname': $('#mateAlarmUserNickname').val(),
                            'alarmType': 'MATE_ACCOMPANY_CONFIRMED'
                        })
                    )
                }, error: function (e) {
                    console.log(e)
                }
            })
        }

        //신청자닉네임 가져오기
        function getGuestNickname() {
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/guest_nickname",
                data: {
                    roomId: $('#mateHeaderChaRoomId').val()
                },
                success: function (guestNickname) {
                    console.log("게스트 닉네임" + guestNickname.nickname);
                    $(".mateGuestName").text(guestNickname.nickname);
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }

        function deleteConfirmButton(ths) {
            $(ths).parent().css('display', 'none');
            $('.mateChatHistory-wrap').css('background', 'transparent');
            $('.ownerAcceptButton').css('display', 'none');
            $('.accompanyConfirmedButton').css('display', 'block')
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
<input type="hidden" id="mateAlarmUserId" value="<c:out value="${sessionScope.id}"/>">
<input type="hidden" id="mateAlarmUserNickname" value="<c:out value="${sessionScope.nickName}"/>">
<input type="hidden" id="mateAlarmUserProfileImage" value="<c:out value="${sessionScope.profileImage}"/>">
</body>
</html>
