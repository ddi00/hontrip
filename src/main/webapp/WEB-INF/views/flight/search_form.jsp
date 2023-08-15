<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>

</head>
<body>
<a href="/hontrip" role="button" class="btn btn-light mx-4 mt-4">홈</a>
<div class="container-fluid container rounded shadow-sm my-5 w-75 p-3">
    <form id="myFlight" action="search" method="post">
        <div class="row">
            <div class="col-md-6 col-12 mb-4">
                <div class="form-control d-flex flex-column">
                    <p>출발 공항</p>
                    <span class="form-select-wrapper mb-4">
                <select name="depAirportName" id="depAirportName" form="myFlight" class="selectpicker">
                    <option value="KIMPO" selected>김포</option>
                    <option value="INCHEON">인천</option>
                    <option value="JEJU">제주</option>
                    <option value="GIMHAE">김해</option>
                    <option value="DAEGU">대구</option>
                    <option value="CHEONGJU">청주</option>
                    <option value="GWANGUJU">광주</option>
                    <option value="POHANG">포항</option>
                    <option value="YANGYANG">양양</option>
                    <option value="WONJU">원주</option>
                    <option value="YEOSU">여수</option>
                    <option value="ULSAN">울산</option>
                    <option value="SACHEON">사천</option>
                    <option value="MUAN">무안</option>
                    <option value="GUNSAN">군산</option>
                </select>
            </span>
                </div>
            </div>
            <div class="col-md-6 col-12 mb-4">
                <div class="form-control d-flex flex-column">
                    <p>도착 공항</p>
                    <span class="form-select-wrapper mb-4">
            <select name="arrAirportName" id="arrAirportName" form="myFlight" class="selectpicker">
                <option value="KIMPO">김포</option>
                <option value="INCHEON">인천</option>
                <option value="JEJU" selected>제주</option>
                <option value="GIMHAE">김해</option>
                <option value="DAEGU">대구</option>
                <option value="CHEONGJU">청주</option>
                <option value="GWANGUJU">광주</option>
                <option value="POHANG">포항</option>
                <option value="YANGYANG">양양</option>
                <option value="WONJU">원주</option>
                <option value="YEOSU">여수</option>
                <option value="ULSAN">울산</option>
                <option value="SACHEON">사천</option>
                <option value="MUAN">무안</option>
                <option value="GUNSAN">군산</option>
            </select>
        </span>
                </div>
            </div>
        </div>
            <div class="row">
                <div class="col-md-12 col-12 mb-4">
                    <div class="form-control d-flex flex-column">
                        <p>출발일</p>
                        <span class="mb-4">
                            <input type="date" id="depDate" name="depDate" style="width:220px;height:38px;padding: 10px;" class="bg-light border-0 rounded-1" required>
                        </span>
                    </div>
                </div>
            </div>
        <input type="submit" value="항공편 검색" class="btn btn-primary form-control text-center">
    </form>
</div>

</body>
</html>
