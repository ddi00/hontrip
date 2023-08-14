<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="wrapper bg-gray">
    <nav class="navbar navbar-expand-lg center-nav navbar-light navbar-bg-light">
        <div class="container flex-lg-row flex-nowrap align-items-center">
            <div class="navbar-brand w-100">
                <a href="<c:url value="/"/>">
                    <img src="<c:url value="/resources/assets/img/service_logo.png"/>" width="134" alt="혼여행로고"/>
                </a>
            </div>
            <div class="navbar-collapse offcanvas offcanvas-nav offcanvas-start">
                <div class="offcanvas-header d-lg-none">
                    <h3 class="text-white fs-30 mb-0">Sandbox</h3>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                </div>
                <div class="offcanvas-body ms-lg-auto d-flex flex-column h-100">
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link text-navy scroll active" href="#home">메뉴1</a></li>
                        <li class="nav-item"><a class="nav-link text-navy scroll active" href="#home">메뉴2</a></li>
                        <li class="nav-item"><a class="nav-link text-navy scroll active" href="#home">메뉴3</a></li>
                        <li class="nav-item"><a class="nav-link text-navy scroll active" href="#home">메뉴4</a></li>
                        <li class="nav-item"><a class="nav-link text-navy scroll active" href="#home">메뉴5</a></li>
                    </ul>
                    <!-- /.navbar-nav -->
                    <div class="offcanvas-footer d-lg-none">
                        <div>
                            <a href="mailto:first.last@email.com" class="link-inverse">info@email.com</a>
                            <br/> 00 (123) 456 78 90 <br/>
                            <nav class="nav social social-white mt-4">
                                <a href="#"><i class="uil uil-twitter"></i></a>
                                <a href="#"><i class="uil uil-facebook-f"></i></a>
                                <a href="#"><i class="uil uil-dribbble"></i></a>
                                <a href="#"><i class="uil uil-instagram"></i></a>
                                <a href="#"><i class="uil uil-youtube"></i></a>
                            </nav>
                            <!-- /.social -->
                        </div>
                    </div>
                    <!-- /.offcanvas-footer -->
                </div>
                <!-- /.offcanvas-body -->
            </div>
            <!-- /.navbar-collapse -->
            <div class="navbar-other w-100 d-flex ms-auto">
                <ul class="navbar-nav flex-row align-items-center ms-auto">
                    <li class="nav-item">
                        <nav class="nav social social-muted justify-content-end text-end">
                            <c:if test="${empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
                                <a href="/hontrip/user/sign-in"><i class="uil uil-user-circle"></i></a>
                            </c:if>
                            <c:if test="${not empty sessionScope.id}"><!-- 세션에 ID값이 있는 경우, 로그아웃 링크 출력 -->
                            <a href=""><i class="uil uil-edit-alt"></i></a><!-- 여행 기록쓰기 -->
                            <a href=""><i class="uil uil-bell"></i></a>    <!-- 알림! -->
                            <a href="/hontrip/user/logout"><i class="uil uil-sign-out-alt"></i></a>
                            </c:if>
                        </nav>
                        <!-- /.social -->
                    </li>
                    <li class="nav-item d-lg-none">
                        <button class="hamburger offcanvas-nav-btn"><span></span></button>
                    </li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-other -->
        </div>
        <!-- /.container -->
    </nav>
    <!-- /.navbar -->
</header>
