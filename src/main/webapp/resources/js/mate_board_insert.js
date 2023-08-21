window.history.forward();

$(function () {
    $('#complete').on("click", function () {
        console.log(
            $('#userId').val()
            , $('#imageInput')[0].files[0]
            , $("input[name='regionId']:checked").val()
            , $('#ageRangeId').val()
            , $('#title').val()
            , $('#content').val()
            , $('#mateStartDate').val()
            , $('#mateEndDate').val()
            , $('#recruitNumber').val()
            , $("input[name='gender']:checked").val()
            , $('#isFinish').val()
        )

        const formData = new FormData();
        formData.append("userId", $('#userId').val())
        formData.append("file", $('#imageInput')[0].files[0])
        formData.append("regionId", $("input[name='regionId']:checked").val())
        formData.append("ageRangeId", $('#ageRangeId').val())
        formData.append("title", $('#title').val())
        formData.append("content", $('#content').val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'))
        formData.append("startDate", $('#mateStartDate').val())
        formData.append("endDate", $('#mateEndDate').val())
        formData.append("recruitNumber", $('#recruitNumber').val())
        formData.append("gender", $("input[name='gender']:checked").val())
        formData.append("isFinish", $('#isFinish').val())
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            url: "insert",
            data: formData,
            success: function (boardId) {
                location.href =
                    boardId
            },
            error: function (e) {
                console.log(e);
            }
        })

    })
})

function ageRangeChecked() {
    let checkedArr = [];
    let checkboxes = document.querySelectorAll('input[type="checkbox"][name="age"]:checked');
    for (let i = 0; i < checkboxes.length; i++) {
        checkedArr.push(checkboxes[i].value);
    }
    let checkedStr = checkedArr[0];
    for (let i = 1; i < checkedArr.length; i++) {
        checkedStr += "," + checkedArr[i];
    }
    console.log(checkedStr)
    if (checkboxes.length === 0) {
        checkedStr = ""
    }
    $('#ageRangeId').attr('value', checkedStr);
}

function dateInit() {
    let today = new Date();
    let dd = today.getDate();
    let mm = today.getMonth() + 1; // 0부터 시작하므로 1을 더해줍니다.
    const yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    const fomattedToday = yyyy + '-' + mm + '-' + dd;
    $('#mateStartDate').prop("min", fomattedToday);
    $('#mateEndDate').prop("min", fomattedToday);
}

$(document).ready(function () {
    dateInit();

    $('#mateStartDate').on('change', function () {
        $('#mateEndDate').prop("min", $(this).val());
    });

    $('#endDate').on('change', function () {
        $('#mateStartDate').prop("max", $(this).val());
    });
});