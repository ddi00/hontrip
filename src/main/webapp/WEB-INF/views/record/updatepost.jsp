<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="wrapper bg-light">
    <div class="container pt-12 pt-md-14 pb-14 pb-md-16">
        <div class="row gx-md-8 gx-12 gy-12">
            <div class="col-lg-8 mx-auto">
                <form method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div>썸네일을 선택하세요</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <div class="img_wrap">

                                </div>
                                <input name="file" id="input_img" type="file" class="form-control" required>
                            </div>
                        </div>
                        <div>이미지</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <div class="imgs_wrap">
                                <c:forEach items="${postImgList}" var="postImgDTO">
                                    <img src="<c:url value='/${postImgDTO.imgUrl}'/>"
                                          srcset="<c:url value='/${postImgDTO.imgUrl}'/>" alt="" />
                                </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div>지 역</div>
                        <div class="col-md-12">
                            <div class="form-select-wrapper">
                                <h5>${postInfoDTO.city}</h5>
                            </div>
                        </div>
                        <div>여행 기간을 선택하세요</div>
                        <div class="mateDates1">
                                <input
                                        name="startDate"
                                        type="date"
                                        class="form-control"
                                        required
                                        value="${postInfoDTO.startDate}"
                                >
                                -
                                <input
                                        name="endDate"
                                        type="date"
                                        class="form-control"
                                        required
                                        value="${postInfoDTO.endDate}"
                                >
                        </div>
                        <div>게시물 공개 / 비공개</div>
                        <div class="col-md-4">
                            <div class="form-select-wrapper">
                                <select name="isVisible" class="form-select" required>
                                    <option value="1">공개</option>
                                    <option value="0">비공개</option>
                                </select>
                            </div>
                        </div>
                        <div>제목을 작성하시오</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" name="title" class="form-control" value="${postInfoDTO.title}">
                                <label for="textInputExample">Title*</label>
                            </div>
                        </div>
                        <div>내용을 작성하시오</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <textarea input name="content" class="form-control" placeholder="content"
                                                                style="height: 180px">${postInfoDTO.content}</textarea>
                                <label for="textInputExample">Content*</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-orange rounded-xl">수정완료</button>
                    </div>
                </form>
            </div>
            <!-- /column -->
        </div>
        <!-- /column -->
    </div>
    <!-- /.row -->
    </div>
    <!-- /.container -->
</section>
<!-- /section -->
</html>