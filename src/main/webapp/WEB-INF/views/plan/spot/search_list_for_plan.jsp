<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row justify-content-start align-content-center">
<%--            검색 데이터 없는 경우 메시지 표시       --%>
<h3 class="my-2 align-self-center">
  <c:if test="${empty list}">
    <c:out value="${message}"/>
  </c:if>
</h3>
<%--            검색 여행지 목록       --%>
<c:forEach items="${list}" var="spot" varStatus="status">
  <div class="custom-card ms-3 my-2 col-5">
    <div class="custom-card-body">
      <div><img src="${spot.image}" alt="대표 이미지" class="custom-card-img"></div>
      <div class="mt-2">
        <h5>${spot.title}</h5>
        <p>${spot.address}</p>
        <button id="add-spot-btn-${status.index+1}" class="btn btn-sm btn-soft-orange"
                data-spot-content-day-order="${dayOrder}" data-spot-content-id="${spot.contentId}" data-spot-title="${spot.title}">
          추가</button>
      </div>
    </div>
  </div>
</c:forEach>
</div>