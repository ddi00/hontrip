<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <% session.setAttribute("userId", "1"); %>
    <% session.setAttribute("nickName", "Alice"); %>
<head>
    <meta charset="UTF-8">
    <title>게시물 조회</title>
    <script type="text/javascript"
    	src="../resources/js/jquery-3.7.0.js" ></script>
    <script type="text/javascript">
        function showUpdateTextarea(commentId) {
            var updateField = document.getElementById("commentUpdate" + commentId);
            updateField.style.display = "block";
        }

        function closeTextarea(commentId) {
            var updateField = document.getElementById("commentUpdate" + commentId);
            updateField.style.display = "none";
        }

        function showCcmtTextarea(commentId) {
            var updateField = document.getElementById("cComment" + commentId);
            updateField.style.display = "block";
        }

        function closeCTextarea(commentId) {
            var updateField = document.getElementById("cComment" + commentId);
            updateField.style.display = "none";
        }

        function updateCommentSection(commentListRe) {
            let comments = "";
            let cCount = commentListRe.commentList.length;
            let rCount = commentListRe.reCommentList.length;

            if (cCount > 0) {
                for (let i = 0; i < cCount; i++) {
                    let commentList = commentListRe.commentList[i];
                    if(commentList.cmtSequence == 0){
                    comments += "<img src=" + "<c:url value='/resources/img/recordImg/${cmtList.profileImg}'/> width='60' height='60'>";
                    comments += " 댓글 작성자 : " + commentList.cmtUserNickName + ", ";
                    comments += "댓글 내용 : " + commentList.cmtContent + ", ";
                    comments += "작성날짜 : " + commentList.cmtCreatedAt + ", ";
                    comments += "<a href='javascript:void(0);' onclick='showCcmtTextarea(" + commentList.cmtId + ")'>답글 달기</a>";

                    if (commentList.cmtUserNickName !== "Bob") {
                        comments += "<a href='javascript:void(0);' onclick='showUpdateTextarea(" + commentList.cmtId + ")'>수정</a>";
                        comments += "<button class='commentDelete' data-comment-id='" + commentList.cmtId + "'>삭제</button>"
                    }

                    comments += "<div id='commentUpdate" + commentList.cmtId + "' style='display: none'>";
                    comments += "<textarea id='updateContent" + commentList.cmtId + "' placeholder='수정글을 입력해주세요'>" + commentList.cmtContent + "</textarea>";
                    comments += "<button class='updateComment' data-comment-id='" + commentList.cmtId + "'>수정</button>"
                    comments += "<a href='javascript:void(0);' onclick='closeTextarea(" + commentList.cmtId + ")'>취소</a></div>";

                    comments += `<div id="cComment\${commentList.cmtId}" style="display: none">
                        <textarea id="cContent\${commentList.cmtId}" placeholder="답글을 입력해주세요"></textarea>
                        <button class="cCommentWrite" data-comment-id="\${commentList.cmtId}">답글 전송</button>
                        <a href="javascript:void(0);" onclick="closeCTextarea(\${commentList.cmtId})">취소</a>
                    </div>`;
                    for (let i = 0; i < rCount; i++) {
                        let replyList = commentListRe.reCommentList[i];
                        if (commentList.cmtId == replyList.indentationNum){
                            comments += `<br>
                            --> <img src="<c:url value='/resources/img/recordImg/\${replyList.profileImg}'/>" width="60" height="60">
                                댓글 작성자 : \${replyList.cmtUserNickName}, 댓글 내용 : \${replyList.cmtContent}, 작성날짜 : \${replyList.cmtCreatedAt}`;
                            if (commentList.cmtUserNickName !== "Bob") {
                                comments +=`
                                <a href="javascript:void(0);" onclick="showUpdateTextarea(\${replyList.cmtId})">수정</a>
                                <button class="commentDelete" data-comment-id="\${replyList.cmtId}">삭제</button>`;
                                comments += `<div id="commentUpdate\${replyList.cmtId}" style="display: none">
                                    <textarea id="updateContent\${replyList.cmtId}" placeholder="수정글을 입력해주세요">\${replyList.cmtContent}</textarea>
                                    <br>
                                    <button class="updateComment" data-comment-id="\${replyList.cmtId}">수정</button>
                                    <a href="javascript:void(0);" onclick="closeTextarea(\${replyList.cmtId})">취소</a>
                                </div>`;
                            }
                        }
                    }
                    comments += "<br>";




                    }
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
                    url: "create_comment",
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
                let content = $('#updateContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
                $.ajax({
                    url: "update_comment",
                    dataType: "json",
                    data:{
                        cmtId: commentId,
                        recordId: ${postInfoDTO.boardId},
                        cmtContent: content
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("수정 실패");
                    }
                })
            }) // commentUpdate


            $(document).on('click', '.cCommentWrite', function() {
                let commentId = $(this).data("comment-id");
                let content = $('#cContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
                $.ajax({
                    url: "create_recomment",
                    dataType: "json",
                    data:{
                        recordId: ${postInfoDTO.boardId},
                        cmtContent: content,
                        cmtWriterId: ${userId},
                        cmtSequence: '1',
                        indentationNum: commentId
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("전송 실패");
                    }
                })
            }) // recomment



        }); // $


    </script>
</head>
<body>
		게시물 아이디 : ${postInfoDTO.boardId}<br>
		도시명 : ${postInfoDTO.city}<br>
		작성 유저 닉네임 : ${postInfoDTO.nickName}<br>
		공개 / 비공개 : ${postInfoDTO.isVisible}<br>
		<hr>
		게시물 썸네일 :<br>
		<img src="<c:url value='/${postInfoDTO.thumbnail}'/>"width="300" height="180"><br>
		게시물 제목 : ${postInfoDTO.title}<br>
		게시물 이미지 : <br>
		<c:forEach items="${postImgList}" var="postImgDTO">
		    <img src="<c:url value='/${postImgDTO.imgUrl}'/>"width="300" height="180"><br>
		</c:forEach>
		게시물 내용 : ${postInfoDTO.content}<br>
		게시물 작성날짜 : ${postInfoDTO.createdAt}<br>
		게시물 수정날짜 : ${postInfoDTO.updatedAt}<br>
		게시물 좋아요 개수 : ${postInfoDTO.likeCount}<br>
		<hr>
		<a href="updatepost?id=${postInfoDTO.boardId}">수 정</a>
		<a href="deletepost?id=${postInfoDTO.boardId}">삭 제</a>
        <hr>
        <insert id="insertNewReComment" parameterType="commentDTO" keyProperty="id" useGeneratedKeys="true">
            댓글작성: <input id="cmtContent" style="background: gray">
            <button id="commentWrite">작 성</button>
            <br>
            <br>
            댓글 수
            <div id="count"></div>
            <br>
            <div id="result" style="background: red;">
                <c:choose>
            <c:when test="${commentList.isEmpty()}">
                <h6>등록된 댓글이 없습니다.</h6>
            </c:when>
            <c:otherwise>
                <c:forEach items="${commentList}" var="commentDTO">
                <c:if test="${commentDTO.cmtSequence eq '0'}">
                    <tr id="comment_tr${commentDTO.cmtId}">
                        <td>
                            <img src="<c:url value='/resources/img/recordImg/${commentDTO.profileImg}'/>" width="60" height="60">
                            댓글 작성자 : ${commentDTO.cmtUserNickName}, 댓글 내용 : ${commentDTO.cmtContent}, 작성날짜 : ${commentDTO.cmtCreatedAt}
                            <a href="javascript:void(0);" onclick="showCcmtTextarea(${commentDTO.cmtId})">답글 달기</a>
                            <c:if test="${commentDTO.cmtUserNickName eq 'Alice'}">
                                <a href="javascript:void(0);" onclick="showUpdateTextarea(${commentDTO.cmtId})">수정</a>
                                <button class="commentDelete" data-comment-id="${commentDTO.cmtId}">삭제</button>
                            </c:if>
                            <div id="commentUpdate${commentDTO.cmtId}" style="display: none">
                                <textarea id="updateContent${commentDTO.cmtId}" placeholder="수정글을 입력해주세요">${commentDTO.cmtContent}</textarea>
                                <button class="updateComment" data-comment-id="${commentDTO.cmtId}">수정 하기</button>
                                <a href="javascript:void(0);" onclick="closeTextarea(${commentDTO.cmtId})">취소</a>
                            </div>

                            <div id="cComment${commentDTO.cmtId}" style="display: none">
                                <textarea id="cContent${commentDTO.cmtId}" placeholder="답글을 입력해주세요"></textarea>
                                <button class="cCommentWrite" data-comment-id="${commentDTO.cmtId}">답글 전송</button>
                                <a href="javascript:void(0);" onclick="closeCTextarea(${commentDTO.cmtId})">취소</a>
                            </div>
                                <c:forEach items="${reCommentList}" var="reComment">
                                    <c:if test="${commentDTO.cmtId eq reComment.indentationNum}">
                                        <br>
                                        ---><img src="<c:url value='/resources/img/recordImg/${reComment.profileImg}'/>" width="60" height="60">
                                        댓글 작성자 : ${reComment.cmtUserNickName}, 댓글 내용 : ${reComment.cmtContent}, 작성날짜 : ${reComment.cmtCreatedAt}
                                        <c:if test="${reComment.cmtUserNickName eq 'Alice'}">
                                            <a href="javascript:void(0);" onclick="showUpdateTextarea(${reComment.cmtId})">수정</a>
                                            <button class="commentDelete" data-comment-id="${reComment.cmtId}">삭제</button>
                                        </c:if>
                                        <br>
                                        <div id="commentUpdate${reComment.cmtId}" style="display: none">
                                            <textarea id="updateContent${reComment.cmtId}" placeholder="수정글을 입력해주세요">${reComment.cmtContent}</textarea>
                                            <button class="updateComment" data-comment-id="${reComment.cmtId}">수정 하기</button>
                                            <a href="javascript:void(0);" onclick="closeTextarea(${reComment.cmtId})">취소</a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            <br>
                        </td>
                    </tr>
                </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
<script>
    const userId = ${userId};
</script>