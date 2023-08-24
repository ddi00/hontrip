<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<a href="feedlist?isVisible=1"><button>공유피드</button></a><br>
<a href="createpost"><button>게시글작성버튼</button></a><br>
검색어 입력한 내 게시물 해당지역 리스트
<hr color="red">
    <c:forEach items="${mylist}" var="createPostDTO">
        유저정보 : ${createPostDTO.userId},
        지역id : ${createPostDTO.locationId},
        썸네일 : ${createPostDTO.thumbnail},
        글제목 : ${createPostDTO.title},
        공개여부: ${createPostDTO.isVisible} <br>
    </c:forEach>

