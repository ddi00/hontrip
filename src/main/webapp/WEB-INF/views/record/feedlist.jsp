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
        <section class="feed-header">
            공유피드 <br>
            (공개여부 1인 게시물 모두)<br>
            로그인 없이도 볼 수 있음
        </section>

        <!-- 버튼 영역 -->
        <section class="buttons">
            <div class="card-body">
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="allLocations">전국</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="capital-area">수도권</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="gangwon">강원</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="gyeongsang">경상</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="jeolla">전라</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="chungcheong">충청</button>
                <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="jeju">제주</button>
            </div>
            <br>
            <button class="btn btn-main rounded-pill mb-2 me-1 like" like="like">좋아요 순</button>
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
                $('.like').click(function() {
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
            <section class="wrapper">
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
                                                <h3 class="mb-0">${postInfoDTO.title}</h3>
                                            </div>
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
