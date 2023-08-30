<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
  <div class="container pt-12 pt-md-14 pb-14 pb-md-16">
    <div class="row">
      <div class="col-lg-9 col-xl-8 mx-auto">
        <figure class="mb-10">
          <img class="img-fluid" src="<c:url value="/resources/assets/img/illustrations/404.png"/>" alt="404에러">
        </figure>
      </div>
      <div class="col-lg-8 col-xl-7 col-xxl-6 mx-auto text-center">
        <h1 class="mb-3 kor-font">찾을 수 없는 페이지입니다.</h1>
        <p class="lead mb-7 px-md-12 px-lg-5 px-xl-7">
          요청하신 "${requestedPath}"페이지는 사용할 수 없거나 이동되었습니다.
          다른 페이지를 시도하거나 아래 버튼을 이용해 홈으로 이동해주세요.
        </p>
        <a href="/hontrip/" class="btn btn-main rounded-pill">홈으로</a>
      </div>
    </div>
  </div>
</section>