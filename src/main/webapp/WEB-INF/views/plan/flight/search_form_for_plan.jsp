<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="search-flight-form">
  <div class="row">
    <div class="col-md-6 mb-4">
      <div class="form-control d-flex flex-column">
        <p>출발 공항</p>
        <span class="form-select-wrapper mb-4">
                <select name="depAirportName" id="depAirportName" form="search-flight-form" class="form-select show-tick" required>
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
    <div class="col-md-6 mb-4">
      <div class="form-control d-flex flex-column">
        <p>도착 공항</p>
        <span class="form-select-wrapper mb-4">
            <select name="arrAirportName" id="arrAirportName" form="search-flight-form" class="form-select" required>
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
    <div class="col-md-12 mb-4">
      <div class="form-control d-flex flex-column">
        <p>출발일</p>
        <span class="mb-4">
                            <input type="date" id="depDate" name="depDate"
                                   class="form-control"
                                   required>
                        </span>
      </div>
    </div>
  </div>
    <button type="button" id="search-flight-button" class="btn btn-orange col-md-12">
        검색
    </button>
</form>