
let path = $('#carousels').attr('path');
/* 페이지네이션 클릭시 */
$(document).on('click', 'a.page-info', function () {
    let location = $(this).attr('location');
    let page = $(this).attr('page');
    $.ajax({
        type: "GET",//방식
        url: path + "/MainPageNation" + "/" + page + "/" + location,//주소
        dataType: 'JSON',
        success: function (map) { //성공시
            locationList(map);
        },
        error: function (e) { //실패시
            console.log(e);
        }
    })
})
/* 지역 버튼 클릭시 */
$('.locationBtn').on('click', function () {
    let location = $(this).text();
    let page = 1;
    $.ajax({
        type: "GET",//방식
        url: path + "/MainPageNation" + "/" + page + "/" + location,
        dataType: 'JSON',
        success: function (map) { //성공시
            locationList(map);
        },
        error: function (e) { //실패시
            console.log(e);
        }
    })
})
/* 리스트 깔기 */
function locationList(map) {
    let content = "";
    $.each(map.list, function (index, el) {
        content += '<div class="col-md-4">'
        content += '<div class="card h-100">'
        content += '<a href="' + path + '/reserve/campingDetail/' + el.contentId + '" class="imgPlus">'
        content += '<img src="' + el.firstImageUrl + '" class="card-img-top" style="height: 130px">'
        content += '</a>'
        content += '<div class="card-body">'
        content += '<a href="' + path + '/reserve/campingDetail/' + el.contentId + '"class="card-title text-decoration-none text-dark h5">'
        content += el.facltNm + '</a>'
        content += '<p class="text-muted fs-6">'
        content += el.addr1
        content += '</p>'
        content += '</div>'
        content += '</div>'
        content += '</div>'
    })
    $('#locationBox').empty();
    $('#locationBox').append(content);

    /* 페이지네이션 불러오기 욕나오네 */
    content = '';
    content += '<ul class="pagination justify-content-center mt-3">'
    if (map.startPage != 1) {
        content += '<li class="page-item">'
        content += '<a class="page-link page-info" page="' + (map.startPage - 1) + '" aria-label="Previous" style="cursor:pointer;" location="' + map.location + '">'
        content += '<span aria-hidden="true">&laquo;</span>'
        content += '</a>'
        content += '</li>'
    }
    for (let i = map.startPage; i <= map.endPage; i++) {
        if (map.currPage != i) {
            content += '<li class="page-item"><a style="cursor:pointer;" class="page-link page-info" page="' + i + '" location="' + map.location + '">' + i + '</a></li>'
        } else {
            content += '<li class="page-item active"><a class="page-link">' + i + '</a></li>'
        }
    }
    if (map.totalPage != map.endPage) {
        content += '<li class="page-item">'
        content += '<a class="page-link page-info" page="' + (map.endPage + 1) + '" aria-label="Next" style="cursor:pointer;" location="' + map.location + '">'
        content += '<span aria-hidden="true">&raquo;</span>'
        content += '</a>'
        content += '</li>'
    }
    content += '</ul>'
    $('#paginationBox').empty();
    $('#paginationBox').append(content);
}