<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
        if (session.getAttribute("id") != null) {
            long userId = (long) session.getAttribute("id");
            request.setAttribute("userId", userId);
        }
%>

        <script type="text/javascript" src="../resources/js/jquery-3.7.0.js" ></script>

        <section class="section-frame mx-xxl-11 overflow-hidden">
              <div class="wrapper image-wrapper bg-image bg-cover bg-overlay bg-overlay-light-500">
                <div class="container py-16 py-md-6">

                  <div class="map-wrapper d-flex">
                    <div id="map-container">
                      <div id="map"></div>
                      <a href="createpost" class="btn btn-circle btn-main btn-lg" style='top: 730%; left: 48%'><i class="uil uil-plus"></i></a>
                      <a href="feedlist" class="btn btn-circle btn-main btn-lg" style='top: 600%; left: 43.25%'><i class="uil uil-corner-up-right"></i></i></a>
                    </div>
                  </div>
                </div>
                <!-- /.container -->
              </div>
              <!-- /.wrapper -->
            </section>
            <!-- /section -->
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}"></script>
        <script>
            var mapContainer = document.getElementById('map'),

            mapOption = {
                center: new kakao.maps.LatLng(36.3504, 127.3845), // 지도의 중심 좌표
                level: 13 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

            <c:forEach items="${mymap}" var="locationDTO">
                var marker = new kakao.maps.Marker({ // 마커 생성
                    map: map,
                    position: new kakao.maps.LatLng(${locationDTO.lat}, ${locationDTO.lon}) // 마커 위치 설정
                });

                var infowindow = new kakao.maps.InfoWindow({
                content: '<div> ${locationDTO.city}</div>' // 인포윈도우 내용 설정
                });

                // 마커 클릭 이벤트 등록
                kakao.maps.event.addListener(marker, 'click',
                    function() {
                        // 초기화
                        $("#mylist_section").hide();
                        $("#list_mylocation_dropdown_result").hide();
                        $.ajax({
                            type: "GET",
                            url: "list_mylocation_click", // 요청할 URL
                            data: { locationId: ${locationDTO.id} }, // 마커의 locationId를 전달
                            dataType: "html",
                            success: function(response) {
                                $("#list_mylocation_click_result").html(response).show(); // 결과를 표시하도록 변경
                            },
                            error: function() {
                            // 에러 처리
                                console.log("AJAX 요청 실패");
                            }
                        });
                    });
                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
            </c:forEach>

            // 인포윈도우를 표시하는 클로저 생성 함수
            function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }

            // 인포윈도우를 닫는 클로저 생성 함수
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }
        </script>


        <!-- 버튼, 드롭박스 영역 -->
        <section class="buttons">
            <div class="card-body">
                <select id="locationDropdown">
                    <option value="" disabled selected>지역을 선택하세요</option>
                        <optgroup label="특별시/광역시">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 100 && locationDTO.id < 200}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="강원도">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 200 && locationDTO.id < 300}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="경기도">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 300 && locationDTO.id < 400}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="경상도">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 400 && locationDTO.id < 500}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="전라도">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 500 && locationDTO.id < 600}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="충청도">
                            <c:forEach items="${locationList}" var="locationDTO">
                                <c:choose>
                                    <c:when test="${locationDTO.id >= 600 && locationDTO.id < 700}">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </optgroup>
                </select>
            </div>

            <script>
                $(document).ready(function() {
                // 드롭다운 선택 이벤트 처리
                    $('#locationDropdown').change(function() {
                    // 초기화
                    $("#mylist_section").hide();
                    $("#list_mylocation_click_result").hide();
                    var selectedLocationId = $(this).val();
                        $.ajax({
                            type: 'GET',
                            url: "list_mylocation_dropdown",
                            data: { locationId: selectedLocationId },
                            success: function(response) {
                                $("#list_mylocation_dropdown_result").html(response).show();
                            },
                            error: function() {
                            // 오류 처리
                                alert('검색한 자료가 없습니다.');
                            }
                        });
                    });
                });
            </script>
        </section>


        <!-- 내 게시물 표시 부분 -->
        <div id="mylist_section">
            <section class="wrapper">
                <div class="container pt-12 pt-md-0 pb-16 pb-md-18">
                    <div class="grid grid-view projects-masonry mt-md-n20 mt-lg-n22 mb-20">
                        <div class="row g-8 g-lg-10 isotope">
                            <c:forEach items="${mylist}" var="postInfoDTO">
                                <div class="project item col-md-6 col-xl-4 workshop">
                                    <div class="card shadow-lg">
                                        <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                                            <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                                <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                                            </a>
                                        </figure>
                                        <div class="card-body">
                                            <div class="post-header">
                                                <div class="post-category text-line mb-2 text-aqua">${postInfoDTO.city}</div>
                                                <h3 class="mb-0">${postInfoDTO.title}</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="rePostList row g-8 g-lg-10 isotope">
                            <!-- 게시물 스크롤 영역 -->
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- 마커 클릭 시 해당 지역 게시물 표시 부분 -->
        <div id="list_mylocation_click_result" ></div>

        <!-- 드롭다운 선택 시 해당 지역 게시물 표시 부분 -->
        <div id="list_mylocation_dropdown_result" ></div>

    <script>
        let currentPage = 1;
        let isLoading = false;
        let totalPageCount = "${totalPageCount}";
        let userId = ${userId};

        $(window).on("scroll", function () {
            let scrollTop = $(window).scrollTop();
            let windowHeight = $(window).height();
            let documentHeight = $(document).height();
            let isBottom = scrollTop + windowHeight + 10 >= documentHeight;

            if (isBottom) {
                if (currentPage == totalPageCount || isLoading) {
                    return;
                }
                isLoading = true;
                currentPage++;
                getPostList(currentPage);
            }
        });

        // 무한 스크롤 항공편 리스트 반환 메소드
        const getPostList = function (currentPage) {
            let pageNum = currentPage;
            $.ajax({
                method: "get",
                url: "re-post-page",
                //contentType: "application/json; charset=UTF-8",
                data: {
                    pageNum: pageNum,
                    userId: userId
                },
                success: function (result) {
                    $(".rePostList").append(result);
                    isLoading = false;
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        }
    </script>


