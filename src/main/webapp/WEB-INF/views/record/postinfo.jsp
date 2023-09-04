<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
        if (session.getAttribute("id") != null) {
            long userId = (long) session.getAttribute("id");
            request.setAttribute("userId", userId);
        }
    %>

<style>
    /* 스크롤 가능한 컨테이너의 스타일을 정의합니다. */
    .scrollable-container {
        max-height: 750px; /* 원하는 최대 높이 설정 */
        overflow-y: scroll; /* 세로 스크롤을 허용합니다. */
        border: 1px solid #ccc; /* 테두리 스타일을 지정할 수 있습니다. */
    }

    /* 이미지 슬라이드의 스타일을 조절합니다. */
    .postimg {
        padding: 15px; /* 이미지 사이의 간격을 조절할 수 있습니다. */
    }

    /* 이미지에 호버 스케일 효과를 적용합니다. (옵션) */
    .hover-scale:hover {
        transform: scale(1.1);
        transition: transform 0.3s ease;
    }


    /* 이미지 컨테이너의 스타일 설정 */
    .swiper-slide{
        width: 500px;
        height: 700px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* 실제 이미지의 스타일 설정 */
    .swiper-slide img {
        max-width: 100%;
        max-height: 100%;
    }

    #likeBtn {
        position: absolute;
        bottom: 95px; /* 원하는 상단 여백 값으로 조정하세요 */
        right: 0px; /* 원하는 오른쪽 여백 값으로 조정하세요 */
    }

    .modal-dialog {
        max-width: 90%; /* 원하는 너비로 설정하세요. 예를 들어, 80%로 설정하면 화면의 80% 너비를 차지합니다. */
    }

