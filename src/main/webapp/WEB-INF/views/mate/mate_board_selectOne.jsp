<%@ page import="com.multi.hontrip.mate.dto.MateBoardInsertDTO" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>

    <title>Title</title>
    <style>
        body {
            width: 700px;
            margin: 0 auto;
            padding: 20px;
            color: #292929;
            font-size: 12px;
        }
    </style>

</head>
<body>


<a href="../">메인 페이지</a>
<a href="../mate/insert">게시글 작성 페이지</a>
<table>
    <tr>
        <td><img src="../resources/upload/${dto.thumbnail}" alt="${dto.thumbnail}" height="200" width="600"></td>
    </tr>
    <tr>
        <td height="40px"><span style="font-weight: bold">${dto.title}</span></td>
    </tr>
    <tr>
        <td>(캘린더 아이콘) <fmt:parseDate value="${dto.startDate}" var="dateValue" pattern="yyyy-MM-dd"/>
            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/> - <fmt:parseDate value="${dto.endDate}"
                                                                                    var="dateValue"
                                                                                    pattern="yyyy-MM-dd"/>
            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/>
            (위치 아이콘) ${dto.regionId.regionStr} (모집인원) ${dto.recruitNumber}명
        </td>
    </tr>

    <tr>
        <td><span style="font-weight: bold">원해요</span> #${dto.gender.genderStr} ${dto.ageRangeId}
            <button style="background-color: #FFA41B" id="application">동행 신청하기</button>
        </td>
    </tr>

    <tr>
        <td height="100px">${dto.content}</td>
    </tr>

    <tr>
        <td>${dto.createdAt} <a href="#">수정</a> <a href="#">삭제</a></td>
    </tr>
</table>

<% MateBoardInsertDTO mateBoardInsertDTO = (MateBoardInsertDTO) request.getAttribute("dto");
    String[] ageRangeArr = mateBoardInsertDTO.getAgeRangeId().split(",");
    for (String age : ageRangeArr) {
        AgeRange.valueOf(Integer.parseInt(age));
    }
%>

<%--<c:forEach items="${ageRangeArr}" var="age">
<%= AgeRange.valueOf(age)%>
</c:forEach>--%>

<input id="comment" type="text" placeholder="댓글을 적어주세요">
<button>등록</button>


</body>
</html>
