<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 상세 페이지</title>
</head>
<body>
<h1>여행 상세 정보</h1>

<p><strong>일정 제목:</strong> ${plan.title}</p>
<p><strong>일정 시작일:</strong> ${plan.startDate}</p>
<p><strong>일정 종료일:</strong> ${plan.endDate}</p>
<p><strong>일정 메모:</strong> ${plan.memo}</p>

<h2>일자별 상세 정보</h2>
<table>
    <thead>
    <tr>
        <th>일자</th>
        <th>일자별 요약</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="day" items="${planDays}">
        <tr>
            <td>${day.dayDate}</td>
            <td>${day.daySummary}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- 기타 내용 추가 가능 -->
</body>
</html>--%>
