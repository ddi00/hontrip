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

    // 회원정보 갱신
    var refreshUserInfoButton = document.getElementById("refreshUserInfoButton");

    // 버튼을 클릭할 때 fetch 요청을 보냅니다.
    refreshUserInfoButton.addEventListener("click", function(event) {
      event.preventDefault(); // 기본 링크 동작을 막습니다.

      // fetch 요청을 보냅니다.
      fetch("/hontrip/user/refresh-userInfo", {
        method: "GET", // GET 요청
        headers: {
          "Content-Type": "application/json" // 요청 헤더 설정 (필요에 따라 변경)
        }
      })
          .then(response => {
            if (!response.ok) {
              throw new Error("네트워크 오류"); // 오류 처리 (필요에 따라 변경)
            }
            return response.json();
          })
          .then(data => {
            var userInfoDTO = data;

            // userInfoDTO에서 데이터 추출
            var profileImage = userInfoDTO.profileImage;
            var nickName = userInfoDTO.nickName;
            var email = userInfoDTO.email;
            var gender = userInfoDTO.gender;
            var ageRange = userInfoDTO.ageRange;

            // 이미지 요소를 가져와서 src, alt 속성을 설정합니다.
            var profileImageElement = document.getElementById("userProfileImage");
            profileImageElement.src = profileImage;
            profileImageElement.alt = nickName + '의 프로필 이미지';


            //닉네임 변경
            document.getElementById("userNickName").textContent=nickName;
            //이메일 변경
            document.getElementById("userEmail").textContent=email;

            //테이블 변경
            document.getElementById("emailInfo").textContent = email;
            document.getElementById("nickNameInfo").textContent = nickName;
            document.getElementById("genderInfo").textContent = gender;
            document.getElementById("ageRangeInfo").textContent = ageRange;

          })
          .catch(error => {
            // 오류 발생 시 처리할 작업을 여기에 추가합니다.
          });
    });


  }
});

