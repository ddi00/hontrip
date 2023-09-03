<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h2>여행지 검색 > ${keyword}</h2>
        <form id="spot-list-search-form" action="search" method="post" class="mt-5">
            <div class="custom-form-container">
                <div class="col-md-2 me-2">
                    <select class="form-select" id="category" name="category" form="spot-list-search-form"
                            aria-label="검색 범주" style="border: 1px solid rgba(8, 60, 130, 0.2);">
                        <option value="keyword" selected>여행지명</option>
                        <option value="area">지역명</option>
                    </select>
                </div>
                <input type="text" id="keyword" name="keyword" class="custom-form-control col-8 me-2">
                <input type="submit" value="검색" class="btn btn-primary col-md-2">
            </div>
        </form>
        <div id="spot-list" class="row justify-content-start align-content-center">
            <%--            검색 데이터 없는 경우 메시지 표시       --%>
            <h3 class="my-2 align-self-center">
                <c:if test="${empty list}">
                    <c:out value="${message}"/>
                </c:if>
            </h3>
            <%--            검색 여행지 목록       --%>

            <c:forEach items="${list}" var="spot">
                <div class="custom-card ms-3 my-2 custom-col-3">
                        <%--                    <div class="custom-card-body">--%>
                    <div class="custom-card-body project item" role="group" aria-label="1 / 5">
                        <figure class="rounded">
                            <a href="detail?category=${category}&keyword=${keyword}&contentId=${spot.contentId}"
                               class="custom-a">
                                <img src="${spot.image}" alt="대표 이미지" class="custom-card-img"
                                     style="height: 170px !important;">
                            </a>
                            <span class="item-like-span">
                                <c:set var="LikedSpotIds" value="${userLikedSpotIds}"/>
                                <c:choose>
                                    <c:when test="${fn:contains(LikedSpotIds, spot.contentId)}">
                                        <a class="item-like dislike-btn" aria-label="즐겨찾기 해제"
                                           data-spot-content-id="${spot.contentId}">
                                            <i class="uil"><svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                                height="20" viewBox="0 0 24 24">
                                            <path fill="black"
                                                  d="M20.205 4.791a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595a5.904 5.904 0 0 0-3.996-1.558a5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412L12 21.414l8.207-8.207c2.354-2.353 2.355-6.049-.002-8.416z"/>
                                            </svg></i></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="item-like like-btn" aria-label="즐겨찾기 추가"
                                           data-spot-content-id="${spot.contentId}"><i class="uil uil-heart"></i></a>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </figure>
                        <div class="mt-2">
                            <h5><a href="detail?category=${category}&keyword=${keyword}&contentId=${spot.contentId}"
                                   class="custom-a">${spot.title}</a></h5>
                            <p>${spot.address}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<script>
    let userId = <%= userId %>;
    // 즐겨찾기 추가 버튼 클릭 이벤트 처리
    $(document).on('click', '.like-btn', function () {
        let clickedLikeButton = $(this);
        let spotContentId = $(this).data("spot-content-id");
        $.ajax({
            method: "get",
            url: "add-spot-like",
            dataType: "json",
            data: {
                userId: userId,
                spotContentId: spotContentId
            },
            success: function (result) {
                let likeButtonSpan = clickedLikeButton.parent(".item-like-span");
                let filledLikeButtonHtml = "";
                filledLikeButtonHtml += "<a class='item-like dislike-btn' aria-label='즐겨찾기 해제' data-spot-content-id='" + spotContentId + "'>"
                filledLikeButtonHtml += "<i class='uil'><svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' viewBox='0 0 24 24'><path fill='black' d='M20.205 4.791a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595a5.904 5.904 0 0 0-3.996-1.558a5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412L12 21.414l8.207-8.207c2.354-2.353 2.355-6.049-.002-8.416z'/></svg></i></a>"
                likeButtonSpan.html(filledLikeButtonHtml);
                location.reload();
            },
            error: function () {
                alert("즐겨찾기 추가에 실패했습니다.");
            }
        });
    });

    // 즐겨찾기 해제 버튼 클릭 이벤트 처리
    $(document).on('click', '.dislike-btn', function () {
        let clickedDislikeButton = $(this);
        let spotContentId = $(this).data("spot-content-id");
        $.ajax({
            method: "get",
            url: "delete-spot-like",
            dataType: "json",
            data: {
                userId: userId,
                spotContentId: spotContentId
            },
            success: function (result) {
                let likeButtonSpan = clickedDislikeButton.parent(".item-like-span");
                let filledDislikeButtonHtml = "";
                filledDislikeButtonHtml += "<a class='item-like like-btn' aria-label='즐겨찾기 추가' data-spot-content-id='" + spotContentId + "'>"
                filledDislikeButtonHtml += "<i class='uil uil-heart'></i></a>"
                likeButtonSpan.html(filledDislikeButtonHtml);
                location.reload();
            },
            error: function () {
                alert("즐겨찾기 해제에 실패했습니다.");
            }
        });
    });
</script>