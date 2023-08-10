<%--
  Created by IntelliJ IDEA.
  User: CR_YOO
  Date: 2023-08-09
  Time: 오후 5:30
  To change this template use File | Settings | File Templates.
--%>

<%--여행 일정 생성--%>

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
        <form id="myForm" action="insert_plan" method="post">

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
</html>