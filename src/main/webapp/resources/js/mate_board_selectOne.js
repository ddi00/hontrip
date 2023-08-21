function applyMate() {
    //로그인 안했을 경우 로그인창을 띄움
    if ($('#mateBoardLogin').val() == "no") {
        alert("로그인 창")
        //로그인 했을 경우
    } else {
        //신청자의 성별, 연령대를 가져온 후, 모집조건에 적합한지 체크한다
        $.ajax({
            url: "findUserGenderAge",
            data: {
                id: $('#mateBoardLogin').val()
            },
            dataType: "json",
            success: function (json) {
                //게시글 작성자가 원하는 연령대 리스트 생성
                /*배열이 아닌거같음!!!*/
                let ageRangeStrArr = [];
                if ($('#ageRangeJS').val() != "[]") {
                    let ageRangeStrArr = $('#ageRangeJS').val().split(",");
                }
                //모집조건에 부합하다면
                //성별, 연령대 아무나 처리
                if (json.id == $('#mateBoardLogin').val() && (json.gender === $('#mateBoardGenderStr').val() ||
                        $('#mateBoardGenderStr').val() == "성별무관" || json.gender == "NONE")
                    && (ageRangeStrArr.includes(json.ageRange.ageRangeStr) || ageRangeStrArr.includes("전연령")
                        || ageRangeStrArr.length == 0 || json.ageRange == "AGE_UNKNOWN")) {
                    $("#ableButton").click();
                    //모집조건에 부합하지 않다면
                } else {
                    $("#unableButton").click()
                }
            },
            error: function (e) {
                console.log(e)
            }
        })//ajax
    }
}


/*모달에서 삭제버튼을 눌렀을때 */
function deleteAccept() {
    $.ajax({
        method: 'DELETE',
        url: "delete/" + $('#mateBoardId').val(),
        data: {
            id: parseInt($('#mateBoardId').val())
        },
        success: function (result) {
            if (result == 1) {
                location.href = "../mate/bbs_list?page=1"
            }
        }, error: function (e) {
            console.log(e)
        }
    })
}


/*삭제시 경고 모달*/
function deleteMateBoard() {
    $('#deleteButton').click();
}

//동행인신청메세지 모달에서 전송버튼을 눌렀을때
function send() {

    if ($('#applicationMessage').val().trim() == "") {
        $('#applicationMessage').val("같이 여행가요")
    }
    $.ajax({
        type: "POST",
        url: "insertMatchingAlarm",
        data: {
            mateBoardId: $('#mateBoardId').val(),
            senderId: $('#mateBoardLogin').val(),
            content: $("#applicationMessage").val()
        },
        success: function () {
            //동행 신청 메세지를 전송한 후, 모달을 끄고
            location.reload()
            //동행인 신청 버튼 비활성화
            $('#application').attr('disabled', 'disabled');
        }, error: function (e) {
            console.log(e)
        }
    })
}

$(function () {
    let login = $('#mateBoardLogin').val();

    //로그인 했고,
    if (login != "no") {

        //이미 지원한 경우 동행인 신청 버튼 비활성화
        $.ajax({
            url: "checkApply",
            data: {
                senderId: $('#mateBoardLogin').val(),
                mateBoardId: $('#mateBoardId').val()
            },
            dataType: "json",
            success: function (result) {
                if (result === 1) {
                    console.log(result)
                    $('#application').attr('disabled', 'disabled');
                }
            },
            error: function (e) {
                console.log(e)
            }
        })
    }
})
