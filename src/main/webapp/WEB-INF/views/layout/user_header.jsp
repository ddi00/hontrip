<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="wrapper bg-soft-primary">
    <nav class="navbar navbar-expand-lg center-nav transparent position-absolute navbar-light">
        <div class="container flex-lg-row flex-nowrap align-items-center">
            <div class="navbar-brand w-100">
                <a href="<c:url value="/"/>">
                    <img src="<c:url value="/resources/assets/img/service_logo_black.png"/>" width="134" alt="혼여행로고"/>
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
                </div>
                <!-- /.offcanvas-body -->
            </div>
            <!-- /.navbar-collapse -->
            <div class="navbar-other w-100 d-flex ms-auto">
                <ul class="navbar-nav flex-row align-items-center ms-auto">
                    <li class="nav-item vertical-center">
                        <nav class="nav social social-muted justify-content-end text-end">
                            <c:if test="${empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
                                <a href="/hontrip/user/sign-in"><i class="uil uil-user-circle"><span class="kor-font-small">로그인</span></i></a>
                            </c:if>
                            <c:if test="${not empty sessionScope.id}"><!-- 세션에 ID값이 있는 경우, 로그아웃 링크 출력 -->
                            <a href="" class="vertical-center"><i class="uil uil-schedule"><span class="kor-font-small">계획</span></i></a><!-- 여행 계획쓰기 -->
                            <a href="" class="vertical-center"><i class="uil uil-edit-alt"><span class="kor-font-small">기록</span></i></a><!-- 여행 기록쓰기 -->
                            <a href="" class="vertical-center"><i class="uil uil-bell"><span class="kor-font-small">알림</span></i></a>    <!-- 알림! -->
                            <a href="/hontrip/user/logout" class="vertical-center"><i class="uil uil-sign-out-alt"><span class="kor-font-small">로그아웃</span></i></a>
                            </c:if>
                        </nav>
                        <!-- /.social -->
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