</style>
    <script type="text/javascript"
    	src="../resources/js/jquery-3.7.0.js" ></script>
    <script type="text/javascript">
        function showUpdateTextarea(commentId) {
            var updateField = document.getElementById("commentUpdate" + commentId);
            updateField.style.display = "block";
            var reCommentField = document.getElementById("cComment" + commentId);
            reCommentField.style.display = "none";
        }

        function closeTextarea(commentId) {
            var updateField = document.getElementById("commentUpdate" + commentId);
            updateField.style.display = "none";
        }

        function showCcmtTextarea(commentId) {
            var reCommentField = document.getElementById("cComment" + commentId);
            reCommentField.style.display = "block";
            var updateField = document.getElementById("commentUpdate" + commentId);
            updateField.style.display = "none";
        }

        function closeCTextarea(commentId) {
            var reCommentField = document.getElementById("cComment" + commentId);
            reCommentField.style.display = "none";
        }

        function updateLikeSection(likeList) {
            let users = "";
            let likeCnt = "";
            likeCnt += "<a href='#' data-bs-toggle='modal' data-bs-target='#modal-02'><div id='likeCountSection'><i class='uil uil-heart-alt text-primary'></i>" + likeList.likeCount + "</div></a>";
            $('.likeCnt').html(likeCnt);


            if (likeList.likeCount > 0) {
                for (let i = 0; i < likeList.likeCount; i++) {
                    let postLikeDTO = likeList.likeUserList[i];
                    users += `<p class="mb-6"><img class="avatar w-10" src="\${postLikeDTO.profileImg}"/>\${postLikeDTO.likeUserNickname}</p>`;
                }
            } else {
                users += "<h6 class='text-primary'>좋아요를 누른 사람이 없습니다.</h6>"
            }
            $('#likeUsers').html(users);
        }

        function updateCommentSection(commentListRe) {
            let comments = "";
            let cCount = commentListRe.commentList.length;
            let rCount = commentListRe.reCommentList.length;

            if (cCount > 0) {
                comments += "<h3 class='mb-12 text-orange'>" + cCount + " 댓글</h3>";
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
                                    class="btn btn-soft-orange btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                        class="uil uil-comments"></i> 답글</a>`;
                        }
                        comments += "</div></div>";
                        comments += `<p>\${commentList.cmtContent}</p>`;
                        comments += `
                            <div id="commentUpdate\${commentList.cmtId}" style="display: none" class="form-floating mb-4">
                                <textarea id="updateContent\${commentList.cmtId}" style="height: 100px"
                                    placeholder="수정글을 입력해주세요" class="form-control">\${commentList.cmtContent}</textarea>
                                <label>Update Comment *</label>
                                <button class="updateComment btn btn-outline-primary btn-sm rounded-pill"
                                    data-comment-id="\${commentList.cmtId}">완료</button>
                                <a href="javascript:void(0);" class="btn btn-soft-primary btn-sm rounded-pill"
                                    onclick="closeTextarea(\${commentList.cmtId})">취소</a>
                            </div>

                            <div id="cComment\${commentList.cmtId}" style="display: none" class="form-floating mb-4">
                                <textarea id="cContent\${commentList.cmtId}" style="height: 100px"
                                    placeholder="답글을 입력해주세요" class="form-control"></textarea>
                                <label>ReComment *</label>
                                <button class="cCommentWrite btn btn-outline-primary btn-sm rounded-pill"
                                    data-comment-id="\${commentList.cmtId}">전송</button>
                                <a href="javascript:void(0);" class="btn btn-soft-primary btn-sm rounded-pill"
                                    onclick="closeCTextarea(\${commentList.cmtId})">취소</a>
                            </div>`;
                        for (let i = 0; i < rCount; i++) {
                            let replyList = commentListRe.reCommentList[i];
                            if (commentList.cmtId == replyList.indentationNum) {
                                comments += `
                                    <ul class="en">
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
                                            style="display: none" class="form-floating mb-4">
                                            <textarea id="updateContent\${replyList.cmtId}" style="height: 100px"
                                                placeholder="수정글을 입력해주세요" class="form-control">\${replyList.cmtContent}</textarea>
                                            <label>Update Comment *</label>
                                            <button class="updateComment btn btn-outline-primary btn-sm rounded-pill"
                                                data-comment-id="\${replyList.cmtId}">완료
                                                </button>
                                            <a href="javascript:void(0);" class="btn btn-soft-primary btn-sm rounded-pill"
                                                onclick="closeTextarea(\${replyList.cmtId})">취소</a>
                                        </div></ul>`;
                            }
                        }
                        comments += "</li></ol></div>";
                    }
                }
            } else {
                comments += "<h3 class='mb-6'>" + cCount + " Comments</h3>";
                comments += "<div><h6>등록된 댓글이 없습니다.</h6></div>";
            }

            $('#count').html(cCount);
            $('#result').html(comments);
        }



    $(function() {
        $('#commentWrite').click(function() {
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


        $(document).on("click", ".like-button", function () {
            var clickedButton = $(this);
            $.ajax({
                url: "like_post",
                data: {
                    recordId: ${postInfoDTO.boardId},
                    userId: ${userId}
                },
                success: function (result) {
                    updateLikeSection(result);

                    $('#likeBtn').empty();
                    let btns = "<button class='unlike-button btn btn-circle btn-primary'><i class='uil uil-heart'></i></button>";
                    $('#likeBtn').html(btns);
                },
                error: function () {
                    console.log("좋아요 실패");
                }
            });
        });

        $(document).on("click", ".unlike-button", function () {
            var clickedButton = $(this);
            $.ajax({
                url: "delete_like_post",
                data: {
                    recordId: ${postInfoDTO.boardId},
                    userId: ${userId}
                },
                success: function (result) {
                    updateLikeSection(result);

                    $('#likeBtn').empty();
                    let btns = "<button class='like-button btn btn-circle btn-primary'><i class='uil uil-heart-break'></i></button>";
                    $('#likeBtn').html(btns);
                },
                error: function () {
                    alert("Error unliking the post");
                }
            });
        });

        // 수정 버튼 클릭 시 Ajax 요청 보내는 부분
        $(".btn-update").click(function () {
            // 수정할 데이터를 수집
            var startDate = $("input[name='startDate']").val();
            var endDate = $("input[name='endDate']").val();
            var isVisible = $("select[name='isVisible']").val();
            var title = $("input[name='title']").val();
            var content = $("textarea[name='content']").val();
            var id = $("input[name='id']").val();
            // 수정할 데이터를 객체로 만듦
            var postData = {
                id: id,
                startDate: startDate,
                endDate: endDate,
                isVisible: isVisible,
                title: title,
                content: content
            };

            // Ajax 요청
            $.ajax({
                type: "POST",
                url: "update_post",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(postData),
                success: function (response) {
                    window.location.href = "postinfo?id=" + id;
                },
                error: function (error) {
                    // 수정 실패 시의 처리
                    alert("게시물 수정에 실패했습니다.");
                }
            });
        });


    }); // $
</script>

<section class="wrapper bg-light">
    <div class="container pt-11 pt-md-13 pb-10 pb-md-0 pb-lg-5 text-center">
        <div class="row">
            <div class="col-lg-8 col-xl-7 col-xxl-6 mx-auto" data-cues="slideInDown" data-group="page-title">
                <h1 class="display-1"><span class="underline-3 style-3 primary">기록</span> 게시물</h1>
            </div>
            <!-- /column -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</section>
<!-- /section -->
    <br>
    <br>
    <section class="wrapper bg-light">
        <div class="container pb-14 pb-md-16">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="blog classic-view mt-n0">
                        <article class="post">
                            <div class="card">
                                <div class="post-slider card-img-top">
                                    <div class="swiper-container dots-over" data-margin="5" data-nav="true"
                                        data-dots="true">
                                        <div class="swiper">
                                            <div class="swiper-wrapper">
                                                <c:forEach items="${postImgList}" var="postImgDTO">
                                                    <div class="swiper-slide">
                                                        <figure class="hover-scale rounded cursor-dark">
                                                            <a href="/hontrip/${postImgDTO.imgUrl}" data-glightbox
                                                                data-gallery="product-group"><img
                                                                    src="<c:url value='/${postImgDTO.imgUrl}'/>"
                                                                    srcset="<c:url value='/${postImgDTO.imgUrl}'/>" /></a>
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
                                        <h2 class="post-title mt-1 mb-0 text-primary">${postInfoDTO.title}</h2>
                                    </div>
                                    <!-- /.post-header -->
                                    <div class="post-content">
                                        <p>${postInfoDTO.content}</p>
                                    <c:if test="${not empty sessionScope.id}">
                                        <div id="likeBtn">
                                            <c:if test="${userCheckLike eq 'ok'}">
                                                <button class="unlike-button btn btn-circle btn-primary"><i class="uil uil-heart"></i></button>
                                            </c:if>
                                            <c:if test="${userCheckLike ne 'ok'}">
                                                <button class="like-button btn btn-circle btn-primary"><i class="uil uil-heart-break"></i></button>
                                            </c:if>
                                        </div>
                                    </c:if>
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
                                        <li class="post-author">
                                            <i class="uil uil-user"></i><span>${postInfoDTO.nickName}</span>
                                        </li>
                                        <li class="likeCnt post-likes ms-auto">

                                            <a href="#" data-bs-toggle="modal" data-bs-target="#modal-02">
                                                <div id="likeCountSection"><i class="uil uil-heart-alt text-primary"></i>
                                                    ${postInfoDTO.likeCount}
                                                </div></a>
                                        </li>
                                        <li class="post-likes">
                                            <i class="uil uil-eye"></i>${postInfoDTO.views}
                                        </li>

                                        <c:if test="${postInfoDTO.userId eq userId}">
                                            <li class="post-likes">
                                                <a href="#" data-bs-toggle="modal" data-bs-target="#modal-update">수정</a>
                                            </li>
                                            <li class="post-likes"><a
                                                    href="/hontrip/record/deletepost?id=${postInfoDTO.boardId}">
                                                    <i class="uil uil-trash-alt"></i>삭 제</a>
                                            </li>
                                        </c:if>
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
                    <br>
                    <div id="result">
                        <h3 class="mb-12 text-primary">${postInfoDTO.cmtCount} 댓글</h3>
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
                                                                                class="commentDelete"
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
                                                                    class="btn btn-soft-primary btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                        class="uil uil-comments"></i> 답글</a>
                                                            </c:if>
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /.comment-header -->
                                                    <p>${commentDTO.cmtContent}</p>
                                                    <div id="commentUpdate${commentDTO.cmtId}" style="display: none"
                                                        class="form-floating mb-4">
                                                        <textarea id="updateContent${commentDTO.cmtId}"
                                                            style="height: 100px" placeholder="수정글을 입력해주세요"
                                                            class="form-control">${commentDTO.cmtContent}</textarea>
                                                        <label>Update Comment *</label>
                                                        <button class="updateComment btn btn-outline-primary btn-sm rounded-pill"
                                                            data-comment-id="${commentDTO.cmtId}">완료</button>
                                                        <a href="javascript:void(0);"
                                                            class="btn btn-soft-primary btn-sm rounded-pill"
                                                            onclick="closeTextarea(${commentDTO.cmtId})">취소</a>
                                                    </div>

                                                    <div id="cComment${commentDTO.cmtId}" style="display: none"
                                                        class="form-floating mb-4">
                                                        <textarea id="cContent${commentDTO.cmtId}" style="height: 100px"
                                                            placeholder="답글을 입력해주세요" class="form-control"></textarea>
                                                        <label>ReComment *</label>
                                                        <button class="cCommentWrite btn btn-outline-primary btn-sm rounded-pill"
                                                            data-comment-id="${commentDTO.cmtId}">전송</button>
                                                        <a href="javascript:void(0);"
                                                            class="btn btn-soft-primary btn-sm rounded-pill"
                                                            onclick="closeCTextarea(${commentDTO.cmtId})">취소</a>
                                                    </div>


                                                    <c:forEach items="${reCommentList}" var="reComment">
                                                        <c:if test="${commentDTO.cmtId eq reComment.indentationNum}">
                                                            <ul class="en">
                                                                <div
                                                                    class="comment-header d-md-flex align-items-center">
                                                                    <div class="d-flex align-items-center">
                                                                        <figure class="user-avatar"><img
                                                                                class="rounded-circle"
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
                                                                    style="display: none"
                                                                    class="form-floating mb-4">
                                                                    <textarea id="updateContent${reComment.cmtId}"
                                                                        style="height: 100px"
                                                                        placeholder="수정글을 입력해주세요"
                                                                        class="form-control">${reComment.cmtContent}</textarea>
                                                                    <label>Update Comment *</label>
                                                                    <button
                                                                        class="updateComment btn btn-outline-primary btn-sm rounded-pill"
                                                                        data-comment-id="${reComment.cmtId}">완료
                                                                        </button>
                                                                    <a href="javascript:void(0);"
                                                                        class="updateComment btn btn-soft-primary btn-sm rounded-pill"
                                                                        onclick="closeTextarea(${reComment.cmtId})">취소</a>
                                                                </div>
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
                    <c:if test="${not empty sessionScope.id}">
                        <hr>
                        <h3 class="mb-8 main-color">댓글을 작성해주세요</h3>
                        <div class="form-floating mb-5">
                            <textarea input id="cmtContent" name="textarea" class="form-control" placeholder="Comment"
                                style="height: 100px"></textarea>
                            <label>Comment *</label>
                        </div>
                        <div class="row">
                            <div class="col-md-6"> <!-- 작성 버튼을 왼쪽에 배치 -->
                                <button id="commentWrite" class="btn btn-outline-primary rounded-pill mb-0">작성 하기</button>
                            </div>
                            <div class="col-md-6 text-end"> <!-- 목록으로 가는 버튼을 오른쪽에 배치 -->
                                <a href="feedlist" class="btn btn-primary rounded-pill">목록으로 돌아가기</a>
                            </div>
                        </div>
                    </c:if>
                </div>
                <!-- /column -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->

    <div class="modal fade" id="modal-02" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content text-center">
                <div class="modal-body">
                    <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="row">
                    </div>
                    <!-- /.row -->
                    <h3 class="text-primary">좋아요</h3>
                    <br>
                    <div id="likeUsers">
                        <c:choose>
                            <c:when test="${likeUserList.isEmpty()}">
                                <h6>좋아요를 누른 사람이 없습니다.</h6>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${likeUserList}" var="user">
                                    <p class="mb-6"><img class="avatar w-10" src="${user.profileImg}"/>${user.likeUserNickname}</p>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="newsletter-wrapper">
                        <div class="row">
                            <div class="col-md-10 offset-md-1">
                            </div>
                            <!-- /.newsletter-wrapper -->
                        </div>
                        <!-- /column -->
                    </div>
                    <!-- /.row -->
                </div>
                <!--/.modal-body -->
            </div>
            <!--/.modal-content -->
        </div>
        <!--/.modal-dialog -->
    </div>
    <!--/.modal -->

<div class="modal fade" id="modal-update" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content text-center">
            <div class="modal-body">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <section class="wrapper bg-light">
                    <div class="container py-14 py-md-10">
                        <div class="row gx-md-8 gx-xl-12 gy-8">
                            <div class="col-lg-6">
                                <div class="scrollable-container">
                                    <c:forEach items="${postImgList}" var="postImgDTO">
                                        <div class="postimg">
                                            <figure class="hover-scale rounded cursor-dark">
                                                <a href="/hontrip/${postImgDTO.imgUrl}" data-glightbox data-gallery="product-group">
                                                    <img src="<c:url value='/${postImgDTO.imgUrl}'/>"
                                                         srcset="<c:url value='/${postImgDTO.imgUrl}'/>" />
                                                </a>
                                            </figure>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <!-- /column -->
                            <div class="col-lg-6">
                                <div class="post-header mb-5">
                                    <h2 class="post-title display-5 text-primary">게시물 수정</h2>
                                </div>
                                <br>
                                <form class="text-start mb-3">
                                    <input type="hidden" name="id" value="${postInfoDTO.boardId}">
                                    <p class="mb-3 text-start">날짜 수정</p>
                                    <div class="form-floating mb-0">
                                        <div class="mateDates1">
                                            <input name="startDate" type="date" class="form-control" required
                                                value="${postInfoDTO.startDate}">
                                            -
                                            <input name="endDate" type="date" class="form-control" required
                                                value="${postInfoDTO.endDate}">
                                        </div>
                                    </div>
                                    <br>
                                    <p class="mb-3 text-start">공개/비공개 수정</p>
                                    <div class="form-floating mb-4">
                                        <div class="form-select-wrapper">
                                            <select name="isVisible" class="form-select" required>
                                                <option value="1">공개</option>
                                                <option value="0">비공개</option>
                                            </select>
                                        </div>
                                    </div>
                                    <p class="mb-3 text-start">제목 수정</p>
                                    <div class="form-floating password-field mb-4">
                                        <div class="form-floating">
                                            <input type="text" name="title" class="form-control"
                                                value="${postInfoDTO.title}">
                                            <label for="textInputExample">Title*</label>
                                        </div>
                                    </div>
                                    <p class="mb-3 text-start">내용 수정</p>
                                    <div class="form-floating password-field mb-4">
                                        <div class="form-floating">
                                            <textarea input name="content" class="form-control" placeholder="content"
                                                style="height: 180px">${postInfoDTO.content}</textarea>
                                            <label for="textInputExample">Content*</label>
                                        </div>
                                    </div>
                                    <a class="btn btn-outline-primary rounded-pill btn-update w-100 mb-2">수정 완료</a>
                                </form>
                                <!-- /form -->
                            </div>
                            <!-- /column -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container -->
                </section>
                <!-- /section -->
            </div>
            <!--/.modal-content -->
        </div>
        <!--/.modal-body -->
    </div>
    <!--/.modal-dialog -->
</div>
<!--/.modal -->