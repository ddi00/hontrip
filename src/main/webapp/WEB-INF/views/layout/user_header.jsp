<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="myMateAlarmModal" class="mateAlarmModal">
    <div class="mateAlarmModal-content">
        <span style="text-align: center; font-weight: bold; display: inline-block; width: 95%; font-size:15px; margin-top: 8px; margin-bottom: 10px;">알람</span><span
            class="mateAlarmListClose">&times;</span>
        <ul id="notificationList" class="mateAlarmUl">
        </ul>
    </div>
</div>

<div id="myMateRealTimeAlarmModal" class="mateRealTimeAlarmModal">
    <div class="mateRealTimeAlarmModal-content">
        <span id="mateRealTimeAlarmContent">
        </span>
        <span class="mateAlarmListClose">x</span>
    </div>
</div>


<header class="wrapper bg-soft-primary">
    <nav class="navbar navbar-expand-lg center-nav transparent position-absolute navbar-light">
        <div class="container flex-lg-row flex-nowrap align-items-center">
            <div class="navbar-brand w-100">
                <a href="<c:url value="/"/>">
                    <img src="<c:url value="/resources/img/common/logo.png"/>" width="134" alt="혼여행로고"/>
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
                        <li class="nav-item"><a class="nav-link" href="/hontrip/plan/list">계획</a></li>
                        <li class="nav-item"><a class="nav-link" href="/hontrip/record/mylist">기록</a></li>
                        <li class="nav-item"><a class="nav-link" href="/hontrip/mate/bbs_list">동행인</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">메뉴1</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">메뉴1</a></li>
                    </ul>
                    <!-- /.navbar-nav -->
                </div>
                <!-- /.offcanvas-body -->
            </div>
            <!-- /.navbar-collapse -->
            <div class="navbar-other w-100 d-flex ms-auto">
                <ul class="navbar-nav flex-row align-items-center ms-auto">
                    <c:if test="${not empty sessionScope.id}">
                        <a class="nav-link d-flex" onclick="clickAlarm()">알람</a> <!--동행신청 알림-->
                    </c:if>
                    <li class="nav-item dropdown language-select">
                        <c:if test="${empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
                            <a href="/hontrip/user/sign-in" class="vertical-center"><i class="uil uil-user-circle"><span
                                    class="kor-font-small">로그인</span></i></a>
                        </c:if>
                        <c:if test="${not empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
                            <a class="nav-link dropdown-item dropdown-toggle d-flex" href="#" role="button"
                               data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img class="avatar w-7" src="<c:url value="${sessionScope.profileImage}"/>"
                                     alt="${sessionScope.nickName}의 프로필"/>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="dropdown-item" href="/hontrip/user/my-page"><i
                                        class="uil uil-user"><span class="kor-font-small">회원정보</span></i></a></li>
                                <li class="nav-item"><a class="dropdown-item" href="#"><i class="uil uil-schedule"><span
                                        class="kor-font-small">계획</span></i></a></li>
                                <li class="nav-item"><a class="dropdown-item" href="/hontrip/record/createpost"><i
                                        class="uil uil-edit-alt"><span class="kor-font-small">기록</span></i></a></li>
                                <li class="nav-item"><a class="dropdown-item" href="/hontrip/mate/insert"><i
                                        class="uil uil-users-alt"><span class="kor-font-small">동행인모집</span></i></a></li>
                                <li class="nav-item"><a class="dropdown-item" href="/hontrip/user/logout"><i
                                        class="uil uil-sign-out-alt"><span class="kor-font-small">로그아웃</span></i></a>
                                </li>
                            </ul>
                        </c:if>
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
