/*<div class="pt-4 border-bottom border-dark">
    <h4 class="fw-bold">댓글</h4>
</div>
<%-- 댓글 입력 폼 --%>
<div class="d-flex align-items-center mt-2">
    <div class="form-floating flex-grow-1 px-2">
    <textarea class="form-control" placeholder="Leave a comment here"
name="commentContent" id="commentContent"
style="height: 100px; resize: none;"></textarea>
<div class="invalid-feedback">1자 이상 입력해주세요</div>
<c:if test="${sessionScope.loginId eq null}">
    <label for="commentContent">댓글을 작성하려면, 로그인 해주세요</label>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <label for="commentContent">${sessionScope.loginId}님 이곳에 댓글을 작성하세요</label>
</c:if>
</div>
<c:if test="${sessionScope.loginId ne null}">
    <a id="cmInsertBtn" class="btn btn-warning btn-sm">등록</a>
</c:if>
</div>
<%-- 댓글리스트 --%>
<div id="commentLists" class="container px-5 my-4">
    <c:forEach items="${map.commentList}" var="dto">
<%-- 댓글 내용 --%>
<div class="listForm">
    <div class="fw-bold fs-4">${dto.id}</div>
<div class="lh-sm">${dto.content}</div>
<div class="d-flex justify-content-end">
    <div>
        <c:if test="${sessionScope.loginId ne dto.id && sessionScope.loginId != null}">
            <a class="btn btn-warning btn-sm" href="">신고</a>
        </c:if>
        <c:if test="${sessionScope.loginId eq dto.id}">
            <a class='cmUpdateBtnForm btn btn-warning btn-sm'>수정</a>
            <a cmNum="${dto.cmNum}" class='cmDelBtn btn btn-warning btn-sm'>삭제</a>
        </c:if>
    </div>
</div>
<div class="d-flex justify-content-end">
    작성일 : ${dto.dates}
</div>
<hr/>
</div>
<%-- 수정하기 수정 클릭시 요놈 생김 --%>
<div class="updateForm visually-hidden">
    <div class="form-floating flex-grow-1 px-2">
    <textarea class="cmUpdateContent form-control"
style="height: 100px; resize: none;">${dto.content}</textarea>
<label>수정할 댓글을 작성하세요</label>
<div class="invalid-feedback">1자 이상 입력해주세요</div>
</div>
<div class="d-flex justify-content-end mt-2">
    <a cmNum="${dto.cmNum}" class='cmUpdateBtn btn btn-warning btn-sm'>등록</a>
    <a class='cmUpdateCancel btn btn-warning btn-sm ms-1'>취소</a>
</div>
<hr/>
</div>
</c:forEach>
</div>
<%-- 페이지 네이션 --%>
<div id="paginationBox">
    <ul class="pagination justify-content-center mb-3">
    <c:if test="${map.startPage ne 1}">
    <li class="page-item">
    <a class="page-link page-info" aria-label="Previous" style="cursor:pointer;"
page=${map.startPage+1}>
<span aria-hidden="true">&laquo;</span>
</a>
</li>
</c:if>
<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
    <c:if test="${i ne map.currPage}">
        <li class="page-item"><a class="page-link page-info" style="cursor:pointer;" page=${i}>${i}</a></li>
    </c:if>
    <c:if test="${i eq map.currPage}">
        <li class="page-item active"><a class="page-link">${i}</a></li>
    </c:if>
</c:forEach>
<c:if test="${map.totalPage ne map.endPage}">
    <li class="page-item">
        <a class="page-link page-info" aria-label="Next" page=${map.endPage+1} style="cursor:pointer;">
            <span aria-hidden="true">&raquo;</span>
        </a>
    </li>
</c:if>
</ul>
</div>*/

/*<input id="infoList" type = "hidden" contentId="${contentId}" division="camping" path="${path}"/>*/

/* 1. 디테일 들어갈때 map으로 뿌려준다 @Autowised CmService
* CmService.cmList("contentId", "자기 보드이름", 1) */

/* 2. 위의 내용 복붙 */

/* 3. cm.js 부르기 */

let contentId = $("#infoList").attr("contentId");
let division = $("#infoList").attr("division");
let path = $("#infoList").attr("path");
/* 댓글 등록 ajax */
$('#cmInsertBtn').on('click', function () {
    // 여기에 받을 변수 써주세용
    let commentContent = $('#commentContent').val();
    if (commentContent.trim() != "") {
        $('#commentContent').removeClass('is-invalid');
        $.ajax({
            type: "POST",//방식
            url: path + "/cm/cmInsert",//주소
            data: {
                commentContent: commentContent,
                contentId: contentId,
                division: division,
            },
            dataType: 'JSON',
            success: function (map) { //성공시
                commentList(map);
                $('#commentContent').val("");
            },
            error: function (e) { //실패시
                console.log(e);
            }
        });
    } else {
        $('#commentContent').addClass('is-invalid');
    }
})

