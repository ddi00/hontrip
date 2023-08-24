<%--
  Created by IntelliJ IDEA.
  User: ehska
  Date: 2023-08-23
  Time: 오후 8:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /*if (session.getAttribute("id") != null){
        long userId = (long) session.getAttribute("id");
        request.setAttribute("loginUserId",userId);
    }*/
    request.setAttribute("ii", 1);
%>
<html>
<title>Title</title>
<script src="resources/js/sockjs-0.3.4.js"></script>
<script src="resources/js/stomp.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
    let stompClient = null;

    console.log("${ii}")
    $(document).ready(function () {
        console.log('gg')
        if ("${ii}" != "") {
            connectStomp()
        }
    });

    function connectStomp() {
        let socket = new SockJS('${pageContext.request.contextPath}/matews');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log(frame);
            stompClient.subscribe('/sub/' + $('#stompReceiverId').val(), function (result) {
                console.log("haha")
                showshow(JSON.parse(result.body));
            })
        })
    }


    //이건 셀렉트원에서 -> 동행인신청버튼누르고 + 신청조건에 맞는사람일경우에 넣기
    function sendMessage() {
        stompClient.send('/pub/mate', {},
            JSON.stringify({
                'mateBoardId': $('#stompMateBoardId').val(),
                'receiverId': $('#stompReceiverId').val(),
                'senderId': $('#stompSenderId').val(),
                'content': $('#stompContent').val()
            }))
    }

    /*function sendMessage() {
        stompClient.mateMatchingNotify('/pub/mate/apply', {},
            JSON.stringify({
                'userId':1,
                'mateBoardId': 1,
                'senderId': 2,
                'receiverId': 2,
                'content': '안녕!!'
            }))
    }*/

    //stomp 설정 끊음
    function stompDisconnect() {
        if (stompClient != null) {
            stompClient.disconnect();
        }
        console.log('해제됨')
    }

    //로그아웃 버튼 누르면 disconnect
    function logout() {
        stompDisconnect();
    }

    function showshow(result) {
        let response = document.getElementById('alarmResult');
        let p = document.createElement('p');
        p.innerHTML = "senderId :" + result.senderId + ", message: " + result.content;
        response.appendChild(p);
    }


    //여기서부터는 채팅입니다.

    function setConnected(connected) { //연결 여부에 따라 설정
        document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected;
        document.getElementById('conversationDiv').style.visibility = connected ? 'visible'
            : 'hidden';
        //$('#response').html('')와 동일한 코드
        document.getElementById('response').innerHTML = '';
    }

    //서버로 연결함.
    function connect() {
        //chat주소 서버와의 소켓객체 생성
        let socket = new SockJS('${pageContext.request.contextPath}/chat');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log(frame);
            stompClient.subscribe('/topic/messages', function (result) {
                console.log(JSON.parse(result.body));
            })
        })
    }

    //서버로 연결 끊음.
    function disconnect() {
        if (stompClient != null) {
            stompClient.disconnect();
        }
        setConnected(false); //연결끊어졌을 때 설정 변경
        console.log("Disconnected");
    }

    //서버로 메세지 보냄
    function sendMessage2() {
        //입력한 정보를 가지고 와서
        var from = document.getElementById('from').value;
        var text = document.getElementById('text').value;
        //url을 /app/cht을 호출하고,data를 json형태의 sring으로 만들어서 보내라.
        stompClient.send("/app/chat", {}, JSON.stringify({
            'from': from,
            'text': text
        }));
    }

    //받은 데이터를 원하는 위치에 넣음.
    function showMessageOutput(messageOutput) {
        //<p id="response">
        //	<p> 홍길동: 잘지내지?(13:00)</p>
        //</p>
        var response = document.getElementById('response');
        var p = document.createElement('p');
        p.style.wordWrap = 'break-word';
        p.appendChild(document.createTextNode(messageOutput.from + ": "
            + messageOutput.text + " (" + messageOutput.time + ")"));
        response.appendChild(p);
    }
</script>
</head>
<body>
알람알람~~<br>

<br>
<button id="connectStomp" onclick="connectStomp()">연결</button>
<button id="disconnectStomp" onclick="stompDisconnect()">해제</button>
<br>
receiverId <input id="stompReceiverId" value="1"><br>
mateBoardId <input id="stompMateBoardId" value="3"><br>
senderId <input id="stompSenderId" value="3"><br>
content <input id="stompContent" value="같이 여행가요!!"><br>
<button id="sendMessage" onclick="sendMessage()">메세지 전송</button>
<p id="alarmResult"></p>
<div>
    <div class="input-group mb-3 input-group-lg">
        <span class="input-group-text">닉네임 입력:</span> <input type="text" class="form-control" id="from">
    </div>
    <br/>
    <div>
        <button id="connect" onclick="connect();" class="btn btn-danger" style="width:200px">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();" style="width:200px" class="btn btn-danger">
            Disconnect
        </button>
    </div>
    <br/>
    <div id="conversationDiv">
        <input type="text" id="text" placeholder="Write a message..."
               class="form-control"/>
        <button id="sendMessage2" onclick="sendMessage2();"
                class="btn btn-primary">Send
        </button>

        <p id="response" class="alert alert-success"></p>
    </div>
</div>
</body>
</html>
