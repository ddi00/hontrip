<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <style>
    	.thumbnail{
    		width: 300px;
    		height: 180px;
    	}
    </style>

    <% session.setAttribute("userId", "1"); %>
    <% session.setAttribute("nickName", "Alice"); %>

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
    </script>
</head>
<body>
    <form action="createpost" method="post" enctype="multipart/form-data">
        <input name="userId" type="hidden" value="${userId}">
        <br>
        썸네일<div class="container">
           	<input name="file" type="file">
           	<div class="frame">

           	</div>
           </div>
        <br>
        <br>
        <select name="isVisible">
            <option value="1">공개</option>
            <option value="0">비공개</option>
        </select>
        <br>
        <br>
        <select name="locationId">
                    <option value="1">서울</option>
                    <option value="2">인천</option>
        </select>
        <br>
        <br>
        <input type="text" name="title" placeholder="제목을 입력해주세요">
        <br>
        <br>
        <textarea name="content" placeholder="${postInfoDTO.content}"></textarea>
        <br>
        <button type="submit">전 송</button>
    </form>
</body>
</html>