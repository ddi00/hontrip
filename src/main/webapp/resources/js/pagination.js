$(function() {


   // 검색 버튼 클릭 시 페이지 버튼 생성 및 데이터 가져오기
    $('#searchBtn').click(function() {
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
            str += `<tr>
                        <td><img src="${one.thumbnail}"></td>
                        <td><a href="../mate/bbs_one?mateBoardId=${one.mateBoardId}">${one.title}</a></td>
                        <td>${one.nickname}</td>
                        <td>${one.ageRange}</td>
                        <td>${one.startDate}</td>
                        <td>${one.endDate}</td>
                    </tr>`;
        }

          //alert(str);
          $('#list-area').empty().html(str);
          // 페이지 버튼 다시 생성
          generatePageButtons(1, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);
        },
        error: function() {
          alert("실패");
        }
      });
    });

  $('.paging').on('click', '.pageBtn', function() {
    let page = $(this).data('page');

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
                     str += `<tr>
                                 <td><img src="${one.thumbnail}"></td>
                                 <td><a href="../mate/bbs_one?mateBoardId=${one.mateBoardId}">${one.title}</a></td>
                                 <td>${one.nickname}</td>
                                 <td>${one.ageRange}</td>
                                 <td>${one.startDate}</td>
                                 <td>${one.endDate}</td>
                             </tr>`;
                 }
                  //alert(str);
                  $('#list-area').empty().html(str);

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
    if (page > 1) {
      pagingHtml += '<button class="pageBtn prevBtn" data-page="' + (page - 1) + '"> < </button>';
    }

    let startPage = Math.max(1, Math.floor((page - 1) / pageSize) * pageSize + 1);
    console.log(startPage, "startPage")
    let endPage = Math.min(startPage + pageSize - 1, realEnd);
    console.log(endPage, "endPage")
    for (let i = startPage; i <= endPage; i++) {
      if (i === page) {
        pagingHtml += '<button class="pageBtn active" data-page="' + i + '">' + i + '</button>';
      } else {
        pagingHtml += '<button class="pageBtn" data-page="' + i + '">' + i + '</button>';
      }
    }

    if (page < realEnd) {
      pagingHtml += '<button class="pageBtn nextBtn" data-page="' + (page + 1) + '"> > </button>';
    }

    if (endPage < realEnd) {
      pagingHtml += '<button class="pageBtn skipBtn" data-page="' + (endPage + 1) + '">>></button>';
    }

    if (startPage > 1) {
      pagingHtml = '<button class="pageBtn skipBtn" data-page="' + (startPage - pageSize) + '"><<</button>' + pagingHtml;
    }

    $('.paging').empty().html(pagingHtml);
  }

});