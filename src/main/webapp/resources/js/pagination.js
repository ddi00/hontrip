$(function() {
   // 검색 버튼 클릭 시 페이지 버튼 생성 및 데이터 가져오기
    $('#searchBtn').on('click', function() {
      let searchType = $('#searchType').val();
      let keyword = $('#keyword').val();
  $.ajax({
        url: '/hontrip/mate/pagination',
        data: {
          page: 1, // 검색 시 첫 페이지로 초기화
          searchType: searchType,
          keyword: keyword
        },
         dataType:'json',
        success: function(data) {
        console.log(JSON.stringify(data), "data");
        let str = '';
        for (let i = 0; i < data.list.length; i++) {
            let one = data.list[i];
            str += `<div class="col-md-6">
                <article class="item post" style="width: 49%; height: 530px;">
                  <div class="card">
                    <figure class="card-img-top overlay overlay-1 hover-scale">
                <a href="../mate/${one.mateBoardId}">
                  <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>">
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

          //alert(str);
          $('.row.isotope').empty().html(str);
          // 페이지 버튼 다시 생성
          generatePageButtons(1, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);
        },
        error: function() {
          alert("실패");
        }
      });
    });
  $(document).on('click', '.pageBtn', function() {
    let page = $(this).data('page');
    console.log("page >> " + page);

    let searchType = $('#searchType').val();
    let keyword = $('#keyword').val();

    $.ajax({
      url: '/hontrip/mate/pagination',
      data: {
        page: page,
        searchType: searchType,
        keyword: keyword
      },
      dataType:'json',
      success: function(data) {
      console.log(JSON.stringify(data), "data");
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
                  $('.row.isotope').empty().html(str);

                  // 페이지 버튼 다시 생성
                  let pageSize = data.pageDTO.pageSize;
                  generatePageButtons(page, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);

                },
      error: function() {
        alert("실패");
      }
    });
  });
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

});