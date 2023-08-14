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

        /*$(function () {
            $('#btn').click(function () {
                $.ajax({
                    url: "insert",
                    data: {
                        userId: userId,
                        regionId: regionId,
                        gender: gender,
                        ageRangeId: ageRangeId,
                        startDate: startDate,
                        endDate: endDate,
                        title: title,
                        content: content,
                        recruitNumber: recruitNumber,
                        thumbnail: thumbnail
                    },
                    success: function () {
                        alert("작성완료!!!")
                    }
                })//ajax
            })//btn
        })//function*/
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
<body>
<form action="insert" method="post" enctype="multipart/form-data">
    <table>
        <%--TODO: 유저아이디 숨기기 + 유저아이디 받아오기--%>
        유저아이디 <input hidden name="userId" value=<%= request.getAttribute("id")%>> <br>

        <%--지역아이디 <input type="text" name="regionId" value="20"> <br>--%>
        <select name="regionId">
            <c:forEach items="${Region.values()}" var="region">
                <option value="${region}">${region.regionStr}</option>
            </c:forEach>
        </select>


        모집인원 <input name="recruitNumber" value="1"> <br>


        <div class="tripDate">
            <span class="option">여행 기간</span>
            <input
                    name="startDate"
                    type="date"
                    data-placeholder="날짜 선택"
                    required
                    aria-required="true"
                    value="2023-08-11"
                    className={styles.selectDay}
                    onChange={StartDateValueHandler}
            >
            -
            <input
                    name="endDate"
                    type="date"
                    data-placeholder="날짜 선택"
                    required
                    aria-required="true"
                    value="2023-08-15"
                    className={styles.selectDay}
                    onChange={StartDateValueHandler}
            >
        </div>
        <div class="recruit">
            <c:forEach items="${Gender.values()}" var="gender">
                <input type="radio" id="${gender.genderStr}" value="${gender}" name="gender" checked><label
                    for="${gender.genderStr}">${gender.genderStr}</label></input>
            </c:forEach>

            <div class="a">
                <c:forEach items="${AgeRange.values()}" var="ageRange">
                    <c:if test="${ageRange.ageRangeStr eq '아무나'}">
                        <input type="checkbox" id="${ageRange}" value="${ageRange.ageRangeNum}" name="age"
                               onclick="ageRangeChecked()" checked><label
                            for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                    </c:if>
                    <c:if test="${ageRange.ageRangeStr ne '아무나'}">
                        <input type="checkbox" id="${ageRange}" value="${ageRange.ageRangeNum}" name="age"
                               onclick="ageRangeChecked()"><label
                            for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                    </c:if>
                </c:forEach>
                <input hidden id="ageRangeId" name="ageRangeId">

            </div>
        </div>
        <input type="file" name="file" required>
        <div class="form-container">
            <input class="form-input" type="text" name="title" value="8/11 제주 월정리에서 같이 여행하실분"
                   placeholder="ex) 8/11 제주 월정리에서 같이 여행하실분 찾아요!!"
                   required>
            <textarea class="form-input" name="content"
                      placeholder="같이 월정리 주변 여행하실분 계신가요? 사진찍는걸 좋아하고 바다 좋아하시는 분이었으면 좋겠어요"
                      rows="8" style="resize: none;" required>텍스트입력</textarea>
        </div>

        <button id="cancle" onclick="location.href='bbs_list?page=1'">취소</button>
        <button type="submit" id="complete">작성완료</button>
</form>
</body>
</html>