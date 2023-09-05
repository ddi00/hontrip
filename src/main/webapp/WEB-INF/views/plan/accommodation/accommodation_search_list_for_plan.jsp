<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="div-accommodation-search-results-for-plan" class="row justify-content-center align-content-center">
  <div class="col-6">
  <%--            검색 데이터 없는 경우 메시지 표시       --%>
  <h3 class="my-2 align-self-center">
    <c:if test="${empty list}">
      <c:out value="${message}"/>
    </c:if>
  </h3>

    <%--            검색 숙박지 목록       --%>

  <c:forEach items="${list}" var="accommodation">
    <div class="card col-11 mt-2 ms-4 me-5">
      <div class="card-body">
          <%--  <p><strong>숙박 id:</strong> ${accommodation.id}--%>
        <div class="row mb-2">
          <div class="mb-2">${accommodation.categoryName}</div>
          <h4><a href="${accommodation.placeUrl}" target="_blank">${accommodation.placeName}</a></h4>
          <div><i class="uil uil-map-marker"> </i>${accommodation.addressName}</div>
          <div><i class="uil uil-phone"> </i>${accommodation.phone}</div>
        </div>
<%--        <p>&lt;%&ndash;<strong>숙박 구분:</strong>&ndash;%&gt; </p>--%>
<%--        <p><a href="${accommodation.placeUrl}" target="_blank">&lt;%&ndash;<strong>숙박 이름:</strong>&ndash;%&gt; ${accommodation.placeName}</a></p>--%>
<%--        <p>&lt;%&ndash;<strong>숙박 주소:</strong>&ndash;%&gt; <i class="uil uil-map-marker"> </i>${accommodation.addressName}</p>--%>
<%--        <p>&lt;%&ndash;<strong>숙박 전화번호:</strong>&ndash;%&gt; <i class="uil uil-phone"> </i>${accommodation.phone}</p>--%>
<%--          &lt;%&ndash;<p>&lt;%&ndash;<strong>숙박 URL:</strong>&ndash;%&gt; <a href="${accommodation.placeUrl}"--%>
<%--                                         target="_blank">${accommodation.placeUrl}</a></p>&ndash;%&gt;--%>
        <button type="button" id="add-accommodation-btn-${i + 1}-${accommodation.id}" class="btn btn-soft-yellow"
                data-accommodation-id="${accommodation.id}" data-accommodation-place-name="${accommodation.placeName}">
          추가
        </button>
      </div>
    </div>
  </c:forEach>
  </div>
</div>