<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript"
            src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script>
        function boardInit() {
            let genderVal = document.querySelector('input[type="radio"][name="genders"]:checked');
            $('#gender').val(genderVal.value);

            let ageRange = "${dto.ageRangeId}";
            let ageRangeArr = ageRange.split(",");
            for (let i = 0; i < ageRangeArr.length; i++) {
                $('#' + ageRangeArr[i]).prop("checked", true)
            }

            $('#ageRangeId').attr('value', "${dto.ageRangeId}");
            $('#isFinish').val("${dto.isFinish}");

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

        function genderChecked() {
            let genderVal = document.querySelector('input[type="radio"][name="genders"]:checked');
            $('#gender').val(genderVal.value);
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
            });

            $('#endDate').on('change', function () {
                $('#startDate').prop("max", $(this).val());
            });
        });

        $(function () {
            $('#edit').on("click", function () {
                if ($('#file')[0].files[0] == null) {
                    $.ajax({
                        method: "POST",
                        url: "edit",
                        data: {
                            id: ${dto.id},
                            regionId: $("input[name='regionId']:checked").val(),
                            ageRangeId: $('#ageRangeId').val(),
                            title: $('#title').val(),
                            content: $('#content').val(),
                            thumbnail: "${dto.thumbnail}",
                            startDate: $('#startDate').val(),
                            endDate: $('#endDate').val(),
                            recruitNumber: $('#recruitNumber').val(),
                            gender: $('#gender').val(),
                            isFinish: $('#isFinish').val(),
                        },
                        success: function () {
                            location.href =
                            ${dto.id}
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    })
                } else {
                    const formData = new FormData();
                    formData.append("id", ${dto.id})
                    formData.append("file", $('#file')[0].files[0])
                    formData.append("regionId", $("input[name='regionId']:checked").val())
                    formData.append("ageRangeId", $('#ageRangeId').val())
                    formData.append("title", $('#title').val())
                    formData.append("content", $('#content').val())
                    formData.append("startDate", $('#startDate').val())
                    formData.append("endDate", $('#endDate').val())
                    formData.append("recruitNumber", $('#recruitNumber').val())
                    formData.append("gender", $('#gender').val())
                    formData.append("isFinish", $('#isFinish').val())
                    $.ajax({
                        method: "POST",
                        enctype: 'multipart/form-data',
                        processData: false,
                        contentType: false,
                        url: "edit",
                        data: formData,
                        success: function () {
                            location.href =
                            ${dto.id}
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    })
                }
            })
        })
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

        input[type=radio][name="genders"] + label {
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

        .numDate {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-input:focus {
            outline: none;
            border-color: #FFA41B; /* Changed to orange color */
            box-shadow: 0px 0px 1px rgba(231, 76, 60, 0.5);
        }

        input[type='date'] {
            width: 100px;
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
            width: 300px;
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
            display: inline-block;
            width: 75px;
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

        .genderRecruitNum {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 5px;
        }

        .wantAgeRange {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 5px;
        }


        .recruitNum, .isFinish {
            color: #505050;
            border-radius: 5px;
            font-size: 12px;
            margin-left: 10px;
            height: 27px;
            width: 100px;
        }

        .image-container {
            cursor: pointer;
        }

        #imageInput {
            display: none;
        }

    </style>
</head>


<body onload="boardInit()">


<div class="content-wrapper">
    <section class="wrapper bg-xs-none">
        <div class="container pt-2 pb-18 pt-md-18 pb-md-15">
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->
    <section class="wrapper bg-xs-none">
        <div class="container pb-14 pb-md-16">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="blog single mt-n15">
                        <div class="card shadow-xl">
                            <div class="card-body">
                                <div class="total">


                                    <input hidden name="userId" value=<%= request.getAttribute("id")%>
                                            <input hidden name="userId" value="1">
                                    <div class="region">
                                        <c:forEach items="${Region.values()}" var="region">
                                            <c:if test="${dto.regionId eq region}">
                                                <input type="radio" id="${region.regionStr}" value="${region}"
                                                       name="regionId"
                                                       checked required><label
                                                    for="${region.regionStr}">${region.regionStr}</label></input>
                                            </c:if>
                                            <c:if test="${dto.regionId ne region}">
                                                <input type="radio" id="${region.regionStr}" value="${region}"
                                                       name="regionId" required
                                                ><label
                                                    for="${region.regionStr}">${region.regionStr}</label></input>
                                            </c:if>
                                        </c:forEach>
                                    </div>


                                    <div class="numDate">
                                        <span class="option">여행 기간</span>
                                        <div class="dates">
                                            <input
                                                    id="startDate"
                                                    name="startDate"
                                                    type="date"
                                                    value="${dto.startDate}"
                                                    data-placeholder="날짜 선택"
                                                    required
                                            >
                                            -
                                            <input
                                                    id="endDate"
                                                    name="endDate"
                                                    type="date"
                                                    value="${dto.endDate}"
                                                    data-placeholder="날짜 선택"
                                                    required
                                            >
                                        </div>

                                        <span class="option2">모집확정여부</span>
                                        <select class="isFinish" name="isFinish" id="isFinish">
                                            <option value="0">모집중</option>
                                            <option value="1">모집완료</option>
                                        </select>
                                    </div>


                                    <div class="genderRecruitNum">
                                        <span class="option">모집 조건 (성별)</span>

                                        <c:forEach items="${Gender.values()}" var="gender">
                                            <c:if test="${gender ne Gender.NONE}">
                                                <c:if test="${dto.gender eq  gender}">
                                                    <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                           name="genders" onclick="genderChecked()"
                                                           checked><label
                                                        for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                </c:if>
                                                <c:if test="${dto.gender ne  gender}">
                                                    <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                           onclick="genderChecked()" name="genders"><label
                                                        for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                        <input hidden id="gender" name="gender">


                                        <span class="option2">모집 인원</span>
                                        <select id="recruitNumber" name="recruitNumber" class="recruitNum"
                                                value="${dto.recruitNumber}">
                                            <option value="1" selected>1명</option>
                                            <option value="2">2명</option>
                                            <option value="3">3명</option>
                                            <option value="4">4명</option>
                                            <option value="5">5명</option>
                                            <option value="6">6명</option>
                                        </select>
                                    </div>

                                    <div class="wantAgeRange">
                                        <span class="option">모집 조건 (연령대)</span>
                                        <c:forEach items="${AgeRange.values()}" var="ageRange">
                                            <c:if test="${ageRange ne AgeRange.AGE_UNKNOWN}">
                                                <input type="checkbox" id="${ageRange.ageRangeNum}"
                                                       value="${ageRange.ageRangeNum}"
                                                       name="age"
                                                       onclick="ageRangeChecked()"><label
                                                    for="${ageRange.ageRangeNum}">${ageRange.ageRangeStr}</label></input>
                                            </c:if>
                                        </c:forEach>
                                    </div>

                                    <input hidden id="ageRangeId" name="ageRangeId">
                                    <br>


                                    <div class="image-container" style="margin-bottom: 20px">
                                        <%--<div id="uploadYourImage" style="width:630px; height:250px;
                                                background-color: rgba(163, 163, 163, 0.2); color:#ffffff; text-align: center;
                                                align-content: center; font-size: 13px; font-weight: bold; border-radius: 5px;">
                                            여행지 사진을 업로드하세요
                                        </div>--%>
                                        <img id="upldimg" src="../resources/upload/${dto.thumbnail}"
                                             alt="Uploaded Image"
                                             height="250px" width="100%">
                                        <input type="file" name="file" id="file" accept="image/*" style="display: none">
                                    </div>

                                    <script>
                                        const imageInput = document.getElementById("file");
                                        const uploadYourImage = document.getElementById("uploadYourImage");
                                        const uploadedImage = document.getElementById("upldimg");


                                        uploadedImage.addEventListener("click", () => {
                                            imageInput.click();
                                        });

                                        imageInput.addEventListener("change", (event) => {
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
                                        <input class="form-input" type="text" id="title" name="title"
                                               value="${dto.title}" style="height:40px;"
                                               required>
                                        <textarea class="form-input" id="content" name="content"
                                                  rows="8" style="resize: none; height:200px;"
                                                  required>${dto.content}</textarea>
                                    </div>


                                    <input hidden name="thumbnail" value="${dto.thumbnail}">
                                    <div class="btns">
                                        <button id="cancel" onclick="location.href='bbs_list?page=1'"
                                                class="btn btn-outline-red">취소
                                        </button>
                                        <button id="edit" class="btn btn-yellow">수정완료</button>
                                    </div>
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


</body>
</html>

