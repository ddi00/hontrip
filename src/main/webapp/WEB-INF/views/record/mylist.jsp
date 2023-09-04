<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
        if (session.getAttribute("id") != null) {
            long userId = (long) session.getAttribute("id");
            request.setAttribute("userId", userId);
        }
%>
        <script type="text/javascript" src="../resources/js/jquery-3.7.0.js" ></script>

        <section class="wrapper bg-light">
            <div class="container pt-11 pt-md-13 pb-10 pb-md-0 pb-lg-5 text-center">
                <div class="row">
                    <div class="col-lg-8 col-xl-7 col-xxl-6 mx-auto" data-cues="slideInDown" data-group="page-title">
                        <h1 class="display-1">나의<span class="underline-3 style-3 primary"> 여행기록</span></h1>
                    </div>
                    <!-- /column -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->

        <section class="section-frame mx-xxl-11 overflow-hidden">
              <div class="wrapper image-wrapper bg-image bg-cover bg-overlay bg-overlay-light-500">
                <div class="container py-16 py-md-12">
                  <div class="map-wrapper d-flex">
                    <div id="map-container">
                      <div id="map"></div>
                      <a href="createpost" class="btn btn-circle btn-primary btn-lg" data-bs-toggle="tooltip" data-bs-placement="right" title="마커 생성하기" style='top: 730%; left: 47.87%'><i class="uil uil-plus"></i></a>
                      <a href="feedlist" class="btn btn-circle btn-primary btn-lg" data-bs-toggle="tooltip" data-bs-placement="right" title="공유 피드가기" style='top: 600%; left: 43.21%'><i class="uil uil-corner-up-right"></i></a>
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
            map.setMaxLevel(13);
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
                                $(".list_mylocation").html(response).show(); // 결과를 표시하도록 변경
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

        <style>
             .project.item.col-md-6.col-xl-4.workshop .card-img-top {
                 width: 100%;
                 padding-bottom: 55%; /* 1:1 비율을 위해 높이를 너비와 동일하게 설정합니다. */
                 position: relative;
                 overflow: hidden; /* 이미지가 넘치지 않도록 설정합니다. */
             }

             .project.item.col-md-6.col-xl-4.workshop .card-img-top img {
                 position: absolute;
                 width: 100%;
                 height: 100%;
                 object-fit: cover; /* 이미지가 박스에 맞게 잘리지 않고 채워지도록 설정합니다. */
             }
            .txt_line {
                  width:320px;
                  padding:0 5px;
                  overflow:hidden;
                  text-overflow:ellipsis;
                  white-space:nowrap;
              }
        </style>

       <div class="list_mylocation container">
           <section class="wrapper bg-light">
               <div class="container">
                   <div class="row gy-6">
                       <div class="row isotope gx-md-8 gy-8 mb-0">
                           <c:forEach items="${mylist}" var="postInfoDTO">
                               <div class="col-md-6 col-lg-4">
                                   <article class="item post">
                                       <div class="card">
                                           <figure class="card-img-top overlay overlay-1 hover-scale">
                                               <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                                   <div class="mate-list-image-container">
                                                       <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt=""/>
                                                   </div>
                                                   <span class="bg"></span>
                                               </a>
                                               <figcaption>
                                                   <h5 class="from-top mb-0">Read More</h5>
                                               </figcaption>
                                           </figure>
                                           <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                           <div class="card-body p-7">
                                               <div class="post-header">
                                                   <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                                                   <div class="post-category mb-2 text-end">${postInfoDTO.nickName}</div>
                                                   <h3 class="txt_line mb-0">${postInfoDTO.title}</h3>
                                               </div>
                                           </div>
                                           <div class="card-footer">
                                               <ul class="post-meta d-flex mb-0">
                                                   <li class="post-date"><i
                                                           class="uil uil-calendar-alt"></i><span>${postInfoDTO.startDate}~${postInfoDTO.endDate}</span>
                                                   </li>
                                                   <li class="post-likes ms-auto"><i
                                                           class="uil uil-heart-alt text-primary"></i>${postInfoDTO.likeCount}</li>
                                               </ul>
                                               <!-- /.post-meta -->
                                           </div>
                                           </a>
                                       </div>
                                   </article>
                               </div>
                           </c:forEach>
                       </div>
                       <div class="rePostList">

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

        // 무한 스크롤 리스트 반환 메소드
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


