<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row d-flex justify-content-center">
    <div class="col-12">
        <div class="ps-8 pb-5">
            <h5>${depDate}</h5>
            <h3>${depAirportName}발 - ${arrAirportName}행 항공편 목록</h3>
        </div>

        <h3 class="my-2 align-self-center">
            <c:if test="${empty list}">
                <c:out value="${message}"/>
            </c:if>
        </h3>

        <ul>
            <c:forEach items="${list}" var="flight" varStatus="status">
                <div class="custom-card-for-plan p-4 mt-2 me-7">
                    <div class="card-body-for-plan-flight-search justify-content-start">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <span><h3>${flight.depAirportName}</h3></span>
                                <span>
                                <fmt:parseDate value="${flight.departureTime}" var="departureTime"
                                               pattern="yyyy-MM-dd HH:mm:ss"/>
                                <fmt:formatDate value="${departureTime}" pattern="HH:mm"/>
                                    </span>
                            </div>
                            <div class="col-md-2 text-center">
                                <i class="uil uil-plane-fly"></i>
                            </div>
                            <div class="col-md-5 text-center">
                                <span><h3>${flight.arrAirportName}</h3></span>
                                <span>
                                <fmt:parseDate value="${flight.arrivalTime}" var="arrivalTime"
                                               pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:formatDate value="${arrivalTime}" pattern="HH:mm"/>
                                    </span>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <span>${flight.vehicleId}</span>
                                <span>/</span>
                                <span>${flight.airlineName}</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 text-center" style="font-size: 0.7rem;">
                                <span>이코노미</span>
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
                                <span>프레스티지</span>
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
                        <div class="row mt-2">
                            <div class="col-6 text-center">
                                <button type="button"
                                        class="btn btn-outline-green w-100"
                                        onclick="goToAirlineHomepage('${flight.airlineName}')">
                                    예매
                                </button>
                            </div>
                            <div class="col-6 text-center">
                                <button id="add-flight-btn-${status.index+1}" type="button"
                                        class="btn btn-green text-white w-100" data-flight-id="${flight.id}">
                                    추가
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </ul>
    </div>
</div>

<script>
    let depAirportName = "${depAirportName}";
    let arrAirportName = "${arrAirportName}";
    let depDate = "${depDate}";

    // 예매하기 버튼 클릭 시 항공사명과 일치하는 항공사 홈페이지 새창 열기하는 메소드
    const goToAirlineHomepage = function (airlineName) {
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