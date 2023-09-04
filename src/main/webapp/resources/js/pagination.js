if (window.location.href.includes('/mate/bbs_list')) {
    $(document).ready(function () {
        const SEARCH_TYPE_KEY = 'savedSearchType';
        const KEYWORD_KEY = 'savedKeyword';
        const SELECTED_REGION_KEY = 'selectedRegion';
        const SAVED_PAGE_KEY = 'savedPage';
        const AGE_KEY = 'selectedAge';
        const orderBy_KEY = 'savedOrderBy';



        let savedSearchType = sessionStorage.getItem(SEARCH_TYPE_KEY);
        let savedKeyword = sessionStorage.getItem(KEYWORD_KEY);
        let savedRegion = sessionStorage.getItem(SELECTED_REGION_KEY);
        let savedPage = sessionStorage.getItem(SAVED_PAGE_KEY);
        let savedAge = sessionStorage.getItem(AGE_KEY);
        let savedOrderBy = sessionStorage.getItem(orderBy_KEY);


        // 검색 조건과 지역 정보 복원
        if (savedSearchType) {
            $('#searchType').val(savedSearchType);
        }
        if (savedKeyword) {
            $('#keyword').val(savedKeyword);
        }
        if (savedRegion) {
            // 선택된 버튼 강조 표시
            $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('.regionBtn[data-region="' + savedRegion + '"]').removeClass('btn-soft-primary').addClass('btn-primary');
        }
        if (savedAge) {
            // 선택된 버튼 강조 표시
            $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('.ageBtn[data-age="' + savedAge + '"]').removeClass('btn-soft-primary').addClass('btn-primary');
        }
        if (savedOrderBy) {
            $('#viewCount').removeClass('btn-soft-primary').addClass('btn-primary');
        }


        if (!savedSearchType) {
            sessionStorage.removeItem(SEARCH_TYPE_KEY);
        }
        if (!savedKeyword) {
            sessionStorage.removeItem(KEYWORD_KEY);
        }
        if (!savedRegion) {
            sessionStorage.removeItem(SELECTED_REGION_KEY);
        }
        if (!savedOrderBy) {
            sessionStorage.removeItem(orderBy_KEY);
        }
        if (!savedAge) {
            sessionStorage.removeItem(AGE_KEY);
        }

        // 페이지 정보가 있는 경우 해당 페이지로 데이터 로딩 및 페이지 버튼 생성
        if (savedPage) {
            loadPageData(savedPage);
        } else {
            loadPageData(1); // 기본 페이지 번호
        }

        // 검색 버튼 클릭 시 페이지 버튼 생성 및 데이터 가져오기
        $(document).on('click', '.searchBtn', function () {
            let searchType = $('#searchType').val();
            let keyword = $('#keyword').val();
            sessionStorage.setItem(SEARCH_TYPE_KEY, searchType);
            sessionStorage.setItem(KEYWORD_KEY, keyword);
            //regionId 세션 삭제
            sessionStorage.removeItem(SELECTED_REGION_KEY);
            sessionStorage.removeItem(AGE_KEY);
            sessionStorage.removeItem(orderBy_KEY);
            $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('#viewCount').removeClass('btn-primary').addClass('btn-soft-primary');
            loadPageData(1);
        });

        $(document).on('click', '.pageBtn', function () {
            let page = $(this).data('page');
            loadPageData(page);
        });

        $('.regionBtn').click(function () {
            let selectedRegion = $(this).data('region');
            sessionStorage.setItem(SELECTED_REGION_KEY, selectedRegion);
            $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $(this).removeClass('btn-soft-primary').addClass('btn-primary');

            // 세션 스토리지에서 검색 조건 초기화
            sessionStorage.removeItem(SEARCH_TYPE_KEY);
            sessionStorage.removeItem(KEYWORD_KEY);
            sessionStorage.removeItem(AGE_KEY);
            sessionStorage.removeItem(orderBy_KEY);
            $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('#searchType').val('');
            $('#keyword').val('');
            $('#viewCount').removeClass('btn-primary').addClass('btn-soft-primary');

            loadPageData(1);
        });

        // 클릭 이벤트 핸들러
        $('.ageBtn').click(function () {
            let ageRange = $(this).data('age');
            sessionStorage.setItem(AGE_KEY, ageRange);

            // 선택된 버튼 스타일 변경
            $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $(this).removeClass('btn-soft-primary').addClass('btn-primary');

            // 세션 스토리지에서 검색 조건 초기화
            sessionStorage.removeItem(SEARCH_TYPE_KEY);
            sessionStorage.removeItem(KEYWORD_KEY);
            sessionStorage.removeItem(SELECTED_REGION_KEY);
            sessionStorage.removeItem(orderBy_KEY);

            $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('#searchType').val('');
            $('#keyword').val('');
            $('#viewCount').removeClass('btn-primary').addClass('btn-soft-primary');

            loadPageData(1);
        });
        // 클릭 이벤트 핸들러
        $('#viewCount').click(function () {
            let orderBy = 'viewCount';
            sessionStorage.setItem(orderBy_KEY, orderBy);

            $('#viewCount').removeClass('btn-soft-primary').addClass('btn-primary');

            // 세션 스토리지에서 검색 조건 초기화
            sessionStorage.removeItem(SEARCH_TYPE_KEY);
            sessionStorage.removeItem(KEYWORD_KEY);
            sessionStorage.removeItem(SELECTED_REGION_KEY);
            sessionStorage.removeItem(AGE_KEY);
            $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
            $('#searchType').val('');
            $('#keyword').val('');

            loadPageData(1);
        });

        $('#filterButton').click(function () {
            const viewCountButton = document.getElementById("viewCount");
            const ageBtnContainer = document.querySelector(".ageBtn-container");
            const regionBtnContainer = document.querySelector(".regionBtn-container");

            if (ageBtnContainer.style.display === "block") {
                // .ageBtn-container를 숨기는 스타일
                regionBtnContainer.style.display = "none";
                ageBtnContainer.style.display = "none";
                // #viewCount를 숨기는 스타일
                viewCountButton.style.display = "none";
            } else {
                // 다시 버튼을 누르면 보이게 하려면 이 부분에 보이게 하는 스타일을 추가합니다.
                regionBtnContainer.style.display = "block";
                ageBtnContainer.style.display = "block";
                viewCountButton.style.display = "block";
            }
        });

        // 초기화 버튼 클릭 시 세션 스토리지 값을 모두 초기화
        $(document).on('click', '#resetButton', function () {

                                sessionStorage.removeItem(SEARCH_TYPE_KEY);
                                sessionStorage.removeItem(KEYWORD_KEY);
                                sessionStorage.removeItem(SELECTED_REGION_KEY);
                                sessionStorage.removeItem(orderBy_KEY);
                                sessionStorage.removeItem(AGE_KEY);


                    // 선택된 버튼 스타일 초기화
                    $('.regionBtn').removeClass('btn-primary').addClass('btn-soft-primary');
                    $('.ageBtn').removeClass('btn-primary').addClass('btn-soft-primary');
                    $('#viewCount').removeClass('btn-primary').addClass('btn-soft-primary');

                    // 검색 조건 선택 상자 초기화
                    $('#searchType').val('');
                    $('#keyword').val('');

                    // 페이지 데이터 다시 로딩
                    loadPageData(1);
                });

    });




//페이징 처리
    function loadPageData(page) {
        let searchType = $('#searchType').val();
        let keyword = $('#keyword').val();
        let selectedRegion = sessionStorage.getItem('selectedRegion');
        let selectedAge = sessionStorage.getItem('selectedAge');
        let orderBy = sessionStorage.getItem('savedOrderBy');

        if (!selectedRegion) {
            selectedRegion = 0;
            sessionStorage.setItem('selectedRegion', selectedRegion);
        }

        $.ajax({
            url: '/hontrip/mate/pagination',
            data: {
                page: page,
                searchType: searchType,
                keyword: keyword,
                regionId: selectedRegion,
                age: selectedAge,
                orderBy: orderBy
            },
            dataType: 'json',
            success: function (data) {
                let str = '';
                for (let i = 0; i < data.list.length; i++) {
                    let one = data.list[i];
                    let thumbnail = one.thumbnail;
                    let imagePath = `/resources/img/mateImg/${thumbnail}`;

                    let ageRangeValues = data.ageRangeValues;
                    let ageRangeId = one.ageRangeId;
                    let ageRangeStr = findAgeRangeStr(ageRangeValues, ageRangeId);

                    let regionValues = data.regionValues;
                    let regionId = one.regionId;
                    let regionStr = findRegionStr(regionValues,regionId);

                    let genderValues = data.genderValues;
                    let genderId = one.genderId;
                    let genderStr = findGenderStr(genderValues,genderId);

                    str += `
                                        <div class="col-md-6 col-lg-4">
                                            <article class="item post">
                                                <div class="card mate-post-item">
                                                    <figure class="card-img-top overlay overlay-1 hover-scale">
                                                        <a href="../mate/${one.mateBoardId}">
                                                            <div class="mate-list-image-container">
                                                                <img src="../${imagePath}">
                                                            </div>
                                                            <span class="bg"></span>
                                                        </a>
                                                        <figcaption>
                                                            <h5 class="from-top mb-0">Read More</h5>
                                                        </figcaption>
                                                    </figure>
                                                        <div class="card-body">
                                                            <div class="post-header d-flex align-items-center mb-3"> <!-- 프로필 이미지와 닉네임을 가로로 나란히 배치 -->
                                                                <figure class="user-avatar">
                                                                    <img class="rounded-circle" alt="" src="${one.profileImage}" />
                                                                </figure>
                                                                ${one.nickname}
                                                            </div>

                                                            <h2 class="post-title h3 mt-1 mb-2">
                                                                <a class="link-dark mb-2" href="../mate/${one.mateBoardId}">${one.title}</a><br>
                                                            </h2>
                                                            <h4>
                                                                <div class="badge bg-pale-primary text-primary rounded-pill">#${ageRangeStr}</div>
                                                                <div class="badge bg-pale-primary text-primary rounded-pill">#${genderStr}</div>
                                                                <div class="badge bg-pale-primary text-primary rounded-pill">#${regionStr}</div>
                                                            </h4>

                                                            <div class="mate-list-card-footer">
                                                                <ul class="post-meta d-flex mb-0 mate-list-one">
                                                                    <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.startDate} </span>
                                                                    </li>
                                                                    <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.endDate}</span></li>
                                                                    <li class="post-likes ms-auto"><i class="uil uil-user-check"></i>조회수 ${one.viewCount}</li>
                                                                </ul>
                                                                <!-- /.post-meta -->
                                                            </div>
                                                        </div>
                                                </div>
                                            </article>
                                        </div>`;
                }

                // 데이터 삽입 및 페이지 버튼 다시 생성
                $('.row.isotope').empty().html(str);
                generatePageButtons(page, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);

                // 페이지 정보 저장
                sessionStorage.setItem('savedPage', page);
            },
            error: function () {
                console.log("실패")
            }
        });
    }

    function findAgeRangeStr(ageRangeValues, ageRangeId) {
        for (let j = 0; j < ageRangeValues.length; j++) {
            let age = ageRangeValues[j];
            if (age.ageRangeNum == parseInt(ageRangeId)) {
                return age.ageRangeStr;
            }
        }
        return ''; // 매치되는 값이 없을 경우 빈 문자열 반환
    }

    function findRegionStr(regionValues, regionId) {
        for (let k = 0; k < regionValues.length; k++) {
            let region = regionValues[k];
            if (region.regionNum == parseInt(regionId)) {
                return region.regionStr;
            }
        }
        return ''; // 매치되는 값이 없을 경우 빈 문자열 반환
    }

    function findGenderStr(genderValues, genderId) {
        for (let k = 0; k < genderValues.length; k++) {
            let gender = genderValues[k];
            if (gender.genderNum == parseInt(genderId)) {
                return gender.genderStr;
            }
        }
        return ''; // 매치되는 값이 없을 경우 빈 문자열 반환
    }



    //페이지 버튼 생성하는 메서드
    function generatePageButtons(page, pageSize, firstPageNoOnPageList, lastPageNoOnPageList, realEnd) {
        let pagingHtml = "";

//    if (page > 1) {
//      pagingHtml += '<li><button class="page-link pageBtn prevBtn" data-page="' + (page - 1) + '"> <i class="uil uil-arrow-left"></i> </button></li>';
//    }

        let startPage = Math.max(1, Math.floor((page - 1) / pageSize) * pageSize + 1);
        console.log(startPage, "startPage")
        let endPage = Math.min(startPage + pageSize - 1, realEnd);
        console.log(endPage, "endPage")
        if (startPage > 1) {
            pagingHtml += '<li class="page-item"><button class="page-link pageBtn skipBtn" data-page="' + (startPage - pageSize) + '"><i class="uil uil-arrow-left"></i></button></li>';
        } else {
            pagingHtml += '<li class="page-item disabled"><button class="page-link pageBtn skipBtn"><i class="uil uil-arrow-left"></i></button></li>';
        }

        for (let i = startPage; i <= endPage; i++) {
            if (i === page) {
                pagingHtml += '<li class="page-item active"><button class="page-link pageBtn active" data-page="' + i + '">' + i + '</button></li>';
            } else {
                pagingHtml += '<li class="page-item"><button class="page-link pageBtn" data-page="' + i + '">' + i + '</button></li>';
            }
        }
// >, < 버튼들 >> <<로 통합 시키기
//    if (page < realEnd) {
//      pagingHtml += '<li class="page-item"> <button class="page-link pageBtn nextBtn" data-page="' + (page + 1) + '"> <i class="uil uil-arrow-left"></i> </button> </li>';
//    }

//    if (endPage < realEnd) {
//      pagingHtml += '<li class="page-item"><button class="page-link pageBtn skipBtn" data-page="' + (endPage + 1) + '">>></button></li>';
//    }


        if (endPage < realEnd) {
            pagingHtml += '<li class="page-item"><button class="page-link pageBtn skipBtn" data-page="' + (endPage + 1) + '"><i class="uil uil-arrow-right"></i> </button></li>';
        } else {
            pagingHtml += '<li class="page-item disabled"><button class="page-link pageBtn skipBtn"><i class="uil uil-arrow-right"></i> </button></li>';
        }

        $('.pagination').empty().html(pagingHtml);
    }
}