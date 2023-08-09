<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-09
  Time: 오후 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>일정 목록</h1>
<ul type="circle">
  <c:forEach items="${list}" var="planDTO">
    사용자 id : ${planDTO.userId} <br>
    제목 : ${planDTO.title} <br>
    시작일 : ${planDTO.startDate} <br>
    종료일 : ${planDTO.endDate} <br>
    메모 : ${planDTO.memo} <br>
    생성일시 : ${planDTO.createdAt} <br>
    수정일시 : ${planDTO.updatedAt} <br>
    <hr>
  </c:forEach>
</ul>
