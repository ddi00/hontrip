<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/styles.css">
<div class="container">
<div class="row justify-content-center">
<div class="text-center">
<form name="mate_search" autocomplete="off">
    <select id="location" name="location" size="1">
        <option selected value="">지역 선택</option>
        <c:forEach items="${Region.values()}" var="location">
            <option value="${location.regionNum}"> ${location.regionStr} </option>
        </c:forEach>
    </select>
        <select id="searchType" name="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="title_content">제목+내용</option>
            <option value="nickname">작성자</option>
        </select>
        <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요">
        <button id="searchBtn">검색</button>
    </form>
</div>
<section class="wrapper bg-light">
  <div class="container py-14 py-md-16">
   <div class="row gx-lg-8 gx-xl-12">
<div class="col-lg-12">
<div class="blog grid grid-view">
<div class="row isotope gx-md-8 gy-8 mb-8" style="display: flex; flex-wrap: wrap;">
  <c:forEach items="${list}" var="one" varStatus="loop">
     <div class="col-md-6 col-lg-4">
          <article class="item post">
            <div class="card">
              <figure class="card-img-top overlay overlay-1 hover-scale">
          <a href="../mate/${one.mateBoardId}">
            <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>">
            <span class="bg"></span>
          </a>
          <figcaption>
            <h5 class="from-top mb-0">Read More</h5>
          </figcaption>
        </figure>
        <div class="card-body">
          <div class="post-header">
            <div class="post-category text-line">
              <a href="#" class="hover" rel="category">${one.nickname}</a>
            </div>
            <h2 class="post-title h3 mt-1 mb-3">
              <a class="link-dark" href="../mate/${one.mateBoardId}">${one.title}</a>
            </h2>
          </div>
        </div>
      </div>
      <div class="card-footer">
                            <ul class="post-meta d-flex mb-0">
                              <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.startDate} </span></li>
                              <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.endDate}</span></li>
                              <li class="post-comments"><a href="#"><i class="uil uil-comment"></i>3</a></li>
                              <li class="post-likes ms-auto"><a href="#"><i class="uil uil-heart-alt"></i>3</a></li>
                            </ul>
                            <!-- /.post-meta -->
                          </div>
    </article>
  </div>
  </c:forEach>
</div>
</div>
</div>
<hr>
<nav class="d-flex" aria-label="pagination">
              <ul class="pagination">
               <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}"/>
               <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}"/>
                <li class="page-item disabled">
                  <button class="page-link pageBtn prevBtn" data-page="${pageDTO.firstPageNoOnPageList - 1}"><i class="uil uil-arrow-left"></i></button>
                </li>
                <c:forEach var="num" begin="${startPage}" end="${endPage}">
                <c:choose>
                <c:when test="${num == pageDTO.page}">
                <li class="page-item active">
                <button class="page-link pageBtn active" data-page="${num}">${num}</button>
                </li>
                </c:when>
                 <c:otherwise>
                <li class="page-item">
                <button class="page-link pageBtn" data-page="${num}">${num}</button>
                </li>
                </c:otherwise>
                </c:choose>
                </c:forEach>
                <c:choose>
                <c:when test="${pageDTO.pages > pageDTO.lastPageNoOnPageList}">
                <li class="page-item">
                    <button class="page-link pageBtn nextBtn" data-page="${pageDTO.lastPageNoOnPageList + 1}">
                      <i class="uil uil-arrow-right"></i>
                    </button>
                </li>
                </c:when>
                <c:otherwise>
                <li class="page-item disabled">
                <button class="page-link pageBtn nextBtn" data-page="${pageDTO.lastPageNoOnPageList + 1}">
                 <i class="uil uil-arrow-right"></i>
                </li>
                </c:otherwise>
                </c:choose>
              </ul>
    <!-- /.pagination -->
 </nav>
  </div>
 </div>
 </div>
</section>


