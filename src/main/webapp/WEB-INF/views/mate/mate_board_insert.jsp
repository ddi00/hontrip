<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    /*long userId = (long) session.getAttribute("id");
    request.setAttribute("login", userId);*/
    request.setAttribute("id", 4L);
%>
<html>
<head>
    <title>동행인 매칭 게시글 등록</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="css/mate_board_insert.css">
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript"
            src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script>

        window.onpopstate = function () {
            window.location.href = "/hontrip"; // 홈페이지로 리다이렉트
        }

        function ageRangeChecked() {
            let checkedArr = [];
            let checkboxes = document.querySelectorAll('input[type="checkbox"][name="age"]:checked');
            for (let i = 0; i < checkboxes.length; i++) {
                checkedArr.push(checkboxes[i].value);
            }
            let checkedStr = checkedArr[0];
            for (let i = 1; i < checkedArr.length; i++) {
                checkedStr += "," + checkedArr[i];
            }
            console.log(checkedStr)
            if (checkboxes.length === 0) {
                checkedStr = ""
            }
            $('#ageRangeId').attr('value', checkedStr);
        }

        function dateInit() {
            let today = new Date();
            let dd = today.getDate();
            let mm = today.getMonth() + 1; // 0부터 시작하므로 1을 더해줍니다.
            const yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            const fomattedToday = yyyy + '-' + mm + '-' + dd;
            $('#startDate').prop("min", fomattedToday);
            $('#endDate').prop("min", fomattedToday);
        }

        $(document).ready(function () {
            dateInit();

            $('#startDate').on('change', function () {
                $('#endDate').prop("min", $(this).val());
                $('#endDate').prop("max", $('#endDate').val());
            });

            $('#endDate').on('change', function () {
                $('#startDate').prop("max", $(this).val());
            });
        });


    </script>

    <style>
        .total {
            margin: 0px 10px;
        }

        input, .recruitNum {
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 11px;
            height: 30px;
        }

        input:focus, .recruitNum:focus {
            outline: none;
            border-color: #FFA41B; /* Changed to orange color */
            box-shadow: 0px 0px 1px rgba(231, 76, 60, 0.5);
        }

        .recruit {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* 남성, 여성, 아무나 <- 라디오버튼 css 처리 */
        input[type=radio] {
            display: none;
            padding: 5px 5px;
        }

        input[type=radio][name="gender"] + label {
            margin: 5px;
            cursor: pointer;
            height: 24px;
            width: 58px;
            line-height: 24px;
            text-align: center;
            font-weight: bold;
            font-size: 13px;
            background-color: #ffffff;
            border-radius: inherit;
            color: #FFA41B;
            border-radius: 10px;
        }

        input[type=radio]:checked + label {
            background-color: #FFA41B;
            color: #fff;
        }

        /* 20대, 30대, 40대, 50대, 아무나 <- 체크박스 css 처리 */
        input[type=checkbox] {
            display: none;
            padding: 5px 5px;
        }

        input[type=checkbox] + label {
            margin-left: 3px;
            cursor: pointer;
            height: 24px;
            width: 52px;
            line-height: 24px;
            text-align: center;
            font-weight: bold;
            font-size: 13px;
            background-color: #ffffff;
            border-radius: inherit;
            color: #FFA41B;
            border-radius: 10px;
        }

        input[type=checkbox]:checked + label {
            background-color: #FFA41B;
            color: #fff;
        }

        .form-input {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 11px;
        }

        .form-input:focus {
            outline: none;
            border-color: #FFA41B; /* Changed to orange color */
            box-shadow: 0px 0px 1px rgba(231, 76, 60, 0.5);
        }

        input[type='date'] {
            width: 225px;
            height: 27px;
            margin: 5px 6px;
        }

        input[type='date']::before {
            content: attr(data-placeholder);
            display: none;

        }

        input[type='date']:focus::before,
        input[type='date']:valid::before {
            display: none;
        }

        .dates {
            width: 500px;
            display: inline-block;
            justify-content: space-between;
        }


        .option {
            margin-left: 8px;
            display: inline-block;;
            width: 110px;
            color: rgba(30, 50, 30, 0.7);
            font-size: 12px;
            font-weight: 550;
        }

        .option2 {
            margin-left: 40px;
            display: inline-block;
            width: 80px;
            color: rgba(30, 50, 30, 0.7);
            font-size: 12px;
            font-weight: 550;
        }

        .btns {
            display: flex;
            justify-content: space-between;
        }

        .btn {
            width: 320px;
            font-size: 12px;
        }

        .region {
            display: flex;
            justify-content: space-between;
            padding-bottom: 7px;
        }

        input[type=radio][name="regionId"] + label {
            padding: 3px 3px;
            cursor: pointer;
            width: 47px;
            line-height: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 13px;
            background-color: #ffffff;
            border-radius: inherit;
            color: #FFC845;
            border-radius: 10px;
        }

        input[type=radio][name="regionId"]:checked + label {
            background-color: #FFC845;
            color: #fff;
        }

        .recruitNum {
            color: #505050;
            border-radius: 5px;
            font-size: 12px;
            margin-left: 10px;
            height: 27px;
            width: 130px;
        }

        .image-container {
            cursor: pointer;
        }

        #imageInput {
            display: none;
        }
    </style>
