<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
            $('#regionId').val("${dto.regionId}");
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
            $('#startDate').prop("max", $('#endDate').val());
            $('#endDate').prop("min", $('#startDate').val());
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
                            regionId: $('#regionId').val(),
                            ageRangeId: $('#ageRangeId').val(),
                            title: $('#title').val(),
                            content: $('#content').val(),
                            thumbnail: "${dto.thumbnail}",
                            startDate: $('#startDate').val(),
                            endDate: $('#endDate').val(),
                            recruitNumber: $('#recruitNumber').val(),
                            gender: $('#gender').val(),
                            isFinish: $('#isFinish').val(),
                            /*TODO: 업데이트 시간 바꾸기*/
                            /*updatedAt: "<%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>"*/
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
                    formData.append("regionId", $('#regionId').val())
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

        /* 페이지 가운데 정렬 + 가로길이 정렬*/
        body {
            width: 700px;
            margin: 0 auto;
            padding: 20px;
            color: #292929;
            font-size: 12px;
        }


        input {
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 11px;
            height: 30px;
        }

        input:focus {
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
            padding: 15px 10px;
        }

        input[type=radio] + label {
            margin: 15px 5px;
            display: inline-block;
            cursor: pointer;
            height: 24px;
            width: 62px;
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
            padding: 15px 10px;
        }

        input[type=checkbox] + label {
            display: inline-block;
            cursor: pointer;
            height: 24px;
            width: 62px;
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
            width: 270px;
        }

        input[type='date']::before {
            content: attr(data-placeholder);
            display: none;

        }

        input[type='date']:focus::before,
        input[type='date']:valid::before {
            display: none;
        }

        .tripDate {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .option {
            font-weight: 550;
        }

    </style>
</head>

<body onload="boardInit()">
<%--<form action="edit" method="post" enctype="multipart/form-data">--%>
<table>
    <%--TODO: 유저아이디 숨기기 + 유저아이디 받아오기--%>
    <input hidden name="userId" value=<%= request.getAttribute("id")%>> <br>

    <select name="regionId" id="regionId">
        <c:forEach items="${Region.values()}" var="region">
            <option value="${region}">${region.regionStr}</option>
        </c:forEach>
    </select>


    모집인원 <input name="recruitNumber" id="recruitNumber" value="${dto.recruitNumber}"> <br>


    <div class="tripDate">
        <span class="option">여행 기간</span>
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
    <div class="recruit">
        <c:forEach items="${Gender.values()}" var="gender">
            <c:if test="${dto.gender eq  gender}">
                <input type="radio" id="${gender.genderStr}" value="${gender}" name="genders" onclick="genderChecked()"
                       checked><label
                    for="${gender.genderStr}">${gender.genderStr}</label></input>
            </c:if>
            <c:if test="${dto.gender ne  gender}">
                <input type="radio" id="${gender.genderStr}" value="${gender}" onclick="genderChecked()" name="genders"><label
                    for="${gender.genderStr}">${gender.genderStr}</label></input>
            </c:if>
        </c:forEach>
        <input hidden id="gender" name="gender">

        <div class="a">
            <c:forEach items="${AgeRange.values()}" var="ageRange">
                <input type="checkbox" id="${ageRange.ageRangeNum}" value="${ageRange.ageRangeNum}" name="age"
                       onclick="ageRangeChecked()"><label for="${ageRange.ageRangeNum}">${ageRange.ageRangeStr}</label></input>
            </c:forEach>
            <input hidden id="ageRangeId" name="ageRangeId">

        </div>
    </div>
    <input type="file" id="file" name="file">
    <div class="form-container">
        <input class="form-input" type="text" id="title" name="title" value="${dto.title}"
               required>
        <textarea class="form-input" id="content" name="content"
                  rows="8" style="resize: none;" required>${dto.content}</textarea>
    </div>
    모집확정여부
    <select name="isFinish" id="isFinish">
        <option value="0">모집중</option>
        <option value="1">모집완료</option>
    </select>
    <input hidden name="thumbnail" value="${dto.thumbnail}">

    <button id="cancel" onclick="location.href='bbs_list?page=1'">취소</button>
    <button id="edit">수정완료</button>

<%--</form>--%>
</body>
</html>
