<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>


<body style="background: pink;">
<div>
    <select name="location" size="1">
        <option selected value="">지역 선택</option>
        <c:forEach items="${location}" var="location">
        <option> ${location.city} </option>
        </c:forEach>
</div>
<div>
    <form name="mate_search" autocomplete="off">
        </select>
        <select name="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="title_content">제목+내용</option>
            <option value="writer">작성자</option>
        </select>
        <input type="text" name="keyword" value=""></input>
        <button id="searchBtn" class="btn btn-primary mr-2">검색</button>
    </form>
</div>
<script>

    document.getElementById("searchBtn").onclick = function () {

        let searchType = document.getElementsByName("searchType")[0].value;
        let keyword = document.getElementsByName("keyword")[0].value;

        location.href = "/hontrip/bbs_list?page=1" + "&searchType=" + searchType + "&keyword=" + keyword;
    };
</script>
<table class="table table-borderless">
    <tr>
        <td>이미지</td>
        <td>제목</td>
        <td>글쓴이</td>
        <td>모집 희망 나이대</td>
        <td>여행 시작일</td>
        <td>여행 종료일</td>
    </tr>
    <c:forEach items="${list}" var="one">
        <tr>
            <td><img src="${one.thumbnail}"></td>
            <td><a href="bbs_one?id=${one.mateBoardId}">${one.title}</a></td>
            <td>${one.nickname}</td>
            <td>${one.ageRange}</td>
            <td>${one.startDate}</td>
            <td>${one.endDate}</td>
        </tr>
    </c:forEach>
</table>
<hr color="blue">
<%
    int pages = (int) request.getAttribute("pages");
    for (int p = 1; p <= pages; p++) {
%>
<a href=bbs_list?page=<%= p %>>
    <button><%= p %>
    </button>
</a>
<%
    }
%>
</body>
</html>