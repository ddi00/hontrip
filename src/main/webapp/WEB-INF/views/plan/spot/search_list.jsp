<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>여행지 목록</title>
</head>
<body>
<div class="container-fluid container my-5 w-75 p-3">
    <h2>${keyword} 여행지 목록</h2>
    <a href="search_form" role="button" class="btn btn-yellow">재검색</a>
    <div class="row d-flex justify-content-center">
        <div class="mb-3">
        </div>
        <ul>
            <c:forEach items="${list}" var="spot">
                <div class="card p-4 mt-2">
                    <div class="card-body align-items-center justify-content-between">
                        <div class="row d-flex">
                <span><img src="${spot.image}" alt="대표 이미지" width="300" height="220"></span>
                <span>
                    <li>여행지명 : <a href="one?contentId=${spot.contentId}">${spot.title}</a></li>
                    <li>주소 : ${spot.address}</li>
                </span>
                </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </ul>
    </div>
</div>
</body>
</html>
