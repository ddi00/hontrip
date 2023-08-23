//댓글, 답글 부분 업데이트
function updateCommentSection(commentListRe) {
            let comments = "";
            let cCount = commentListRe.list.length;
            let rCount = commentListRe.reCommentList.length;

            console.log(cCount)
            if (cCount > 0) {
                for (let i = 0; i < cCount; i++) {
                    let commentList = commentListRe.list[i];
                    if(commentList.commentSequence == 0){
                    comments += " 댓글 작성자 : " + commentList.nickname + ", ";
                    comments += "댓글 내용 : " + commentList.content + ", ";
                    comments += "작성날짜 : " + commentList.createdAt + ", ";
                    comments += "<a href='javascript:void(0);' onclick='showCcmtTextarea(" + commentList.commentId + ")'>답글 달기</a>";

                    if (commentList.nickname !== "Bob") {
                        comments += "<a href='javascript:void(0);' onclick='showUpdateTextarea(" + commentList.commentId + ")'>수정</a>";
                        comments += "<button class='commentDelete' data-comment-id='" + commentList.commentId + "'>삭제</button>"
                    }
                    for (let i = 0; i < rCount; i++) {
                        let replyList = commentListRe.reCommentList[i];
                        if (commentList.commentId == replyList.indentationNumber){
                            comments += `<br>
                                    -->댓글 작성자 : ${replyList.nickname}, 댓글 내용 : ${replyList.content}, 작성날짜 : ${replyList.createdAt}`;
                            if (commentList.nickname !== "Bob") {
                                comments += `
                                <a href="javascript:void(0);" onclick="showUpdateTextarea(${replyList.commentId})">수정</a>
                                <button class="commentDelete" data-comment-id="${replyList.commentId}">삭제</button>`;
                                comments += `<div id="commentUpdate${replyList.commentId}" style="display: none">
                                    <textarea id="updateContent${replyList.commentId}" placeholder="수정글을 입력해주세요">${replyList.content}</textarea>
                                    <br>
                                    <button class="updateComment" data-comment-id="${replyList.commentId}">수정</button>
                                    <a href="javascript:void(0);" onclick="closeTextarea(${replyList.commentId})">취소</a>
                                </div>`;
                            }

                        }
                    }
                    comments += "<br>";

                    comments += "<div id='commentUpdate" + commentList.commentId + "' style='display: none'>";
                    comments += "<textarea id='updateContent" + commentList.commentId + "' placeholder='수정글을 입력해주세요'>" + commentList.content + "</textarea>";
                    comments += "<br>";
                    comments += "<button class='updateComment' data-comment-id='" + commentList.commentId + "'>수정</button>"
                    comments += "<a href='javascript:void(0);' onclick='closeTextarea(" + commentList.commentId + ")'>취소</a></div>";

                    comments += `<div id="cComment${commentList.commentId}" style="display: none">
                        <textarea id="cContent${commentList.commentId}" placeholder="답글을 입력해주세요"></textarea>
                        <br>
                        <button class="cCommentWrite" data-comment-id="${commentList.commentId}">답글 전송</button>
                        <a href="javascript:void(0);" onclick="closeCTextarea(${commentList.commentId})">취소</a>
                        <br>
                    </div>`;



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

        $(function() {
            $('#commentWrite').click(function() {
                console.log("ajax 실행");
                $.ajax({
                    url: "/hontrip/mate/comment_insert",
                    data: {
                        mateBoardId: $('#mateBoardId').val(),
                        content: $('#cmtContent').val(),
                        userId: $('#userId').val(),
                        nickname: $('#nickName').val()
                    },
                    dataType: "json",
                    success: function(cmtListRe) {
                        console.log(cmtListRe)
                        updateCommentSection(cmtListRe);
                        $('#cmtContent').val("");
                    },
                    error: function() {
                        alert("실패!");
                    } // error
                });
            }); // commentWrite

            //댓글,답글 삭제
            $(document).on('click', '.commentDelete', function() {
                let commentId = $(this).data("comment-id");
                $.ajax({
                    url: "/hontrip/mate/comment_delete",
                    dataType: "json",
                    data:{
                        commentId: commentId,
                        mateBoardId: $('#mateBoardId').val(),
                       userId: $('#userId').val(),
                       nickname: $('#nickName').val()
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("삭제 실패");
                    }
                })
            }) // commentDelete


            //댓글 수정
            $(document).on('click', '.updateComment', function() {
                let commentId = $(this).data("comment-id");
                let content = $('#updateContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
                $.ajax({
                    url: "/hontrip/mate/comment_edit",
                    dataType: "json",
                    data:{
                        commentId: commentId,
                        mateBoardId: $('#mateBoardId').val(),
                        content: content
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("수정 실패");
                    }
                })
            }) // commentUpdate

            //답글 수정
            $(document).on('click', '.cCommentWrite', function() {
                let commentId = $(this).data("comment-id");
                let content = $('#cContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
                $.ajax({
                    url: "/hontrip/mate/reply_insert",
                    dataType: "json",
                    data:{
                        mateBoardId: $('#mateBoardId').val(),
                        content: content,
                        userId: $('#userId').val(),
                        nickname: $('#nickName').val(),
                        commentSequence: '1',
                        commentId: commentId,
                        indentationNumber: commentId
                    },
                    success: function(cmtListRe) {
                        updateCommentSection(cmtListRe);
                    },
                    error: function() {
                        console.log("수정 실패");
                    }
                })
            }) // commentUpdate



        }); // $