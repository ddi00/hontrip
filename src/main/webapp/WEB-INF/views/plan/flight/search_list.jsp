<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--jquery cdn 따로 삽입 안 해주면 Uncaught ReferenceError: $ is not defined 발생하여 무한 스크롤 되지 않음 확인--%>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-15 w-75 p-3">
        <div class="row d-flex justify-content-center">
            <div class="col-md-10">
                <div class="ps-8 pb-5">
                    <h5>${depDate}</h5>
                    <h3>${depAirportName}발 - ${arrAirportName}행 항공편 목록</h3>
                    <a href="search" role="button" class="btn btn-yellow col-md-12">재검색</a>
                </div>
                <ul>
                    <c:forEach items="${list}" var="flight">
                        <div class="card p-4 mt-2">
                            <div class="card-body align-items-center justify-content-between">
                                <div class="row d-flex">
                                    <div class="col-md-4">
                                        <div id="departure-info">
                                            <span style="display:none">출발 시간</span>
                                            <span>
                                <fmt:parseDate value="${flight.departureTime}" var="departureTime"
                                               pattern="yyyy-MM-dd HH:mm:ss"/>
                                <fmt:formatDate value="${departureTime}" pattern="HH:mm"/>
                                    </span>
                                            <span style="display:none">출발 공항</span>
                                            <span>${flight.depAirportName}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="arrival-info">
                                            <span style="display:none">도착 시간</span>
                                            <span>
                                <fmt:parseDate value="${flight.arrivalTime}" var="arrivalTime"
                                               pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:formatDate value="${arrivalTime}" pattern="HH:mm"/>
                                    </span>
                                            <span style="display:none">도착 공항</span>
                                            <span>${flight.arrAirportName}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex flex-column align-items-center float-end">
                                            <button type="button" id="book-btn" name="book-btn"
                                                    class="btn btn-outline-yellow">
                                                예매하기
                                            </button>
                                            <button type="button" id="add-btn" name="add-btn"
                                                    class="btn btn-custom1 mt-1 text-white">
                                                추가하기
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <span style="display:none">항공편명</span>
                                        <span>${flight.vehicleId}</span>
                                        <span>/</span>
                                        <span style="display:none">항공사명</span>
                                        <span>${flight.airlineName}</span>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <span>이코노미석 운임</span>
                                        <span>
                                        <c:set var="economyCharge" value="${flight.economyCharge}"/>
                                        <c:choose>
                                            <c:when test="${economyCharge == '0'}"> <c:out value="미제공"/> </c:when>
                                            <c:when test="${economyCharge != '0'}">
                                                <fmt:formatNumber value="${flight.economyCharge}" pattern="###,###"/>
                                            </c:when>
                                        </c:choose>
                                    </span>
                                        <span>/</span>
                                        <span>프레스티지석 운임</span>
                                        <span>
                                        <c:set var="prestigeCharge" value="${flight.prestigeCharge}"/>
                                        <c:choose>
                                            <c:when test="${prestigeCharge == '0'}"> <c:out value="미제공"/> </c:when>
                                            <c:when test="${prestigeCharge != '0'}">
                                                <fmt:formatNumber value="${flight.prestigeCharge}" pattern="###,###"/>
                                            </c:when>
                                        </c:choose>
                                    </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </ul>
                <ul id="flight-list">
                </ul>
                <%--             로딩 spinner      --%>
                <div class="text-center">
                    <div class="spinner-border text-warning" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    let currentPage = 1;
    let isLoading = false;

    $(window).on("scroll", function () {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();

        let isBottom = scrollTop + windowHeight + 10 >= documentHeight;

        if (isBottom) {
            if (currentPage == ${totalPageCount} || isLoading) {
                return;
            }
            isLoading = true;
            $(".spinner-border").show();
            currentPage++;
            GetFlightList(currentPage);
        }
    });

    const GetFlightList = function (currentPage) {
        let pageNum = currentPage;
        $.ajax({
            type: "get",
            url: "search-page",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            data: {
                pageNum: pageNum,
                depAirportName: "${depAirportName}",
                arrAirportName: "${arrAirportName}",
                depDate: "${depDate}"
            },
            success: function (result) {
                $("#flight-list").html(result);
                $(".spinner-border").hide();
                isLoading = false;
            },
            error: function () {
                alert("오류가 발생했습니다.");
            }
        });
    } // GetFlightList
</script>
</body>
</html>