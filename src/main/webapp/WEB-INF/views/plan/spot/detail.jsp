<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container mt-15 mb-20 w-75">
        <div class="row mb-2 d-flex justify-content-center">
            <div class="col-8 me-5">
                <span class="invisible">${spot.id}</span>
                <span class="invisible">${spot.contentId}</span>
                <span class="invisible">${spot.contentTypeId}</span>
                <span>
            <form id="spot-list-form" action="search" method="post">
                <input type="hidden" id="category" name="category" value="${category}">
                <input type="hidden" id="keyword" name="keyword" value="${keyword}">
            </form>
            </span>
            </div>
            <div class="col-3 text-end ms-auto">
                <input type="submit" value="목록" class="btn btn-outline-gray bg-white text-black-50 ms-1" style="width: 74%; border: 1px solid rgba(8, 60, 130, 0.15);" form="spot-list-form">
            </div>
        </div>
        <div class="row d-flex justify-content-center">
            <div class="col-lg-6">
                <img src="${spot.image}" alt="대표 이미지" width="550" height="450">
            </div>
            <div class="card col-lg-6 p-4">
                <div class="card-body align-items-center justify-content-between">
                    <div class="post-header mb-5">
                        <h2 class="post-title display-5">${spot.title}</h2>
                    </div>
                    <h5>${spot.address}</h5>
                    <p class="mb-6">${spot.overview}</p> <br>
                    <br>
                    <div class="col-lg-9 d-flex flex-row pt-2">
                        <div class="item-like-div" style="height: 2.2rem;">
                            <c:choose>
                                <c:when test="${isLiked eq 1}">
                                    <button class="dislike-btn btn btn-block btn-primary btn-icon rounded px-3 w-100 h-100"
                                            data-spot-content-id="${spot.contentId}">
                                        <a class="item-like text-white" aria-label="즐겨찾기 해제"><i class="uil">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                 viewBox="0 0 24 24">
                                                <path fill="white"
                                                      d="M20.205 4.791a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595a5.904 5.904 0 0 0-3.996-1.558a5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412L12 21.414l8.207-8.207c2.354-2.353 2.355-6.049-.002-8.416z"/>
                                            </svg>
                                                ${likeCount}
                                        </i></a></button>
                                </c:when>
                                <c:when test="${isLiked eq 0}">
                                    <button class="like-btn btn btn-block btn-primary btn-icon rounded px-3 w-100 h-100"
                                            data-spot-content-id="${spot.contentId}">
                                        <a class="item-like text-white" aria-label="즐겨찾기 추가"><i
                                                class="uil uil-heart"> ${likeCount}</i></a>
                                    </button>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <ul class="custom-nav custom-nav-tabs custom-nav-tabs-basic mt-12" role="tablist">
            <li class="custom-nav-item" role="presentation">
                <a class="custom-nav-link active" data-bs-toggle="tab" href="#tab1-1" aria-selected="true" role="tab">기본
                    정보</a>
            </li>
            <li class="custom-nav-item" role="presentation">
                <a class="custom-nav-link" data-bs-toggle="tab" href="#tab1-2" aria-selected="false" tabindex="-1"
                   role="tab">상세
                    정보</a>
            </li>
        </ul>
        <div class="tab-content mt-0 mt-md-5">
            <div class="tab-pane fade show active" id="tab1-1" role="tabpanel">
                <table class="table">
                    <tbody>
                    <tr>
                        <th scope="row">전화번호</th>
                        <td>${spot.tel}</td>
                    </tr>
                    <tr>
                        <th scope="row">홈페이지</th>
                        <td>${spot.homepage}</td>
                    </tr>
                    <tr>
                        <th scope="row">이용 시간</th>
                        <td>${spot.usetime}</td>
                    </tr>
                    <tr>
                        <th scope="row">휴일</th>
                        <td>${spot.restDate}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--/.tab-pane -->
            <div class="tab-pane fade" id="tab1-2" role="tabpanel">
                <table class="table">
                    <tbody>
                    <tr>
                        <th scope="row">문의 및 안내</th>
                        <td>${spot.infoCenter}</td>
                    </tr>
                    <tr>
                        <th scope="row">체험 안내</th>
                        <td>${spot.expguide}</td>
                    </tr>
                    <tr>
                        <th scope="row">주차 시설</th>
                        <td>${spot.parking}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--/.tab-pane -->
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
                let likeButtonDiv = clickedLikeButton.parent(".item-like-div");
                let filledLikeButtonHtml = "";
                let likeCount = result;
                filledLikeButtonHtml += "<button class='dislike-btn btn btn-block btn-primary btn-icon rounded px-3 w-100 h-100' data-spot-content-id='" + spotContentId + "'>"
                filledLikeButtonHtml += "<a class='item-like text-white' aria-label='즐겨찾기 해제'>"
                filledLikeButtonHtml += "<i class='uil'><svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' viewBox='0 0 24 24'><path fill='white' d='M20.205 4.791a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595a5.904 5.904 0 0 0-3.996-1.558a5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412L12 21.414l8.207-8.207c2.354-2.353 2.355-6.049-.002-8.416z'/>"
                filledLikeButtonHtml += "</svg>" + " " + likeCount + "</i></a></button>"
                likeButtonDiv.html(filledLikeButtonHtml);
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
                let likeButtonDiv = clickedDislikeButton.parent(".item-like-div");
                let filledDislikeButtonHtml = "";
                let likeCount = result;
                filledDislikeButtonHtml += "<button class='like-btn btn btn-block btn-primary btn-icon rounded px-3 w-100 h-100' data-spot-content-id='" + spotContentId + "'>"
                filledDislikeButtonHtml += "<a class='item-like text-white' aria-label='즐겨찾기 추가'>"
                filledDislikeButtonHtml += "<i class='uil uil-heart'></i>" + "<i class='uil'>" + " " + likeCount + "</i></a></button>"
                likeButtonDiv.html(filledDislikeButtonHtml);
            },
            error: function () {
                alert("즐겨찾기 해제에 실패했습니다.");
            }
        });
    });
</script>
