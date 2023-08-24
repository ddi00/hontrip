document.addEventListener("DOMContentLoaded", function () {// 새 방에 입장
    if (window.location.href.includes('/mate/create-chatroom')) {
        var chatRoomId = document.getElementById("roomId").value;
        var chatSenderId = document.getElementById("senderId").value;
        var chatReceiverId = document.getElementById("receiverId").value;

        const message = {
            roomId: chatRoomId,
            senderId: chatSenderId,
            receiverId: chatReceiverId,
            messageType: 'JOIN'
        };
        connectWebsocket(message);
    }
    if (window.location.href.includes('/mate/join-chat')) { // 기존 방에 입장
        var chatRoomId = document.getElementById("roomId").value;
        var chatSenderId = document.getElementById("senderId").value;
        var chatReceiverId = document.getElementById("receiverId").value;
        var newFlag = document.getElementById("newFlag").value;
        if(newFlag == 'true'){
            const message = {
                roomId: chatRoomId,
                senderId: chatSenderId,
                receiverId: chatReceiverId,
                messageType: 'JOIN'
            };
            connectWebsocket(message);
        }else{
            const message = {
                roomId: chatRoomId,
                senderId: chatSenderId,
                receiverId: chatReceiverId,
                messageType: 'ENTER'
            };
            connectWebsocket(message);
        }
    }

    function connectWebsocket(data) {    // Connect는 2가지 경우 JOIN(방 만들때), ENTER(이미 생긴 방 입장할 때\

        const messageSendButton = document.getElementById("messge-send");

        messageSendButton.addEventListener("click",function (){
            //사용자 입력값 가져오기
            var message=document.getElementById("chat-input-text").value;
            var chatMassage = {
                messageType: 'TALK',
                message: message
            }
            send(chatMassage);
        });

        const mateChatURL = "ws://" + location.host + "/hontrip/chat";
        var ws; //웹소켓 변수
        function wsOpen() {  //웹 소캣을 지정한 url로 연결
            var senderId = data.senderId;
            var receiverId = data.receiverId; // 채팅방 ID
            var queryString = `senderId=${senderId}&receiverId=${receiverId}`;
            var websocketURL = mateChatURL + "/" + data.roomId + "?" + queryString;
            ws = new WebSocket(websocketURL);
            wsEvt();
        }

        wsOpen();

        function wsEvt() {
            ws.onopen = function (e) {    //소켓이 열리면 동작
                if (data.messageType == 'JOIN') {
                    var joinMassage = {
                        messageType: 'JOIN',
                        message: ""
                    }
                    send(joinMassage);
                } else if (data.messageType == 'ENTER') {
                    var enterMassage = {
                        messageType: 'ENTER',
                        message: ""
                    }
                    send(enterMassage);
                }
            }
            ws.onmessage = function (e) {    // 데이터 수신시(메세지 받으면)
                // 문자형식 : "[roomId][messageType][senderId][sendTime][messageContent]"
                const message = e.data;   // 전달 받은 데이터
                const parts = message.split(/\[|\]/).filter(part => part !== "");

                // 각 부분을 변수에 저장
                const roomId = parts[0];
                const messageType = parts[1];
                const messageSenderId = parts[2];
                const sendTime = parts[3];
                const messageContent = parts[4];

                console.log(roomId);
                console.log(messageType);
                console.log(messageSenderId);
                console.log(sendTime);
                console.log(messageContent);

                var chatRoomContent = document.querySelector(".chat-room-content");

                if (messageType == "JOIN") {    //첫 입장
                    // chat-room-content(class name) div에 p태그로 넣기-> 텍스트 가운데
                    const p = document.createElement('p');
                    p.textContent = messageContent;
                    p.classList='join-chat';
                    chatRoomContent.appendChild(p);
                } else if (messageType == "ENTER") { // 그냥 입장
                    // 입장 여부를 알수 있는 영역에 입장처리

                } else if (messageType == "TALK") {  //채팅 메세지를 받음
                    // chat-room-content(class name) div에 p태그로 넣기-> session id와 sender가 같으면왼쪽정렬, 다르면 오른쪽정렬
                    // [sender_id][내용][시간]으로 표시
                    const p = document.createElement('p');
                    p.textContent = `[${messageSenderId}] ${messageContent} [${sendTime}]`;
                    if (messageSenderId === chatSenderId) {
                        p.classList='sender-chat';
                    } else {
                        p.classList='receiver-chat';
                    }
                    chatRoomContent.appendChild(p);
                } else if (messageType == "OUT") {   // 나감
                    // 입장여부를 알수 있는 영역에 퇴장처리
                }
            }
        }

        function send(e) {    //메세지 보낼때
            var chatMessage = {
                messageType: e.messageType,
                message: e.message
            }
            ws.send(JSON.stringify(chatMessage));   //메세지 전송
        }
    }
});
