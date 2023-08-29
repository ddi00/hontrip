<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<style>
.img_wrap {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 10px;
}

.img_wrap img {
    width: 100%;
    height: auto;
    max-width: 100%;
    max-height: 200px; /* 이미지의 최대 높이 설정 */
    object-fit: cover; /* 이미지가 잘릴 수 있지만 화면에 채우기 위해 늘립니다. */
}
</style>
<script type="text/javascript">

    var sel_files = [];

    document.addEventListener("DOMContentLoaded", function() {
      var inputImgs = document.getElementById("input_imgs");
      inputImgs.addEventListener("change", function(e) {
        handleImgsFilesSelect(e, ".imgs_wrap");
      });

      var inputImg = document.getElementById("input_img");
      inputImg.addEventListener("change", function(e) {
        handleImgsFilesSelect(e, ".img_wrap");
      });
    });

    function handleImgsFilesSelect(e, imgWrapSelector) {
      var files = e.target.files;
      var filesArr = Array.prototype.slice.call(files);

      filesArr.forEach(function(f) {
        if (!f.type.match("image.*")) {
          alert("확장자는 이미지 확장자만 가능합니다.");
          return;
        }

        sel_files.push(f);

        var reader = new FileReader();
        reader.onload = function(e) {
          var img = document.createElement("img");
          img.src = e.target.result;
          var imgWrap = document.querySelector(imgWrapSelector);
          imgWrap.appendChild(img);
        };
        reader.readAsDataURL(f);
      });
    }
</script>


<section class="wrapper bg-light">
    <div class="container pt-12 pt-md-14 pb-14 pb-md-16">
        <div class="row gx-md-8 gx-12 gy-12">
            <div class="col-lg-8 mx-auto">
                <form action="createpost" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-12">
                            <input name="userId" type="hidden" value="${userId}">
                        </div>
                        <div>썸네일을 선택하세요</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <div class="img_wrap">

                                </div>
                                <input name="file" id="input_img" type="file" class="form-control" required>
                            </div>
                        </div>
                        <div>이미지를 선택하세요</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <div class="imgs_wrap">

                                </div>
                                <input type="file" name="multifiles" id="input_imgs" class="form-control" multiple>
                            </div>
                        </div>
                        <div>지역을 선택하세요</div>
                        <div class="col-md-12">
                            <div class="form-select-wrapper">
                                <select name="locationId" class="form-select" required>
                                    <option value="" disabled selected>지역을 선택하세요</option>
                                    <c:forEach items="${locationList}" var="locationDTO">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div>여행 기간을 선택하세요</div>
                        <div class="mateDates1">
                                <input
                                        name="startDate"
                                        type="date"
                                        class="form-control"
                                        required
                                >
                                -
                                <input
                                        name="endDate"
                                        type="date"
                                        class="form-control"
                                        required
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
                                <input type="text" name="title" class="form-control">
                                <label for="textInputExample">Title*</label>
                            </div>
                        </div>
                        <div>내용을 작성하시오</div>
                        <div class="col-12">
                            <div class="form-floating">
                                <textarea input name="content" class="form-control" placeholder="content"
                                                                style="height: 180px"></textarea>
                                <label for="textInputExample">Content*</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-orange rounded-xl">작 성</button>
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