</head>
<section class="wrapper image-wrapper bg-image bg-overlay bg-overlay-light-600 text-white"
         data-image-src="<c:url value='/resources/assets/img/photos/datachef_gradation.png'/>"
         style="background-image: url('<c:url value='/resources/assets/img/photos/bg13.jpg'/>');">
    <div class="content-wrapper">
        <section class="wrapper bg-xs-none">
            <div class="container pt-5 pb-18 pt-md-18 pb-md-15">
                <!-- /.row -->
            </div>
            <!-- /.container -->
            <%-- </section>
             <!-- /section -->
             <section class="wrapper bg-xs-none">--%>
            <div class="container pb-14 pb-md-16">
                <div class="row">
                    <div class="col-lg-10 mx-auto">
                        <div class="blog single mt-n15">
                            <div class="card shadow-xl">
                                <div class="card-body">
                                    <div class="total">
                                        <form action="insert" method="post" enctype="multipart/form-data">

                                            <%--TODO: 유저아이디 숨기기 + 유저아이디 받아오기--%>
                                            <%--<input hidden name="userId" value=<%= request.getAttribute("id")%>>--%>
                                            <input hidden name="userId" value="1">
                                            <div class="region">

                                                <c:forEach items="${Region.values()}" var="region">

                                                    <input type="radio" id="${region.regionStr}" value="${region}"
                                                           name="regionId"
                                                           checked><label
                                                        for="${region.regionStr}">${region.regionStr}</label></input>

                                                </c:forEach>
                                            </div>


                                            <div class="numDate">
                                                <span class="option">여행 기간</span>
                                                <div class="dates">
                                                    <input
                                                            id="startDate"
                                                            name="startDate"
                                                            type="date"
                                                            data-placeholder="날짜 선택"
                                                            required
                                                    >
                                                    -
                                                    <input
                                                            id="endDate"
                                                            name="endDate"
                                                            type="date"
                                                            data-placeholder="날짜 선택"
                                                            required
                                                    >
                                                </div>
                                            </div>

                                            <div class="wantCondition">
                                                <span class="option">모집 조건 (성별)</span>
                                                <c:forEach items="${Gender.values()}" var="gender">

                                                    <c:if test="${gender ne Gender.NONE}">
                                                        <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                               name="gender"
                                                               checked><label
                                                            for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                    </c:if>
                                                </c:forEach>

                                                <span class="option2">모집 인원</span>
                                                <select name="recruitNumber" class="recruitNum">
                                                    <option value="1" selected>1명</option>
                                                    <option value="2">2명</option>
                                                    <option value="3">3명</option>
                                                    <option value="4">4명</option>
                                                    <option value="5">5명</option>
                                                    <option value="6">6명</option>
                                                </select>

                                                <br>
                                                <span class="option">모집 조건 (연령대)</span>
                                                <c:forEach items="${AgeRange.values()}" var="ageRange">
                                                    <c:if test="${ageRange ne AgeRange.AGE_UNKNOWN}">
                                                        <c:if test="${ageRange.ageRangeStr eq '전연령'}">
                                                            <input type="checkbox" id="${ageRange}"
                                                                   value="${ageRange.ageRangeNum}"
                                                                   name="age"
                                                                   onclick="ageRangeChecked()" checked><label
                                                                for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                                                        </c:if>
                                                        <c:if test="${ageRange.ageRangeStr ne '전연령'}">
                                                            <input type="checkbox" id="${ageRange}"
                                                                   value="${ageRange.ageRangeNum}"
                                                                   name="age"
                                                                   onclick="ageRangeChecked()"><label
                                                                for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <input hidden id="ageRangeId" name="ageRangeId">
                                            <br>


                                            <div class="image-container" style="margin-bottom: 20px">
                                                <div id="uploadYourImage" style="height:250px;
                                                background-color: rgba(163, 163, 163, 0.2); color:#ffffff; text-align: center;
                                                align-content: center; font-size: 13px; font-weight: bold; border-radius: 5px;">
                                                    여행지 사진을 업로드하세요
                                                </div>
                                                <img id="upldimg" src="" alt="Uploaded Image" width="100%"
                                                     height="250px" hidden>
                                                <input type="file" name="file" id="imageInput" accept="image/*">
                                            </div>

                                            <script>
                                                const imageInput = document.getElementById("imageInput");
                                                const uploadYourImage = document.getElementById("uploadYourImage");
                                                const uploadedImage = document.getElementById("upldimg");

                                                uploadYourImage.addEventListener("click", () => {
                                                    imageInput.click();
                                                });

                                                uploadedImage.addEventListener("click", () => {
                                                    imageInput.click();
                                                });

                                                imageInput.addEventListener("change", (event) => {
                                                    uploadYourImage.hidden = true;
                                                    uploadedImage.hidden = false;
                                                    const selectedFile = event.target.files[0];
                                                    if (selectedFile) {
                                                        const reader = new FileReader();
                                                        reader.onload = (e) => {
                                                            uploadedImage.src = e.target.result;
                                                        };
                                                        reader.readAsDataURL(selectedFile);
                                                    }
                                                });
                                            </script>

                                            <div class="form-container">
                                                <input class="form-input" type="text" name="title"
                                                       value="8/11 제주 월정리에서 같이 여행하실분"
                                                       placeholder="ex) 8/11 제주 월정리에서 같이 여행하실분 찾아요!!"
                                                       style="height:40px;"
                                                       required>
                                                <textarea class="form-input" name="content"
                                                          placeholder="같이 월정리 주변 여행하실분 계신가요? 사진찍는걸 좋아하고 바다 좋아하시는 분이었으면 좋겠어요"
                                                          rows="8" style="resize: none; height:200px;"
                                                          required>텍스트입력</textarea>
                                            </div>
                                            <input hidden name="isFinish" value="0">

                                            <div class="btns">
                                                <button id="cancel" onclick="location.href='bbs_list?page=1'"
                                                        class="btn btn-outline-red">취소
                                                </button>
                                                <button type="submit" id="complete" class="btn btn-yellow">작성완료</button>
                                            </div>


                                        </form>
                                    </div>
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
    </div>
    <!-- /.content-wrapper -->
</section>