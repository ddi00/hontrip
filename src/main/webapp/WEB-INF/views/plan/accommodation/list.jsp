<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container container-fluid mt-15 mb-20 w-75">
        <div class="text-center">
            <h1 class="mb-5">숙소 목록</h1>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/plan/accommodation/filter_list">
            <div class="row mb-3">
                <div class="custom-col-5">
                    <input type="text" name="addressName" class="form-control" placeholder="주소 입력">
                </div>
                <div class="custom-col-5">
                    <input type="text" name="placeName" class="form-control" placeholder="이름 입력">
                </div>
                <div class="col-auto">
                    <button type="submit" name="filterType" value="address_place" class="btn btn-orange">
                        검색
                    </button>
                </div>
            </div>
        </form>
      <%--  <ul class="unordered-list">
            <c:forEach items="${list}" var="accommodation">
                <div class="card mt-2">
                    <div class="card-body">
                        <p><strong>숙박 id:</strong> ${accommodation.id}
                        <p><strong>숙박 구분:</strong> ${accommodation.categoryName}</p>
                        <p><strong>숙박 이름:</strong> ${accommodation.placeName}</p>
                        <p><strong>숙박 주소:</strong> ${accommodation.addressName}</p>
                        <p><strong>숙박 전화번호:</strong> ${accommodation.phone}</p>
                        <p><strong>숙박 URL:</strong> <a href="${accommodation.placeUrl}"
                                                       target="_blank">${accommodation.placeUrl}</a></p>
                    </div>
                </div>
            </c:forEach>
        </ul>--%>
    </div>
</section>