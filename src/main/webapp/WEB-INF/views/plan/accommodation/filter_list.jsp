<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container container-fluid mt-15 mb-20 w-75">
        <h1 class="mt-4 text">필터링된 숙박시설 목록</h1>
        <div class="row">
            <a href="/hontrip/plan/accommodation/list" class="btn btn-custom1 my-5 col-12">전체 숙박시설 보기</a>
        </div>

        <ul class="unordered-list my-5">
            <c:forEach items="${list}" var="accommodation">
                <div class="card mt-2">
                    <div class="card-body">
                      <%--  <p><strong>숙박 id:</strong> ${accommodation.id}--%>
                        <p><%--<strong>숙박 구분:</strong>--%> ${accommodation.categoryName}</p>
                          <p><a href="${accommodation.placeUrl}" target="_blank"><%--<strong>숙박 이름:</strong>--%> ${accommodation.placeName}</a></p>
                        <p><%--<strong>숙박 주소:</strong>--%> ${accommodation.addressName}</p>
                        <p><%--<strong>숙박 전화번호:</strong>--%> ${accommodation.phone}</p>
                        <%--<p>&lt;%&ndash;<strong>숙박 URL:</strong>&ndash;%&gt; <a href="${accommodation.placeUrl}"
                                                       target="_blank">${accommodation.placeUrl}</a></p>--%>
                    </div>
                </div>
            </c:forEach>
        </ul>
    </div>
</section>