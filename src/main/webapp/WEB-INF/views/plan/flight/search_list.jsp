<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-15 w-75 p-3">
        <div class="row d-flex justify-content-center">
            <div class="col-md-10">
                <div class="ps-8 pb-5">
                    <h5>${depDate}</h5>
                    <h3>${depAirportName}발 - ${arrAirportName}행 항공편 목록</h3>
                    <a href="search" role="button" class="btn btn-orange col-md-12">재검색</a>
                </div>

                <h3 class="my-2 align-self-center">
                    <c:if test="${empty list}">
                        <c:out value="${message}"/>
                    </c:if>
                </h3>

                <ul>
                    <c:forEach items="${list}" var="flight">
                        <div class="card p-4 mt-2">
                            <div class="card-body align-items-center justify-content-between">
                                <div class="row">
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
                                        <div>
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
                                            <button type="button"
                                                    class="btn btn-outline-orange" onclick="goToAirlineHomepage('${flight.airlineName}')">
                                                예매
                                            </button>
                                            <button type="button"
                                                    class="btn btn-orange mt-1 text-white">
                                                추가
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
            </div>
        </div>
    </div>
</section>
<script>
    let currentPage = 1;
    let isLoading = false;

    let depAirportName = "${depAirportName}";
    let arrAirportName = "${arrAirportName}";
    let depDate = "${depDate}";
    let totalPageCount = "${totalPageCount}";

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
            getFlightList(currentPage);
        }
    });

    // 무한 스크롤 항공편 리스트 반환 메소드
    const getFlightList = function (currentPage) {
        let pageNum = currentPage;
        $.ajax({
            method: "get",
            url: "search-page",
            contentType: "application/json; charset=UTF-8",
            dataType: "html",
            data: {
                pageNum: pageNum,
                depAirportName: depAirportName,
                arrAirportName: arrAirportName,
                depDate: depDate
            },
            success: function (result) {
                $("#flight-list").html(result);
                isLoading = false;
            },
            error: function () {
                alert("오류가 발생했습니다.");
            }
        });
    }

    // 예매하기 버튼 클릭 시 항공사명과 일치하는 항공사 홈페이지 새창 열기하는 메소드
    const goToAirlineHomepage = function(airlineName){
        let homepageUrl = "";
        switch (airlineName) {
            case "대한항공":
                homepageUrl = "https://www.koreanair.com";
                break;
            case "아시아나항공":
                homepageUrl = "https://www.flyasiana.com";
                break;
            case "에어서울":
                homepageUrl = "http://flyairseoul.com";
                break;
            case "에어부산":
                homepageUrl = "https://www.airbusan.com";
                break;
            case "이스타항공":
                homepageUrl = "https://www.eastarjet.com";
                break;
            case "제주항공":
                homepageUrl = "https://www.jejuair.net";
                break;
            case "하이에어":
                homepageUrl = "https://www.hi-airlines.com";
                break;
            case "진에어":
                homepageUrl = "https://www.jinair.com";
                break;
            case "티웨이항공":
                homepageUrl = "https://www.twayair.com";
                break;
            case "에어로케이":
                homepageUrl = "https://www.aerok.com";
                break;
            default:
                homepageUrl = null; // 항공사 없는 경우
        }

        if (homepageUrl) {
            window.open(homepageUrl, "_blank");
        }
    }
</script>