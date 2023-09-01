<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach items="${mylist}" var="postInfoDTO">
    <div class="project item col-md-6 col-xl-4 workshop">
        <div class="card shadow-lg">
            <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                    <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                </a>
            </figure>
            <div class="card-body">
                <div class="post-header">
                    <div class="post-category text-line mb-2 text-aqua">${postInfoDTO.city}</div>
                    <h3 class="mb-0">${postInfoDTO.title}</h3>
                </div>
            </div>
        </div>
    </div>
</c:forEach>