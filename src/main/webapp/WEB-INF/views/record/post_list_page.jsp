<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="mylist_section">
    <section class="wrapper-record">
        <div class="container pt-0 pt-md-0 pb-16 pb-md-0">
            <div class="grid grid-view projects-masonry mt-md-n5 mt-lg-n22 mb-0">
                <div class="row g-8 g-lg-10 isotope">
                    <c:forEach items="${mylist}" var="postInfoDTO">
                        <div class="project item col-md-3 col-xl-3 workshop">
                            <div class="card shadow-lg">
                                <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                                    <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                        <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                                    </a>
                                </figure>
                                <div class="card-body">
                                    <div class="post-header">
                                        <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                                        <h3 class="mb-0">${postInfoDTO.title}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</div>