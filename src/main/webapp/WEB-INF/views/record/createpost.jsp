<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% session.setAttribute("userId", "1"); %>
<% session.setAttribute("nickName", "Alice"); %>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        // DOM 요소들을 가져옴
        const container = document.querySelector('.container');
        const frame = container.querySelector('.frame');
        const fileInput = container.querySelector('input[type="file"]');

        // 파일이 선택되면 호출될 이벤트 리스너
        fileInput.addEventListener('input', () => {

            // 이미지 파일이 아닌 경우 경고 메시지 출력
            if (!isImage(fileInput.files[0])) {
                alert('Image 파일만 업로드 할 수 있습니다.');
                return;
            }

            // FileReader 객체를 생성하고, 선택한 파일을 읽음
            const reader = new FileReader();

            reader.addEventListener('load', () => {
                // 이미지를 생성하고, 썸네일 클래스를 추가하고, 이미지 파일 경로를 설정함
                const img = document.createElement('IMG');
                img.classList.add('thumbnail');
                img.src = reader.result;

                // 생성된 이미지를 frame 요소 마지막에 추가함
                frame.insertAdjacentElement('beforeend', img);
            });

            reader.readAsDataURL(fileInput.files[0]);
        });

        function isImage(file) {
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
<section class="wrapper bg-gray">
    <div class="container pt-10 pb-14 pb-md-16">
        <form action="createpost" method="post" enctype="multipart/form-data">
            <input name="userId" type="hidden" value="${userId}">
            <br>
            썸네일
            <input name="file" type="file">
            <div class="container">
                <div class="frame">

                </div>
            </div>
            <br>
            파일 여러장<br>
            <input type="file" name="multifiles" id="input_imgs" multiple />
            <div>
                <div class="imgs_wrap">

                </div>
            </div>
            <br>
            장소를 선택하세요
            <select name="locationId">
                <c:forEach items="${locationList}" var="locationDTO">
                    <option value="${locationDTO.id}">${locationDTO.city}</option>
                </c:forEach>
            </select>
            <br>
            <br>
            <select name="isVisible">
                <option value="1">공개</option>
                <option value="0">비공개</option>
            </select>
            <br>
            <br>
            <input type="text" name="title" placeholder="제목을 입력해주세요">
            <br>
            <br>
            <textarea name="content" placeholder="내용을 입력해주세요"></textarea>
            <br>
            <button type="submit">전 송</button>
        </form>
    </div>
</section>