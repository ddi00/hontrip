<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h2>${keyword} 검색 결과</h2>
        <form id="spot-list-search-form" action="search" method="post" class="mt-5">
            <div class="custom-form-container">
                <div class="col-md-2 me-2">
                    <select class="form-select" id="category" name="category" form="spot-list-search-form" aria-label="검색 범주">
                        <option value="keyword" selected>여행지명</option>
                        <option value="area">지역명</option>
                    </select>
                </div>
                <input type="text" id="keyword" name="keyword" class="custom-form-control col-8 me-2">
                <input type="submit" value="검색" class="btn btn-yellow col-md-2">
            </div>
        </form>
        <div id="spot-list" class="row justify-content-start align-content-center">
            <%--            검색 데이터 없는 경우 메시지 표시       --%>
            <h3 class="my-2 align-self-center">
                <c:if test="${empty list}">
                    <c:out value="${message}"/>
                </c:if>
            </h3>
            <%--            검색 여행지 목록       --%>
            <c:forEach items="${list}" var="spot">
                <div class="custom-card ms-3 my-2 custom-col-3">
                    <div class="custom-card-body">
                        <div><img src="${spot.image}" alt="대표 이미지" class="custom-card-img"></div>
                        <div class="mt-2">
                            <h5><a href="detail?category=${category}&keyword=${keyword}&contentId=${spot.contentId}"
                                   class="custom-a">${spot.title}</a></h5>
                            <p>${spot.address}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>