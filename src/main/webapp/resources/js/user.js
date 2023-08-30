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
        refreshUserInfoButton.addEventListener("click", function (event) {
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
                    document.getElementById("userNickName").textContent = nickName;
                    //이메일 변경
                    document.getElementById("userEmail").textContent = email;

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
    if (window.location.href.includes('/user/my-record')) {

    }
});

function movePage(url) {    //페이지 이동

    // 페이지 번호를 사용하여 fetch 요청 실행
    fetch(url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then(response => response.json())
        .then(data => {
            refreshList(data);
            refreshPaging(data);
        })
        .catch(error => {
        });
}

function sort(){

}

function refreshList(data){ //tbody에 다시 데이터 뿌리기
    const tbody = document.querySelector('#userInfoTable tbody');
    tbody.innerHTML = '';
    data.myRecordList.forEach((record) => {
        const row = tbody.insertRow();
        // 각 열에 데이터를 추가.
        const noCell = row.insertCell(0);
        noCell.textContent = record.no; // No

        const cityCell = row.insertCell(1);
        cityCell.textContent = record.city; // 도시

        const titleCell = row.insertCell(2);
        const link = document.createElement("a");   // 타이틀에 a태그
        link.classList = "page-link moveBtn main-color"
        link.setAttribute("href", `/hontrip/record/postinfo?id=${record.boardId}`);
        link.textContent = record.title;
        titleCell.appendChild(link);

        const startDateCell = row.insertCell(3);
        startDateCell.textContent = record.startDate;// 여행시작날짜

        const endDateCell = row.insertCell(4);
        endDateCell.textContent = record.endDate; // 여행끝날짜

        const createdAtCell = row.insertCell(5);
        createdAtCell.textContent = record.createdAt; // 작성일

        const isVisible = row.insertCell(6);
        isVisible.textContent = record.isVisible === 1 ? "공개" : "비공개";  //공개여부

        const likeCountCell = row.insertCell(7);
        likeCountCell.textContent = record.likeCount; // 좋아요 수

        const cmtCountCell = row.insertCell(8);
        cmtCountCell.textContent = record.cmtCount; // 답글 수

        const lastCell = row.insertCell(9); // 마지막 열 (8번 열)에 추가
        const checkbox = document.createElement("input");
        checkbox.setAttribute("type", "checkbox");
        checkbox.setAttribute("class", "form-check-input selectRow");
        checkbox.setAttribute("value", record.boardId);
        checkbox.setAttribute("required", "required");
        lastCell.appendChild(checkbox);

    });
}

function refreshPaging(data){
    // pagination 다시하기
    const pageInfo = data.pageInfo;
    const paginationContainer = document.querySelector('.pagination');
    paginationContainer.innerHTML = ''; // 기존 pagination 내용 초기화

    // 이전 페이지로 가는 버튼
    if (pageInfo.showPrev) {
        const prevBtn = document.createElement('li');
        prevBtn.classList.add('page-item');
        prevBtn.innerHTML = `
        <a class="page-link" href="#" aria-label="Previous" onclick="movePage('/hontrip/user/my-record/${pageInfo.page - 1}')">
          <span aria-hidden="true"><i class="uil uil-arrow-left"></i></span>
        </a>
      `;
        prevBtn.addEventListener('click', () => {
            if (pageInfo.page > 1) {
                movePage(pageInfo.page - 1);
            }
        });
        paginationContainer.appendChild(prevBtn);
    }

    // 페이지 버튼들
    const pageNumbers = []; // pageNumbers 배열 생성
    for (let i = pageInfo.beginPage; i <= pageInfo.endPage; i++) {
        pageNumbers.push(i);
    }

    pageNumbers.forEach(pageNumber => {
        const pageBtn = document.createElement('li');
        pageBtn.classList.add('page-item');
        if (pageInfo.page === pageNumber) {
            pageBtn.classList.add('active');
        }
        pageBtn.innerHTML = `
        <a class="page-link moveBtn" href="#" onclick="movePage('/hontrip/user/my-record/${pageNumber}')">${pageNumber}</a>
      `;
        paginationContainer.appendChild(pageBtn);
    });

    // 다음 페이지로 가는 버튼
    if (pageInfo.showNext) {
        const nextBtn = document.createElement('li');
        nextBtn.classList.add('page-item');
        nextBtn.innerHTML = `
        <a class="page-link" href="#" aria-label="Next" onclick="movePage('/hontrip/user/my-record/${pageInfo.page + 1}')">
          <span aria-hidden="true"><i class="uil uil-arrow-right"></i></span>
        </a>
      `;
        nextBtn.addEventListener('click', () => {
            if (pageInfo.page < pageInfo.totalPages) {
                movePage(pageInfo.page + 1);
            }
        });
        paginationContainer.appendChild(nextBtn);
    }
}