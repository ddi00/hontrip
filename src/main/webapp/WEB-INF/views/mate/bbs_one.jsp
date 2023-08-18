<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#commentBtn').click(function () {
                $.ajax({
                    url: "/hontrip/mate/comment_insert",
                    data: {
                        mateBoardId: ${one.mateBoardId},
                        content: $('#comment').val(),
                        userId: '${user_id}',
                        nickname: '${nickname}'
                    },
                    dataType: 'json',
                    success: function (data) {
                        let comment = '';
                        for (let i = 0; i < data.list.length; i++) {
                            let commentList = data.list[i];
                            comment += commentList.nickname + ', ' + commentList.content + '<br>';
                        }
                        $('#result').empty().html(comment);
                    },
                    error: function () {
                        alert("실패!");
                    }
                });
            });
        });
    </script>
</head>
<body style="color: blue;">
게시판 번호: ${one.mateBoardId}<br>
게시판 제목: ${one.title}<br>
게시판 내용: ${one.content}<br>
게시판 글쓴이: ${one.nickname}
<hr color="blue">
댓글작성: <input id="comment" style="background: black; color: white;">
<button id="commentBtn" style="background: red; color: white;">작성완료</button>
<hr color="blue">
<div id="result" style="background: lime; height: 150px; width: 300px;">
    <c:forEach items="${list}" var="commentList">
        ${commentList.nickname}, ${commentList.content} <br>
    </c:forEach>
</div>
</body>
</html>