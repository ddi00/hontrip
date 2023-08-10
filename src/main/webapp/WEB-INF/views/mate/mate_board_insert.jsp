<%@ page import="com.multi.hontrip.mate.dto.Gender" %><%--
  Created by IntelliJ IDEA.
  User: ehska
  Date: 2023-08-09
  Time: 오후 1:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        유저아이디 <input hidden name="userId" value="1"> <br>

        지역아이디 <input type="text" name="regionId" value="20"> <br>

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
            <%--모집조건 - 성별 (남성, 여성, 아무나 중 택1)--%>
            <input type="radio" id="male" value="${Gender.MALE}" name="gender"><label for="male">남성</label>
            <input type="radio" id="female" value="${Gender.FEMALE}" name="gender" checked><label
                for="female">여성</label>
            <input type="radio" id="genderAll" value="${Gender.ALLGENDER}" name="gender"><label
                for="genderAll">아무나</label>
            <%--모집조건 - 연령대 (20,30,40,50,아무나 중복 선택 가능)--%>
            <input type="checkbox" id="10" value="3" name="ageRangeId"><label for="10">10대</label>
            <input type="checkbox" id="20" value="4" name="ageRangeId"><label for="20">20대</label>
            <input type="checkbox" id="30" value="5" name="ageRangeId"><label for="30">30대</label>
            <input type="checkbox" id="40" value="6" name="ageRangeId"><label for="40">40대</label>
            <input type="checkbox" id="50" value="7" name="ageRangeId" checked><label for="50">50대</label>
            <input type="checkbox" id="ageAll" value="8" name="ageRangeId"><label for="ageAll">아무나</label>
        </div>
        <%--<input type="file" name="thumbnail">
    --%>

        <input type="file" name="file">
        <div class="form-container">
            <input class="form-input" type="text" name="title" value="제발" placeholder="ex) 8/11 제주 월정리에서 같이 여행하실분 찾아요!!"
                   required>
            <textarea class="form-input" name="content"
                      placeholder="같이 월정리 주변 여행하실분 계신가요? 사진찍는걸 좋아하고 바다 좋아하시는 분이었으면 좋겠어요"
                      rows="8" style="resize: none;" required>텍스트입력</textarea>
        </div>

        <button id="complete">작성완료</button>
</form>
</body>
</html>
