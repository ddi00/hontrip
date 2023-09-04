<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 공유피드 버튼 선택 시 해당 지역 게시물  리스트 -->
<div id="feedlist_button_like_section">
    <section class="wrapper-record">
        <div class="container pt-12 pt-md-0 pb-16 pb-md-18">
            <div class="grid grid-view projects-masonry mt-md-n20 mt-lg-n22 mb-20">
                <div class="row g-8 g-lg-10 isotope">
                    <c:forEach items="${feedlist_like}" var="postInfoDTO">
                        <div class="project item col-md-6 col-xl-4 workshop">
                            <div class="card shadow-lg">
                                <figure class="card-img-top">
                                    <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                        <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                                    </a>
                                </figure>
                                <div class="card-body p-7">
                                    <div class="post-header">
                                        <div class="text-primary mb-3">${postInfoDTO.city}</div>
                                        <h3 class="txt_line mb-0">${postInfoDTO.title}</h3>
                                    </div>
                                </div>
                                 <div class="card-footer">
                                  <ul class="post-meta d-flex mb-0">
                                    <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${postInfoDTO.startDate}~${postInfoDTO.endDate}</span></li>
                                    <li class="post-likes ms-auto"><i class="uil uil-heart-alt"></i>${postInfoDTO.likeCount}</li>
                                  </ul>
                                  <!-- /.post-meta -->
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</div>
