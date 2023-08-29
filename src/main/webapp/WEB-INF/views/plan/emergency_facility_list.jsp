<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mb-5">응급시설 목록</h1>
        <form id="emergency_facility_search_form" class="mt-3 left-aligned" method="post" action="filter_list">
            <div class="input-group mb-3">
                <select id="categorySelect" name="categoryGroupName" form="emergency_facility_search_form"
                        class="form-select">
                    <option value="" selected>전체</option>
                    <option value="병원">병원</option>
                    <option value="약국">약국</option>
                </select>
                <input type="text" id="addressName" name="addressName" class="form-control me-2" placeholder="주소 입력"
                       value="">
                <button type="submit" name="filterType" value="address" class="btn btn-orange">검색</button>
            </div>
        </form>
        <ul class="unordered-list mt-4">
            <c:forEach items="${list}" var="emergency_facility">
                <div class="card mt-2">
                    <div class="card-body left-aligned">
                            <strong>응급시설 id:</strong> ${emergency_facility.id}<br>
                            <strong>응급시설 카테고리 그룹:</strong> ${emergency_facility.categoryGroupName}<br>
                            <strong>응급시설 이름:</strong> ${emergency_facility.placeName}<br>
                            <strong>응급시설 주소:</strong> ${emergency_facility.addressName}<br>
                            <strong>응급시설 전화번호:</strong> ${emergency_facility.phone}<br>
                            <strong>응급시설 URL:</strong> <a href="${emergency_facility.placeUrl}" target="_blank"
                                                          class="custom-a">${emergency_facility.placeUrl}</a><br>
                        </div>
                </div>
            </c:forEach>
        </ul>
    </div>
</section>
>