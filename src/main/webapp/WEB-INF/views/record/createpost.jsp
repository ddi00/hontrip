<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>

<script type="text/javascript">
    window.addEventListener('load', function() {

    	const container = document.querySelector('.container');
    	const frame = container.querySelector('.frame');
    	const fileInput = container.querySelector('input[type="file"]');

    	fileInput.addEventListener('input', () => {

    		if(!isImage(fileInput.files[0])) {
    			alert('Image 파일만 업로드 할 수 있습니다.');
    			return;
    		}

    		const reader = new FileReader();

    		reader.addEventListener('load', () => {

    			const img = document.createElement('IMG');
    			img.classList.add('thumbnail');
    			img.src = reader.result;

    			frame.insertAdjacentElement('beforeend', img);
    		});

    		reader.readAsDataURL(fileInput.files[0]);
    	});

    	function isImage(file){
    		return file.type.indexOf('image') >= 0;
    	}
    });



    //멀티이미지 미리보기
    var sel_files = [];

    document.addEventListener("DOMContentLoaded", function() {
        var inputImgs = document.getElementById("input_imgs");
        inputImgs.addEventListener("change", handleImgsFilesSelect);
    });

    function handleImgsFilesSelect(e) {
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
                var imgWrap = document.querySelector(".imgs_wrap");
                imgWrap.appendChild(img);
            };
            reader.readAsDataURL(f);
        });
    }
</script>
<section class="wrapper bg-light">
    <div class="container pt-12 pt-md-14 pb-14 pb-md-16">
        <div class="row gx-md-8 gx-xl-12 gy-12">
            <div class="col-lg-8">
                <div>
                    <div class="frame">

                    </div>
                    <div class="imgs_wrap">

                    </div>
                </div>
                <form action="createpost" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-12">
                            <input name="userId" type="hidden" value="${userId}">
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                            썸네일
                                <input name="file" type="file" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                            이미지
                                <input type="file" name="multifiles" id="input_imgs" class="form-control" multiple>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" name="title" class="form-control">
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" name="content" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-select-wrapper">
                                <select name="locationId" class="form-select" required>
                                    <c:forEach items="${locationList}" var="locationDTO">
                                        <option value="${locationDTO.id}">${locationDTO.city}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback"> Please select a valid country. </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-select-wrapper">
                                <select name="isVisible" class="form-select" required>
                                    <option value="1">공개</option>
                                    <option value="0">비공개</option>
                                </select>
                                <div class="invalid-feedback"> Please provide a valid state. </div>
                            </div>
                        </div>
                    </div>
                    <hr class="mt-7 mb-6">
                    <button type="submit">전 송</button>
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
</section>