<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="com.multi.hontrip.mate.dto.Region" %>
        <%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
            <script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
            <div class="container">
                <div class="row justify-content-center">
                        <div class="col-md-offset-2">
                            <div class="text-left">
                                <form name="mate_search" autocomplete="on">
                                    <div class="input-group mb-3">
                                        <select class="form-select" id="searchType" name="searchType">
                                            <option value="" disabled selected hidden>검색 유형</option>
                                            <option value="title">제목</option>
                                            <option value="content">내용</option>
                                            <option value="title_content">제목+내용</option>
                                            <option value="nickname">작성자</option>
                                        </select>
                                        <input type="text" id="keyword" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
                                        <button id="searchBtn" class="searchBtn btn btn-main rounded-pill btn-lg px-4" type="submit">검색</button>
                                    </div>
                                <div class="offset-md-11 text-right">
                                <!-- 추가적인 내용이 있다면 여기에 작성할 수 있습니다. -->
                                <a href="../mate/insert"><span class="underline-3 style-1 yellow">게시물 작성하기</span></a><br>
                            </div>
                                </form>

                                <button id="filterButton" type="button" class="btn btn-expand btn-soft-orange rounded-pill" aria-expanded="false">
                                        <i class="uil uil-arrow-right"></i>
                                        <span>검색 필터</span>
                                </button>
                                <button id="resetButton"class="btn btn-main rounded-pill">
                                검색 조건 초기화
                                </button>
                                <div class="regionBtn-container">
                                <c:forEach items="${Region.values()}" var="region">
                                    <button class="regionBtn btn btn-soft-orange btn-sm rounded-pill" data-region="${region.regionNum}">
                                        ${region.regionStr}
                                    </button>
                                </c:forEach>
                            </div>
                                <div class="ageBtn-container">
                                    <c:forEach items="${AgeRange.values()}" var="age" varStatus="status">
                                        <c:if test="${status.index > 0}">
                                            <button class="ageBtn btn btn-soft-orange btn-sm rounded-pill" data-age="${age.ageRangeNum}">
                                                ${age.ageRangeStr}
                                            </button>
                                        </c:if>
                                    </c:forEach>
                                </div>

                                </div>
                                <div>
                                <button id="viewCount" class="btn btn-soft-orange btn-sm rounded-pill mb-2">
                                    조회수 순
                                </button>
                                </div>
                            </div>
                        </div>
                        <div class="mate-list-title">
                        <span class="text-navy">동행</span>
                        <span class="rotator-zoom text-orange">
                            혼자도 좋지만,같이 여행 할래?,즐거운 여행!!
                        </span>
                     </div>
                    <section class="wrapper bg-light">
                        <div class="container py-14 py-md-16">
                            <div class="row gx-lg-8 gx-xl-12">
                                <div class="col-lg-12">
                                    <div class="blog grid grid-view">
                                        <div class="row isotope gx-md-8 gy-8 mb-8"
                                            style="display: flex; flex-wrap: wrap;">
                                            <c:forEach items="${list}" var="one" varStatus="loop">
                                                <div class="col-md-6 col-lg-4 mate-post-card">
                                                    <article class="item post">
                                                        <div class="card">
                                                            <figure class="card-img-top overlay overlay-1 hover-scale">
                                                                <a href="../mate/${one.mateBoardId}">
                                                                    <div class="mate-list-image-container">
                                                                        <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>" alt="Image">
                                                                    </div>
                                                                    <span class="bg"></span>
                                                                </a>
                                                                <figcaption>
                                                                    <h5 class="from-top mb-0">Read More</h5>
                                                                </figcaption>
                                                            </figure>

                                                            <div class="card-body">
                                                                <div class="post-header">
                                                                    <div class="post-category text-line">
                                                                        <a href="#" class="hover"
                                                                            rel="category">${one.nickname}</a>
                                                                    </div>
                                                                    <h2 class="post-title h3 mt-1 mb-3">
                                                                        <a class="link-dark"
                                                                            href="../mate/${one.mateBoardId}">${one.title}</a>
                                                                        <c:forEach items="${AgeRange.values()}" var="age">
                                                                            <c:if test="${age.ageRangeNum == Integer.parseInt(one.ageRangeId)}">
                                                                                <span class="badge bg-pale-orange text-orange rounded-pill">${age.ageRangeStr}</span>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </h2>
                                                                    <ul class="post-meta d-flex mb-0">
                                                                <li class="post-date"><i
                                                                        class="uil uil-calendar-alt"></i><span>${one.startDate}
                                                                    </span></li>
                                                                <li class="post-date"><i
                                                                        class="uil uil-calendar-alt"></i><span>${one.endDate}</span>
                                                                </li>
                                                                <li class="post-likes ms-auto">
                                                                <i class="uil uil-user-check"></i>조회수${one.viewCount}</li>
                                                            </ul>
                                                            <!-- /.post-meta -->
                                                                </div>
                                                            </div>
                                                        </div>



                                                    </article>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </section>
                        <nav class="d-flex mate-pagination" aria-label="pagination">
                            <ul class="pagination">
                                <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}" />
                                <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}" />
                                <li class="page-item disabled">
                                    <button class="page-link pageBtn prevBtn"
                                        data-page="${pageDTO.firstPageNoOnPageList - 1}"><i
                                            class="uil uil-arrow-left"></i></button>
                                </li>
                                <c:forEach var="num" begin="${startPage}" end="${endPage}">
                                    <c:choose>
                                        <c:when test="${num == pageDTO.page}">
                                            <li class="page-item active">
                                                <button class="page-link pageBtn active"
                                                    data-page="${num}">${num}</button>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <button class="page-link pageBtn"
                                                    data-page="${num}">${num}</button>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${pageDTO.pages > pageDTO.lastPageNoOnPageList}">
                                        <li class="page-item">
                                            <button class="page-link pageBtn nextBtn"
                                                data-page="${pageDTO.lastPageNoOnPageList + 1}">
                                                <i class="uil uil-arrow-right"></i>
                                            </button>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item disabled">
                                            <button class="page-link pageBtn nextBtn"
                                                data-page="${pageDTO.lastPageNoOnPageList + 1}">
                                                <i class="uil uil-arrow-right"></i>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                            <!-- /.pagination -->
                        </nav>
                </div>
            </div>
