        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h2 class="mb-4">일정 수정</h2>
        <div>
            <hr class="my-8"/>
            <input type="hidden" id="id" name="id" value="${plan.id}">
            <input type="hidden" id="userId" name="userId" value="${userId}">
            <div class="mb-3">
                <label for="title" class="form-label">일정명</label>
                <input type="text" id="title" name="title" value="${plan.title}" class="form-control" readonly>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label for="startDate" class="form-label">출발일</label>
                    <input type="date" id="startDate" name="startDate"
                           value="${plan.startDate}"
                           class="form-control" readonly>
                </div>
                <div class="col">
                    <label for="endDate" class="form-label">종료일</label>
                    <input type="date" id="endDate" name="endDate"
                           value="${plan.endDate}"
                           class="form-control" readonly>
                </div>
            </div>
            <div class="my-5">
                <label for="memo" class="form-label">메모</label>
                <textarea id="memo" name="memo" class="form-control" readonly>${plan.memo}</textarea>
            </div>
        </div>

        <div class="mt-5">
            <button type="button" onclick="location.href='/hontrip/plan/safety_search'" class="btn btn-primary">안전정보 확인</button>
            <button type="button" id="add-emergency-facility-button" class="btn btn-danger ms-3">응급시설 추가</button>
        </div>

        <div id="days-div" class="my-7">
            <% int numOfDays = (int) request.getAttribute("numOfDays");
                for (int i = 0; i < numOfDays; i++) { %>
            <label>Day <%=i + 1%>
            </label><br>
            <div id="add-buttons" class="mt-5">
                <button type="button" id="add-spot-<%=i + 1%>" class="btn btn-soft-aqua">여행지 추가</button>
                <button type="button" id="add-flight-<%=i + 1%>" class="btn btn-soft-aqua">항공권 추가</button>
                <button type="button" id="add-accommodation-<%=i + 1%>" class="btn btn-soft-aqua">숙소 추가</button>
            </div>
            <br>
            <div class="row" id="selected-spots-<%=i + 1%>">

                <c:set var="index" value="<%=i + 1%>"/>
                <c:forEach items="${addedSpots}" var="spot">
                    <c:if test="${spot.dayOrder eq index}">
                        <div class='row my-5'>
                            <span class='col-2'><img src="${spot.image}" width="55px" height="45px"></span>
                            <span class='col-auto'>${spot.title}</span>
                        </div>
                    </c:if>
                </c:forEach>

            </div>
            <br>
            <div class="my-5" id="search-spot-form-<%=i + 1%>">
                <form id="search-form">
                    <div class="custom-form-container">
                        <div class="col-md-2 me-2">
                            <%--@declare id="search-form"--%><select class="form-select" id="category-<%=i + 1%>"
                                                                     name="category-<%=i + 1%>" form="search-form"
                                                                     aria-label="검색 범주">
                            <option value="keyword" selected>여행지명</option>
                            <option value="area">지역명</option>
                        </select>
                        </div>
                        <input type="text" id="keyword-<%=i + 1%>" name="keyword-<%=i + 1%>"
                               class="custom-form-control col-md-8 me-2">
                        <button type="button" id="search-button-<%=i + 1%>" class="btn btn-yellow col-md-2">검색
                        </button>
                    </div>
                </form>
            </div>
            <div class="search-spot-results row" id="search-spot-results-<%=i + 1%>">
            </div>
            <hr class="my-8"/>

            <div class="my-5" id="search-accommodation-form-<%=i + 1%>" style="display: none;">
                <form id="search-accommodation-form">
                    <div class="custom-form-container">
                        <div class="col-md-4 me-2">
                            <select class="form-select" id="category-accommodation-<%=i + 1%>"
                                    name="category-accommodation-<%=i + 1%>" form="search-accommodation-form"
                                    aria-label="검색 범주">
                                <!-- Similar to spot search form, but for accommodation categories -->
                            </select>
                        </div>
                        <input type="text" id="address-accommodation-<%=i + 1%>" name="address-accommodation-<%=i + 1%>"
                               class="custom-form-control col-md-6 me-2" placeholder="주소 입력">
                        <input type="text" id="placeName-accommodation-<%=i + 1%>" name="placeName-accommodation-<%=i + 1%>"
                               class="custom-form-control col-md-6 me-2" placeholder="이름 입력">
                        <button type="button" id="search-accommodation-button-<%=i + 1%>" class="btn btn-yellow col-md-2">검색</button>
                    </div>
                </form>
            </div>
            <div class="search-accommodation-results row" id="search-accommodation-results-<%=i + 1%>">
                <!-- Accommodation search results will be displayed here -->
            </div>
            <hr class="my-8"/>
            <div class="search-accommodation-results row" id="search-accommodation-results-<%=i + 1%>">
                <c:forEach items="${list}" var="accommodation">
                    <div class="card mt-2">
                        <div class="card-body">
                            <p><strong>숙박 id:</strong> ${accommodation.id}</p>
                            <p><strong>숙박 구분:</strong> ${accommodation.categoryName}</p>
                            <p><strong>숙박 이름:</strong> ${accommodation.placeName}</p>
                            <p><strong>숙박 주소:</strong> ${accommodation.addressName}</p>
                            <p><strong>숙박 전화번호:</strong> ${accommodation.phone}</p>
                            <p><strong>숙박 URL:</strong> <a href="${accommodation.placeUrl}" target="_blank">${accommodation.placeUrl}</a></p>
                            <button type="button" id="add-accommodation-btn-${i + 1}-${accommodation.id}" class="btn btn-soft-aqua" data-accommodation-id="${accommodation.id}" data-accommodation-place-name="${accommodation.placeName}">
                                숙소 추가
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <% } %>
        </div>
    </div>
