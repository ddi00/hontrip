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

        <!-- 드롭박스 영역 -->
        <section class="buttons">
            <div class="card-body">
                <div>장소별</div>
                <select id="locationDropdown">
                    <option value="" disabled selected>지역을 선택하세요</option>
                    <option value="allLocations">전국</option>
                    <option value="capital-area">수도권</option>
                    <option value="gangwon">강원</option>
                    <option value="gyeongsang"}>경상</option>
                    <option value="jeolla">전라</option>
                    <option value="chungcheong">충청</option>
                    <option value="jeju">제주</option>
                </select>
            </div>
        </section>


        <!-- 드롭다운 선택 시 이벤트 처리 -->
        <script>
            $(document).ready(function() {
                // 드롭다운 선택 이벤트 처리
                $('#locationDropdown').change(function() {
                    // 초기화
                    $("#feedlist_section").hide();

                    // 선택한 드롭다운의 value 값을 가져옵니다
                    var selectedLocationId = $(this).val();
                    // 선택한 옵션에 따라 locationId 패턴 값을 설정
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

            // 드롭박스 권역 구분
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
                    default:
                        return ""; // 기본 값
                }
            }

            // 드롭박스 권역구분 - 광역시 포함하는 작업1
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

            // 드롭박스 권역구분 - 광역시 포함하는 작업2
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

            // 드롭박스 권역구분 - 광역시 포함하는 작업3
            function getSpecialId3(selectedOption) {
                switch (selectedOption) {
                    case "gyeongsang":
                        return "108";
                    default:
                        return "";
                }
            }
        </script>

        <!-- 드롭다운 선택 시 해당 지역 게시물 표시 부분 -->
        <div id="feedlist_dropdown_section_result" ></div>

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
                                                <h4 class="mb-0">공개여부 : ${postInfoDTO.isVisible}</h4> <!-- 테스트 후 삭제 예정 -->
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
    </body>
</html>
