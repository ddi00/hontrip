$(document).ready(function () {
    const SEARCH_TYPE_KEY = 'searchType';
    const KEYWORD_KEY = 'keyword';
    const SELECTED_REGION_KEY = 'selectedRegion';
    const SAVED_PAGE_KEY = 'savedPage';

    let savedSearchType = sessionStorage.getItem(SEARCH_TYPE_KEY);
    let savedKeyword = sessionStorage.getItem(KEYWORD_KEY);
    let savedRegion = sessionStorage.getItem(SELECTED_REGION_KEY);
    let savedPage = sessionStorage.getItem(SAVED_PAGE_KEY);

    // 검색 조건과 지역 정보 복원
    if (savedSearchType){
    $('#searchType').val(savedSearchType);
    }
    if (savedKeyword){
    $('#keyword').val(savedKeyword);
    }
    if (savedRegion) {
        // 선택된 버튼 강조 표시
        $('.regionBtn').removeClass('btn-orange').addClass('btn-soft-orange');
        $('.regionBtn[data-region="' + savedRegion + '"]').removeClass('btn-soft-orange').addClass('btn-orange');
    }

    if (!savedSearchType){
    sessionStorage.removeItem(SEARCH_TYPE_KEY);
    }
    if (!savedKeyword){
    sessionStorage.removeItem(KEYWORD_KEY);
    }
    if (!savedRegion){
    sessionStorage.removeItem(SELECTED_REGION_KEY);
    }

    // 페이지 정보가 있는 경우 해당 페이지로 데이터 로딩 및 페이지 버튼 생성
    if (savedPage) {
        loadPageData(savedPage);
    } else {
        loadPageData(1); // 기본 페이지 번호
    }

    // 검색 버튼 클릭 시 페이지 버튼 생성 및 데이터 가져오기
    $(document).on('click', '.searchBtn', function() {
        let searchType = $('#searchType').val();
        let keyword = $('#keyword').val();
        sessionStorage.setItem(SEARCH_TYPE_KEY, searchType);
        sessionStorage.setItem(KEYWORD_KEY, keyword);
        //regionId 세션 삭제
        sessionStorage.removeItem(SELECTED_REGION_KEY);
        loadPageData(1);
    });

    $(document).on('click', '.pageBtn', function() {
        let page = $(this).data('page');
        loadPageData(page);
    });

    $('.regionBtn').click(function() {
        let selectedRegion = $(this).data('region');
        sessionStorage.setItem(SELECTED_REGION_KEY, selectedRegion);
        $('.regionBtn').removeClass('btn-orange').addClass('btn-soft-orange');
        $(this).removeClass('btn-soft-orange').addClass('btn-orange');

        // 세션 스토리지에서 검색 조건 초기화
            sessionStorage.removeItem(SEARCH_TYPE_KEY);
            sessionStorage.removeItem(KEYWORD_KEY);
            $('#searchType').val('');
            $('#keyword').val('');

        loadPageData(1);
    });
});

//페이징 처리
function loadPageData(page) {
    let searchType = $('#searchType').val();
    let keyword = $('#keyword').val();
    let selectedRegion = sessionStorage.getItem('selectedRegion');

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
            regionId: selectedRegion
        },
        dataType: 'json',
        success: function(data) {
            let str = '';
            for (let i = 0; i < data.list.length; i++) {
                let one = data.list[i];
                let thumbnail = one.thumbnail;
                                     let imagePath = `/resources/img/mateImg/${thumbnail}`;
                                     str += ` <div class="col-md-6 col-lg-4">
                                                       <article class="item post">
                                                         <div class="card">
                                                           <figure class="card-img-top overlay overlay-1 hover-scale">
                                                       <a href="../mate/${one.mateBoardId}">
                                                         <img src="../${imagePath}">
                                                         <span class="bg"></span>
                                                       </a>
                                                       <figcaption>
                                                         <h5 class="from-top mb-0">Read More</h5>
                                                       </figcaption>
                                                     </figure>
                                                     <div class="card-body">
                                                       <div class="post-header">
                                                         <div class="post-category text-line">
                                                           <a href="#" class="hover" rel="category">${one.nickname}</a>
                                                         </div>
                                                         <h2 class="post-title h3 mt-1 mb-3">
                                                           <a class="link-dark" href="../mate/${one.mateBoardId}">${one.title}</a>
                                                         </h2>
                                                       </div>
                                                     </div>
                                                   </div>
                                                   <div class="card-footer">
                                                                         <ul class="post-meta d-flex mb-0">
                                                                           <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.startDate} </span></li>
                                                                           <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${one.endDate}</span></li>
                                                                           <li class="post-comments"><a href="#"><i class="uil uil-comment"></i>3</a></li>
                                                                           <li class="post-likes ms-auto"><a href="#"><i class="uil uil-heart-alt"></i>3</a></li>
                                                                         </ul>
                                                                         <!-- /.post-meta -->
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
        error: function() {
            alert("실패");
        }
    });
}

  //페이지 버튼 생성하는 메서드
  function generatePageButtons(page, pageSize, firstPageNoOnPageList, lastPageNoOnPageList, realEnd) {
    let pagingHtml = "";
    console.log(pageSize, "pageSize")

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

