<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg center-nav navbar-light navbar-bg-light">
  <div class="container flex-lg-row flex-nowrap align-items-center">
    <div class="navbar-brand w-100">
      <a href="<c:url value="/"/>">
        <img src="<c:url value="/resources/img/common/logo.png"/>" width="134" alt="혼여행로고"/>
      </a>
    </div>
    <div class="navbar-collapse offcanvas offcanvas-nav offcanvas-start">
      <div class="offcanvas-body ms-lg-auto d-flex flex-column h-100">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="/hontrip/plan/list">계획</a></li>
          <li class="nav-item"><a class="nav-link" href="/hontrip/record/mylist">기록</a></li>
          <li class="nav-item"><a class="nav-link" href="/hontrip/mate/bbs_list">동행인</a></li>
        </ul>
        <!-- /.navbar-nav -->
      </div>
      <!-- /.offcanvas-body -->
    </div>
    <!-- /.navbar-collapse -->
    <div class="navbar-other w-100 d-flex ms-auto">
      <ul class="navbar-nav flex-row align-items-center ms-auto">
        <c:if test="${not empty sessionScope.id}">
          <a class="nav-link d-flex" onclick="clickAlarm()"><span
                  id="alarmBell"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                      class="bi bi-bell" viewBox="0 0 16 16">
                                <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
                            </svg></span></a> <!--동행신청 알림-->
        </c:if>
        <li class="nav-item dropdown language-select">
          <c:if test="${empty sessionScope.id}"> <!-- 세션에 ID값이 없는 경우, 로그인 링크 출력 -->
            <a href="/hontrip/user/sign-in" class="vertical-center"><i class="uil uil-user-circle"><span
                    class="kor-font main-color">로그인</span></i></a>
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