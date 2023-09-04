<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="custom-card container-fluid container p-6 mt-15 mb-20 w-75">
        <div class="row">
            <h2 class="my-4 col-9 float-start">내 여행 일정 > ${plan.title}</h2>
            <div class="col-3 text-end">
                <button type="button" class="btn btn-outline-gray" style="width: 74%; border: 1px solid rgba(8, 60, 130, 0.15);"><a href="list" class="text-black-50">목록</a>
                </button>
            </div>
        </div>
        <hr class="my-4"/>
        <form id="planForm" action="update" method="post">
            <input type="hidden" id="planId" name="planId" value="${plan.planId}">
            <input type="hidden" id="userId" name="userId" value="<%= userId %>">
            <div class="mb-3">
                <label for="title" class="form-label">일정명</label>
                <input type="text" id="title" name="title" value="${plan.title}" class="form-control">
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label for="startDate" class="form-label">출발일</label>
                    <input type="date" id="startDate" name="startDate"
                           value="${plan.startDate}"
                           class="form-control">
                </div>
                <div class="col">
                    <label for="endDate" class="form-label">종료일</label>
                    <input type="date" id="endDate" name="endDate"
                           value="${plan.endDate}"
                           class="form-control">
                </div>
            </div>
            <div class="my-5">
                <label for="memo" class="form-label">메모</label>
                <textarea id="memo" name="memo" form="planForm" class="form-control">${plan.memo}</textarea>
            </div>
            <hr class="my-8"/>
            <div>
                <button type="submit" class="btn btn-primary col-2 float-end" form="planForm">수정</button>
            </div>
        </form>

        <%--안전정보, 응급시설 버튼--%>
        <hr class="my-5">
        <div class="row justify-content-center">
            <div class="col-md-6 my-2">
                <div class="d-flex justify-content-center">
                    <button type="button" class="btn btn-outline-orange rounded-pill" style="width: 50%;"
                            data-bs-toggle="modal" data-bs-target="#safetyModal">안전정보 확인
                    </button>
                </div>
            </div>
            <div class="col-md-6 my-2">
                <div class="d-flex justify-content-center">
                    <button type="button" id="add-emergency-facility-button" class="btn btn-outline-orange rounded-pill"
                            style="width: 50%;" data-toggle="modal" data-target="#emergencyFacilityModal">응급시설 확인
                    </button>
                </div>
            </div>
        </div>


        <hr class="my-8"/>

        <%--안전정보 모달--%>
        <div class="modal fade" id="safetyModal" tabindex="-1" aria-labelledby="safetyModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="safetyModalLabel">안전정보 확인</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <jsp:include page="safety_search.jsp"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <%--응급시설 모달--%>
        <div class="modal fade" id="emergencyFacilityModal" tabindex="-1" role="dialog"
             aria-labelledby="emergencyFacilityModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="emergencyFacilityModalLabel">응급시설 목록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modalContent">
                        <jsp:include page="emergency_facility/list.jsp"/>
                    </div>
                </div>
            </div>
        </div>


        <%--        기본 정보    --%>

        <div class="row gx-md-8 gx-xl-12 gy-8">
            <div class="col-6" style="border-right: 2px solid #F5F5F5;">

                <% int numOfDays = (int) request.getAttribute("numOfDays");
                    for (int i = 0; i < numOfDays; i++) { %>

                <label>Day <%=i + 1%>
                </label><br>
                <div id="add-buttons" class="mt-5 text-center">
                    <button type="button" id="add-spot-<%=i + 1%>" class="btn btn-sm btn-soft-orange rounded-pill w-75">
                        여행지 추가
                    </button>
                </div>
                <br>

                <div class="card" id="selected-spots-<%=i + 1%>">
                    <c:set var="index" value="<%=i + 1%>"/>
                    <c:set var="contentOrder" value="0"/> <!-- 초기 값 설정 -->
                    <c:forEach items="${addedSpots}" var="spot" varStatus="status">
                        <c:if test="${spot.dayOrder eq index}">
                            <div class='row ms-3 my-4'>
                                <span class='col-3'><img src="${spot.image}" width="88px" height="72px"></span>
                                <span class='col-6 align-self-center'>${spot.title}</span>
                                <span class="col-1 align-self-center"><button type="button"
                                                                              class="btn btn-sm delete-spot-btn"
                                                                              data-spot-content-day-order="${index}"
                                                                              data-spot-content-order="${contentOrder}"
                                                                              data-spot-content-id="${spot.contentId}">
                                        <svg style="color: gray" xmlns="http://www.w3.org/2000/svg" width="16"
                                             height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"
                                                      fill="gray"></path>
                                            </svg>
                                    </button></span>
                            </div>
                            <c:set var="contentOrder" value="${contentOrder + 1}"/> <!-- 일차가 같은 경우 contentOrder 증가 -->
                        </c:if>
                    </c:forEach>
                </div>
                <br>
                <% } %>
            </div>

            <%--        col1 일차별 항목      --%>

            <div class="col-6">

                <% for (int i = 0; i < numOfDays; i++) { %>
                <div class="my-9" id="search-spot-form-<%=i + 1%>">
                    <form id="spot-form">
                        <div class="custom-form-container">
                            <div class="col-md-3 me-2">
                                <%--@declare id="search-form"--%><select class="form-select"
                                                                         id="category-<%=i + 1%>"
                                                                         name="category-<%=i + 1%>"
                                                                         form="spot-form"
                                                                         aria-label="검색 범주" style="font-size: 0.65rem;">
                                <option value="keyword" selected>여행지명</option>
                                <option value="area">지역명</option>
                            </select>
                            </div>
                            <input type="text" id="keyword-<%=i + 1%>" name="keyword-<%=i + 1%>" form="spot-form"
                                   class="custom-form-control col-md-7 me-2">
                            <button type="button" id="search-spot-button-<%=i + 1%>" class="btn btn-orange col-md-2">
                                검색
                            </button>
                        </div>
                    </form>
                </div>
                <%--                여행지 검색 폼      --%>
                <div class="search-spot-results" id="search-spot-results-<%=i + 1%>">

                </div>
                <%--                여행지 검색 결과--%>
                <% } %>
            </div>
            <%--            col2 여행지 검색 폼 및 검색 결과    --%>
        </div>
        <%--        row--%>

        <hr class="my-8"/>
        <div class="row gx-md-8 gx-xl-12 gy-8">
            <div class="col-6 text-center" style="border-right: 2px solid #F5F5F5;">
                <button id="add-flight" type="button" class="btn btn-sm btn-soft-green rounded-pill w-75">항공권 추가
                </button>

                <div class="mt-5 mb-2" id="selected-flights">
                    <c:forEach items="${addedFlights}" var="flight">
                        <div class="card my-2">
                            <div class="col-12 text-end">
                                <button type="button"
                                        class="delete-flight-btn btn custom-btn-sm mt-2 me-2"
                                        data-flight-id="${flight.id}">
                                    <svg style="color: gray" xmlns="http://www.w3.org/2000/svg" width="16"
                                         height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                        <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"
                                              fill="gray"></path>
                                    </svg>
                                </button>
                            </div>
                            <div class="card-body-for-plan-flight">
                                <div class="row">
                                    <div class="col-5 text-center ms-2"><h4>${flight.depAirportName}</h4></div>
                                    <div class="col-1 text-center">
                                        <i class="uil uil-plane-fly"></i>
                                    </div>
                                    <div class="col-5 text-center"><h4>${flight.arrAirportName}</h4></div>
                                </div>
                                <div class="row">
                                    <div class="col-6 text-center">
                                        <span style="font-size: 0.7rem">
                                            <fmt:parseDate value="${flight.departureTime}" var="departureTime"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/>
                                            <fmt:formatDate value="${departureTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </span>
                                    </div>
                                    <div class="col-6 text-center">
                                        <span style="font-size: 0.7rem">
                                            <fmt:parseDate value="${flight.arrivalTime}" var="arrivalTime"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/>
                                            <fmt:formatDate value="${arrivalTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <span>${flight.vehicleId}</span>
                                        <span> / </span>
                                        <span>${flight.airlineName}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-lg-6">
                <jsp:include page="flight/search_form_for_plan.jsp"/>
                <%--                항공권 검색 폼      --%>
                <div class="search-flight-results mt-2" id="search-flight-results">


                </div>
                <%--                여행지 검색 결과--%>
            </div>
        </div>
        <hr class="my-8"/>
        <div class="row gx-md-8 gx-xl-12 gy-8">

            <%--숙소추가--%>
            <div class="col-6 text-center" style="border-right: 2px solid #F5F5F5;">

                <button id="add-accommodation-1" type="button" class="btn btn-sm btn-soft-yellow rounded-pill w-75">숙소
                    추가
                </button>
                <br>

                <div class="row mt-3" id="selected-accommodations-1">

                    <c:forEach items="${addedAccommodations}" var="accommodation">
                        <div class="card my-2" style="text-align: left; font-size: 0.8em;">
                            <div class='row ms-3 my-4'>
                                    <%--<span class='col-3'><img src="${spot.image}" width="88px" height="72px"></span> --%>
                                <div class="row">
                                    <span class='col-6 align-self-center'> <Strong> ${accommodation.placeName} </Strong></span>
                                    <span class='col-8'>${accommodation.categoryName}"</span>
                                </div>

                                <div class="row">
                                    <span class='col-8 align-self-center'>${accommodation.addressName}</span>
                                </div>

                                <div class="row">
                                    <span class='col-10 align-self-center'>${accommodation.phone}</span>
                                    <span class="col-2 align-self-start">
                                            <button type="button" class="delete-accommodation-btn btn btn-sm"
                                                    data-accommodation-id="${accommodation.id}">
                                                <svg style="color: gray" xmlns="http://www.w3.org/2000/svg" width="16"
                                                     height="16" fill="currentColor" class="bi bi-x"
                                                     viewBox="0 0 16 16">
                                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"
                                                      fill="gray"></path>
                                            </svg>
                                            </button>
                                        </span>
                                </div>


                                <div class="row">
                                    <span class='col-8 align-self-center'><a href="${accommodation.placeUrl}">숙박 후기</a> </span>
                                </div>


                            </div>
                        </div>
                    </c:forEach>

                </div>
                <br>
            </div>
            <!-- 숙소 검색창과 검색결과 시작-->
            <div class="col-lg-6" id="search-accommodation-form-1" style="display: none;">
                <form id="search-accommodation-form">
                    <div class="custom-form-container">

                        <input type="text" id="address-input-accommodation-1" name="address-accommodation-1"
                               class="custom-form-control col-md-5 me-2" placeholder="주소 검색">
                        <input type="text" id="placeName-input-accommodation-1" name="placeName-accommodation-1"
                               class="custom-form-control col-md-5 me-2" placeholder="장소명 검색">

                        <button type="button" id="search-accommodation-button-1" class="btn btn-yellow col-md-2">검색
                        </button>

                    </div>

                </form>

                <div class="search-accommodation-results row" id="search-accommodation-results-1">
                    <!-- Accommodation search results will be displayed here -->
                </div>
            </div>
            <!-- 숙소 검색창과 검색결과  끝-->
        </div>
        <hr class="my-8"/>
        <%--    container   --%>

