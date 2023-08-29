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
        <hr class="my-8"/>

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
        </form>
        <%--        기본 정보    --%>

        <div class="row gx-md-8 gx-xl-12 gy-8">
            <div class="col-lg-6" style="border-right: 2px solid #F5F5F5;">

                <% int numOfDays = (int) request.getAttribute("numOfDays");
                    for (int i = 0; i < numOfDays; i++) { %>

                <label>Day <%=i + 1%>
                </label><br>
                <div id="add-buttons" class="mt-5">
                    <button type="button" id="add-spot-<%=i + 1%>" class="btn btn-soft-orange rounded-pill">여행지 추가</button>
                </div>
                <br>

                <div class="card mt-2" id="selected-spots-<%=i + 1%>">
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
                                        <svg style="color: red" xmlns="http://www.w3.org/2000/svg" width="16"
                                             height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16"> <path
                                                d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"
                                                fill="red"></path> <path fill-rule="evenodd"
                                                                         d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"
                                                                         fill="red"></path> </svg>
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

            <div class="col-lg-6">

                <% for (int i = 0; i < numOfDays; i++) { %>
                <div class="my-9" id="search-spot-form-<%=i + 1%>">
                    <form id="spot-form">
                        <div class="custom-form-container">
                            <div class="col-md-3 me-2">
                                <%--@declare id="search-form"--%><select class="form-select"
                                                                         id="category-<%=i + 1%>"
                                                                         name="category-<%=i + 1%>"
                                                                         form="spot-form"
                                                                         aria-label="검색 범주">
                                <option value="keyword" selected>여행지명</option>
                                <option value="area">지역명</option>
                            </select>
                            </div>
                            <input type="text" id="keyword-<%=i + 1%>" name="keyword-<%=i + 1%>"
                                   class="custom-form-control col-md-7 me-2">
                            <button type="button" id="search-button-<%=i + 1%>" class="btn btn-yellow col-md-2">
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
            <div class="col-lg-6" style="border-right: 2px solid #F5F5F5;">
        <button type="button" class="add-flight btn btn-soft-green rounded-pill">항공권 추가</button>
        <button type="button" class="add-accom btn btn-soft-yellow rounded-pill">숙소 추가</button>
            </div>
        </div>
        <hr class="my-8"/>
        <div class="align-self-end">
            <button type="submit" class="btn btn-yellow col-md-2" form="planForm">수정</button>
        </div>
    </div>
    <%--    container   --%>
</section>
<script>
    let planId = "${plan.planId}";
    let userId = <%= userId %>;

    // 일차마다 부착된 여행지 검색 버튼 클릭 시 여행지 검색창 표시
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

    // 여행지 검색 버튼 클릭 시 여행지 검색 결과 표시
    $(document).ready(function () {
        $('[id^="search-button-"]').click(function () {
            let searchBtnId = $(this).attr('id');
            let dayOrder = parseInt(searchBtnId.split('-')[2]);
            let categoryId = 'category-' + dayOrder;
            let category = $("#" + categoryId).children("option:selected").val();
            let keywordInputId = 'keyword-' + dayOrder;
            let keyword = $('#' + keywordInputId).val();
            getSpotList(category, keyword, searchBtnId);
        });
    });

    // 검색 여행지 리스트 반환 메소드
    const getSpotList = function (category, keyword, btnId) {
        let dayOrder = parseInt(btnId.split('-')[2]);
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
                $('#' + searchSpotResultsDivId).css({'overflow': 'scroll', 'width': '100%', 'height': '500px'}); // 스크롤
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
                selectedSpotDivHTML += "<span class='col-1 align-self-center'><button type='button' class='btn btn-sm btn-circle btn-soft-red delete-spot-btn' data-spot-content-day-order='" + dayOrder + "'data-spot-content-order='" + spotOrder + "'data-spot-content-id='" + spot.contentId + "'>"
                selectedSpotDivHTML += "<svg style='color: red' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>"
                selectedSpotDivHTML += "<path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z' fill='red'></path>"
                selectedSpotDivHTML += "<path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z' fill='red'></path></svg>"
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
            },
            error: function () {
                alert("여행지 삭제에 실패했습니다.");
            }
        });
    })

    // 항공권 추가 버튼 이벤트 처리

</script>