function boardInit() {

    if ($('#mateBoardDbAgeRangeId').val() != "") {
        let ageRange = $('#mateBoardDbAgeRangeId').val();
        let ageRangeArr = ageRange.split(",");
        for (let i = 0; i < ageRangeArr.length; i++) {
            $('#' + ageRangeArr[i]).prop("checked", true)
        }
        $('#ageRangeId').attr('value', $('#mateBoardDbAgeRangeId').val());
    }

    $('#isFinish').val($('#mateBoardDbIsFinish').val()).prop("selected", true);
    $('#recruitNumber').val($('#mateBoardDbRecruitNumber').val()).prop("selected", true);
}

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

function genderChecked() {
    let genderVal = document.querySelector('input[type="radio"][name="genders"]:checked');
    $('#gender').val(genderVal.value);
}


//여행 시작, 마지막날짜 설정 및 min 설정
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
    const formattedToday = yyyy + '-' + mm + '-' + dd;
    const maxDay = (yyyy + 2) + '-' + mm + '-' + dd;

    $('#mateStartDate').prop("min", formattedToday);
    $('#mateEndDate').prop("min", formattedToday);

    $('#mateStartDate').on('change', function () {
        $('#mateEndDate').prop("min", $(this).val());
    });

    $('#mateEndDate').on('change', function () {
        $('#mateStartDate').prop("max", $(this).val());
    });
}

$(document).ready(function () {
    boardInit();
    dateInit();
});

/*
function startDateChange() {
    console.log($('#startDate').val())
    $('#endDate').prop("min", $('#startDate').val());
    $('#endDate').prop("max", "2023-09-10");
}

function endDateChange() {
    $('#startDate').prop("max", $('#endDate').val());
}
*/

$(function () {
    $('#edit').on("click", function () {
        if ($('#file')[0].files[0] == null) {
            $.ajax({
                method: "POST",
                url: "edit",
                data: {
                    id: $('#mateBoardId').val(),
                    regionId: $("input[name='regionId']:checked").val(),
                    ageRangeId: $('#ageRangeId').val(),
                    title: $('#title').val(),
                    content: $('#content').val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'),
                    thumbnail: $('#mateBoardThumbnail').val(),
                    startDate: $('#mateStartDate').val(),
                    endDate: $('#mateEndDate').val(),
                    recruitNumber: $('#recruitNumber').val(),
                    gender: $("input[name='gender']:checked").val(),
                    isFinish: $('#isFinish').val(),
                },
                success: function () {
                    location.href = $('#mateBoardId').val();
                },
                error: function (e) {
                    console.log(e);
                }
            })
        } else {
            const formData = new FormData();
            formData.append("id", $('#mateBoardId').val())
            formData.append("file", $('#file')[0].files[0])
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
                method: "POST",
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                url: "edit",
                data: formData,
                success: function () {
                    location.href = $('#mateBoardId').val();
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }
    })
})

const imageInput = document.getElementById("file");
const uploadYourImage = document.getElementById("uploadYourImage");
const uploadedImage = document.getElementById("upldimg");


uploadedImage.addEventListener("click", () => {
    imageInput.click();
});

imageInput.addEventListener("change", (event) => {
    const selectedFile = event.target.files[0];
    if (selectedFile) {
        const reader = new FileReader();
        reader.onload = (e) => {
            uploadedImage.src = e.target.result;
        };
        reader.readAsDataURL(selectedFile);
    }
});