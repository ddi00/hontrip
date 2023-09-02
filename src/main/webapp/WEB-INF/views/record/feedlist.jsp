<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>feedlist</title>
    </head>
    <body>
        <!-- 피드 헤더 영역 -->
        <section class="feed-header" "form-select" style="border: 1px solid rgba(8, 60, 130, 0.2);">
               <section class="wrapper bg-light">
                 <div class="container pt-10 pt-md-14 text-center">
                   <div class="row">
                     <div class="col-md-8 col-lg-7 col-xl-6 col-xxl-5 mx-auto">
                       <h1 class="display-1 mb-3">공유피드</h1>
                       <p class="lead fs-lg px-lg-10 px-xxl-8">당신의 여행을 공유하세요(가내용) <br> 내용쓰는 공간(안써도됨)</p>
                     </div>
                     <!-- /column -->
                   </div>
                   <!-- /.row -->
                 </div>
                 <!-- /.container -->
               </section>
               <!-- /section -->

        <!-- 버튼 영역 -->
            <section class="wrapper bg-light">
              <div class="container">
                <div class="row-record-buttons">
                  <div class="col-lg-9-record-location-buttons col-xl-8 col-xxl-7 mx-auto">
                    <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="allLocations">전국</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="capital-area">수도권</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="gangwon">강원</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="gyeongsang">경상</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="jeolla">전라</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="chungcheong">충청</button>
                                   <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="jeju">제주</button>
                  </div>
                </div>
              </div>
             </section>

             <section class="wrapper bg-light">
               <div class="container">
                 <div class="row">
                   <div class="col-lg-9-record-like-button col-xl-8 col-xxl-7 mx-auto">
                    <button class="btn btn-lg btn-primary rounded-pill me-2 like-button" like="like">좋아요 순</button>
                   </div>
                 </div>
               </div>
              </section>




        <!-- 지역 버튼 선택 시 이벤트 처리 -->
        <script>
            $(document).ready(function() {
                $('.location-button').click(function() {
                    // 초기화
                    $("#feedlist_section").hide();
                    $("#feedlist_button_like_section_result").hide();

                    var selectedLocationId = $(this).data('location');
                    var locationIdPattern = getPattern(selectedLocationId);
                    var locationIdSpecialId = getSpecialId(selectedLocationId);
                    var locationIdSpecialId2 = getSpecialId2(selectedLocationId);
                    var locationIdSpecialId3 = getSpecialId3(selectedLocationId);


                    // 서버로 AJAX 요청 보내기
                    $.ajax({
                        type: 'GET',
                        url: "feedlist_dropdown",
                        data: {
                            locationIdPattern: locationIdPattern,
                            locationIdSpecialId: locationIdSpecialId,
                            locationIdSpecialId2: locationIdSpecialId2,
                            locationIdSpecialId3: locationIdSpecialId3
                        },  // 선택한 값 전달
                        success: function(response) {
                            $("#feedlist_dropdown_section_result").html(response).show();
                        },
                        error: function() {
                            alert('검색한 자료가 없습니다.');
                        }
                    });
                });
            });

            // 버튼 권역 구분
            function getPattern(selectedOption) {
                switch (selectedOption) {
                    case "allLocations":
                        return ""; // 전체 범위 설정
                    case "capital-area":
                        return "3%"; // 수도권 지역 범위 설정
                    case "gangwon":
                        return "2%"; // 강원 지역 범위 설정
                    case "gyeongsang":
                        return "4%"; // 경상 지역 범위 설정
                    case "jeolla":
                        return "5%"; // 전라 지역 범위 설정
                    case "chungcheong":
                    return "6%"; // 충청 지역 범위 설정
                    case "jeju":
                    return "9%"; // 제주지역(비여져있음 안되서 임의로 넣음)
                    default:
                        return ""; // 기본 값
                }
            }

            // 버튼 권역구분 - 광역시 포함하는 작업1
            function getSpecialId(selectedOption) {
                switch (selectedOption) {
                    case "capital-area":
                        return "101";
                    case "gyeongsang":
                        return "102";
                    case "jeolla":
                        return "104";
                    case "jeju":
                        return "103";
                   case "chungcheong":
                        return "106";
                    default:
                        return "";
                }
            }

            // 버튼 권역구분 - 광역시 포함하는 작업2
            function getSpecialId2(selectedOption) {
                switch (selectedOption) {
                    case "gyeongsang":
                        return "105";
                    case "capital-area":
                        return "109";
                   case "chungcheong":
                        return "107";
                    default:
                        return "";
                }
            }

            // 버튼 권역구분 - 광역시 포함하는 작업3
            function getSpecialId3(selectedOption) {
                switch (selectedOption) {
                    case "gyeongsang":
                        return "108";
                    default:
                        return "";
                }
            }
        </script>

        <!-- 좋아요 버튼 선택 시 이벤트 처리 -->
        <script>
            $(document).ready(function() {
                $('.like-button').click(function() {
                    // 초기화
                    $("#feedlist_section").hide();
                    $("#feedlist_dropdown_section_result").hide();
                    $.ajax({
                        type: 'GET',
                        url: "feedlist_like",
                        success: function(response) {
                            $("#feedlist_button_like_section_result").html(response).show();
                        },
                        error: function() {
                            alert('검색한 자료가 없습니다.');
                        }
                    });
                });
            });
        </script>


        <!-- 공유피드 게시물 표시 부분 -->
     <div id="feedlist_section">
      <section class="wrapper-record">
             <div class="container pt-12 pt-md-0 pb-16 pb-md-18">
                 <div class="grid grid-view projects-masonry mt-md-n20 mt-lg-n22 mb-20">
                     <div class="row g-8 g-lg-10 isotope">
                         <c:forEach items="${feedlist}" var="postInfoDTO">
                             <div class="project item col-md-6 col-xl-4 workshop">
                                  <div class="card shadow-lg">
                                     <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                                         <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                             <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                                         </a>
                                     </figure>
                                     <div class="card-body p-7">
                                         <div class="post-header">
                                             <div class="post-category text-line mb-2 text-aqua">${postInfoDTO.city}</div>
                                             <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}"><h3 class="mb-0">${postInfoDTO.title}</h3></a>
                                         </div>
                                     </div>
                                    <div class="card-footer">
                                      <ul class="post-meta d-flex mb-0">
                                        <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${postInfoDTO.startDate}~${postInfoDTO.endDate}</span></li>
                                        <li class="post-likes ms-auto"><i class="uil uil-heart-alt"></i>${postInfoDTO.likeCount}</li>
                                      </ul>
                                      <!-- /.post-meta -->
                                    </div>
                                 </div>
                             </div>
                         </c:forEach>
                     </div>
                 </div>
             </div>
         </section>
</div>


        <!-- 지역 버튼 선택 시 해당 지역 게시물 표시 부분 -->
        <div id="feedlist_dropdown_section_result" ></div>

        <!-- 좋아요 버튼 선택 시 게시물 리스트 표시 부분 -->
        <div id="feedlist_button_like_section_result" ></div>


    </body>
</html>
