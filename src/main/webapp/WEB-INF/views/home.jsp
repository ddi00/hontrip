<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container pt-10 pt-md-14 pb-14 pb-md-16 text-center">
        <div class="row gx-lg-8 gx-xl-12 gy-10 gy-xl-0 mb-14 align-items-center">
            <div class="col-md-10 offset-md-1 offset-lg-0 col-lg-5 text-center text-lg-start">
                <h1 class="display-1 fs-54 mb-5 mx-md-n5 mx-lg-0 mt-7">계획하고, <br>기록하고, <br>
                    <span class="rotator-fade main-color">함께하는 여행</span></h1>
                <p class="lead fs-lg mb-7 ">지금부터 'HonTrip'을 통해 여행을 계획하고 / 기록하고 / 함께해보세요!</p>
                <span><a class="btn btn-lg btn-main rounded-pill me-2" href="/hontrip/user/sign-in">가입하고 글쓰기!</a></span>
            </div>
            <div class="col-lg-7 order-lg-2">
                <div class="swiper-container dots-over main-slide" data-margin="5" data-dots="true" data-nav="true" data-autoheight="true" data-autoplay="true" data-autoplaytime="4000">
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

    <div>
        나중에 여기에 조회수 순으로 기록이 들어옴
    </div>
    <div>
        나중에 여기에 즐겨찾기 순으로 여행지가 들어옴
    </div>
</section>