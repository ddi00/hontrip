<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="div-accommodation-search-results-for-plan" class="row justify-content-start align-content-center">
  <%--            검색 데이터 없는 경우 메시지 표시       --%>
  <h3 class="my-2 align-self-center">
    <c:if test="${empty list}">
      <c:out value="${message}"/>
    </c:if>
  </h3>

    <%--            검색 숙박지 목록       --%>

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
        <button type="button" id="add-accommodation-btn-${i + 1}-${accommodation.id}" class="btn btn-soft-aqua"
                data-accommodation-id="${accommodation.id}" data-accommodation-place-name="${accommodation.placeName}">
          숙소 추가
        </button>
      </div>
    </div>
  </c:forEach>
</div>
