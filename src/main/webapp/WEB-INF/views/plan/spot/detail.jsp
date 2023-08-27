<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container mt-15 mb-20">
        <div class="row d-flex justify-content-center">
            <p class="invisible">${spot.id}</p>
            <p class="invisible">${spot.contentId}</p>
            <p class="invisible">${spot.contentTypeId}</p>
            <div class="col-lg-6">
                <img src="${spot.image}" alt="대표 이미지" width="550" height="450">
            </div>
            <div class="card col-lg-6 p-4">
                <div class="card-body align-items-center justify-content-between">
                    <div class="post-header mb-5">
                        <h2 class="post-title display-5">${spot.title}</h2>
                    </div>
                    <h5>${spot.address}</h5>
                    <p class="mb-6">${spot.overview}</p> <br>
                    <br>
                    <%--                    추가 연결 필요   --%>
                    <button id="add-to-plan" type="button" class="btn btn-custom2 text-white">추가</button>
                    <button id="go-to-list" type="button" class="btn btn-custom1 text-white ms-1">목록</button>
                </div>
            </div>
        </div>
        <ul class="custom-nav custom-nav-tabs custom-nav-tabs-basic mt-12" role="tablist">
            <li class="custom-nav-item" role="presentation">
                <a class="custom-nav-link active" data-bs-toggle="tab" href="#tab1-1" aria-selected="true" role="tab">기본
                    정보</a>
            </li>
            <li class="custom-nav-item" role="presentation">
                <a class="custom-nav-link" data-bs-toggle="tab" href="#tab1-2" aria-selected="false" tabindex="-1"
                   role="tab">상세
                    정보</a>
            </li>
        </ul>
        <div class="tab-content mt-0 mt-md-5">
            <div class="tab-pane fade show active" id="tab1-1" role="tabpanel">
                <table class="table">
                    <tbody>
                    <tr>
                        <th scope="row">전화번호</th>
                        <td>${spot.tel}</td>
                    </tr>
                    <tr>
                        <th scope="row">홈페이지</th>
                        <td>${spot.homepage}</td>
                    </tr>
                    <tr>
                        <th scope="row">이용 시간</th>
                        <td>${spot.usetime}</td>
                    </tr>
                    <tr>
                        <th scope="row">휴일</th>
                        <td>${spot.restDate}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--/.tab-pane -->
            <div class="tab-pane fade" id="tab1-2" role="tabpanel">
                <table class="table">
                    <tbody>
                    <tr>
                        <th scope="row">문의 및 안내</th>
                        <td>${spot.infoCenter}</td>
                    </tr>
                    <tr>
                        <th scope="row">체험 안내</th>
                        <td>${spot.expguide}</td>
                    </tr>
                    <tr>
                        <th scope="row">주차 시설</th>
                        <td>${spot.parking}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--/.tab-pane -->
        </div>
    </div>
</section>
<script>
    $("#go-to-list").click(function () {
        location.href="${path}/plan/spot/search?category=${category}&keyword=${keyword}";
    })

    <%--$(document).ready(function () {--%>
    <%--    $("#go-to-list").click(function () {--%>
    <%--        $.ajax({--%>
    <%--            type: "post",--%>
    <%--            url: "search",--%>
    <%--            contentType: "application/json; charset=UTF-8",--%>
    <%--            dataType: "html",--%>
    <%--            data: {--%>
    <%--                category: "${category}",--%>
    <%--                keyword: "${keyword}"--%>
    <%--            },--%>
    <%--            success: function (result) {--%>
    <%--                $("#flight-list").html(result);--%>
    <%--                $(".spinner-border").hide();--%>
    <%--                isLoading = false;--%>
    <%--            },--%>
    <%--            error: function () {--%>
    <%--                alert("오류가 발생했습니다.");--%>
    <%--            } // error--%>
    <%--        }) //ajax--%>
    <%--    }) // click--%>
    <%--}); // document--%>

    // $.post("/plan/spot/search", {id: '67', name: 'Deepak'}, function (data) {
    //     alert(data.id); // display id value which is returned from the action method
    //     alert(data.name);//display name value which is returned from the action method
    // });

</script>
</body>
</html>
