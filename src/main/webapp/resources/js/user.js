
document.addEventListener("DOMContentLoaded", function () {// 새 방에 입장
  if (window.location.href.includes('/user/my-page')) {
    // 회원 정보 가져오기
    const emailInfo = document.getElementById("emailInfo").textContent;
    const genderInfo = document.getElementById("genderInfo").textContent;
    const ageRangeInfo = document.getElementById("ageRangeInfo").textContent;

    if (
        emailInfo === "정보없음" ||
        genderInfo === "나이정보 없음" ||
        ageRangeInfo === "정보없음"
    ) {
      const warningAlert = document.getElementById("warningAlert");
      warningAlert.style.display = "block";
    }
  }
});