<%--
  Created by IntelliJ IDEA.
  User: ehska
  Date: 2023-08-22
  Time: 오전 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notification Test Page</title>
</head>
<body>
<input type="text" id="id"/>
<button type="button" onclick="login()">로그인</button>
</body>
</html>
<script type="text/javaScript">
    function login() {
        console.log("로그인 완료")
        const id = document.getElementById('id').value;

        const eventSource = new EventSource(`/subscribe/` + id);
        console.log("연결 완료")
        eventSource.addEventListener("sse", function (event) {
            console.log(event.data);

            const data = JSON.parse(event.data);
            console.log(data)

            (async () => {
                // 브라우저 알림
                const showNotification = () => {

                    const notification = new Notification('코드 봐줘', {
                        body: data.content
                    });

                    setTimeout(() => {
                        notification.close();
                    }, 10 * 1000);

                    notification.addEventListener('click', () => {
                        window.open(data.url, '_blank');
                    });
                }

                // 브라우저 알림 허용 권한
                let granted = false;

                if (Notification.permission === 'granted') {
                    granted = true;
                } else if (Notification.permission !== 'denied') {
                    let permission = await Notification.requestPermission();
                    granted = permission === 'granted';
                }

                // 알림 보여주기
                if (granted) {
                    showNotification();
                }
            })();
        })
    }
</script>
</html>
