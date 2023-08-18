<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan Form</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>여행 일정 생성</h2>
<form id="myForm" action="insert" method="post">

  <label for="title">Title:</label>
  <input type="text" id="title" name="title" required><br>

  <label for="startDate">Start Date:</label>
  <input type="date" id="startDate" name="startDate" required><br>

  <label for="endDate">End Date:</label>
  <input type="date" id="endDate" name="endDate" required><br>

  <label for="memo">Memo:</label>
  <textarea id="memo" name="memo"></textarea><br>

  <input type="submit" value="일정생성">
</form>
</body>
</html>--%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan Form</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
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
    <button type="submit" class="btn btn-custom mb-3 full-width-btn">일정생성</button>
  </form>
</div>
</body>
</html>
