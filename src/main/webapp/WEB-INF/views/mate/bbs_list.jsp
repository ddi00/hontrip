<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
<div>
    <select id="location" name="location" size="1">
        <option selected value="">지역 선택</option>
        <c:forEach items="${Region.values()}" var="location">
            <option value="${location.regionNum}"> ${location.regionStr} </option>
        </c:forEach>
    </select>
</div>
<div>
    <form name="mate_search" autocomplete="off">
        </select>
        <select id="searchType" name="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="title_content">제목+내용</option>
            <option value="nickname">작성자</option>
        </select>
        <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요"></input>
        <button id="searchBtn" class="btn btn-primary mr-2">검색</button>
    </form>
</div>
<table class="table table-borderless">
    <tr>
        <td>이미지</td>
        <td>제목</td>
        <td>글쓴이</td>
        <td>모집 희망 나이대</td>
        <td>여행 시작일</td>
        <td>여행 종료일</td>
    </tr>
    <tbody id=list-area>
    <c:forEach items="${list}" var="one">
        <tr>
            <td><img src="${one.thumbnail}"></td>
            <td><a href="../mate/${one.mateBoardId}">${one.title}</a></td>
            <td>${one.nickname}</td>
            <td>${one.ageRange}</td>
            <td>${one.startDate}</td>
            <td>${one.endDate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<hr color="blue">
<div class="paging">
    <button class="pageBtn prevBtn" data-page="${pageDTO.firstPageNoOnPageList - 1}"><</button>

    <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}"/>
    <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}"/>

    <c:forEach var="num" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${num == pageDTO.page}">
                <button class="pageBtn active" data-page="${num}">${num}</button>
            </c:when>
            <c:otherwise>
                <button class="pageBtn" data-page="${num}">${num}</button>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <button class="pageBtn nextBtn" data-page="${pageDTO.lastPageNoOnPageList + 1}">></button>
</div>
