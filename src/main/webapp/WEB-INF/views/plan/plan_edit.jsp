<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Plan list</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div>
  <br>
  <form action="plan_update" method="post">
    <table>
      <tr>
        <td> <input  type=hidden  id="id" name="id" value="${plan.id}" required></td>
      </tr>
      <tr>
        <td>user id</td>
        <td> <input  type=text  id="userId" name="userId" value="${plan.userId}" required></td>
      </tr>

      <tr>
        <td>title</td>
        <td><input type=text  id="title" name=title size=20 value="${plan.title}" required></td>
      </tr>

      <tr>
        <td>Start Date</td>
        <td><input type="date" id="startDate" name="startDate" value="${plan.startDate}" required></td>
      </tr>

      <tr>
        <td>End Date</td>
        <td><input type="date" id="endDate" name="endDate" value="${plan.endDate}" required></td>
      </tr>

      <tr>
        <td>Memo</td>
        <td><textarea id="memo" name="memo">${plan.memo}</textarea></td>
      </tr>
      <tr>
        <td colspan=2>
          <input  type=submit  value="수정">
          <input  type=reset   value="다시입력">
        </td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>