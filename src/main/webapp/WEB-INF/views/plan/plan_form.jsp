<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-09
  Time: 오후 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan Form</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>여행 일정 생성</h2>
<form id="myForm">
  <label for="title">Title:</label>
  <input type="text" id="title" name="title" required><br>

  <label for="start_date">Start Date:</label>
  <input type="date" id="start_date" name="start_date" required><br>

  <label for="end_date">End Date:</label>
  <input type="date" id="end_date" name="end_date" required><br>

  <label for="memo">Memo:</label>
  <textarea id="memo" name="memo"></textarea><br>

  <input type="submit" value="일정생성">
</form>

<script>
  /*$(document).ready(function() {
    $("#createPlanButton").click(function() {*/

  $(document).ready(function() {
    $("#myForm").submit(function(event) {
      event.preventDefault(); // 폼 제출 방지

      var formData = {
        title: $("#title").val(),
        start_date: $("#start_date").val(),
        end_date: $("#end_date").val(),
        memo: $("#memo").val()
      };

      // ajax 요청
      $.ajax({
        url: "insert_plan",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(response) {
          // 일정 생성 후 폼 초기화
          $("#title").val("");
          $("#start_date").val("");
          $("#end_date").val("");
          $("#memo").val("");

          // 서버로부터의 응답을 처리
          console.log(response);
        },
        error: function(xhr, status, error) {
          // 에러 처리
          console.error(error);
        }
      });
    });
  });
</script>
</body>
</html>