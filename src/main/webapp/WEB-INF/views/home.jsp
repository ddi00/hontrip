<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<section class="wrapper bg-light">
    <div class="container pt-10 pt-md-12 pb-14 pb-md-8 text-center">
        <div class="row gx-lg-8 gx-xl-12 gy-10 gy-xl-0 mb-14 align-items-center">
            <div class="col-md-10 offset-md-1 offset-lg-0 col-lg-5 text-center text-lg-start">
                <h1 class="display-1 fs-54 mb-5 mx-md-n5 mx-lg-0 mt-7">계획하고, <br>기록하고, <br>
                    <span class="rotator-fade main-color">함께하는 여행</span></h1>
                <p class="lead fs-lg mb-7 ">지금부터 'HonTrip'을 통해 여행을 계획하고 / 기록하고 / 함께해보세요!</p>
                <span><a class="btn btn-lg btn-primary
                 rounded-pill me-2" href="/hontrip/user/sign-in">가입하고 글쓰기!</a></span>
            </div>
            <div class="col-lg-7 order-lg-2">
                <div class="swiper-container dots-over" data-margin="5" data-dots="true" data-nav="true"
                     data-autoheight="true" data-autoplay="true" data-autoplaytime="4000">
                    <div class="swiper">
                        <div class="swiper-wrapper ">
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인1.jpg"/>" alt=""/>
                            </div>
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인2.jpg"/>" alt=""/>
                            </div>
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인3.jpg"/>" alt=""/>
                            </div>
                            <!--/.swiper-wrapper -->
                        </div>
                    </div>
                    <!-- /.swiper -->
                </div>
                <!-- /.swiper-container -->
            </div>
        </div>
    </div>
    <div class="overflow-hidden">
        <div class="text-soft-primary mx-n2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100">
                <path fill="rgba(255,90,70,0.1)"
                      d="M1260,1.65c-60-5.07-119.82,2.47-179.83,10.13s-120,11.48-180,9.57-120-7.66-180-6.42c-60,1.63-120,11.21-180,16a1129.52,1129.52,0,0,1-180,0c-60-4.78-120-14.36-180-19.14S60,7,30,7H0v93H1440V30.89C1380.07,23.2,1319.93,6.15,1260,1.65Z"></path>
            </svg>
        </div>
    </div>
</section>

