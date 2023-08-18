<%@ page import="com.multi.hontrip.mate.dto.MateBoardInsertDTO" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.multi.hontrip.mate.dto.MateBoardSelectOneDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
    MateBoardSelectOneDTO mateBoardSelectOneDTO = (MateBoardSelectOneDTO) request.getAttribute("dto");
    String createdDate = mateBoardSelectOneDTO.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));

    request.setAttribute("createdDate", createdDate);
    if (!mateBoardSelectOneDTO.getAgeRangeId().isEmpty()) {
        String[] ageRangeStr = mateBoardSelectOneDTO.getAgeRangeId().split(",");
        for (int i = 0; i < ageRangeStr.length; i++) {
            ageRangeStr[i] = AgeRange.valueOf(Integer.parseInt(ageRangeStr[i]));
        }
        request.setAttribute("ageRangeStr", ageRangeStr);

        /* js에서 사용할 배열 문자열 -> ageRangeJS*/
        String[] age = mateBoardSelectOneDTO.getAgeRangeId().split(",");
        String ageRangeJS = "[";
        for (int i = 0; i < age.length; i++) {
            age[i] = AgeRange.valueOf(Integer.parseInt(age[i]));
            ageRangeJS += "'" + age[i] + "'";
            if (i < age.length - 1) {
                ageRangeJS += ",";
            }
        }
        ageRangeJS += "]";
        System.out.println("js: " + ageRangeJS);
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <style>
        /*body {
            width: 700px;
            margin: 0 auto;
            padding: 20px;
            color: #292929;
            font-size: 12px;
        }*/

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


        function applyMate() {
            //로그인 안했을 경우 로그인창을 띄움
            if ("${login}" == "no") {
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

                        if (json.id === ${login} && (json.gender === "${dto.gender.genderStr}" || "${dto.gender.genderStr}" == "성별무관" || json.gender == "NONE")
                            && (ageRangeStrArr.includes(json.ageRange.ageRangeStr) || ageRangeStrArr.includes("전연령") || ageRangeStrArr.length == 0 || json.ageRange == "AGE_UNKNOWN")) {
                            console.log(json.ageRange.ageRangeStr)
                            $("#ableButton").click();

                            //모집조건에 부합하지 않다면
                        } else {
                            $("#unableButton").click()
                        }
                    },
                    error: function (e) {
                        console.log(e)
                    }
                })//ajax
            }
        }

        /*
                function updateMateBoard() {
                    console.log("업데이트");
                    let queryParams = $.param(dtoData); // 데이터를 URL 파라미터 문자열로 변환
                    window.location.href = "edit?" + queryParams; // update 페이지로 이동
                }*/

        /*삭제시 경고 모달*/
        function deleteMateBoard() {
            $('#deleteButton').click();
        }

        /* 모달에서 삭제버튼을 눌렀을때 */
        function deleteAccept() {
            $.ajax({
                method: 'DELETE',
                url: "delete/${dto.id}",
                data: {
                    id: "${dto.id}"
                },
                success: function (result) {
                    if (result == 1) {
                        location.href = "../mate/bbs_list?page=1"
                    }
                }, error: function (e) {
                    console.log(e)
                }
            })
        }


        //동행인신청메세지 모달에서 전송버튼을 눌렀을때
        function send() {
            console.log(${dto.id})

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
                    location.reload()
                    //동행인 신청 버튼 비활성화
                    $('#application').attr('disabled', 'disabled');
                }, error: function (e) {
                    console.log(e)
                }
            })
        }

        $(function () {
            let login = "${login}";

            //로그인 했고,
            if (login != "no") {

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
        })

    </script>

</head>
<body>
<div class="content-wrapper">
    <header class="wrapper bg-soft-primary">
        <nav class="navbar navbar-expand-lg center-nav transparent navbar-light">
            <div class="container flex-lg-row flex-nowrap align-items-center">
                <div class="navbar-brand w-100">
                    <%--<a href="./index.html">
                        <img src="./assets/img/logo.png" srcset="./assets/img/logo@2x.png 2x" alt=""/>
                    </a>--%>
                </div>
                <div class="navbar-collapse offcanvas offcanvas-nav offcanvas-start">
                    <div class="offcanvas-header d-lg-none">
                        <h3 class="text-white fs-30 mb-0">Sandbox</h3>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
                                aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body ms-lg-auto d-flex flex-column h-100">

                        <!-- /.navbar-nav -->

                        <!-- /.offcanvas-footer -->
                    </div>
                    <!-- /.offcanvas-body -->
                </div>
                <!-- /.navbar-collapse -->

            </div>
            <!-- /.container -->
        </nav>
        <!-- /.navbar -->
        <div class="offcanvas offcanvas-top bg-light" id="offcanvas-search" data-bs-scroll="true">
            <div class="container d-flex flex-row py-6">
                <form class="search-form w-100">
                    <input id="search-form" type="text" class="form-control" placeholder="Type keyword and hit enter">
                </form>
                <!-- /.search-form -->
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <!-- /.container -->
        </div>
        <!-- /.offcanvas -->
    </header>
    <!-- /header -->
    <section class="wrapper bg-soft-primary">
        <div class="container pt-10 pb-15 pt-md-12 pb-md-15 text-center">
            <div class="row">
                <div class="col-md-5 col-xl-8 mx-auto">
                    <!-- /.post-header -->
                </div>
                <!-- /column -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->


    <%--

        <div class="total">


            <a href="../">메인 페이지</a>
            <a href="../mate/insert">게시글 작성 페이지</a>
            <form action="ed" method="post">
                <input hidden name="id" value=${dto.id}>
                <input hidden name="userId" value=${dto.userId}>
                <input hidden name="title" value="${dto.title}">
                <input hidden name="content" value="${dto.content}">
                <input hidden name="thumbnail" value="${dto.thumbnail}">
                <input hidden name="startDate" value="${dto.startDate}">
                <input hidden name="endDate" value="${dto.endDate}">
                <input hidden name="isFinish" value="${dto.isFinish}">
                <input hidden name="gender" value="${dto.gender}">
                <input hidden name="recruitNumber" value="${dto.recruitNumber}">
                <input hidden name="regionId" value="${dto.regionId}">
                &lt;%&ndash;     <input hidden name="createdAt" value=${dto.createdAt}>&ndash;%&gt;
                <input hidden name="ageRangeId" value=${dto.ageRangeId}>

                <table>
                    <tr>
                        <td><img src="../resources/upload/${dto.thumbnail}" alt="${dto.thumbnail}" height="200" width="600"></td>
                    </tr>
                    <tr>
                        <td height="40px"><span style="font-weight: bold">${dto.title}</span></td>
                    </tr>
                    <tr>
                        &lt;%&ndash;<td>(캘린더 아이콘) <fmt:parseDate value="${dto.startDate}" var="dateValue" pattern="yyyy-MM-dd"/>
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
                        </td>&ndash;%&gt;
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

                                <button id="edit" type="submit">수정</button>

                                <button id="delete" onclick="deleteMateBoard()">삭제</button>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form>

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
        </div>
    --%>
    <button hidden id="ableButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0" data-bs-toggle="modal"
            data-bs-target="#ableApply">신청가능
    </button>

    <section class="wrapper bg-light">
        <div class="modal fade" tabindex="-1" id="ableApply">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content text-center">
                    <div class="modal-body">
                        <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        <div class="row">
                            <!-- /column -->
                        </div>
                        <!-- /.row -->
                        <h3>동행 신청 메세지</h3>
                        <p class="mb-6">자신의 여행 성향과 경험을 작성하면 매칭될 가능성 up!</p>
                        <div class="newsletter-wrapper">
                            <div class="row">
                                <div class="col-md-10 offset-md-1">
                                    <!-- Begin Mailchimp Signup Form -->
                                    <div id="mc_embed_signup">
                                        <form action="https://elemisfreebies.us20.list-manage.com/subscribe/post?u=aa4947f70a475ce162057838d&amp;id=b49ef47a9a"
                                              method="post" id="mc-embedded-subscribe-form"
                                              name="mc-embedded-subscribe-form" class="validate" target="_blank"
                                              novalidate>
                                            <div id="mc_embed_signup_scroll">
                                                <div class="mc-field-group input-group form-floating">
                                                    <textarea id="applicationMessage" class="form-control"
                                                              placeholder="Textarea" style="height: 150px"
                                                              required></textarea>
                                                    <label for="applicationMessage">Textarea</label>
                                                </div>
                                                <div id="mce-responses" class="clear">
                                                    <div class="response" id="mce-error-response"
                                                         style="display:none"></div>
                                                    <div class="response" id="mce-success-response"
                                                         style="display:none"></div>
                                                </div>
                                                <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
                                                <div style="position: absolute; left: -5000px;" aria-hidden="true">
                                                    <input type="text" name="b_ddc180777a163e0f9f66ee014_4b1bcfa0bc"
                                                           tabindex="-1" value=""></div>

                                                <div class="modal-footer mb-0">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">취소
                                                    </button>
                                                    <button type="button" class="btn btn-primary" onclick="send()">전송
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <!--End mc_embed_signup-->
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


        <button hidden id="deleteButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0" data-bs-toggle="modal"
                data-bs-target="#deleteBoard"> 삭제
        </button>

        <section class="wrapper bg-light">
            <div class="modal fade" tabindex="-1" id="deleteBoard">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content text-center">
                        <div class="modal-body">
                            <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <div class="row">
                                <!-- /column -->
                            </div>
                            <!-- /.row -->
                            <div class="newsletter-wrapper">
                                <div class="row">
                                    <div class="col-md-10 offset-md-1">
                                        <!-- Begin Mailchimp Signup Form -->
                                        <div>
                                            <form action="https://elemisfreebies.us20.list-manage.com/subscribe/post?u=aa4947f70a475ce162057838d&amp;id=b49ef47a9a"
                                                  method="post"
                                                  name="mc-embedded-subscribe-form" class="validate" target="_blank"
                                                  novalidate>
                                                <div>
                                                    <div class="mc-field-group input-group form-floating">
                                                        삭제시 되돌릴 수 없습니다.
                                                        삭제하시겠습니까?
                                                    </div>
                                                    <%-- <div  class="clear">
                                                         <div class="response"
                                                              style="display:none"></div>
                                                         <div class="response"
                                                              style="display:none"></div>
                                                     </div>--%>
                                                    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
                                                    <div style="position: absolute; left: -5000px;" aria-hidden="true">
                                                        <input type="text" name="b_ddc180777a163e0f9f66ee014_4b1bcfa0bc"
                                                               tabindex="-1" value=""></div>

                                                    <br>
                                                    <div>
                                                        <button type="button" class="btn btn-secondary"
                                                                data-bs-dismiss="modal">취소
                                                        </button>
                                                        <button type="button" class="btn btn-primary"
                                                                onclick="deleteAccept()">삭제
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <!--End mc_embed_signup-->
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


            <button hidden id="unableButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0"
                    data-bs-toggle="modal"
                    data-bs-target="#unableApply">신청불가
            </button>

            <div class="modal fade" tabindex="-1" id="unableApply">
                <div class="modal-dialog modal-dialog-centered modal-sm">
                    <div class="modal-content text-center">
                        <div class="modal-body">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <h2 class="mb-3 text-start" style="text-align: center;">동행인 신청 불가</h2>
                            <p class="lead mb-6 text-start">모집조건에 맞지 않습니다.</p>
                            <!--/.social -->
                        </div>
                        <!--/.modal-content -->
                    </div>
                    <!--/.modal-body -->
                </div>
                <!--/.modal-dialog -->
            </div>
            <!--/.modal -->


            <%--<div class="modal no">
                <div class="modal_content"
                     title="클릭하면 창이 닫힙니다.">
                    모집 조건에 맞지 않습니다.
                </div>
            </div>

            <div class="modal yes">
                <div class="modal_content"
                     title="클릭하면 창이 닫힙니다.">
                    동행 신청 메세지<br>
                    <textarea id="applicationMessage"
                              placeholder="같이 여행가요"
                              cols="50" rows="5"
                              style="resize: none;"></textarea><br>
                    <button onclick="cancel()" id="cancel">취소</button>
                    <button onclick="send()" id="send">전송</button>
                </div>
            </div>--%>
            <form action="editpage" method="post">
                <div class="container pb-12 pb-md-16">
                    <div class="row">
                        <div class="col-lg-10 mx-auto">
                            <div class="blog single mt-n15">
                                <div class="card">

                                    <figure class="card-img-top"><img src="../resources/upload/${dto.thumbnail}"
                                                                      alt="여행지 사진"/>
                                    </figure>
                                    <div class="card-body" style="padding-top: 0;">
                                        <div class="classic-view">


                                            <input hidden name="id" value=${dto.id}>
                                            <input hidden name="userId" value=${dto.userId}>
                                            <input hidden name="title" value="${dto.title}">
                                            <input hidden name="content" value="${dto.content}">
                                            <input hidden name="thumbnail" value="${dto.thumbnail}">
                                            <input hidden name="startDate" value="${dto.startDate}">
                                            <input hidden name="endDate" value="${dto.endDate}">
                                            <input hidden name="isFinish" value="${dto.isFinish}">
                                            <input hidden name="gender" value="${dto.gender}">
                                            <input hidden name="recruitNumber" value="${dto.recruitNumber}">
                                            <input hidden name="regionId" value="${dto.regionId}">
                                            <%--     <input hidden name="createdAt" value=${dto.createdAt}>--%>
                                            <input hidden name="ageRangeId" value=${dto.ageRangeId}>

                                            <article class="post">
                                                <div class="post-footer d-md-flex flex-md-row justify-content-md-between align-items-center mt-8">
                                                    <div style="width: 700px;">
                                                        <div class="d-flex align-items-center">

                                                            <figure class="user-avatar"><img class="rounded-circle"
                                                                                             alt="유저 썸네일"
                                                                                             src="../resources/userImage/${dto.userProfileImage}"/>
                                                            </figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#"
                                                                                              class="link-dark">${dto.userNickName}</a>
                                                                </h6>
                                                                <ul class="post-meta">
                                                                    <li>${dto.userGender.genderStr}</li>
                                                                    <li>${dto.userAgeRange.ageRangeStr}</li>
                                                                </ul>

                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <br>

                                                        <h3 class="h3 mb-5">${dto.title}</h3>
                                                        <div class="mb-3">
                                                            <i
                                                                    class="uil uil-calendar-alt"></i>
                                                            <fmt:parseDate value="${dto.startDate}" var="dateValue"
                                                                           pattern="yyyy-MM-dd"/>
                                                            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/> -
                                                            <fmt:parseDate value="${dto.endDate}"
                                                                           var="dateValue"
                                                                           pattern="yyyy-MM-dd"/>
                                                            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/></li>

                                                            <span style="margin-right: 10px;"></span>


                                                            <i class="uil uil-location-pin-alt"></i>
                                                            ${dto.regionId.regionStr}
                                                            </li>

                                                            <span style="margin-right: 10px;"></span>

                                                            모집인원 ${dto.recruitNumber}명
                                                        </div>

                                                    </div>
                                                    <div class="mb-0 mb-md-16">
                                                        <div class="dropdown share-dropdown btn-group">
                                                            <c:if test="${dto.isFinish eq 0 && dto.userId ne login}">
                                                                <%-- <button id="application"
                                                                         class="btn btn-sm btn-red rounded-pill btn-icon btn-icon-start dropdown-toggle mb-0 me-0"
                                                                         data-bs-toggle="dropdown" aria-haspopup="true"
                                                                         aria-expanded="false">

                                                                 </button>--%>
                                                                <button type="button" id="application" onclick="applyMate()"
                                                                        class="btn btn-danger rounded-0"
                                                                        style="width:200px;">동행인 신청하기
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${dto.isFinish eq 1}">
                                                                <a style="width:200px;"
                                                                   class="btn btn-secondary rounded-0">모집완료</a>
                                                            </c:if>
                                                        </div>
                                                        <!--/.share-dropdown -->
                                                    </div>
                                                </div>
                                                <ul class="list-unstyled tag-list mb-0">
                                                    <li class="btn btn-soft-ash btn-sm rounded-pill mb-0">원해요</li>
                                                    <li class="btn btn-soft-ash btn-sm rounded-pill mb-0">
                                                        #${dto.gender.genderStr}</li>
                                                    <c:if test="${not empty ageRangeStr}">
                                                        <c:forEach items="${ageRangeStr}" var="age">
                                                            <li class="btn btn-soft-ash btn-sm rounded-pill mb-0">
                                                                #${age}</li>
                                                        </c:forEach>
                                                    </c:if>
                                                </ul>
                                                <!-- /.post-footer -->
                                                <br>
                                                <br>
                                                <div class="post-content mb-5">

                                                    <p>${dto.content}</p>
                                                    <!-- /.row -->
                                                </div>
                                                <!-- /.post-content -->
                                            </article>


                                            <br>


                                        </div>
                                        <!-- /.classic-view -->

                                        <!-- /.social -->
                                        <div class="swiper-container blog grid-view mb-2" data-margin="30"
                                             data-dots="true"
                                             data-items-md="2" data-items-xs="1">
                                            <div class="swiper">
                                                <div class="swiper-wrapper">
                                                    <div class="swiper-slide">
                                                        <article>
                                                            <div class="post-footer" style="width:600px;">
                                                                <ul class="post-meta mb-0">
                                                                    <li class="post-date"><i
                                                                            class="uil uil-calendar-alt"></i><span>${createdDate}
                                                                    </span>
                                                                    </li>
                                                                    <li class="post-comments"><i
                                                                            class="uil uil-eye"></i>조회수
                                                                    </li>
                                                                    <li class="post-comments"><i
                                                                            class="uil uil-comment"></i>댓글개수
                                                                    </li>
                                                                    <c:if test="${dto.userId eq login}">

                                                                        <button
                                                                                id="edit" type="submit" style="border: 0;
                                                                        background-color: transparent; margin-left: 5px; color:#b5b5b5;">
                                                                            수정
                                                                        </button>

                                                                        <button type="button" id="delete"
                                                                                onclick="deleteMateBoard()"
                                                                                style="border: 0; background-color: transparent;
                                                                         color:#b5b5b5;">삭제
                                                                        </button>
                                                                    </c:if>
                                                                </ul>
                                                                <!-- /.post-meta -->


                                                            </div>
                                                            <!-- /.post-footer -->
                                                        </article>
                                                        <!-- /article -->
                                                    </div>
                                                    <!--/.swiper-slide -->
                                                </div>
                                                <!--/.swiper-wrapper -->
                                            </div>
                                            <!-- /.swiper -->
                                        </div>
                                        <!-- /.swiper-container -->
                                        <hr>
                                        <div id="comments">
                                            <h3 class="mb-6">5 Comments</h3>
                                            <ol id="singlecomments" class="commentlist">
                                                <li class="comment">
                                                    <div class="comment-header d-md-flex align-items-center">
                                                        <div class="d-flex align-items-center">
                                                            <figure class="user-avatar"><img class="rounded-circle" alt=""
                                                                                             src="./assets/img/avatars/u1.jpg"/>
                                                            </figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#" class="link-dark">Connor
                                                                    Gibson</a></h6>
                                                                <ul class="post-meta">
                                                                    <li><i class="uil uil-calendar-alt"></i>14 Jan 2022</li>
                                                                </ul>
                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <!-- /div -->
                                                        <div class="mt-3 mt-md-0 ms-auto">
                                                            <a href="#"
                                                               class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                    class="uil uil-comments"></i> Reply</a>
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /.comment-header -->
                                                    <p>Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis
                                                        vestibulum. Duis mollis, est non commodo luctus, nisi erat porttitor
                                                        ligula, eget lacinia odio sem nec elit. Sed posuere consectetur est
                                                        at
                                                        lobortis integer posuere erat ante.</p>
                                                </li>
                                                <li class="comment">
                                                    <div class="comment-header d-md-flex align-items-center">
                                                        <div class="d-flex align-items-center">
                                                            <figure class="user-avatar"><img class="rounded-circle" alt=""
                                                                                             src="./assets/img/avatars/u2.jpg"/>
                                                            </figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#" class="link-dark">Nikolas
                                                                    Brooten</a></h6>
                                                                <ul class="post-meta">
                                                                    <li><i class="uil uil-calendar-alt"></i>21 Feb 2022</li>
                                                                </ul>
                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <!-- /div -->
                                                        <div class="mt-3 mt-md-0 ms-auto">
                                                            <a href="#"
                                                               class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                    class="uil uil-comments"></i> Reply</a>
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /.comment-header -->
                                                    <p>Quisque tristique tincidunt metus non aliquam. Quisque ac risus sit
                                                        amet
                                                        quam sollicitudin vestibulum vitae malesuada libero. Mauris magna
                                                        elit,
                                                        suscipit non ornare et, blandit a tellus. Pellentesque dignissim
                                                        ornare
                                                        faucibus mollis.</p>
                                                    <ul class="children">
                                                        <li class="comment">
                                                            <div class="comment-header d-md-flex align-items-center">
                                                                <div class="d-flex align-items-center">
                                                                    <figure class="user-avatar"><img class="rounded-circle"
                                                                                                     alt=""
                                                                                                     src="./assets/img/avatars/u3.jpg"/>
                                                                    </figure>
                                                                    <div>
                                                                        <h6 class="comment-author"><a href="#"
                                                                                                      class="link-dark">Pearce
                                                                            Frye</a></h6>
                                                                        <ul class="post-meta">
                                                                            <li><i class="uil uil-calendar-alt"></i>22 Feb
                                                                                2022
                                                                            </li>
                                                                        </ul>
                                                                        <!-- /.post-meta -->
                                                                    </div>
                                                                    <!-- /div -->
                                                                </div>
                                                                <!-- /div -->
                                                                <div class="mt-3 mt-md-0 ms-auto">
                                                                    <a href="#"
                                                                       class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                            class="uil uil-comments"></i> Reply</a>
                                                                </div>
                                                                <!-- /div -->
                                                            </div>
                                                            <!-- /.comment-header -->
                                                            <p>Cras mattis consectetur purus sit amet fermentum. Integer
                                                                posuere
                                                                erat a ante venenatis dapibus posuere velit aliquet. Etiam
                                                                porta
                                                                sem malesuada magna mollis.</p>
                                                            <ul class="children">
                                                                <li class="comment">
                                                                    <div class="comment-header d-md-flex align-items-center">
                                                                        <div class="d-flex align-items-center">
                                                                            <figure class="user-avatar"><img
                                                                                    class="rounded-circle" alt=""
                                                                                    src="./assets/img/avatars/u2.jpg"/>
                                                                            </figure>
                                                                            <div>
                                                                                <h6 class="comment-author"><a href="#"
                                                                                                              class="link-dark">Nikolas
                                                                                    Brooten</a></h6>
                                                                                <ul class="post-meta">
                                                                                    <li><i class="uil uil-calendar-alt"></i>4
                                                                                        Apr 2022
                                                                                    </li>
                                                                                </ul>
                                                                                <!-- /.post-meta -->
                                                                            </div>
                                                                            <!-- /div -->
                                                                        </div>
                                                                        <!-- /div -->
                                                                        <div class="mt-3 mt-md-0 ms-auto">
                                                                            <a href="#"
                                                                               class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                                    class="uil uil-comments"></i> Reply</a>
                                                                        </div>
                                                                        <!-- /div -->
                                                                    </div>
                                                                    <!-- /.comment-header -->
                                                                    <p>Nullam id dolor id nibh ultricies vehicula ut id.
                                                                        Cras
                                                                        mattis consectetur purus sit amet fermentum. Aenean
                                                                        eu
                                                                        leo quam. Pellentesque ornare sem lacinia aenean
                                                                        bibendum nulla consectetur.</p>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li class="comment">
                                                    <div class="comment-header d-md-flex align-items-center">
                                                        <div class="d-flex align-items-center">
                                                            <figure class="user-avatar"><img class="rounded-circle" alt=""
                                                                                             src="./assets/img/avatars/u4.jpg"/>
                                                            </figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#" class="link-dark">Lou
                                                                    Bloxham</a></h6>
                                                                <ul class="post-meta">
                                                                    <li><i class="uil uil-calendar-alt"></i>3 May 2022</li>
                                                                </ul>
                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <!-- /div -->
                                                        <div class="mt-3 mt-md-0 ms-auto">
                                                            <a href="#"
                                                               class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                    class="uil uil-comments"></i> Reply</a>
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /.comment-header -->
                                                    <p>Sed posuere consectetur est at lobortis. Vestibulum id ligula porta
                                                        felis
                                                        euismod semper. Cum sociis natoque penatibus et magnis dis
                                                        parturient
                                                        montes, nascetur ridiculus mus.</p>
                                                </li>
                                            </ol>
                                        </div>
                                        <!-- /#comments -->

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
            </form>
        </section>
    <!-- /section -->
</div>
<!-- /.content-wrapper -->
</body>
</html>