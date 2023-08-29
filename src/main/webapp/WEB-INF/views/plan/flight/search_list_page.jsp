<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <button type="button"
                                class="btn btn-outline-orange">
                            예매하기
                        </button>
                        <button type="button"
                                class="btn btn-orange mt-1 text-white">
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