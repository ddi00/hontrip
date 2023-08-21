<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

    <% session.setAttribute("userId", "1"); %>
    <% session.setAttribute("nickName", "Alice"); %>
<head>
    <meta charset="UTF-8">
    <title>게시물 조회</title>
    <script type="text/javascript"
    	src="../resources/js/jquery-3.7.0.js" ></script>
    <script type="text/javascript">

        function updateCommentSection(commentListRe) {
            let comments = "";
            let cCount = commentListRe.commentList.length;

            if (cCount > 0) {
                for (let i = 0; i < cCount; i++) {
                    let cmtList = commentListRe.commentList[i];
                    comments += "<img src=" + "<c:url value='/resources/img/recordImg/${cmtList.profileImg}'/> width='60' height='60'>";
                    comments += " 댓글 작성자 : " + cmtList.cmtUserNickName + ", ";
                    comments += "댓글 내용 : " + cmtList.cmtContent + ", ";
                    comments += "작성날짜 : " + cmtList.cmtCreatedAt + ", ";
                    if (cmtList.cmtUserNickName !== "Bob") {
                        comments += "<button class='commentUpdate' data-comment-id='" + cmtList.cmtId + "'>수정</button>";
                        comments += "<button class='commentDelete' data-comment-id='" + cmtList.cmtId + "'>삭제</button>"
                    }
                    comments += "<br>";
                }
            } else {
                comments += "<div>";
                comments += "<h6>등록된 댓글이 없습니다.</h6>";
                comments += "</div>";
            }

            $('#count').html(cCount);
            $('#result').html(comments);
        }

        $(function() {
            $('#commentWrite').click(function() {
                console.log("ajax 실행");
                $.ajax({
                    url: "post_comment",
                    dataType: "json",
                    data: {
                        recordId: ${postInfoDTO.boardId},
                        cmtContent: $('#cmtContent').val(),
                        cmtWriterId: ${userId}
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        alert("실패!");
                    } // error
                });
            }); // commentWrite

            $(document).on('click', '.commentDelete', function() {
                let commentId = $(this).data("comment-id");
                $.ajax({
                    url: "delete_comment",
                    dataType: "json",
                    data:{
                        cmtId: commentId,
                        recordId: ${postInfoDTO.boardId}
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("삭제 실패");
                    }
                })
            }) // commentDelete

            $(document).on('click', '.updateComment', function() {
                let commentId = $(this).data("comment-id");
                $.ajax({
                    url: "delete_comment",
                    dataType: "json",
                    data:{
                        cmtId: commentId,
                        cmtContent: $('#updateCmt').val(),
                        recordId: ${postInfoDTO.boardId}
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("삭제 실패");
                    }
                })
            }) // commentDelete



        }); // $
    </script>
</head>
<body>
    게시물 아이디 : ${postInfoDTO.boardId}<br>
    도시명 : ${postInfoDTO.city}<br>
    작성 유저 닉네임 : ${postInfoDTO.nickName}<br>
    공개 / 비공개 : ${postInfoDTO.isVisible}<br>
    <hr>
    게시물 썸네일 : ${postInfoDTO.thumbnail}<br>
    <img src="<c:url value='/resources/img/recordImg/${postInfoDTO.thumbnail}'/>"width="300" height="180"><br>
    게시물 제목 : ${postInfoDTO.title}<br>
    게시물 이미지 : ${postInfoDTO.imgUrl} <br>
    게시물 내용 : ${postInfoDTO.content}<br>
    게시물 작성날짜 : ${postInfoDTO.createdAt}<br>
    게시물 수정날짜 : ${postInfoDTO.updatedAt}<br>
    게시물 좋아요 개수 : ${postInfoDTO.likeCount}<br>
    <hr>
    <a href="updatepost?id=${postInfoDTO.boardId}">수 정</a>
    <a href="deletepost?id=${postInfoDTO.boardId}">삭 제</a>
    <hr>
    댓글작성: <input id="cmtContent" style="background: gray">
    <button id="commentWrite">작 성</button>
    <br>
    <br>
    댓글 수<div id="count"></div>
    <br>
    <div id="updateModal" class="modal">
        <div class="modal-content">
            <!-- 수정할 내용을 입력할 폼 -->
            <!-- 예: 댓글 내용 입력 창, 수정 버튼 -->
        </div>
    </div>
    <div id="result" style="background: gray;">
        <c:choose>
            <c:when test="${commentList.isEmpty()}">
                <h6>등록된 댓글이 없습니다.</h6>
            </c:when>
            <c:otherwise>
                <c:forEach items="${commentList}" var="commentDTO">
                    <img src="<c:url value='/resources/img/recordImg/${commentDTO.profileImg}'/>" width="60" height="60">
                    댓글 작성자 : ${commentDTO.cmtUserNickName}, 댓글 내용 : ${commentDTO.cmtContent}, 작성날짜 : ${commentDTO.cmtCreatedAt}
                    <c:if test="${commentDTO.cmtUserNickName eq 'Alice'}">
                        <br>댓글수정: <input id="updateCmt" style="background: gray">
                        <button id="updateComment">작 성</button>
                        <button class="commentUpdate" data-comment-id="${commentDTO.cmtId}">수정</button>
                        <button class="commentDelete" data-comment-id="${commentDTO.cmtId}">삭제</button>
                    </c:if>
                    <br>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>