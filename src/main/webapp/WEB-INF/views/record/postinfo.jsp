<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

    <% session.setAttribute("userId", "2"); %>
    <% session.setAttribute("nickName", "Bob"); %>
<head>
    <meta charset="UTF-8">
    <title>게시물 조회</title>
    <script type="text/javascript"
    	src="../resources/js/jquery-3.7.0.js" ></script>
    <script type="text/javascript">
        $(function() {
            $('#b1').click(function() {
                console.log("ajax 실행");
                $.ajax({
                    url: "post_comment",
                    dataType: "json",
                    data: {
                        recordId: ${postInfoDTO.boardId},
                        cmtContent: $('#cmtComment').val(),
                        cmtWriterId: ${userId}
                    },
                    success: function(cmtListRe) {
                        let comments = "";
                        let cCount = cmtListRe.commentList.length

                        for (let i = 0; i < cmtListRe.commentList.length; i++) {
                            let cmtList = cmtListRe.commentList[i];
                            comments += "<img src=" + "<c:url value='/resources/img/recordImg/${cmtList.profileImg}'/> width='60' height='60'" + ">"
                            comments += " 댓글 작성자 : " + cmtList.cmtUserNickName + ", "
                            comments += "댓글 내용 : " + cmtList.cmtContent + ", "
                            comments += "작성날짜 : " + cmtList.cmtCreatedAt + ", "
                            comments +=  "<a href=''>" + "수 정" + "</a>"
                            comments +=  "<a href=''>" + "삭 제" + "</a>" + "<br>"
                        }
                        $('#result').html(comments);
                    },
                    error: function() {
                        alert("실패!");
                    } // error
                });
            }); // b1
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
    댓글작성: <input id="cmtComment" style="background: gray">
    <button id="b1">작 성</button>
    <br>
    <br>
    댓글 수 :
    <br>
    <div id="result" style="background: gray;">
    <c:forEach items="${commentList}" var="commentDTO">
        <img src="<c:url value='/resources/img/recordImg/${commentDTO.profileImg}'/>"width="60" height="60">
        댓글 작성자 : ${commentDTO.cmtUserNickName}, 댓글 내용 : ${commentDTO.cmtContent}, 작성날짜 : ${commentDTO.cmtCreatedAt}
        <a href="">수 정</a>
        <a href="">삭 제</a><br>
    </c:forEach>
    </div>
</body>
</html>