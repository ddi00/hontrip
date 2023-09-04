<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 드롭다운 선택 시 해당 지역 게시물 리스트 -->
<div class="container">
   <section class="wrapper bg-light">
       <div class="container">
            <div class="row gy-6c">
                <div class="row isotope gx-md-8 gy-8 mb-8">
                    <c:forEach items="${mylist}" var="postInfoDTO">
                        <div class="col-md-6 col-lg-4">
                            <article class="item post">
                                <div class="card">
                                    <figure class="card-img-top overlay overlay-1 hover-scale">
                                        <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                            <div class="mate-list-image-container">
                                                <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt=""/>
                                            </div>
                                            <span class="bg"></span>
                                        </a>
                                        <figcaption>
                                            <h5 class="from-top mb-0">Read More</h5>
                                        </figcaption>
                                    </figure>
                                    <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                    <div class="card-body p-7">
                                        <div class="post-header">
                                            <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                                            <h3 class="txt_line mb-0">${postInfoDTO.title}</h3>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <ul class="post-meta d-flex mb-0">
                                            <li class="post-date"><i
                                                    class="uil uil-calendar-alt"></i><span>${postInfoDTO.startDate}~${postInfoDTO.endDate}</span>
                                            </li>
                                            <li class="post-likes ms-auto"><i
                                                    class="uil uil-heart-alt text-primary"></i>${postInfoDTO.likeCount}</li>
                                        </ul>
                                        <!-- /.post-meta -->
                                    </div>
                                    </a>
                                </div>
                            </article>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
   </section>
</div>