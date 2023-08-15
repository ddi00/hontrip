<%@ page import="com.multi.hontrip.mate.dto.MateBoardInsertDTO" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    /*세션에서 유저아이디 불러옴 -> 없으면 no 있으면 유저아이디*/
    /*if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
        request.setAttribute("login", "no");
    } else {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("login", userId);
    }*/
    request.setAttribute("login", 4L);
%>
<%
    /* c:forEach 에서 사용할 배열 -> ageRangeStr */
    MateBoardInsertDTO mateBoardInsertDTO = (MateBoardInsertDTO) request.getAttribute("dto");
    if (!mateBoardInsertDTO.getAgeRangeId().isEmpty()) {
        String[] ageRangeStr = mateBoardInsertDTO.getAgeRangeId().split(",");
        for (int i = 0; i < ageRangeStr.length; i++) {
            ageRangeStr[i] = AgeRange.valueOf(Integer.parseInt(ageRangeStr[i]));
        }
        request.setAttribute("ageRangeStr", ageRangeStr);

        /* js에서 사용할 배열 문자열 -> ageRangeJS*/
        String[] age = mateBoardInsertDTO.getAgeRangeId().split(",");
        String ageRangeJS = "[";
        for (int i = 0; i < age.length; i++) {
            age[i] = AgeRange.valueOf(Integer.parseInt(age[i]));
            ageRangeJS += "'" + age[i] + "'";
            if (i < age.length - 1) {
                ageRangeJS += ",";
            }
        }
        ageRangeJS += "]";
        request.setAttribute("ageRangeJS", ageRangeJS);
    } else {
        //String[] ageRangeStr = {};
        //request.setAttribute("ageRangeStr", ageRangeStr);
        String ageRangeJS = "[]";
        request.setAttribute("ageRangeJS", ageRangeJS);

    }
%>
<html>
<head>

    <title>Title</title>
    <style>
        body {
            width: 700px;
            margin: 0 auto;
            padding: 20px;
            color: #292929;
            font-size: 12px;
        }

        .modal {
            position: absolute;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.1);
            top: 0;
            left: 0;
            display: none;
        }

        .modal_content {
            width: 400px;
            height: 200px;
            background: #FFF;
            border-radius: 10px;
            position: relative;
            top: 50%;
            left: 50%;
            margin-top: -100px;
            margin-left: -200px;
            text-align: center;
            box-sizing: border-box;
            line-height: 55px;
            cursor: pointer;
        }

    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script>

        let dtoData = {
            id: "${dto.id}",
            userId: "${dto.userId}",
            regionId: "${dto.regionId}",
            ageRangeId: "${dto.ageRangeId}",
            title: "${dto.title}",
            content: "${dto.content}",
            thumbnail: "${dto.thumbnail}",
            startDate: "${dto.startDate}",
            endDate: "${dto.endDate}",
            recruitNumber: "${dto.recruitNumber}",
            gender: "${dto.gender}",
            createdAt: "${dto.createdAt}",
            updatedAt: "${dto.updatedAt}",
            isFinish: "${dto.isFinish}"
        }

        function updateMateBoard() {
            console.log("업데이트");
            let queryParams = $.param(dtoData); // 데이터를 URL 파라미터 문자열로 변환
            window.location.href = "edit?" + queryParams; // update 페이지로 이동
        }


        function deleteMateBoard() {
            $.ajax({
                method: 'DELETE',
                url: "delete/${dto.id}",
                data: {
                    id: "${dto.id}"
                },
                success: function (result) {
                    if (result == 1) {
                        location.href = "bbs_list"
                    }
                }, error: function (e) {
                    console.log(e)
                }
            })
        }

        let applicationInProgress = false;

        //동행인신청메세지 모달에서 취소버튼을 눌렀을때
        function cancel() {
            $(".modal").fadeOut();
        }

        //동행인신청메세지 모달에서 전송버튼을 눌렀을때
        function send() {
            if ($('#applicationMessage').val().trim() == "") {
                $('#applicationMessage').val("같이 여행가요")
            }
            $.ajax({
                type: "POST",
                url: "insertMatchingAlarm",
                data: {
                    mateBoardId: ${dto.id},
                    senderId: ${login},
                    content: $("#applicationMessage").val()
                },
                success: function () {
                    //동행 신청 메세지를 전송한 후, 모달을 끄고
                    $(".modal").fadeOut();
                    //동행인 신청 버튼 비활성화
                    $('#application').attr('disabled', 'disabled');
                }, complete: function () {
                    applicationInProgress = false; // 요청 완료 시 플래그 리셋
                }
            })
        }

        $(function () {
            let login = "${login}";
            /*let applicationInProgress = false; // 플래그 추가*/


            //로그인 했고,
            if (login != "no") {
                //본인이 작성한 글이면 버튼 감추기
                if ("${dto.userId}" == login) {
                    $('#application').hide();
                }

                //이미 지원한 경우 동행인 신청 버튼 비활성화
                $.ajax({
                    url: "checkApply",
                    data: {
                        senderId: ${login},
                        mateBoardId: ${dto.id}
                    },
                    dataType: "json",
                    success: function (result) {
                        if (result === 1) {
                            console.log(result)
                            $('#application').attr('disabled', 'disabled');
                        }
                    },
                    error: function (e) {
                        console.log(e)
                    }
                })
            }

            //동행인 신청 버튼 눌렀을때
            $('#application').on("click", function () {

                //로그인 안했을 경우 로그인창을 띄움
                if (login == "no") {
                    alert("로그인 창")
                    //로그인 했을 경우
                } else {
                    //신청자의 성별, 연령대를 가져온 후, 모집조건에 적합한지 체크한다
                    $.ajax({
                        url: "findUserGenderAge",
                        data: {
                            id:${login}
                        },
                        dataType: "json",
                        success: function (json) {
                            //게시글 작성자가 원하는 연령대 리스트 생성
                            let ageRangeStrArr = <%= request.getAttribute("ageRangeJS") %>;
                            //모집조건에 부합하다면
                            //성별, 연령대 아무나 처리

                            if (json.id === ${login} && (json.gender === "${dto.gender.genderStr}" || "${dto.gender.genderStr}" == "성별무관")
                                && (ageRangeStrArr.includes(json.ageRange) || ageRangeStrArr.includes("전연령") || ageRangeStrArr.length == 0)) {
                                $(".modal.yes").fadeIn();
                                //모집조건에 부합하지 않다면
                            } else {
                                $(".modal.no").fadeIn();
                                $(".modal_content").click(function () {
                                    $(".modal").fadeOut();
                                    $('#application').attr('disabled', 'disabled');
                                });
                            }
                        },
                        error: function (e) {
                            console.log(e)
                        }
                    })//ajax
                }
            })//application 버튼
        })

    </script>