/* 댓글 삭제 ajax */
$(document).on('click', '.cmDelBtn', function () {
    let cmNum = $(this).attr('cmNum');
    $.ajax({
        type: "POST",//방식
        url: path + "/cm/cmDelete",//주소
        data: {
            cmNum: cmNum,
            contentId: contentId,
            division: division
        },
        dataType: 'JSON',
        success: function (data) { //성공시
            commentList(data);
        },
        error: function (e) { //실패시
            console.log(e);
        }
    });
})

/* 댓글 페이지네이션 클릭시 ajax */
$(document).on('click', '.page-info', function () {
    let page = $(this).attr('page');
    $.ajax({
        type: "GET",
        url: path + "/cm/cmList" + "/" + page + "/" + contentId + "/" + division,
        dataType: 'JSON',
        success: function (data) { //성공시
            commentList(data);
        },
        error: function (e) { //실패시
            console.log(e);
        }
    });
})

/* 댓글 업데이트 ajax */
$(document).on('click', '.cmUpdateBtn', function () {
    let cmNum = $(this).attr('cmNum');
    let cmUpdateContent = $(this).parent().prev().children('.cmUpdateContent').val();
    if (cmUpdateContent.trim() != "") {
        $.ajax({
            type: "POST",//방식
            url: path + "/cm/cmUpdate",//주소
            data: {
                contentId: contentId,
                cmNum: cmNum,
                cmUpdateContent: cmUpdateContent,
                division: division
            },
            dataType: 'JSON',
            success: function (data) { //성공시
                commentList(data);
            },
            error: function (e) { //실패시
                console.log(e);
            }
        });
    } else {
        $(this).parent().prev().children('.cmUpdateContent').addClass('is-invalid');
    }
})



/* 댓글 리스트 메서드 */
function commentList(map) {
    let content = '';
    let sessionId = map.loginId;
    /*댓글리스트 불러오기*/
    $.each(map.cmList, function (i, dto) {
        content += '<div class="listForm">'
        content += '<div class="fw-bold fs-4">' + dto.id + '</div>'
        content += '<div class="lh-sm">' + dto.content + '</div>'
        content += '<div class="d-flex justify-content-end">'
        content += '<div>'
        if(sessionId !=null){
            if (sessionId != dto.id) {
                content += '<a class="btn btn-warning btn-sm" href="">신고</a>'
            } else {
                content += '<a class="cmUpdateBtnForm btn btn-warning btn-sm">수정</a>'
                content += '<a cmNum="' + dto.cmNum + '" class="cmDelBtn btn btn-warning btn-sm ms-1">삭제</a>'
            }
        }
        content += '</div>'
        content += '</div>'
        content += '<div class="d-flex justify-content-end">'
        content += '작성일 :' + dto.dates
        content += '</div>'
        content += '<hr/>'
        content += '</div>'
        content += '<div class="updateForm visually-hidden">'
        content += '<div class="form-floating flex-grow-1 px-2">'
        content += '<textarea class="cmUpdateContent form-control" style="height: 100px; resize: none;">' + dto.content + '</textarea>'
        content += '<label>수정할 댓글을 작성하세요</label>'
        content += '<div class="invalid-feedback">1자 이상 입력해주세요</div>'
        content += '</div>'
        content += '<div class="d-flex justify-content-end mt-2">'
        content += '<a cmNum="' + dto.cmNum + '" class="cmUpdateBtn btn btn-warning btn-sm">등록</a>'
        content += '<a class="cmUpdateCancel btn btn-warning btn-sm ms-1">취소</a>'
        content += '</div>'
        content += '<hr/>'
        content += '</div>'
    })
    $('#commentLists').empty();
    $('#commentLists').append(content);

    /* 페이지네이션 불러오기 욕나오네 */
    content = '';
    content += '<ul class="pagination justify-content-center">'
    if (map.startPage != 1) {
        content += '<li class="page-item">'
        content += '<a class="page-link page-info" page="' + (map.startPage - 1) + '" aria-label="Previous" style="cursor:pointer;">'
        content += '<span aria-hidden="true">&laquo;</span>'
        content += '</a>'
        content += '</li>'
    }
    for (let i = map.startPage; i <= map.endPage; i++) {
        if (map.currPage != i) {
            content += '<li class="page-item"><a style="cursor:pointer;" class="page-link page-info" page="' + i + '" >' + i + '</a></li>'
        } else {
            content += '<li class="page-item active"><a class="page-link">' + i + '</a></li>'
        }
    }
    if (map.totalPage != map.endPage) {
        content += '<li class="page-item">'
        content += '<a class="page-link page-info" page="' + (map.endPage + 1) + '" aria-label="Next" style="cursor:pointer;">'
        content += '<span aria-hidden="true">&raquo;</span>'
        content += '</a>'
        content += '</li>'
    }
    content += '</ul>'
    $('#paginationBox').empty();
    $('#paginationBox').append(content);
}