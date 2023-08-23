<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h2>여행 일정 생성</h2>
        <hr class="my-8"/>
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
                <textarea id="memo" name="memo" class="form-control h-24"></textarea>
            </div>
            <button type="submit" class="btn btn-yellow mb-3 w-100">일정생성</button>
        </form>
    </div>
</section>