<style>
    .swiper-slide img {
        width: 100%;
        height: 100%;
        object-fit: fill;
        aspect-ratio: 4/3; /* 가로 세로 비율을 1:1로 설정합니다. */
        border-radius: 10px;
    }

    .txt_line {
        width: 210px;
        padding: 0 5px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
</style>
<section class="wrapper bg-main-light">
    <div class="container pt-10 pt-lg-8 pb-5 pb-md-15">
        <section id="snippet-1" class="wrapper-border">
            <h6 class="display-1 text-center top-ten"><span class="underline-3 style-3 primary">요즘 뜨는</span> 여행 기록</h6>
            <div class="container">
                <div class="swiper-container clients" data-margin="30" data-dots="false" data-loop="true"
                     data-autoplay="true" data-autoplaytime="1" data-drag="false" data-speed="6000" data-items-xxl="4"
                     data-items-xl="3" data-items-lg="5" data-items-md="2" data-items-xs="1">
                    <div class="swiper">
                        <div class="swiper-wrapper ticker">
                            <c:forEach items="${topList}" var="postInfoDTO">
                                <div class="swiper-slide">
                                    <div class="project item">
                                        <div class="card shadow-lg">
                                            <figure class="card-img-top">
                                            <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                                <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt=""/>
                                            </a>
                                            </figure>
                                            <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                                <div class="card-body">
                                                    <div class="post-header">
                                                        <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                                                        <h5 class="txt_line mb-0">${postInfoDTO.title}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!--/.swiper-wrapper -->
                    </div>
                    <!-- /.swiper -->
                </div>
                <!-- /.swiper-container -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->
    </div>

    <section class="wrapper">
        <div class="container pt-10 pt-lg-8 pb-5 pb-md-15">
            <section id="snippet-2" class="wrapper-border">
                <h6 class="display-1 text-center top-ten"><span class="underline-3 style-3 primary">요즘 뜨는</span> 여행 동행
                </h6>
                <div class="container">
                    <div class="swiper-container clients" data-margin="30" data-dots="false" data-loop="true"
                         data-autoplay="true" data-autoplaytime="1" data-drag="false" data-speed="6000"
                         data-items-xxl="4" data-items-xl="3" data-items-lg="5" data-items-md="2" data-items-xs="1">
                        <div class="swiper">
                            <div class="swiper-wrapper ticker">
                                <c:forEach items="${mateTopList}" var="one">
                                    <div class="swiper-slide">
                                        <div class="project item">
                                            <div class="card shadow-lg">
                                                <figure class="card-img-top"
                                                <a href="/hontrip/mate/${one.mateBoardId}">
                                                    <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>"
                                                         alt="Image">
                                                </a>
                                                </figure>
                                                <a href="/hontrip/mate/${one.mateBoardId}">
                                                    <div class="card-body">
                                                        <div class="post-header">
                                                            <c:forEach items="${Region.values()}" var="Region">
                                                                <c:if test="${Region.regionNum == Integer.parseInt(one.regionId)}">
                                                                    <div class="post-category mb-2 text-primary">${Region.regionStr}</div>
                                                                </c:if>
                                                            </c:forEach>
                                                            <h5 class="txt_line mb-0">${one.title}</h5>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!--/.swiper-wrapper -->
                        </div>
                        <!-- /.swiper -->
                    </div>
                    <!-- /.swiper-container -->
                </div>
                <!-- /.container -->
            </section>
            <!-- /section -->
        </div>
    </section>

    <section class="wrapper">
        <div class="container pt-10 pt-lg-8 pb-5 pb-md-15">
            <section id="snippet-3" class="wrapper-border">
                <div class="container">
                    <h6 class="display-1 text-center top-ten"><span class="underline-3 style-3 primary">요즘 뜨는</span> 여행지
                    </h6>
                    <div class="row-cols-6 text-end mb-2">
                    <button type="button" class="btn btn-primary"><a href="plan/spot/search" class="text-white">여행지 검색
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="none"><path d="M24 0v24H0V0h24ZM12.593 23.258l-.011.002l-.071.035l-.02.004l-.014-.004l-.071-.035c-.01-.004-.019-.001-.024.005l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427c-.002-.01-.009-.017-.017-.018Zm.265-.113l-.013.002l-.185.093l-.01.01l-.003.011l.018.43l.005.012l.008.007l.201.093c.012.004.023 0 .029-.008l.004-.014l-.034-.614c-.003-.012-.01-.02-.02-.022Zm-.715.002a.023.023 0 0 0-.027.006l-.006.014l-.034.614c0 .012.007.02.017.024l.015-.002l.201-.093l.01-.008l.004-.011l.017-.43l-.003-.012l-.01-.01l-.184-.092Z"/><path fill="white" d="M9.5 2a2.5 2.5 0 0 1 2.495 2.336L12 4.5v4.605l5.442.605a4 4 0 0 1 3.553 3.772l.005.203V14a8 8 0 0 1-7.75 7.996L13 22h-.674a8 8 0 0 1-7.024-4.171l-.131-.251l-2.842-5.684c-.36-.72-.093-1.683.747-2.028c1.043-.427 2.034-.507 3.055.012c.222.113.44.252.654.414l.215.17V4.5A2.5 2.5 0 0 1 9.5 2Zm0 2a.5.5 0 0 0-.492.41L9 4.5V13a1 1 0 0 1-1.78.625l-.332-.407l-.303-.354c-.58-.657-1.001-1.02-1.36-1.203a1.192 1.192 0 0 0-.694-.137l-.141.02l2.57 5.14a6 6 0 0 0 5.123 3.311l.243.005H13a6 6 0 0 0 5.996-5.775L19 14v-.315a2 2 0 0 0-1.621-1.964l-.158-.024l-5.442-.604a2 2 0 0 1-1.773-1.829L10 9.105V4.5a.5.5 0 0 0-.5-.5ZM4 6a1 1 0 0 1 0 2H3a1 1 0 0 1 0-2h1Zm12-1a1 1 0 0 1 .117 1.993L16 7h-1a1 1 0 0 1-.117-1.993L15 5h1ZM4.707 1.293l1 1a1 1 0 0 1-1.414 1.414l-1-1a1 1 0 0 1 1.414-1.414Zm11 0a1 1 0 0 1 0 1.414l-1 1a1 1 0 1 1-1.414-1.414l1-1a1 1 0 0 1 1.414 0Z"/></g></svg>
                        </a>
                    </button>
                    </div>
                    <div class="swiper-container clients" data-margin="30" data-dots="false" data-loop="true"
                         data-autoplay="true" data-autoplaytime="1" data-drag="false" data-speed="6000"
                         data-items-xxl="4" data-items-xl="3" data-items-lg="5" data-items-md="2" data-items-xs="1">
                        <div class="swiper">
                            <div class="swiper-wrapper ticker">
                                <c:forEach items="${topSpotList}" var="spot">
                                    <div class="swiper-slide">
                                        <div class="project item">
                                            <div class="card shadow-lg">
                                                <figure class="card-img-top">
<%--                                                    <a href="/hontrip/plan/spot/detail?category=keyword&keyword=${spot.title}&contentId=${spot.spotContentId}">--%>
                                                    <a>
                                                        <img src="${spot.image}">
                                                    </a>
                                                </figure>
                                                <div class="card-body">
                                                    <div class="post-header">
                                                        <div class="post-category mb-2 text-primary">${spot.area}</div>
                                                        <h4 class="txt_line mb-0">${spot.title}</h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!--/.swiper-wrapper -->
                        </div>
                        <!-- /.swiper -->
                    </div>
                    <!-- /.swiper-container -->
                </div>
                <!-- /.container -->
            </section>
            <!-- /section -->
        </div>
    </section>
</section>
<section class="wrapper bg-main-light">
    <div class="overflow-hidden">
        <div class="divider text-light mx-n2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100">
                <path fill="white"
                      d="M1260,1.65c-60-5.07-119.82,2.47-179.83,10.13s-120,11.48-180,9.57-120-7.66-180-6.42c-60,1.63-120,11.21-180,16a1129.52,1129.52,0,0,1-180,0c-60-4.78-120-14.36-180-19.14S60,7,30,7H0v93H1440V30.89C1380.07,23.2,1319.93,6.15,1260,1.65Z"></path>
            </svg>
        </div>
    </div>
</section>