<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Disaster Message API Search Result</title>
</head>
<body>
<h1>검색 결과</h1>
<p>수신지역 이름: ${locationName}</p>
<button onclick="location.href='/hontrip/plan/safety_search'">다시 검색하기</button>
<p>API 응답:</p>

<!-- Debug: Print the content of the "result" attribute -->
<%--<pre>
  ${result}
</pre>--%>

<table>
  <tr>
    <th>날짜</th>
    <th>지역명</th>
    <th>메세지</th>
  </tr>
  <c:forEach var="entry" items="${result}">
    <c:forEach var="i" begin="0" end="9">
      <c:set var="message" value="${entry.row[i]}"/>
      <tr>
        <td>${message.create_date}</td>
        <td>${message.location_name}</td>
        <td>${message.msg}</td>
      </tr>
    </c:forEach>
    <tr>
      <td colspan="3"><hr></td>
    </tr>
  </c:forEach>
</table>
</body>
</html>


