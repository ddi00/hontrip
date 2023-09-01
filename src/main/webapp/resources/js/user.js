document.addEventListener("DOMContentLoaded", function () {// my-record 입장
    if (window.location.href.includes('/user/my-record')) {
        let globalKeyword = null;
        let globalVisible = null;
        let cityFilterList = [];
        let globalCityFilterList = null;
        const refreshButtons = document.querySelectorAll(".refreshPageBTN");
        refreshButtons.forEach(function (button) {
            button.addEventListener("click", function (event) {
                const pageNumber = button.getAttribute("data-page-number");
                event.preventDefault();
                var pageUrl = `/hontrip/user/my-record/condition?page=${pageNumber}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                refreshPage(pageUrl);
            });
        });

        const totalSelectCheckbox = document.querySelector('.totalSelectbtn');
        totalSelectCheckbox.addEventListener('click', function () {
            const selectRowCheckboxes = document.querySelectorAll('.selectRow');
            const isChecked = this.checked;

            selectRowCheckboxes.forEach(function (checkbox) {
                checkbox.checked = isChecked;
            });
        });

        const selectDeleteBtn = document.querySelector('.rowDeleteBtn');
        selectDeleteBtn.addEventListener('click', function (event) {   // 선택삭제
            event.preventDefault();
            const selectedCheckboxes = document.querySelectorAll('.selectRow:checked');

            if (selectedCheckboxes.length === 0) {  //없으면 돌려보내기
                alert('선택된 항목이 없습니다.');
                return; // 선택된 항목이 없으면 더 이상 진행하지 않고 종료
            }

            const selectedIds = [];

            selectedCheckboxes.forEach(function (checkbox) {
                const id = parseInt(checkbox.getAttribute('value'));
                selectedIds.push(id);
            });

            const confirmation = confirm('선택한 항목을 삭제하시겠습니까?');  //삭제할껀지 확인

            if(confirmation) {
                const data = { ids: selectedIds };
                // POST 요청 보내기
                fetch('/hontrip/user/my-record/deletePosts', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data),
                })
                    .then(response => response.json())
                    .then(result => { // 결과 처리
                        alert(result.message);
                        window.location.href = '/hontrip/user/my-record';
                    })
                    .catch(error => {
                        alert(error.message)
                    });
            }
        })

        const sortSelect = document.getElementById('sort-select');
        sortSelect.addEventListener('change', function (e) {  //정렬선택
            var keyword = this.value;
            console.log(keyword);
            refreshPage(`/hontrip/user/my-record/condition?keyword=${keyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`);
            globalKeyword = keyword;
        });

        //
        const selectVisible = document.getElementById('visible-select');
        selectVisible.addEventListener('change', function (e) {   //공유 선택
            var isVisible = this.value;
            refreshPage(`/hontrip/user/my-record/condition?keyword=${globalKeyword}&isVisible=${isVisible}&cities=${globalCityFilterList}`);
            globalVisible = isVisible;
        })

        const filterCity = document.querySelectorAll('.filter-btn');
        filterCity.forEach(function (cityFilter) {   //filter로 도시 선택
            cityFilter.addEventListener('click', function (event) {
                event.preventDefault(); // 이벤트 기본 동작을 막음
                var cityId = cityFilter.getAttribute('value');  // id가져오기
                var cityName = cityFilter.getAttribute('data-city-name'); //도시이름
                var selectArea = document.querySelector('.select-area');
                var selectConditionArea = document.querySelector('.selected-condition');
                var currentDisplayStyle = window.getComputedStyle(selectArea).getPropertyValue('display');
                if (cityFilter.classList.contains('filter-select-btn')) {   // 이미 선택된거면
                    handleDeleteButtonClick(event);
                } else {
                    if (currentDisplayStyle === 'none') {
                        selectArea.classList.add('select-area-show');
                    }
                    cityFilterList.push(cityId);
                    cityFilter.classList.toggle('filter-select-btn');
                    //버튼넣기
                    var span = document.createElement('span');
                    span.classList = "select-span";
                    span.setAttribute('value', `${cityId}`);
                    var aTag = document.createElement('a'); // 새로운 <a> 태그를 생성
                    aTag.classList.add('btn', 'btn-primary', 'rounded-pill', 'btn-sm', 'deleteCityBtn');
                    aTag.setAttribute('value', `${cityId}`);
                    aTag.addEventListener('click', handleDeleteButtonClick);
                    aTag.textContent = `${cityName}`;
                    var iTag = document.createElement('i');// <i> 태그를 생성하고 추가
                    iTag.classList.add('uil', 'uil-multiply');
                    aTag.appendChild(iTag);
                    span.appendChild(aTag);
                    selectConditionArea.appendChild(span);// <a> 태그를 .select-area에 추가합니다.
                    if (cityFilterList.length === 0) {
                        globalCityFilterList = null;
                    } else {
                        globalCityFilterList = cityFilterList.join(',');
                    }
                    var pageUrl = `/hontrip/user/my-record/condition?keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
                    refreshPage(pageUrl);
                }

            })
        })
        var deleteButtons = document.querySelectorAll('.deleteCityBtn');
        deleteButtons.forEach(function (button) {
            button.addEventListener('click', handleDeleteButtonClick);
        });


        function handleDeleteButtonClick(event) { //버튼 삭제
            var selectArea = document.querySelector('.select-area');
            var selectConditionArea = document.querySelector('.selected-condition');
            var button = event.target;            // 클릭된 버튼의 value 속성.
            var cityId = button.getAttribute('value');
            var spanToDelete = selectConditionArea.querySelector(`span[value="${cityId}"]`); // 삭제할 <span> 요소를 찾습니다.
            if (spanToDelete) { // <span>을 삭제합니다.
                selectConditionArea.removeChild(spanToDelete);
            }
            if (selectConditionArea.childElementCount === 0) {//아무 요소 없으면 display none
                selectArea.classList.remove('select-area-show');
            }
            //위쪽 필터 버튼 끄기
            var indexInCityFilterList = cityFilterList.indexOf(cityId);
            if (indexInCityFilterList !== -1) {
                cityFilterList.splice(indexInCityFilterList, 1);
            }
            if (cityFilterList.length === 0) {
                globalCityFilterList = null;
            } else {
                globalCityFilterList = cityFilterList.join(',');
            }
            var aTags = document.querySelectorAll('.filter-btn');
            var targetATag = Array.from(aTags).find(function (aTag) {
                if (aTag.getAttribute('value') === cityId)
                    aTag.classList.remove('filter-select-btn');
            });

            //데이터 다시 불러오기
            var pageUrl = `/hontrip/user/my-record/condition?keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
            refreshPage(pageUrl);
        }

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

            document.getElementById("recordTotalCount").textContent = data.pageInfo.totalCount;

            // pagination 다시하기
            const pageInfo = data.pageInfo;
            const paginationContainer = document.querySelector('.pagination');
            paginationContainer.innerHTML = ''; // 기존 pagination 내용 초기화

            // 맨 첫장 가는 버튼
            if (pageInfo.page != 1) {
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
                link.setAttribute("data-page-number", `${pageInfo.page - 1}`);
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageInfo.page - 1}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
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
                link.setAttribute("data-page-number", `${pageInfo.page + 1}`);
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    var pageUrl = `/hontrip/user/my-record/condition?page=${pageInfo.page + 1}&keyword=${globalKeyword}&isVisible=${globalVisible}&cities=${globalCityFilterList}`;
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
            if (pageInfo.page != pageInfo.totalPage) {
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
