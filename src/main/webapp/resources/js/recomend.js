/*
<div id="good" className="btn btn-outline-warning mx-1" goodCheck="${map.goodCheck}">
    추천 ${map.goodCount}개
</div>
*/

if ($('#good').attr('goodCheck') == "true") {
    $('#good').attr("class", "btn btn-warning mx-1");
}
$(document).on('click', '#good', function () {
    $.ajax({
        type: "POST",//방식
        url: path + "/good/goodData",//주소
        data: {
            contentId: contentId,
            division: division
        },
        dataType: 'JSON',
        success: function (data) { //성공시
            let content = "";
            if (Object.keys(data).length > 0) {
                if (data.goodCheck == false) {
                    // 좋아요 안눌린상태
                    $("#good").attr("goodCheck", "false");
                    $("#good").attr("class", "btn btn-outline-warning mx-1");
                } else {
                    // 좋아요 눌린상태
                    $("#good").attr("goodCheck", "true");
                    $("#good").attr("class", "btn btn-warning mx-1");
                }
                content += '추천 ' + data.goodCount + '개';
                $("#good").empty();
                $("#good").append(content);
            } else {
                alert("로그인 해주세용 ^^");
                location.href = path + "/member/loginForm";
            }
        },
        error: function (e) { //실패시
            console.log(e);
        }
    })
})
