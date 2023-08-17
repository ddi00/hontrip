<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper image-wrapper bg-image bg-overlay bg-overlay-light-600 text-white"
		 data-image-src="<c:url value='/resources/assets/img/photos/datachef_gradation.png'/>"
		 style="background-image: url('<c:url value='/resources/assets/img/photos/datachef_gradation.png'/>');">
	<div class="container pt-17 pb-20 pt-md-19 pb-md-21 text-center">
		<div class="row">
			<div class="col-lg-8 mx-auto">
				<h1 class="kor-font display-1 mb-3">회원 로그인</h1>
				<nav class="d-inline-block" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="kor-font breadcrumb-item active" aria-current="page">로그인</li>
					</ol>
				</nav>
				<!-- /nav -->
			</div>
			<!-- /column -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
</section>
<!-- /section -->
<section class="wrapper bg-light">
	<div class="container pb-14 pb-md-16">
		<div class="row">
			<div class="col-lg-7 col-xl-6 col-xxl-5 mx-auto mt-n20">
				<div class="card">
					<div class="card-body p-11 text-center">
						<h2 class="kor-font mb-3 text-start">안녕하세요 HonTrip입니다.</h2>
						<p class="kor-font-small mb-6 text-start">소셜 인증으로 회원가입/로그인할 수 있습니다. </p>
						<c:forEach items="${urls}" var="loginUrl">
							<div class="social-login-area">
								<a href="${loginUrl.loginHref}">
									<img src="<c:url value='${loginUrl.imgSrc}'/>" alt="${loginUrl.provider} 로그인">
								</a>
							</div>
						</c:forEach>
						<div class="kor-font divider-icon my-4">주의사항</div>
						<p class="kor-font-small mb-6 text-start "><span class="color-red">이메일, 성별, 연령대에 동의</span>해주셔야 서비스를 올바르게 사용할 수 있습니다.</p>
						<!--/.social -->
					</div>
					<!--/.card-body -->
				</div>
				<!--/.card -->
			</div>
			<!-- /column -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
</section>
<!-- /section -->