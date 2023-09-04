<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mt-4">응급시설 목록</h1>
        <div class="row">
            <a href="/hontrip/plan/emergency_facility/list" class="btn btn-orange col-12 my-5">다시 검색하기
                </a>
            <ul class="unordered-list mt-4">
                <c:forEach items="${list}" var="emergency_facility">
                    <div class="card mt-2">
                        <div class="card-body left-aligned">
                                <%--  <strong>응급시설 id:</strong> ${emergency_facility.id}<br>--%>
                                <%-- <strong>응급시설 카테고리 그룹:</strong>--%> ${emergency_facility.categoryGroupName}<br>
                            <a href="${emergency_facility.placeUrl}" target="_blank">${emergency_facility.placeName}</a><br>
                                <%--<strong>응급시설 이름:</strong> ${emergency_facility.placeName}--%>
                            <strong>주소:</strong> ${emergency_facility.addressName}<br>
                            <strong>연락처:</strong> ${emergency_facility.phone}<br>
                                <%-- <strong>응급시설 URL:</strong> <a href="${emergency_facility.placeUrl}"
                                                               target="_blank"
                                                               class="custom-a">${emergency_facility.placeUrl}</a><br>--%>
                        </div>
                    </div>
                </c:forEach>
            </ul>

            <c:if test="${empty list}">
                <div class="alert alert-warning mt-3" role="alert">
                    검색결과가 없습니다.
                </div>
            </c:if>

        </div>
    </div>
</section>