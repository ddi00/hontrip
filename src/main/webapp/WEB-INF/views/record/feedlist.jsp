<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

피드 <br>
(공개여부 1인 게시물 모두)<br>
로그인 없이도 볼 수 있음
<hr color="red">

  <section class="wrapper">
      <div class="container pt-12 pt-md-0 pb-16 pb-md-18">
        <div class="grid grid-view projects-masonry mt-md-n20 mt-lg-n22 mb-20">
          <div class="row g-8 g-lg-10 isotope">

     <c:forEach items="${feedlist}" var="postInfoDTO">
         <div class="project item col-md-6 col-xl-4 workshop">
                              <div class="card shadow-lg">
                                <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'><a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}"> <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" /></a></figure>
                                <div class="card-body p-7">
                                  <div class="post-header">
                                    <div class="post-category text-line mb-2 text-aqua">${postInfoDTO.city}</div>
                                    <h3 class="mb-0">${postInfoDTO.title}</h3>
                                  </div>
                                </div>  <!-- /.card-body -->
                              </div> <!-- /.card -->
                             </div> <!-- /.project -->
    </c:forEach>

</body>
</html>
