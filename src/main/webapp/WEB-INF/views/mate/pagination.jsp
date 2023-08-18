<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach items="${list}" var="one">
<tr>
<td><img src = "${one.thumbnail}"></td>
	<td><a href="<c:url value='/mate/bbs_one?mateBoardId=${one.mateBoardId}'/>">${one.title}</a></td>
<td>${one.nickname}</td>
<td>${one.ageRange}</td>
<td>${one.startDate}</td>
<td>${one.endDate}</td>
</tr>
</c:forEach>