
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
        let globalKeyword=null;
        let globalVisible=null;
        let cityFilterList=[];
        let globalCityFilterList=null;
        const refreshButtons = document.querySelectorAll(".refreshPageBTN");
        refreshButtons.forEach(function (button) {
            button.addEventListener("click", function (event) {
                const pageNumber = button.getAttribute("data-page-number");
                event.preventDefault();
                var pageUrl = `/hontrip/user/my-record/condition?page=${pageNumber}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                refreshPage(pageUrl);
            });
        });

        const sortSelect = document.getElementById('sort-select');
        sortSelect.addEventListener('change',function (e){  //정렬선택
            var keyword = this.value;
            console.log(keyword);
            refreshPage(`/hontrip/user/my-record/condition?keyword=${keyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`);
            globalKeyword=keyword;
        });

        //
        const selectVisible=document.getElementById('visible-select');
        selectVisible.addEventListener('change',function (e){   //공유 선택
            var isVisible = this.value;
            refreshPage(`/hontrip/user/my-record/condition?keyword=${globalKeyword}&isVisible=${isVisible}&cities=${globalCityFilterList}`);
            globalVisible=isVisible;
        })

        const filterCity = document.querySelectorAll('.filter-btn');
        filterCity.forEach(function (cityFilter){   //filter로 도시 선택
            cityFilter.addEventListener('click',function (event){
                event.preventDefault(); // 이벤트 기본 동작을 막음
                var cityId = cityFilter.getAttribute('value');  // id가져오기
                 if (cityFilter.classList.contains('filter-select-btn')) {   // 이미 선택된거면
                    var indexTocityFilterList = cityFilterList.indexOf(cityId);
                    if(indexTocityFilterList !== -1){
                        cityFilterList.splice(indexTocityFilterList,1);
                    }
                     cityFilter.classList.toggle('filter-select-btn');
                } else {
                    cityFilterList.push(cityId);
                     cityFilter.classList.toggle('filter-select-btn');
                }
                 if(cityFilterList.length===0){
                     globalCityFilterList = null;
                 }else{
                     globalCityFilterList = cityFilterList.join(',');
                 }
                var pageUrl = `/hontrip/user/my-record/condition?keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                refreshPage(pageUrl);
            })
        })



        function refreshList(data) { //tbody에 다시 데이터 뿌리기
            document.getElementById("recordTotalCount")
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
                link.classList = "page-link refreshButtons main-color"
                link.setAttribute("href", `/hontrip/record/postinfo?id=${record.boardId}`);
                link.textContent = record.title;
                titleCell.appendChild(link);

                const startDateCell = row.insertCell(3);
                startDateCell.textContent = `${record.startDate} ~ ${record.endDate}`

                const isVisible = row.insertCell(4);
                isVisible.textContent = record.isVisible === 1 ? "공개" : "비공개";  //공개여부

                const likeCountCell = row.insertCell(5);
                likeCountCell.textContent = record.likeCount; // 좋아요 수

                const cmtCountCell = row.insertCell(6);
                cmtCountCell.textContent = record.cmtCount; // 답글 수

                const viewCountCell = row.insertCell(7);
                viewCountCell.textContent = record.viewCount; // 조회수


                const createdAtCell = row.insertCell(8);
                createdAtCell.textContent = record.createdAt; // 작성일

                const lastCell = row.insertCell(9);
                const checkbox = document.createElement("input");
                checkbox.setAttribute("type", "checkbox");
                checkbox.setAttribute("class", "form-check-input selectRow");
                checkbox.setAttribute("value", record.boardId);
                checkbox.setAttribute("required", "required");
                lastCell.appendChild(checkbox);

            });
        }

        function refreshPaging(data) {

            document.getElementById("recordTotalCount").textContent=data.pageInfo.totalCount;

            // pagination 다시하기
            const pageInfo = data.pageInfo;
            const paginationContainer = document.querySelector('.pagination');
            paginationContainer.innerHTML = ''; // 기존 pagination 내용 초기화

            // 맨 첫장 가는 퍼튼
            if (pageInfo.page!=1) {
                const prevBtn = document.createElement('li');
                prevBtn.classList.add('page-item');

                const link = document.createElement("a");
                link.classList = "page-link refreshPageBTN";
                link.setAttribute("aria-label", "firstPage");
                link.setAttribute("data-page-number", '1');
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=1&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                });

                const span = document.createElement("span");
                span.setAttribute("aria-hidden", "true");

                const iClass = document.createElement("i");
                iClass.classList = "uil uil-left-arrow-to-left";

                span.appendChild(iClass);
                link.appendChild(span);
                prevBtn.appendChild(link);
                paginationContainer.appendChild(prevBtn);
            }


            // 이전 페이지로 가는 버튼
            if (pageInfo.showPrev) {
                const prevBtn = document.createElement('li');
                prevBtn.classList.add('page-item');

                const link = document.createElement("a");
                link.classList = "page-link refreshPageBTN";
                link.setAttribute("aria-label", "Prev");
                link.setAttribute("data-page-number", `${pageInfo.page-1}`);
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageInfo.page-1}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                });

                const span = document.createElement("span");
                span.setAttribute("aria-hidden", "true");

                const iClass = document.createElement("i");
                iClass.classList = "uil uil-arrow-left";

                span.appendChild(iClass);
                link.appendChild(span);
                prevBtn.appendChild(link);
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
                const link = document.createElement("a");
                link.classList = "page-link refreshPageBTN";
                link.setAttribute("data-page-number", pageNumber.toString()); // 페이지 번호를 문자열로 설정
                link.textContent = pageNumber.toString();
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageNumber}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                });

                pageBtn.appendChild(link);
                paginationContainer.appendChild(pageBtn);
            });

            // 다음 페이지로 가는 버튼
            if (pageInfo.showNext) {
                const nextBtn = document.createElement('li');
                nextBtn.classList.add('page-item');
                const link = document.createElement("a");
                link.classList = "page-link refreshPageBTN";
                link.setAttribute("aria-label", "Next");
                link.setAttribute("data-page-number", `${pageInfo.page+1}`);
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageInfo.page+1}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                });
                const span = document.createElement("span");
                span.setAttribute("aria-hidden", "true");
                const iClass = document.createElement("i");
                iClass.classList = "uil uil-arrow-right";
                span.appendChild(iClass);
                link.appendChild(span);
                nextBtn.appendChild(link);
                paginationContainer.appendChild(nextBtn);
            }
            // 막장 가는 페이지
            if (pageInfo.page!=pageInfo.totalPage) {
                const nextBtn = document.createElement('li');
                nextBtn.classList.add('page-item');
                const link = document.createElement("a");
                link.classList = "page-link refreshPageBTN";
                link.setAttribute("aria-label", "lastPage");
                link.setAttribute("data-page-number", `${pageInfo.totalPage}`);
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageInfo.totalPage}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                });
                const span = document.createElement("span");
                span.setAttribute("aria-hidden", "true");
                const iClass = document.createElement("i");
                iClass.classList = "uil uil-arrow-to-right";
                span.appendChild(iClass);
                link.appendChild(span);
                nextBtn.appendChild(link);
                paginationContainer.appendChild(nextBtn);
            }

        }
    }
    function refreshPage(url) {    //페이지 이동
        fetch(url, {    // 페이지 번호를 사용하여 fetch 요청 실행
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
});

