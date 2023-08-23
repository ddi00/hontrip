<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
</head>
<body>
    <form method="post" enctype="multipart/form-data">
        <br>
        썸네일<input type="file" name="file">
        <br>
        <img src="<c:url value='/resources/img/recordImg/${postInfoDTO.thumbnail}'/>"width="300" height="180">
        <br>
        <br>
        <select name="isVisible">
            <option value="1">공개</option>
            <option value="0">비공개</option>
        </select>
        <br>
        <br>
        <input type="text" name="title" value="${postInfoDTO.title}">
        <br>
        <br>
        <textarea name="content">${postInfoDTO.content}</textarea>
        <br>
        <button type="submit">전 송</button>
    </form>
</body>
</html>