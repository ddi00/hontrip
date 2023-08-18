<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>여행지 상세</title>
    <style>
        ul {
            list-style: none;
        }

        .justify-content-center {
            justify-content: center !important;
        }

        .btn-custom1 {
            background-color: #FF9F1C;
            border-color: #FF9F1C;
        }

        .btn-custom2 {
            background-color: #FFE0B5;
            border-color: #FFE0B5;
        }
    </style>
</head>
<body>
<div class="container-fluid container my-5 w-75 p-3">
    <div class="row d-flex justify-content-center">
        <p style="visibility: hidden">${spot.id}</p>
        <p style="visibility: hidden">${spot.contentId}</p>
        <p style="visibility: hidden">${spot.contentTypeId}</p>
        <ul>
            <li>
                <span><img src="${spot.image}" alt="대표 이미지" width="550" height="450"></span> <br>
                여행지명 : ${spot.title} <br>
                주소 : ${spot.address} <br>
                전화번호 : ${spot.tel} <br>
                홈페이지 : ${spot.homepage} <br>
                개요 : ${spot.overview} <br>
                문의 및 안내 : ${spot.infoCenter} <br>
                개장일 : ${spot.openDate} <br>
                휴일 : ${spot.restDate} <br>
                체험 안내 : ${spot.expguide} <br>
                이용 시간 : ${spot.usetime} <br>
                주차 시설 : ${spot.parking} <br>
                <br>
                <button id="addToPlan" type="button" class="btn btn-custom2">추가</button>
                <button id="goToList" type="button" class="btn btn-custom1 ms-1">목록</button>
            </li>
        </ul>
    </div>
</div>
<script>
    $(document).on('click', '#goToList', function () {
        location.href = "${pageContext.request.contextPath}/plan/spot/search_list";
    });
</script>
</body>
</html>
