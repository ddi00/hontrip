<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
    $(function() {
        //댓글 작성 버튼 클릭시
        $('#commentBtn').click(function() {
            $.ajax({
                url: "/hontrip/mate/comment_insert",
                data: {
                    mateBoardId: ${one.mateBoardId},
                    content: $('#comment').val(),
                    userId: '${user_id}',
                    nickname: '${nickname}'
                },
                dataType: 'json',
                success: function(data) {
                    let comment = '';
                    for (let i = 0; i < data.list.length; i++) {
                        let commentList = data.list[i];
                        comment += `\${commentList.nickname} : \${commentList.content}
                        <button class="commentDeleteBtn" data-comment-id = \${commentList.commentId} > 삭제 </button> <br>`
                    }
                    $('#comment').val('');
                    $('#result').empty().html(comment);
                },
                error: function() {
                    alert("실패!");
                }
            });
        });

        // 댓글 수정 버튼 클릭 시
        $(document).on('click', '.commentEditBtn', function() {
            let commentId = $(this).data("comment-id");
             let originalContent = $(this).closest('.result').find('.commentContent').data('content-id');
            console.log(originalContent);
            let editForm = `
                <div class="editForm">
                    <textarea class="editComment" rows="3">\${originalContent}</textarea>
                    <button class="saveEditBtn" data-comment-id="\${commentId}"> 저장 </button>
                </div>
            `;

            $(this).closest('div').append(editForm);
            $(this).closest('div').find('.editComment').val(originalContent).focus();
        });

        // 댓글 수정 저장 버튼 클릭 시
        $(document).on('click', '.saveEditBtn', function() {
            let commentId = $(this).data("comment-id");
            let newContent = $(this).closest('.editForm').find('.editComment').val();
            console.log(commentId);
            console.log(newContent);
            $.ajax({
                url: "/hontrip/mate/comment_edit",
                data: {
                    commentId: commentId,
                    mateBoardId: ${one.mateBoardId},
                    content: newContent
                },

                dataType: 'json',
                success: function(data) {
                    let comment = '';
                    for (let i = 0; i < data.list.length; i++) {
                        let commentList = data.list[i];
                        comment += `\${commentList.nickname} : \${commentList.content}
                        <button class="commentEditBtn" data-comment-id="\${commentList.commentId}"> 수정 </button>
                        <button class="commentDeleteBtn" data-comment-id="\${commentList.commentId}"> 삭제 </button>
                        <br>`;
                    }
                    $('.result').empty().html(comment);
                },
                error: function() {
                    alert("실패!");
                }
            });

            $(this).closest('.editForm').remove();
        });

        // 댓글 삭제 버튼 클릭 시
        $(document).on('click', '.commentDeleteBtn', function() {
            let commentId = $(this).data("comment-id");
            $.ajax({
                url: "/hontrip/mate/comment_delete",
                data: {
                    commentId: commentId,
                    mateBoardId: ${one.mateBoardId},
                    userId: '${user_id}',
                    nickname: '${nickname}'
                },
                dataType: 'json',
                success: function(data) {
                    let comment = '';
                    for (let i = 0; i < data.list.length; i++) {
                        let commentList = data.list[i];
                        comment += `\${commentList.nickname} : \${commentList.content}
                        <button class="commentEditBtn" data-comment-id="\${commentList.commentId}"> 수정 </button>
                        <button class="commentDeleteBtn" data-comment-id="\${commentList.commentId}"> 삭제 </button>
                        <br>`;
                    }
                    $('.result').empty().html(comment);
                },
                error: function() {
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
<div class="result">
<c:forEach items="${list}" var="commentList">
  ${commentList.nickname} : <div class="commentContent" data-content-id="${commentList.content}">${commentList.content}</div>
  <button class="commentEditBtn" data-comment-id="${commentList.commentId}"> 수정 </button>
  <button class="commentDeleteBtn" data-comment-id="${commentList.commentId}"> 삭제 </button>
  <br>
</c:forEach>
</div>
</body>
</html>