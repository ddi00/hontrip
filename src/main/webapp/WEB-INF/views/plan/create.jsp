<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>일정 생성</title>
  <style>
    #memo {
      height: 200px;
    }
    .btn-custom {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }
    .full-width-btn {
      width: 100%;
    }
  </style>
</head>
<body>
<div class="container container-fluid">
  <h2 class="mb-4">여행 일정 생성</h2>
  <div class="line"></div>
  <hr>
  <form id="myForm" action="insert" method="post">
    <div class="mb-3">
      <label for="title" class="form-label">Title:</label>
      <input type="text" id="title" name="title" class="form-control" required>
    </div>
    <div class="row mb-3">
      <div class="col">
        <label for="startDate" class="form-label">Start Date:</label>
        <input type="date" id="startDate" name="startDate" class="form-control" required>
      </div>
      <div class="col">
        <label for="endDate" class="form-label">End Date:</label>
        <input type="date" id="endDate" name="endDate" class="form-control" required>
      </div>
    </div>
    <div class="mb-3">
      <label for="memo" class="form-label">Memo:</label>
      <textarea id="memo" name="memo" class="form-control"></textarea>
    </div>
    <button type="submit" class="btn btn-custom mb-3 full-width-btn text-white">일정생성</button>
  </form>
</div>
</body>
</html>