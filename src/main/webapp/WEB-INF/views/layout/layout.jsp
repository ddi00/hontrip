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
    <link rel="stylesheet" href="<c:url value="/resources/css/user.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/chat.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/record.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/alarm.css"/>">

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
                    applyAlarm(JSON.parse(result.body));
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
        function sendChatAlarm(receiverId, senderNickname, content) {
            stompClient.send('/pub/chat', {},
                JSON.stringify({
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
            stompClient.send('/app/mate/chat', {},
                JSON.stringify({
                    'message': $('#mateChatInputMessage').val(),
                    'roomId': $(ths).val(),
                    'senderId': $('#mateAlarmUserId').val(),
                    'senderNickname': $('#mateAlarmUserNickname').val(),
                    'messageType': 'TALK'
                })
            );
            sendChatAlarm($('#mateHeaderReceiverId').val(), $('#mateAlarmUserNickname').val(), $('#mateChatInputMessage').val());
        }


        //----------------------------------- stompClient.send 모음 ---------------------------------//

        //채팅방 구독 subscribe -> pub에서 받아온 메세지를 처리
        function subscribeChatRoom(roomId) {
            stompClient.subscribe('/topic/chat/roomId/' + roomId, function (result) {
                showChatMessage(JSON.parse(result.body));
            })
        }


        //채팅창에 메세지를 보여줌
        function showChatMessage(chatMessageDTO) {
            if (chatMessageDTO.messageType == "JOIN" || chatMessageDTO.messageType == "LEAVE") {
                $('#mateChatHistoryUl').append('<li>' + chatMessageDTO.message + '</li>')
            } else {
                if (chatMessageDTO.senderId == $('#mateAlarmUserId').val()) {
                    //오른쪽에 배치
                    $('#mateChatHistoryUl').append('<li style="text-align: right;">' + chatMessageDTO.message + '</li>');
                } else {
                    //왼쪽에 배치
                    $('#mateChatHistoryUl').append('<li style="text-align: left;">' + chatMessageDTO.message + '</li>');
                }
            }
        }

        //채팅리스트 모달 펼치기
        function clickChatIcon() {
            console.log($('.mateChatModal').css('display'));
            if ($('.mateChatModal').css('display') == 'none') {
                /* $.ajax({
                     url:"
                ${pageContext.request.contextPath}/mate/my-chat-list",
                    success:function() {

                    },
                    error: function (e) {
                        console.log(e)
                    }
                })*/
                $('.mateChatModal').css('display', 'block')
            } else if ($('.mateChatModal').css('display') == "block") {
                $('.mateChatModal').css('display', 'none')
            }
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
            let chatRoomName = "";

            if (postTitle.length > 5) {
                chatRoomName = "[" + ownerNickname + "][" + guestNickname + "]" + postTitle.substring(0, 6) + "...";
            } else {
                chatRoomName = "[" + ownerNickname + "][" + guestNickname + "]" + postTitle;
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
                    guestId: guestId
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
                },
                error: function (e) {
                    console.log(e);
                }
            })
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

            console.log("알람:" + result.alarmType)

            if (result.alarmType == 'MATE_APPLY') {
                $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 동행을 신청했어요!<span onclick='deleteRealTimeAlarm(this)'>x</span> </li>");

            } else if (result.alarmType == 'MATE_CHAT') {
                $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 메세지를 보냈어요!<span onclick='deleteRealTimeAlarm(this)'>x</span> " +
                    "<br>" + result.content + "</li>");

            } else if (result.alarmType == 'MATE_COMMENT') {
                $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 댓글을 작성했어요!<span onclick='deleteRealTimeAlarm(this)'>x</span> </li>");
            }
            document.getElementsByClassName("mateAlarmListClose")[0].addEventListener("click", function () {
                document.getElementById("myMateRealTimeAlarmModal").style.display = "none";
            });

            setTimeout(function () {
                document.getElementById("mateRealTimeAlarmUl").lastChild.remove();
            }, 3000);
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
                                            list[i].content + '</span><a style="width:8%;" onclick="mateChatCreate(this)"  data-value="' + $('#mateAlarmUserNickname').val() + ',' + list[i].senderNickname + ',' + list[i].mateBoardTitle + ',' + list[i].mateBoardId + ',' + $('#mateAlarmUserId').val() + ',' + list[i].senderId + '"><i class="uil uil-comments"></i></a>' +
                                            '<a id="mateAlarmCurrentPage' + pagination.currentPage + '"onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span></li>');
                                    } else {
                                        $('#notificationList').append('<li id="mateAlarm' + list[i].id + '"class="mateAlarmListLi" xmlns="http://www.w3.org/1999/html"><span style="font-weight: bold; font-size: 12px; width: 100%; "> ' + list[i].senderNickname + '님이 동행 신청을 했어요!</span><br><span class="spanAlarmList">' +
                                            '<img style="border-radius: 70%;" src="' +
                                            list[i].senderProfileImage + '" alt="신청자프로필이미지" width="30px;" height="30px;"> <span style="display:-webkit-box; white-space:normal; overflow: hidden;-webkit-line-clamp: 3; -webkit-box-orient: vertical; width:65%; height:45px; font-size: 12px; ">' +
                                            list[i].content + '</span><a style="width:8%;" onclick="mateChatCreate(this)" data-value="' + $('#mateAlarmUserNickname').val() + ',' + list[i].senderNickname + ',' + list[i].mateBoardTitle + ',' + list[i].mateBoardId + ',' + $('#mateAlarmUserId').val() + ',' + list[i].senderId + '"><i class="uil uil-comments"></i></a>' +
                                            '<a id="mateAlarmCurrentPage' + pagination.currentPage + '" onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span> <hr style="margin:0px;"> </li>')
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
</body>
</html>
