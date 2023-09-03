<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1>${locationName} 지역 안전정보 검색 결과</h1>
        <table id="safety-table" class="table table-striped table-bordered mt-3">
            <thead class="thead-dark">
            <tr>
                <th scope="col" class="text-center">날짜</th>
              <%--  <th scope="col" class="text-center">지역명</th>--%>
                <th scope="col" class="text-center">안전정보</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${result}">
                <c:forEach var="message" items="${entry.row}">
                    <tr>
                        <td>${message.create_date}</td>
                        <%--<td>${message.location_name}</td>--%>
                        <td>${message.msg}</td>
                    </tr>
                </c:forEach>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty result}">
            <div class="alert alert-warning mt-3" role="alert">
                검색결과가 없습니다.
            </div>
        </c:if>

        <div class="row mt-3">
            <div class="col-md-12 text-center">
               <%-- <button id="retrySafetySearch" class="btn btn-orange" onclick="location.href='/hontrip/plan/safety_search'">재검색</button>--%>
                   <button id="retrySafetySearch" class="btn btn-primary" >다시 검색하기</button>
            </div>
        </div>
    </div>
</section>