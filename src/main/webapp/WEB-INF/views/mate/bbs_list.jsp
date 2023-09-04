<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
<section class="wrapper bg-light">
              <section class="wrapper bg-light">
                  <div class="container pt-11 pt-md-13 pb-10 pb-md-0 pb-lg-5 text-center">
                      <div class="row">
                          <div class="col-lg-8 col-xl-7 col-xxl-6 mx-auto" data-cues="slideInDown" data-group="page-title">
                              <h1 class="display-1"><span class="underline-3 style-3 primary">동행인</span> 게시판</h1>
                          </div>
                          <!-- /column -->
                      </div>
                      <!-- /.row -->
                  </div>
                  <!-- /.container -->
              </section>
              <!-- /section -->
<div class="container">
    <section class="wrapper bg-light">
        <div class="container py-8 py-md-8">
            <div class="row justify-content-center">
                <div class="col-md-offset-2">
                    <div class="text-left">
                        <form name="mate_search" autocomplete="on">
                            <div class="input-group mb-1 mate-search-group">
                               <div class ="mate-search-select">
                                <select class="form-select" id="searchType" name="searchType">
                                    <option value="" disabled selected hidden>검색 유형</option>
                                    <option value="title">제목</option>
                                    <option value="content">내용</option>
                                    <option value="title_content">제목+내용</option>
                                    <option value="nickname">작성자</option>
                                </select></div>
                                <div class="mate-search-text">
                                <input type="text" id="keyword" name="keyword" class="form-control"
                                       placeholder="검색어를 입력하세요"></div>
                                <button id="mate-search-Btn" class="mate-search-Btn btn btn-primary rounded-pill btn-lg px-4"
                                        type="submit">
                                    검색
                                </button>
                            </div>
                        </form>
                        <button id="filterButton" type="button" class="btn btn-expand btn-primary rounded-pill"
                                aria-expanded="false">
                            <i class="uil uil-arrow-right"></i>
                            <span>검색 필터</span>
                        </button>
                        <button id="resetButton" class="btn btn-primary rounded-pill">
                            검색 조건 초기화
                        </button>
                        <a href="../mate/insert" class="btn btn-primary mate-list-insert-btn rounded-pill">작성하기</a>
                        <div class="regionBtn-container">
                            <c:forEach items="${Region.values()}" var="region">
                                <button class="regionBtn btn btn-soft-primary btn-sm rounded-pill"
                                        data-region="${region.regionNum}">
                                        ${region.regionStr}
                                </button>
                            </c:forEach>
                        </div>
                        <div class="ageBtn-container">
                            <c:forEach items="${AgeRange.values()}" var="age" varStatus="status">
                                <c:if test="${status.index > 0}">
                                    <button class="ageBtn btn btn-soft-primary btn-sm rounded-pill"
                                            data-age="${age.ageRangeNum}">
                                            ${age.ageRangeStr}
                                    </button>
                                </c:if>
                            </c:forEach>
                        </div>

                    </div>
                    <div>
                        <button id="viewCount" class="btn btn-soft-primary btn-sm rounded-pill mb-2">
                            조회수 순
                        </button>
                    </div>
                </div>
            </div>


            <div class="row gy-6">
                <div class="row isotope gx-md-8 gy-8 mb-8">
                    <c:forEach items="${list}" var="one" varStatus="loop">
                        <div class="col-md-6 col-lg-4">
                            <article class="item post mate-post-item">
                                <div class="card">
                                    <figure class="card-img-top overlay overlay-1 hover-scale">
                                        <a href="../mate/${one.mateBoardId}">
                                            <div class="mate-list-image-container">
                                                <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>"
                                                     alt="Image">
                                            </div>
                                            <span class="bg"></span>
                                        </a>
                                        <figcaption>
                                            <h5 class="from-top mb-0">Read More</h5>
                                        </figcaption>
                                    </figure>

                                    <div class="card-body">
                                        <div class="post-header">
                                            <div class="post-header d-flex align-items-center mb-3"> <!-- 프로필 이미지와 닉네임을 가로로 나란히 배치 -->
                                             <figure class="user-avatar">
                                                 <img class="rounded-circle" alt="" src="${one.profileImage}"/>
                                             </figure>
                                                 ${one.nickname}
                                         </div>
                                            <h2 class="post-title h3 mt-1 mb-2">
                                                <a class="link-dark mb-2"
                                                   href="../mate/${one.mateBoardId}">${one.title}</a><br><br>
                                                <c:forEach items="${AgeRange.values()}" var="age">
                                                    <c:if test="${age.ageRangeNum == Integer.parseInt(one.ageRangeId)}">
                                                        <div class="badge bg-pale-primary text-primary rounded-pill">#${age.ageRangeStr}</div>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach items="${Gender.values()}" var="gender">
                                                <c:if test="${gender.genderNum == Integer.parseInt(one.genderId)}">
                                                    <div class="badge bg-pale-primary text-primary rounded-pill">#${gender.genderStr}</div>
                                                </c:if>
                                            </c:forEach>
                                                <c:forEach items="${Region.values()}" var="Region">
                                                <c:if test="${Region.regionNum == Integer.parseInt(one.regionId)}">
                                                    <div class="badge bg-pale-primary text-primary rounded-pill">#${Region.regionStr}</div>
                                                </c:if>
                                            </c:forEach>
                                            </h2>
                                            <ul class="post-meta d-flex mb-0 mate-list-one">
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

            <nav class="d-flex mate-pagination" aria-label="pagination">
                <ul class="pagination">
                    <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}"/>
                    <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}"/>
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
                                    <i class="uil uil-arrow-right"></i></button>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <!-- /.pagination -->
            </nav>
        </div>
    </section>
</div>
</section>