</section>
<script>
    let planId = "${plan.planId}";
    let userId = <%= userId %>;

    // 일차마다 부착된 여행지 검색 버튼 클릭 시 여행지 검색창 표시
    $(document).ready(function () {
        $('[id^="search-spot-form-"]').hide();
        let selectedSpotsDivs = $('[id^="selected-spots-"]');
        selectedSpotsDivs.each(function () {
            let divContents = $(this).find('div');
            if (divContents.length === 0) {
                $(this).hide(); // 내용이 없는 div 숨김 처리
            }
        });

        $('[id^="add-spot-"]').click(function () {
            let btnId = $(this).attr('id');
            let index = parseInt(btnId.split('-')[2]);
            let searchSpotFormDivId = 'search-spot-form-' + index;
            let searchSpotResultsDivId = 'search-spot-results-' + index;
            $('#' + searchSpotFormDivId).show();

            let searchSpotInputId = 'keyword-' + index;
            let searchSpotBtnId = 'search-spot-button-' + index;
            $('#' + searchSpotInputId).keydown(function (keyNum) {
                if (keyNum.keyCode == 13) {
                    $('#' + searchSpotBtnId).click();
                }
            })
        });
    });

    // 여행지 검색 버튼 클릭 시 여행지 검색 결과 표시
    $(document).ready(function () {
        $('[id^="search-spot-button-"]').click(function () {
            let searchBtnId = $(this).attr('id');
            let dayOrder = parseInt(searchBtnId.split('-')[3]);
            let categoryId = 'category-' + dayOrder;
            let category = $("#" + categoryId).children("option:selected").val();
            let keywordInputId = 'keyword-' + dayOrder;
            let keyword = $('#' + keywordInputId).val();
            getSpotList(category, keyword, searchBtnId);
        });
    });

    // 검색 여행지 리스트 반환 메소드
    const getSpotList = function (category, keyword, btnId) {
        let dayOrder = parseInt(btnId.split('-')[3]);
        let searchSpotFormDivId = 'search-spot-form-' + dayOrder;
        let searchSpotResultsDivId = 'search-spot-results-' + dayOrder;

        $.ajax({
            method: "get",
            url: "detail/search-spot",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            async: false,
            data: {
                userId: userId,
                planId: planId,
                dayOrder: dayOrder,
                category: category,
                keyword: keyword
            },
            success: function (data) {
                // $('#' + searchSpotFormDivId).hide(); // form 숨기기
                $('#' + searchSpotResultsDivId).empty();
                $('#' + searchSpotResultsDivId).append(data); // 검색 결과를 해당 div에 삽입
                $('#' + searchSpotResultsDivId).css({
                    'overflow-x': 'hidden',
                    'overflow-y': 'auto',
                    'width': '100%',
                    'height': '500px'
                }); // 스크롤
                $('#' + searchSpotResultsDivId).show();

            }, // success
            error: function () {
                alert("여행지 검색에 실패했습니다.");
            }
        }); // ajax
    } // getSpotList

    // 여행지 추가 버튼 클릭 이벤트 처리
    $(document).on('click', '[id^="add-spot-btn-"]', function () {
        let dayOrder = $(this).data("spot-content-day-order");
        let spotId = $(this).data("spot-content-id");
        let spotTitle = $(this).data("spot-title");
        addSpot(dayOrder, spotId);
    });

    // 여행지 추가 메소드
    const addSpot = function (dayOrder, spotId) {
        let searchSpotResultsDivId = 'search-spot-results-' + dayOrder;
        let selectedSpotsDivId = 'selected-spots-' + dayOrder;
        let searchSpotFormDivId = 'search-spot-form-' + dayOrder;
        let selectedSpotDivHTML = "";
        let lastButton = $('#' + selectedSpotsDivId).find('div:last button');
        let spotOrder;
        if (lastButton.length > 0) {
            spotOrder = lastButton.data("spot-content-order") + 1;
        } else {
            spotOrder = 0;
        }

        $.ajax({
            method: "get",
            url: "detail/update-plan-spot",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                dayOrder: dayOrder,
                spotContentId: spotId
            },
            success: function (spot) {
                alert("여행지가 추가되었습니다!");
                $('#' + searchSpotFormDivId).hide();
                $('#' + searchSpotResultsDivId).hide();

                selectedSpotDivHTML += "<div class='row ms-3 my-4'>"
                selectedSpotDivHTML += "<span class='col-3'><img src='" + spot.image + "'width='88px' height='72px'></span>"
                selectedSpotDivHTML += "<span class='col-6 align-self-center'>" + spot.title + "</span>"
                selectedSpotDivHTML += "<span class='col-1 align-self-center'><button type='button' class='btn btn-sm delete-spot-btn' data-spot-content-day-order='" + dayOrder + "'data-spot-content-order='" + spotOrder + "'data-spot-content-id='" + spot.contentId + "'>"
                selectedSpotDivHTML += "<svg style='color: gray' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x' viewBox='0 0 16 16'>"
                selectedSpotDivHTML += "<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z' fill='gray'></path></svg>"
                selectedSpotDivHTML += "</button></span></div>"

                $('#' + selectedSpotsDivId).append(selectedSpotDivHTML); // 검색 결과를 해당 div에 삽입
                $('#' + selectedSpotsDivId).show();
            },
            error: function () {
                alert("여행지 추가에 실패했습니다.");
                $('#' + searchSpotResultsDivId).hide();
            }
        });
    }

    // 여행지 삭제 버튼 이벤트 처리
    $(document).on('click', '.delete-spot-btn', function () {
        let userId = $("#userId").val();
        let deleteButton = $(this);
        let dayOrder = $(this).data("spot-content-day-order");
        let spotOrder = $(this).data("spot-content-order");
        let spotId = $(this).data("spot-content-id");

        $.ajax({
            method: "get",
            url: "detail/delete-plan-spot",
            contentType: "application/json; charset=UTF-8",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                dayOrder: dayOrder,
                spotOrder: spotOrder,
                spotContentId: spotId
            },
            success: function (result) {
                alert("여행지가 삭제되었습니다!");
                deleteButton.closest(".row").remove();
                let selectedSpotsDivs = $('[id^="selected-spots-"]');
                selectedSpotsDivs.each(function () {
                    let divContents = $(this).find('div');
                    if (divContents.length === 0) {
                        $(this).hide(); // 내용이 없는 div 숨김 처리
                    }
                })
            },
            error: function () {
                alert("여행지 삭제에 실패했습니다.");
            }
        });
    })

    //항공권 추가 버튼 이벤트 처리
    $(document).ready(function () {
        $("#search-flight-form").hide();
        $("#search-flight-results").hide();

        $("#add-flight").click(function () {
            $("#search-flight-form").show();
            $("#search-flight-button").click(function () {
                $("#search-flight-results").empty();
                let depAirportName = $("#depAirportName").children("option:selected").val();
                let arrAirportName = $("#arrAirportName").children("option:selected").val();
                let depDate = $("#depDate").val();
                getFlightList(depAirportName, arrAirportName, depDate);
            });
        });
    });


    // 검색 항공권 리스트 반환 메소드
    const getFlightList = function (depAirportName, arrAirportName, depDate) {
        $("#search-flight-results").empty();
        $.ajax({
            method: "get",
            url: "detail/search-flight",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            async: false,
            data: {
                userId: userId,
                planId: planId,
                depAirportName: depAirportName,
                arrAirportName: arrAirportName,
                depDate: depDate
            },
            success: function (data) {
                // $("#search-flight-form").hide(); // form 숨기기
                $("#search-flight-results").append(data); // 검색 결과를 해당 div에 삽입D
                $("#search-flight-results").addClass("mt-5");
                $("#search-flight-results").css({
                    'overflow-x': 'hidden',
                    'overflow-y': 'auto',
                    'width': '100%',
                    'height': '500px'
                }); // 스크롤
                $("#search-flight-results").show();
            },
            error: function () {
                alert("항공권 검색에 실패했습니다.");
            }
        }); // ajax
    } // getSpotList


    // 항공권 추가 버튼 클릭 이벤트 처리
    $(document).on('click', '[id^="add-flight-btn-"]', function () {
        let flightId = $(this).data("flight-id");
        addFlight(flightId);
    });

    // 항공권 추가 메소드
    const addFlight = function (flightId) {
        let selectedFlightDivHTML = "";

        $.ajax({
            method: "get",
            url: "detail/update-plan-flight",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                flightId: flightId
            },
            success: function (flight) {
                alert("항공권이 추가되었습니다!");
                $("#search-flight-form").hide();
                $("#search-flight-results").hide();

                let trimmedDepTime = flight.departureTime.substring(0, flight.departureTime.lastIndexOf(':'));
                let trimmedArrTime = flight.arrivalTime.substring(0, flight.arrivalTime.lastIndexOf(':'));

                selectedFlightDivHTML += "<div class='card my-2'><div class='col-12 text-end'>"
                selectedFlightDivHTML += "<button type='button' class='delete-flight-btn btn custom-btn-sm mt-2 me-2' data-flight-id='" + flight.id + "'>"
                selectedFlightDivHTML += "<svg style='color: gray' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x' viewBox='0 0 16 16'>"
                selectedFlightDivHTML += "<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z' fill='gray'></path></svg>"
                selectedFlightDivHTML += "</button></div><div class='card-body-for-plan-flight'><div class='row'>"
                selectedFlightDivHTML += "<div class='col-5 text-center ms-2'><h4>" + flight.depAirportName + "</h4></div>"
                selectedFlightDivHTML += " <div class='col-1 text-center'><i class='uil uil-plane-fly'></i></div>"
                selectedFlightDivHTML += "<div class='col-5 text-center'><h4>" + flight.arrAirportName + "</h4></div></div>"
                selectedFlightDivHTML += "<div class='row'>"
                selectedFlightDivHTML += "<div class='col-6 text-center'><span style='font-size: 0.7rem'>" + trimmedDepTime + "</span></div>"
                selectedFlightDivHTML += "<div class='col-6 text-center'><span style='font-size: 0.7rem'>" + trimmedArrTime + "</span></div>"
                selectedFlightDivHTML += "<div class='row'>"
                selectedFlightDivHTML += "<div class='col-12 text-center'><span>" + flight.vehicleId + "</span><span>" + ' / ' + "</span><span>" + flight.airlineName + "</span></div></div>"
                selectedFlightDivHTML += "</div></div>"

                $("#selected-flights").append(selectedFlightDivHTML); // 검색 결과를 해당 div에 삽입
                $("#selected-flights").show();
            },
            error: function () {
                alert("여행지 추가에 실패했습니다.");
                $("#search-flight-results").hide();
            }
        });
    }

    // 항공권 삭제 버튼 이벤트 처리
    $(document).on('click', '.delete-flight-btn', function () {
        let userId = $("#userId").val();
        let deleteButton = $(this);
        let flightId = $(this).data("flight-id");

        $.ajax({
            method: "get",
            url: "detail/delete-plan-flight",
            contentType: "application/json; charset=UTF-8",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                flightId: flightId
            },
            success: function (result) {
                alert("항공권이 삭제되었습니다!");
                deleteButton.closest(".card").remove();
            },
            error: function () {
                alert("여행지 삭제에 실패했습니다.");
            }
        });
    })

    /*숙소*/
    $(document).ready(function () {
        $('[id^="search-accommodation-form-"]').hide();

        $('[id^="add-accommodation-"]').click(function () {
           /* console.log("숙박시설 검색 div visible show");*/
            let btnId = $(this).attr('id');
            /*console.log("숙박시설 검색 btnId : " + btnId);*/
            //let index = parseInt(btnId.split('-')[3]); // 일차
            let index = parseInt(btnId.split('-')[2]); // 수정
            let searchAccommodationFormDivId = 'search-accommodation-form-' + index;
            let searchAccommodationResultDivId = 'search-accommodation-results-' + index;

            let searchSpotFormDivId = 'search-spot-form-' + index;
            let searchSpotResultsDivId = 'search-spot-results-' + index;

            $('#' + searchSpotFormDivId).hide();
            $('#' + searchAccommodationFormDivId).show();
        });

        $('[id^="search-accommodation-button-"]').click(function () {
            let btnId = $(this).attr('id');
          /*  console.log("Accommodation searchBtnId : " + btnId);*/
            let index = parseInt(btnId.split('-')[3]); // 일차
           /* console.log("btnIndex : " + index);*/

            /*
            let categoryId = 'category-accommodation-' + index;
            let category = $("#" + categoryId).children("option:selected").val();
            */

            let addressInputId = 'address-input-accommodation-' + index;
            let addressInput = $('#' + addressInputId).val();
            let placeNameInputId = 'placeName-input-accommodation-' + index;
            let placeNameInput = $('#' + placeNameInputId).val();

            //getAccommodationList(category, address, placeName, btnId);
            //getAccommodationList(category, addressInput, placeNameInput, btnId);

            getAccommodationList(addressInput, placeNameInput, btnId);
        });


    });

    const getAccommodationList = function (address, placeName, btnId, category = "") {
        let index = parseInt(btnId.split('-')[3]);
        let searchAccommodationFormDivId = 'search-accommodation-form-' + index;
        let searchAccommodationResultsDivId = 'search-accommodation-results-' + index;

     /*   console.log("before ajax getAccommodationList");
        console.log("planId : " + planId);
        console.log("userId : " + userId);
        console.log("index : " + index);
        console.log("category : " + category);
        console.log("address : " + address);
        console.log("placeName : " + placeName);*/

        let filter_type = "";
        if (address === "" || address === undefined || address === null)
            address = "";
        if (placeName === "" || placeName === undefined || placeName === null)
            placeName = ""

        if (placeName !== "" && address !== "")
            filter_type = "address_place";
        else if (placeName !== "")
            filter_type = "place_name";
        else if (address !== "")
            filter_type = "address";

       /* console.log("filter_type : " + filter_type);*/

        $.ajax({
            method: "get",
            url: "detail/search-accommodation",
            contentType: "application/json; charset=UTF-8",
            //dataType: "html",
            dataType: "text",
            async: false,
            data: {
                addressName: address,
                placeName: placeName,
                categoryName: category,
                filterType: filter_type
            },
            success: function (data) {
               /* console.log("after getAccommodationList ajax succeeded!");
                console.log("returned getAccommodationList data");

                console.log(data);*/

                let trimmedHtml = $(data).find('.card');
                $('#' + searchAccommodationResultsDivId).empty(); // 이전 목록 지우기
                $('#' + searchAccommodationResultsDivId).append(trimmedHtml);

                //$('#' + searchAccommodationResultsDivId).append(data);
                $('#' + searchAccommodationResultsDivId).css({
                    'overflow': 'scroll',
                    'width': '100%',
                    'height': '500px'
                });
                $('#' + searchAccommodationResultsDivId).show();

                $(document).ready(function () {
                    // Accommodation addition button click event
                    $('[id^="add-accommodation-btn-"]').click(function () {
                        //let index = parseInt(btnId.split('-')[2]);
                        let index = parseInt(btnId.split('-')[3]);
                        let accommodationId = $(this).data("accommodation-id");
                        let accommodationPlaceName = $(this).data("accommodation-place-name");
                      /*  console.log("data-accommodation-id : " + accommodationId);
                        console.log("data-accommodation-place-name : " + accommodationPlaceName);*/
                        addAccommodation(index, accommodationId);
                        $('#' + searchAccommodationResultsDivId).empty();
                    });
                });
            },
            error: function () {
                alert("숙소 검색에 실패했습니다.");
            }
        });
    };

    // Function to add the selected accommodation to the plan
    const addAccommodation = function (index, accommodationId) {
        let searchAccommodationResultsDivId = 'search-accommodation-results-' + index;
        let selectedAccommodationsDivId = 'selected-accommodations-' + index;
        let selectedAccommodationDivHTML = "";

       /* console.log("before addAccommodation ajax");
        console.log("planId : " + planId);
        console.log("userId : " + userId);
        console.log("index : " + index);
        console.log("accommodationId : " + accommodationId);
*/
        $.ajax({
            method: "get",
            url: "detail/update-plan-accommodation",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                dayOrder: index,
                accommodationId: accommodationId
            },
            success: function (accommodation) {

                alert("숙소가 추가되었습니다!");

                $('#' + searchAccommodationResultsDivId).hide();

                selectedAccommodationDivHTML += "<div class='card my-2'><div class='ms-3 my-4'><div class='row'>"
                selectedAccommodationDivHTML += "<div class='row'> <span class='col-6 align-self-center'> <Strong> "
                    + accommodation.placeName + "<</Strong></span><span class='col-8'>"
                    + accommodation.categoryName + "</span></div>"

                selectedAccommodationDivHTML += "<div class='row'><span class='col-8'>" + accommodation.addressName + "</span></div>"

                selectedAccommodationDivHTML += "<div class='row'>"
                selectedAccommodationDivHTML += "<span class='col-10'>" + accommodation.phone + "</span>"
                selectedAccommodationDivHTML += "<span class='col-2 align-self-start'><button type='button' class='delete-accommodation-btn btn btn-sm'"
                    + "data-accommodation-id='" + accommodation.id + "'>"
                selectedAccommodationDivHTML += "<svg style='color: gray' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x' viewBox='0 0 16 16'>"
                selectedAccommodationDivHTML += "<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z' fill='gray'></path></svg>"
                selectedAccommodationDivHTML += "</button></span></div>"

                selectedAccommodationDivHTML += "<div class='row'>"
                selectedAccommodationDivHTML += "<span class='col-12'><a href='" + accommodation.placeUrl + "'>숙박후기</a>" + "</span>"
                selectedAccommodationDivHTML += "</div>"

                $('#' + selectedAccommodationsDivId).append(selectedAccommodationDivHTML);
                $('#' + selectedAccommodationsDivId).show();

            },
            error: function () {
                alert("숙소 추가에 실패했습니다.");
            }
        });
    };

    // 숙박지 삭제 버튼 이벤트 처리
    $(document).on('click', '.delete-accommodation-btn', function () {
        let userId = $("#userId").val();
        let deleteButton = $(this);
        let accommodationId = $(this).data("accommodation-id");

        $.ajax({
            method: "get",
            url: "detail/delete-plan-accommodation",
            contentType: "application/json; charset=UTF-8",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                accommodationId: accommodationId
            },
            success: function (result) {
                alert("숙박지가 삭제되었습니다!");
                deleteButton.closest(".card").remove();
                //deleteButton.closest(".row").remove();
            },
            error: function () {
                alert("숙박지 삭제에 실패했습니다.");
            }
        });
    })

    /*안전정보 연결*/
    $(document).ready(function () {
        // Load the safety_search.jsp content when the safetyButton is clicked
        $("#safetyButton").click(function () {
            $.ajax({
                url: "/hontrip/plan/safety_search",
                method: "GET",
                success: function (data) {
                    $("#safetyModal .modal-body").html(data);
                    $("#safetyModal").modal("show");
                },
                error: function () {
                    alert("안전정보 페이지를 불러오는 데 실패했습니다.");
                }
            });
        });


        $(document).on('submit', '#safetySearchForm', function (e) {
            e.preventDefault();
            $.ajax({
                url: "safety_result",
                method: "POST",
                data: $(this).serialize(),
                success: function (data) {
                    $("#safetyModal .modal-body").html(data);
                },
                error: function () {
                    alert("안전정보 검색에 실패했습니다.");
                }
            });
        });


        $(document).on('click', '#retrySafetySearch', function () {
            $.ajax({
                url: "/hontrip/plan/safety_search",
                method: "GET",
                success: function (data) {
                    $("#safetyModal .modal-body").html(data);
                },
                error: function () {
                    alert("안전정보 검색 페이지를 불러오는 데 실패했습니다.");
                }
            });
        });
    });

    /*  응급시설*/
    $(document).ready(function () {
        $("#add-emergency-facility-button").click(function () {
            var emergencyFacilityModal = new bootstrap.Modal(document.getElementById('emergencyFacilityModal'));
            emergencyFacilityModal.show();
        });

        $(document).on("submit", "#emergency_facility_search_form", function (e) {
            e.preventDefault();


            $.ajax({
                url: "/hontrip/plan/emergency_facility/filter_list",
                method: "POST",
                data: $(this).serialize(),
                success: function (data) {
                    $("#modalContent").html(data);
                }
            });
        });
    });


    $(document).ready(function () {
        $(document).on("click", "a[href='/hontrip/plan/emergency_facility/list']", function (e) {
            e.preventDefault();


            $.get("/hontrip/plan/emergency_facility/list", function (data) {
                $("#modalContent").html(data);
            });
        });
    });


    /*수정버튼 alert*/
    $(document).ready(function () {
        $("#planForm").on("submit", function () {
            alert("수정이 완료되었습니다.");
        });
    });
</script>