<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    if (session.getAttribute("id") != null) {
        Long userId = (Long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h3 class="mb-4">내 여행 일정</h3>
        <button type="button" class="btn btn-yellow mb-3 w-100">
            <a href="create" role="button" class="text-white">새 일정 생성</a>
        </button>
        <ul class="unordered-list">
            <c:forEach items="${list}" var="plan">
                <div class="card mt-2">
                    <div class="card-body">
                        작성자 : ${userId} <br>
                        제목 : <a href="detail?planId=${plan.id}" class="custom-a">${plan.title}</a> <br>
                        시작일 : ${plan.startDate} <br>
                        종료일 : ${plan.endDate} <br>
                        생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd" type="date"/> <br>
                        <br>
                        <button type="button" class="btn btn-custom1">
                            <a href="delete?planId=${plan.id}" role="button" class="text-white">삭제</a>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </ul>
    </div>
</section>