</section>

<script>
    let planId = "${plan.id}";
    let userId = <%= userId%>;


    $(document).ready(function () {
        $('[id^="search-spot-form-"]').hide();

        $('[id^="add-spot-"]').click(function () {
            let btnId = $(this).attr('id');
            let index = parseInt(btnId.split('-')[2]); // 일차
            let searchSpotFormDivId = 'search-spot-form-' + index;
            let searchSpotResultsDivId = 'search-spot-results-' + index;

            $('#' + searchSpotFormDivId).show();
        });
    });


    $(document).ready(function () {
        $('[id^="search-button-"]').click(function () {
            let searchBtnId = $(this).attr('id');
            let index = parseInt(searchBtnId.split('-')[2]);
            let categoryId = 'category-' + index;
            let category = $("#" + categoryId).children("option:selected").val();
            let keywordInputId = 'keyword-' + index;
            let keyword = $('#' + keywordInputId).val();
            getSpotList(category, keyword, searchBtnId);

        });
    });


    const getSpotList = function (category, keyword, btnId) {
        let index = parseInt(btnId.split('-')[2]);
        let searchSpotFormDivId = 'search-spot-form-' + index;
        let searchSpotResultsDivId = 'search-spot-results-' + index;

        $.ajax({
            method: "get",
            url: "detail/search-spot",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            async: false,
            data: {
                planId: planId,
                userId: userId,
                dayOrder: index,
                category: category,
                keyword: keyword
            },
            success: function (data) {
                // $('#' + searchSpotFormDivId).hide();
                $('#' + searchSpotResultsDivId).append(data);
                $('#' + searchSpotResultsDivId).css({'overflow': 'scroll', 'width': '100%', 'height': '500px'});
                $('#' + searchSpotResultsDivId).show();

                $(document).ready(function () {

                    $('[id^="add-spot-btn-"]').click(function () {
                        let index = parseInt(btnId.split('-')[2]);
                        let spotId = $(this).data("spot-content-id");
                        let spotTitle = $(this).data("spot-title");
                        addSpot(index, spotId);
                        $('#' + searchSpotResultsDivId).empty();
                    });
                });
            },
            error: function () {
                alert("여행지 검색에 실패했습니다.");
            }
        });
    }


    const addSpot = function (index, spotId) {
        let searchSpotResultsDivId = 'search-spot-results-' + index;
        let selectedSpotsDivId = 'selected-spots-' + index;
        let selectedSpotDivHTML = "";
        $.ajax({
            method: "get",
            url: "detail/update-plan-spot",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            async: false,
            data: {
                planId: planId,
                userId: userId, // 일단 구현하고 세션으로
                dayOrder: index,
                spotContentId: spotId
            },
            success: function (spot) {
                alert("여행지가 추가되었습니다!");
                $('#' + searchSpotResultsDivId).hide();
                selectedSpotDivHTML += "<div class='row mt-2'>"
                selectedSpotDivHTML += "<span class='col-2'><img src='" + spot.image + "'width='55px' height='45px'></span>"
                selectedSpotDivHTML += "<span class='col-auto'>" + spot.title + "</span>"
                selectedSpotDivHTML += "</div>"
                $('#' + selectedSpotsDivId).append(selectedSpotDivHTML); // 검색 결과를 해당 div에 삽입
                $('#' + selectedSpotsDivId).show();
                selectedSpotDivHTML.empty();
            },
            error: function () {
                alert("여행지 추가에 실패했습니다.");
            }
        }); // ajax
    } // addSpot




    $(document).ready(function () {
        $('[id^="search-accommodation-form-"]').hide();

        $('[id^="add-accommodation-"]').click(function () {
            let btnId = $(this).attr('id');
            let index = parseInt(btnId.split('-')[3]); // 일차
            let searchAccommodationFormDivId = 'search-accommodation-form-' + index;

            $('#' + searchAccommodationFormDivId).show();
        });

        $('[id^="search-accommodation-button-"]').click(function () {
            let btnId = $(this).attr('id');
            let index = parseInt(btnId.split('-')[3]); // 일차
            let category = $('#category-accommodation-' + index).val();
            let address = $('#address-accommodation-' + index).val();
            let placeName = $('#placeName-accommodation-' + index).val();

            getAccommodationList(category, address, placeName, btnId);
        });

        const addAccommodation = function(index, accommodationId) {
            let selectedAccommodationsDivId = 'selected-accommodations-' + index;
            let selectedAccommodationDivHTML = "";

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
                success: function(accommodation) {
                    alert("숙소가 추가되었습니다!");
                    selectedAccommodationDivHTML += "<div class='row mt-2'>";
                    selectedAccommodationDivHTML += "<span class='col-2'></span>";
                    selectedAccommodationDivHTML += "<span class='col-auto'>" + accommodation.placeName + "</span>";
                    selectedAccommodationDivHTML += "</div>";
                    $('#' + selectedAccommodationsDivId).append(selectedAccommodationDivHTML);
                    $('#' + selectedAccommodationsDivId).show();
                },
                error: function() {
                    alert("숙소 추가에 실패했습니다.");
                }
            });
        };
    });


       /* const getAccommodationList = function(category, address, placeName, btnId) {
        let index = parseInt(btnId.split('-')[2]);
        let searchAccommodationFormDivId = 'search-accommodation-form-' + index;
        let searchAccommodationResultsDivId = 'search-accommodation-results-' + index;

        $.ajax({
            method: "get",
            url: "detail/search-accommodation",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            async: false,
            data: {
                addressName: address,
                placeName: placeName,
                categoryName: category,
                filterType: "address_place"
            },
            success: function(data) {
                $('#' + searchAccommodationResultsDivId).append(data);
                $('#' + searchAccommodationResultsDivId).css({'overflow': 'scroll', 'width': '100%', 'height': '500px'});
                $('#' + searchAccommodationResultsDivId).show();

                $(document).ready(function() {
                    // Accommodation addition button click event
                    $('[id^="add-accommodation-btn-"]').click(function() {
                        let index = parseInt(btnId.split('-')[2]);
                        let accommodationId = $(this).data("accommodation-id");
                        let accommodationPlaceName = $(this).data("accommodation-place-name");
                        addAccommodation(index, accommodationId);
                        $('#' + searchAccommodationResultsDivId).empty();
                    });
                });
            },
            error: function() {
                alert("숙소 검색에 실패했습니다.");
            }
        });
    };

    // Function to add the selected accommodation to the plan
    const addAccommodation = function(index, accommodationId) {
        let searchAccommodationResultsDivId = 'search-accommodation-results-' + index;
        let selectedAccommodationsDivId = 'selected-accommodations-' + index;
        let selectedAccommodationDivHTML = "";

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
            success: function(accommodation) {
                alert("숙소가 추가되었습니다!");
                $('#' + searchAccommodationResultsDivId).hide();
                selectedAccommodationDivHTML += "<div class='row mt-2'>";
                selectedAccommodationDivHTML += "<span class='col-2'></span>";
                selectedAccommodationDivHTML += "<span class='col-auto'>" + accommodation.placeName + "</span>";
                selectedAccommodationDivHTML += "</div>";
                $('#' + selectedAccommodationsDivId).append(selectedAccommodationDivHTML);
                $('#' + selectedAccommodationsDivId).show();
                selectedAccommodationDivHTML.empty();
            },
            error: function() {
                alert("숙소 추가에 실패했습니다.");
            }
        });
    };*/
</script>