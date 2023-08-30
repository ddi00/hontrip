<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="search-accommodation-results row" id="search-accommodation-results-<%=i + 1%>">
  <c:forEach items="${list}" var="accommodation">
    <div class="card mt-2">
      <div class="card-body">
        <p><strong>숙박 id:</strong> ${accommodation.id}</p>
        <p><strong>숙박 구분:</strong> ${accommodation.categoryName}</p>
        <p><strong>숙박 이름:</strong> ${accommodation.placeName}</p>
        <p><strong>숙박 주소:</strong> ${accommodation.addressName}</p>
        <p><strong>숙박 전화번호:</strong> ${accommodation.phone}</p>
        <p><strong>숙박 URL:</strong> <a href="${accommodation.placeUrl}" target="_blank">${accommodation.placeUrl}</a></p>
        <button type="button" id="add-accommodation-btn-${i + 1}-${accommodation.id}" class="btn btn-soft-aqua" data-accommodation-id="${accommodation.id}" data-accommodation-place-name="${accommodation.placeName}">
          숙소 추가
        </button>
      </div>
    </div>
  </c:forEach>
</div>
