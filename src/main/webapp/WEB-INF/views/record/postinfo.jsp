<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <%
        if (session.getAttribute("id") != null) {
            long userId = (long) session.getAttribute("id");
            request.setAttribute("userId", userId);
        }
    %>
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
                comments += "<h3 class='mb-6'>" + cCount + "Comments</h3>";
                for (let i = 0; i < cCount; i++) {
                    let commentList = commentListRe.commentList[i];
                    if (commentList.cmtSequence == 0) {
                        comments += `
                        <div id="comments">
                        <ol id="singlecomments" class="commentlist">
                            <li class="comment">
                                <div class="comment-header d-md-flex align-items-center">
                                    <div class="d-flex align-items-center">
                                        <figure class="user-avatar"><img class="rounded-circle"
                                                alt="" src="\${commentList.profileImg}" /></figure>
                                        <div>
                                            <h6 class="comment-author"><a href="#"
                                                    class="link-dark">\${commentList.cmtUserNickName}</a>
                                            </h6>
                                            <ul class="post-meta">
                                                <li><i
                                                        class="uil uil-calendar-alt"></i>작성날짜 \${commentList.cmtCreatedAt}
                                                </li>
                                                <li><i
                                                        class="uil uil-calendar-alt"></i>수정날짜 \${commentList.cmtUpdatedAt}
                                                </li>`;
                        if (commentList.cmtWriterId == ${ userId }) {
                            comments += `
                                                <li><a href="javascript:void(0);"
                                                onclick="showUpdateTextarea(\${commentList.cmtId})">수정</a>
                                                </li>
                                                <li><button style='all: unset'
                                                        class="commentDelete"
                                                        data-comment-id="\${commentList.cmtId}">삭제</button>
                                                </li>`;
                        }
                        comments += "</ul></div></div>";
                        comments += "<div class='mt-3 mt-md-0 ms-auto'>";
                        if (${ userId } !== null) {
                            comments += `
                                    <a href="javascript:void(0);"
                                    onclick="showCcmtTextarea(\${commentList.cmtId})"
                                    class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                        class="uil uil-comments"></i> Reply</a>`;
                        }
                        comments += "</div></div>";
                        comments += `<p>\${commentList.cmtContent}</p>`;
                        comments += `
                            <div id="commentUpdate\${commentList.cmtId}" style="display: none">
                                <textarea id="updateContent\${commentList.cmtId}"
                                    placeholder="수정글을 입력해주세요">\${commentList.cmtContent}</textarea>
                                <button class="updateComment"
                                    data-comment-id="\${commentList.cmtId}">수정 하기</button>
                                <a href="javascript:void(0);"
                                    onclick="closeTextarea(\${commentList.cmtId})">취소</a>
                            </div>

                            <div id="cComment\${commentList.cmtId}" style="display: none">
                                <textarea id="cContent\${commentList.cmtId}"
                                    placeholder="답글을 입력해주세요"></textarea>
                                <button class="cCommentWrite"
                                    data-comment-id="\${commentList.cmtId}">답글 전송</button>
                                <a href="javascript:void(0);"
                                    onclick="closeCTextarea(\${commentList.cmtId})">취소</a>
                            </div>`;
                        for (let i = 0; i < rCount; i++) {
                            let replyList = commentListRe.reCommentList[i];
                            if (commentList.cmtId == replyList.indentationNum) {
                                comments += `
                                    <ul class="en">
                                      <li class="commechildrnt">
                                        <div
                                            class="comment-header d-md-flex align-items-center">
                                            <div class="d-flex align-items-center">
                                                <figure class="user-avatar"><img
                                                        class="rounded-circle" alt=""
                                                        src="\${replyList.profileImg}" />
                                                </figure>
                                                <div>
                                                    <h6 class="comment-author"><a href="#"
                                                            class="link-dark">\${replyList.cmtUserNickName}</a>
                                                    </h6>
                                                    <ul class="post-meta">
                                                        <li><i
                                                                class="uil uil-calendar-alt"></i>작성날짜 \${replyList.cmtCreatedAt}
                                                        </li>
                                                        <li><i
                                                                class="uil uil-calendar-alt"></i>수정날짜 \${replyList.cmtUpdatedAt}
                                                        </li>`;
                                if (replyList.cmtWriterId == ${ userId }) {
                                    comments += `
                                                            <li><a
                                                                    href="javascript:void(0);"
                                                                    onclick="showUpdateTextarea(\${replyList.cmtId})">수정</a>
                                                            </li>
                                                            <li><button
                                                                    class="commentDelete"
                                                                    style='all: unset'
                                                                    data-comment-id="\${replyList.cmtId}">삭제</button>
                                                            </li>`;
                                }
                                comments += "</ul></div></div></div>";
                                comments += `<p>\${replyList.cmtContent}</p>`;
                                comments += `
                                        <div id="commentUpdate\${replyList.cmtId}"
                                            style="display: none">
                                            <textarea id="updateContent\${replyList.cmtId}"
                                                placeholder="수정글을 입력해주세요">\${replyList.cmtContent}</textarea>
                                            <button class="updateComment"
                                                data-comment-id="\${replyList.cmtId}">수정
                                                하기</button>
                                            <a href="javascript:void(0);"
                                                onclick="closeTextarea(\${replyList.cmtId})">취소</a>
                                        </div></li></ul>`;
                            }
                        }
                        comments += "</li></ol></div>";
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
                    var commentContent = $('#cmtContent').val().trim();
                    if (commentContent === "") {
                        alert("댓글을 입력해 주세요.");
                        return;
                    }

                    $.ajax({
                        url: "create_comment",
                        dataType: "json",
                        data: {
                            recordId: ${postInfoDTO.boardId},
                            cmtContent: commentContent,
                            cmtWriterId: ${userId}
                        },
                        success: function(cmtListRe) {
                            updateCommentSection(cmtListRe);
                            $('#cmtContent').val(""); // 댓글 전송 후 입력칸 비우기
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
<br>
<br>
<br>
<br>
<br>
<section class="wrapper bg-light">
    <div class="container pb-14 pb-md-16">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="blog classic-view mt-n17">
                    <article class="post">
                        <div class="card">
                            <div class="post-slider card-img-top">
                                <div class="swiper-container dots-over" data-margin="5" data-nav="true"
                                    data-dots="true">
                                    <div class="swiper">
                                        <div class="swiper-wrapper">
                                            <c:forEach items="${postImgList}" var="postImgDTO">
                                                <div class="swiper-slide">
                                                    <figure class="rounded">
                                                        <img src="<c:url value='/${postImgDTO.imgUrl}'/>"
                                                            srcset="<c:url value='/${postImgDTO.imgUrl}'/>" alt="" /><a
                                                            class="item-link" href="/hontrip/${postImgDTO.imgUrl}"
                                                            data-glightbox data-gallery="product-group"><i
                                                                class="uil uil-focus-add"></i></a>
                                                    </figure>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <!--/.swiper-wrapper -->
                                    </div>
                                    <!-- /.swiper -->
                                </div>
                                <!-- /.swiper-container -->
                            </div>
                            <!-- /.post-slider -->
                            <div class="card-body">
                                <div class="post-header">
                                    <ul class="post-meta d-flex mb-0">
                                        <li class="post-date"><i class="uil uil-calendar-alt"></i><span>여행기간
                                                ${postInfoDTO.startDate}~${postInfoDTO.endDate}</span></li>
                                    </ul>
                                    <h2 class="post-title mt-1 mb-0">${postInfoDTO.title}</h2>
                                </div>
                                <!-- /.post-header -->
                                <div class="post-content">
                                    <p>${postInfoDTO.content}</p>
                                </div>
                                <!-- /.post-content -->
                            </div>
                            <!--/.card-body -->
                            <div class="card-footer">
                                <ul class="post-meta d-flex mb-0">
                                    <li class="post-date"><i class="uil uil-calendar-alt"></i><span>작성날짜
                                            ${postInfoDTO.createdAt}</span></li>
                                    <li class="post-date"><i class="uil uil-calendar-alt"></i><span>수정날짜
                                            ${postInfoDTO.updatedAt}</span></li>
                                    <li class="post-author"><a href="#"><i
                                                class="uil uil-user"></i><span>${postInfoDTO.nickName}</span></a></li>
                                    <li class="post-likes ms-auto"><a href="#"><i
                                                class="uil uil-heart-alt"></i>${postInfoDTO.likeCount}</a></li>
                                    <li class="post-likes"><a
                                            href="/hontrip/record/updatepost?id=${postInfoDTO.boardId}">수 정</a></li>
                                    <li class="post-likes"><a
                                            href="/hontrip/record/deletepost?id=${postInfoDTO.boardId}">삭 제</a></li>
                                </ul>
                                <!-- /.post-meta -->
                            </div>
                            <!-- /.card-footer -->
                        </div>
                        <!-- /.card -->
                    </article>
                    <!-- /.post -->
                </div>
                <!-- /.blog -->

                <div id="result">
                    <h3 class="mb-6">${postInfoDTO.cmtCount} Comments</h3>
                    <c:choose>
                        <c:when test="${commentList.isEmpty()}">
                            <h6>등록된 댓글이 없습니다.</h6>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${commentList}" var="commentDTO">
                                <c:if test="${commentDTO.cmtSequence eq '0'}">
                                    <div id="comments">
                                        <ol id="singlecomments" class="commentlist">
                                            <li class="comment">
                                                <div class="comment-header d-md-flex align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <figure class="user-avatar"><img class="rounded-circle" alt=""
                                                                src="${commentDTO.profileImg}" /></figure>
                                                        <div>
                                                            <h6 class="comment-author"><a href="#"
                                                                    class="link-dark">${commentDTO.cmtUserNickName}</a>
                                                            </h6>
                                                            <ul class="post-meta">
                                                                <li><i class="uil uil-calendar-alt"></i>작성날짜
                                                                    ${commentDTO.cmtCreatedAt}
                                                                </li>
                                                                <li><i class="uil uil-calendar-alt"></i>수정날짜
                                                                    ${commentDTO.cmtUpdatedAt}
                                                                </li>
                                                                <c:if test="${commentDTO.cmtWriterId eq userId}">
                                                                    <li><a href="javascript:void(0);"
                                                                            onclick="showUpdateTextarea(${commentDTO.cmtId})">수정</a>
                                                                    </li>
                                                                    <li><button style='all: unset'
                                                                            data-comment-id="${commentDTO.cmtId}">삭제</button>
                                                                    </li>
                                                                </c:if>
                                                            </ul>
                                                            <!-- /.post-meta -->
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /div -->
                                                    <div class="mt-3 mt-md-0 ms-auto">
                                                        <c:if test="${not empty sessionScope.id}">
                                                            <a href="javascript:void(0);"
                                                                onclick="showCcmtTextarea(${commentDTO.cmtId})"
                                                                class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                    class="uil uil-comments"></i> Reply</a>
                                                        </c:if>
                                                    </div>
                                                    <!-- /div -->
                                                </div>
                                                <!-- /.comment-header -->
                                                <p>${commentDTO.cmtContent}</p>
                                                <div id="commentUpdate${commentDTO.cmtId}" style="display: none">
                                                    <textarea id="updateContent${commentDTO.cmtId}"
                                                        placeholder="수정글을 입력해주세요">${commentDTO.cmtContent}</textarea>
                                                    <button class="updateComment"
                                                        data-comment-id="${commentDTO.cmtId}">수정 하기</button>
                                                    <a href="javascript:void(0);"
                                                        onclick="closeTextarea(${commentDTO.cmtId})">취소</a>
                                                </div>

                                                <div id="cComment${commentDTO.cmtId}" style="display: none">
                                                    <textarea id="cContent${commentDTO.cmtId}"
                                                        placeholder="답글을 입력해주세요"></textarea>
                                                    <button class="cCommentWrite"
                                                        data-comment-id="${commentDTO.cmtId}">답글 전송</button>
                                                    <a href="javascript:void(0);"
                                                        onclick="closeCTextarea(${commentDTO.cmtId})">취소</a>
                                                </div>


                                                <c:forEach items="${reCommentList}" var="reComment">
                                                    <c:if test="${commentDTO.cmtId eq reComment.indentationNum}">
                                                        <ul class="en">
                                                            <li class="commechildrnt">
                                                                <div
                                                                    class="comment-header d-md-flex align-items-center">
                                                                    <div class="d-flex align-items-center">
                                                                        <figure class="user-avatar"><img
                                                                                class="rounded-circle" alt=""
                                                                                src="${reComment.profileImg}" />
                                                                        </figure>
                                                                        <div>
                                                                            <h6 class="comment-author"><a href="#"
                                                                                    class="link-dark">${reComment.cmtUserNickName}</a>
                                                                            </h6>
                                                                            <ul class="post-meta">
                                                                                <li><i
                                                                                        class="uil uil-calendar-alt"></i>${reComment.cmtCreatedAt}
                                                                                </li>
                                                                                <li><i
                                                                                        class="uil uil-calendar-alt"></i>수정날짜
                                                                                    ${reComment.cmtUpdatedAt}
                                                                                </li>
                                                                                <c:if
                                                                                    test="${reComment.cmtWriterId eq userId}">
                                                                                    <li><a href="javascript:void(0);"
                                                                                            onclick="showUpdateTextarea(${reComment.cmtId})">수정</a>
                                                                                    </li>
                                                                                    <li><button style='all: unset'
                                                                                            class="commentDelete"
                                                                                            data-comment-id="${reComment.cmtId}">삭제</button>
                                                                                    </li>
                                                                                </c:if>
                                                                            </ul>
                                                                            <!-- /.post-meta -->
                                                                        </div>
                                                                        <!-- /div -->
                                                                    </div>
                                                                    <!-- /div -->
                                                                </div>
                                                                <!-- /.comment-header -->
                                                                <p>${reComment.cmtContent}</p>
                                                                <div id="commentUpdate${reComment.cmtId}"
                                                                    style="display: none">
                                                                    <textarea id="updateContent${reComment.cmtId}"
                                                                        placeholder="수정글을 입력해주세요">${reComment.cmtContent}</textarea>
                                                                    <button class="updateComment"
                                                                        data-comment-id="${reComment.cmtId}">수정
                                                                        하기</button>
                                                                    <a href="javascript:void(0);"
                                                                        onclick="closeTextarea(${reComment.cmtId})">취소</a>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </c:if>
                                                </c:forEach>
                                            </li>
                                        </ol>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- /#result -->
                <hr />
                <c:if test="${not empty sessionScope.id}">
                    <h3 class="mb-3">Write a comment</h3>
                    <div class="form-floating mb-4">
                        <textarea input id="cmtContent" name="textarea" class="form-control" placeholder="Comment"
                            style="height: 80px"></textarea>
                        <label>Comment *</label>
                    </div>
                    <button id="commentWrite" class="btn btn-primary rounded-pill mb-0">Submit</button>
                </c:if>
            </div>
            <!-- /column -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</section>
<!-- /section -->
</body>
</html>