</head>
<body>


<a href="../">메인 페이지</a>
<a href="../mate/insert">게시글 작성 페이지</a>
<table>
    <tr>
        <td><img src="../resources/upload/${dto.thumbnail}" alt="${dto.thumbnail}" height="200" width="600"></td>
    </tr>
    <tr>
        <td height="40px"><span style="font-weight: bold">${dto.title}</span></td>
    </tr>
    <tr>
        <td>(캘린더 아이콘) <fmt:parseDate value="${dto.startDate}" var="dateValue" pattern="yyyy-MM-dd"/>
            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/> - <fmt:parseDate value="${dto.endDate}"
                                                                                    var="dateValue"
                                                                                    pattern="yyyy-MM-dd"/>
            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/>
            (위치 아이콘) ${dto.regionId.regionStr} (모집인원) ${dto.recruitNumber}명

            <c:if test="${dto.isFinish eq 0}">
                <span style="background-color: coral; margin:2px 2px; color:white;">모집중</span>
            </c:if>
            <c:if test="${dto.isFinish eq 1}">
                <span style="background-color: coral; color:white;">모집완료</span>
            </c:if>
        </td>
    </tr>

    <tr>
        <td><span style="font-weight: bold">원해요</span> #${dto.gender.genderStr}
            <c:if test="${not empty ageRangeStr}">
                <c:forEach items="${ageRangeStr}" var="age">
                    #${age}
                </c:forEach>
            </c:if>
            <button style="background-color: #FFA41B" id="application">동행 신청하기</button>
        </td>
    </tr>

    <tr>
        <td height="100px">${dto.content}</td>
    </tr>

    <tr>
        <td>${dto.createdAt} 조회수
            <c:if test="${dto.userId eq login}">

                <button id="edit" onclick="updateMateBoard()">수정</button>

                <button id="delete" onclick="deleteMateBoard()">삭제</button>
            </c:if>
        </td>
    </tr>
</table>

<input id="comment" type="text" placeholder="댓글을 적어주세요">
<button>등록</button>

<div class="modal no">
    <div class="modal_content"
         title="클릭하면 창이 닫힙니다.">
        모집 조건에 맞지 않습니다.
    </div>
</div>

<div class="modal yes">
    <div class="modal_content"
         title="클릭하면 창이 닫힙니다.">
        동행 신청 메세지<br>
        <textarea id="applicationMessage" placeholder="같이 여행가요"
                  cols="50" rows="5" style="resize: none;"></textarea><br>
        <button onclick="cancel()" id="cancel">취소</button>
        <button onclick="send()" id="send">전송</button>
    </div>
</div>
</body>
</html>
