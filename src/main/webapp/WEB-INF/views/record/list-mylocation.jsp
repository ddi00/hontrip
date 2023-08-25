<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="list-mylocation">
<a href="feedlist?isVisible=1"><button>공유피드</button></a><br>
<a href="createpost"><button>게시글작성버튼</button></a><br>
마커클릭한 내 게시물 해당지역 리스트
<hr color="red">
    <c:forEach items="${mylist}" var="postInfoDTO">
      <div id ="mylistone">
        <img src="<c:url value='/${postInfoDTO.thumbnail}'/>"width="300" height="180"><br>,
        유저정보 : ${postInfoDTO.userId},
        지역id : ${postInfoDTO.locationId},
        글제목 : ${postInfoDTO.title},
        공개여부: ${postInfoDTO.isVisible} <br>
      </div>
    </c:forEach>
</div>

