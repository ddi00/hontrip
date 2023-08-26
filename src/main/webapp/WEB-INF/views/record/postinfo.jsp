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
                                                <li><button class="btn btn-soft-primary btn-sm rounded-pill"><a href="javascript:void(0);"
                                                onclick="showUpdateTextarea(\${commentList.cmtId})">수정</a></button>
                                                </li>
                                                <li><button class="commentDelete btn btn-soft-primary btn-sm rounded-pill"
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
                                                            <li><button class="btn btn-soft-primary btn-sm rounded-pill"><a
                                                                    href="javascript:void(0);"
                                                                    onclick="showUpdateTextarea(\${replyList.cmtId})">수정</a></button>
                                                            </li>
                                                            <li><button
                                                                    class="commentDelete btn btn-soft-primary btn-sm rounded-pill"
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
<section class="wrapper bg-soft-primary">
    <div class="container pt-10 pb-19 pt-md-14 pb-md-20 text-center">
        <div class="row">
            <div class="col-md-10 col-xl-8 mx-auto">
                <div class="post-header">
                    <!-- /.post-category -->
                    <h1 class="display-1 mb-4">${postInfoDTO.title}</h1>
                    <ul class="post-meta mb-5">
                        <li class="post-date"><i class="uil uil-calendar-alt"></i><span>여행기간 ${postInfoDTO.startDate}~${postInfoDTO.endDate}</span>
                        </li>
                        <li class="post-author"><a href="#"><i
                                    class="uil uil-user"></i><span>${postInfoDTO.nickName}</span></a></li>
                        <li class="post-comments"><span>지역 ${postInfoDTO.city}</span></a></li>
                        <li class="post-likes"><i class="uil uil-heart-alt"></i><span>
                                ${postInfoDTO.likeCount}</span></a></li>
                    </ul>
                    <!-- /.post-meta -->
                </div>
                <!-- /.post-header -->
            </div>
            <!-- /column -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</section>
<!-- /section -->
<section class="wrapper bg-light">
    <div class="container pb-14 pb-md-16">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="blog single mt-n17">
                    <div class="card">

                        <div class="swiper-container swiper-thumbs-container" data-margin="10" data-dots="false"
                            data-nav="true" data-thumbs="true">
                            <div class="swiper">
                                <div class="swiper-wrapper">

                                    <c:forEach items="${postImgList}" var="postImgDTO">
                                        <div class="swiper-slide">
                                            <figure class="rounded"><img src="<c:url value='/${postImgDTO.imgUrl}'/>"
                                                    width="300" height="180" srcset="./assets/img/photos/shs1@2x.jpg 2x"
                                                    alt="" /><a class="item-link" href="./assets/img/photos/shs1@2x.jpg"
                                                    data-glightbox data-gallery="product-group"><i
                                                        class="uil uil-focus-add"></i></a></figure>
                                        </div>
                                    </c:forEach>

                                    <!--/.swiper-slide -->
                                </div>
                                <!--/.swiper-wrapper -->
                            </div>
                            <!-- /.swiper -->

                            <div class="swiper swiper-thumbs">

                            </div>
                        </div>
                        <!--/.swiper-wrapper -->
                    </div>
                    <!-- /.swiper -->
                </div>
                <!-- /.swiper-container -->
                <a class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0" href="updatepost?id=${postInfoDTO.boardId}">수 정</a>
                <a class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0" href="deletepost?id=${postInfoDTO.boardId}">삭 제</a>
                <p>작성날짜 ${postInfoDTO.createdAt}</p>
                <p>수정날짜 ${postInfoDTO.updatedAt}</p>
                <p>${postInfoDTO.content}</p>
                <div class="card-body">
                    <hr />
                    <div id="result">
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
                                                            <figure class="user-avatar"><img class="rounded-circle"
                                                                    alt="" src="${commentDTO.profileImg}" /></figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#"
                                                                        class="link-dark">${commentDTO.cmtUserNickName}</a>
                                                                </h6>
                                                                <ul class="post-meta">
                                                                    <li><i
                                                                            class="uil uil-calendar-alt"></i>작성날짜 ${commentDTO.cmtCreatedAt}
                                                                    </li>
                                                                    <li><i
                                                                            class="uil uil-calendar-alt"></i>수정날짜 ${commentDTO.cmtUpdatedAt}
                                                                    </li>
                                                                    <c:if test="${commentDTO.cmtWriterId eq userId}">
                                                                        <li><a href="javascript:void(0);"
                                                                                    class="btn btn-soft-primary btn-sm rounded-pill"
                                                                                    onclick="showUpdateTextarea(${commentDTO.cmtId})">수정</a>
                                                                        </li>
                                                                        <li><button class="commentDelete btn btn-soft-primary btn-sm rounded-pill"
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
                                                        <button  class="updateComment"
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
                                                                                            class="uil uil-calendar-alt"></i>수정날짜 ${reComment.cmtUpdatedAt}
                                                                                    </li>
                                                                                    <c:if
                                                                                        test="${reComment.cmtWriterId eq userId}">
                                                                                        <li><button class="btn btn-soft-primary btn-sm rounded-pill"><a
                                                                                                    href="javascript:void(0);"
                                                                                                    onclick="showUpdateTextarea(${reComment.cmtId})">수정</a></button>
                                                                                        </li>
                                                                                        <li><button class="btn btn-soft-primary btn-sm rounded-pill"
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
                        <h3 class="mb-3">Would you like to share your thoughts?</h3>
                        <div class="form-floating mb-4">
                            <textarea input id="cmtContent" name="textarea" class="form-control" placeholder="Comment"
                                style="height: 80px"></textarea>
                            <label>Comment *</label>
                        </div>
                        <button id="commentWrite" class="btn btn-primary rounded-pill mb-0">Submit</button>
                    </c:if>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
        <!-- /.blog -->
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