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
                        <optgroup label="전국">
                            <option id="allLocations" value="allLocations">전국</option>
                        </optgroup>
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
                </select>
            </div>

            <!-- 드롭다운 선택 시 이벤트 처리 -->
            <script>
                //전국 선택 시
                $(document).ready(function() {
                    $("#locationDropdown").change(function() {
                        if ($(this).val() === "allLocations") {
                            $.ajax({
                                url: "list_mylocation_dropdown_all",
                                method: "GET",
                                data: { locationId: selectedLocationId },
                                success: function(response) {
                                    $("#list_mylocation_dropdown_result").html(response).show();
                                },
                                error: function(error) {
                                    // 오류 처리
                                    alert('검색한 자료가 없습니다.');
                                }
                            });
                        }
                    });
                });

                //개별지역 선택 시
                $(document).ready(function() {
                    $('#locationDropdown').change(function() {
                        // 초기화
                        $("#feedlist_section").hide();
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

        <!-- 드롭다운 선택 시 해당 지역 게시물 표시 부분 -->
        <div id="list_mylocation_dropdown_result" ></div>

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
