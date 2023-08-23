<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container py-14 py-md-16">
        <div class="row gx-lg-8 gx-xl-12">
            <div class="col-lg-8 order-lg-2">
                <div class="blog single">
                    <div class="card">
                        블로그 내용
                        ${userInfo}
                    </div>
                </div>
            </div>
            <aside class="col-lg-4 sidebar mt-11 mt-lg-6">
                <div class="widget">
                    <form class="search-form">
                        <div class="form-floating mb-0">
                            <input id="search-form" type="text" class="form-control" placeholder="Search">
                            <label for="search-form">Search</label>
                        </div>
                    </form>
                    <!-- /.search-form -->
                </div>
                <div class="widget">
                    <h4 class="widget-title mb-3">Categories</h4>
                    <ul class="unordered-list bullet-primary text-reset">
                        <li><a href="#">회원 정보</a></li>
                        <li><a href="#">회원관련 정보1</a></li>
                        <li><a href="#">회원관련 정보2</a></li>
                        <li><a href="#">회원관련 정보3</a></li>
                        <li><a href="#">회원관련 정보4</a></li>
                        <li><a href="#">회원관련 정보5</a></li>
                    </ul>
                </div>
                <!-- /.widget -->
                왼쪽 슬라이드
            </aside>
        </div>
    </div>
</section>