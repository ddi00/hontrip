<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .justify-content-center {
            justify-content: center !important;
        }

        .align-items-center {
            align-items: center !important;
        }
    </style>
</head>
<body>
<div class="container-fluid container my-5 w-75 p-3">
    <div class="row d-flex justify-content-center">
        <div class="mb-3">
            <h5>${areaName} 여행지 목록</h5>
            <a href="search_form" role="button" class="btn btn-primary">재검색</a>
        </div>
        <ul>
            <c:forEach items="${list}" var="spot">
                <span><img src="${spot.image}" alt="대표 이미지" width="200" height="150"></span>
                <span>
                    <li>여행지명 : ${spot.title}</li>
                    <li>주소 : ${spot.address}</li>
                </span>
                </span>
                <hr>
            </c:forEach>
        </ul>
    </div>


</div>
</body>
</html>
