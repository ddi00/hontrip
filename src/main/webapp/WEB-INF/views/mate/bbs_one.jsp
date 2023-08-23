<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <% session.setAttribute("userId", "1"); %>
    <% session.setAttribute("nickName", "Alice"); %>
    <script type="text/javascript" src="../resources/js/jquery-3.7.0.js" ></script>
    <input hidden id = "userId" name = "userId" value = "${userId}">
    <input hidden id = "nickName" name = "nickName" value = "${nickName}">
    <input hidden id = "mateBoardId" name = "mateBoardId" value = "${one.mateBoardId}">
    <hr>
    댓글작성: <input id="cmtContent" style="background: gray">
    <button id="commentWrite">작 성</button>
    <br>
    <br>
    댓글 수<div id="count"></div>
    <br>
    <div id="result" style="background: skyblue;">
        <c:choose>
            <c:when test="${list.isEmpty()}">
                <h6>등록된 댓글이 없습니다.</h6>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="commentList">
                <c:if test="${commentList.commentSequence eq '0'}">
                    <tr id="comment_tr${commentList.commentId}">
                        <td>
                            댓글 작성자 : ${commentList.nickname}, 댓글 내용 : ${commentList.content}, 작성날짜 : ${commentList.createdAt}
                            <a href="javascript:void(0);" onclick="showCcmtTextarea(${commentList.commentId})">답글 달기</a>
                            <c:if test="${commentList.nickname eq 'Alice'}">
                                <a href="javascript:void(0);" onclick="showUpdateTextarea(${commentList.commentId})">수정</a>
                                <button class="commentDelete" data-comment-id="${commentList.commentId}">삭제</button>
                            </c:if>

                            <c:forEach items="${reCommentList}" var="reComment">
                                <c:if test="${commentList.commentId eq reComment.indentationNumber}">
                                    <br>
                                    --> 댓글 작성자 : ${reComment.nickname}, 댓글 내용 : ${reComment.content}, 작성날짜 : ${reComment.createdAt}
                                    <c:if test="${reComment.nickname eq 'Alice'}">
                                        <a href="javascript:void(0);" onclick="showUpdateTextarea(${reComment.commentId})">수정</a>
                                        <button class="commentDelete" data-comment-id="${reComment.commentId}">삭제</button>
                                         <div id="commentUpdate${reComment.commentId}" style="display: none">
                                          <textarea id="updateContent${reComment.commentId}" placeholder="수정글을 입력해주세요">${reComment.content}</textarea>
                                            <br>
                                            <button class="updateComment" data-comment-id="${reComment.commentId}">수정</button>
                                            <a href="javascript:void(0);" onclick="closeTextarea(${reComment.commentId})">취소</a>
                                        </div>
                                    </c:if>
                                    <br>
                                </c:if>
                            </c:forEach>
                            <br>

                            <div id="commentUpdate${commentList.commentId}" style="display: none">
                                <textarea id="updateContent${commentList.commentId}" placeholder="수정글을 입력해주세요">${commentList.content}</textarea>
                                <br>
                                <button class="updateComment" data-comment-id="${commentList.commentId}">수정</button>
                                <a href="javascript:void(0);" onclick="closeTextarea(${commentList.commentId})">취소</a>
                            </div>

                            <div id="cComment${commentList.commentId}" style="display: none">
                                <textarea id="cContent${commentList.commentId}" placeholder="답글을 입력해주세요"></textarea>
                                <br>
                                <button class="cCommentWrite" data-comment-id="${commentList.commentId}">답글 전송</button>
                                <a href="javascript:void(0);" onclick="closeCTextarea(${commentList.commentId})">취소</a>
                                <br>
                            </div>
                        </td>
                    </tr>
                </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>