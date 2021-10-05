<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <meta charset="utf-8">
    <title>Final</title>
    <%-- 부트 스트랩 메타태그 --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- 부트 스트랩 아이콘 --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <!-- 부트스트랩 css 추가 -->
    <%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="container px-3">
    <div class="border-bottom mb-3">
            <h2 class="">차박지도</h2>
        </div>

<div class="row">
    <div class="col-4 mt-4">
        <div>
            <table class="table">
                <tbody>
                <tr>
                    <th scope="row" class="py-3">주차장명</th>
                    <td class="py-3">${dto.prkplcenm}</td>

                </tr>
                <tr>

                    <c:choose>
                        <c:when test="${dto.rdnmadr eq null}">
                            <th scope="row" class="py-3">주소</th>
                            <td class="py-3">${dto.lnmadr}</td>
                        </c:when>
                        <c:otherwise>
                            <th scope="row" class="py-3">주소</th>
                            <td class="py-3">${dto.rdnmadr}</td>
                        </c:otherwise>
                    </c:choose>

                </tr>
                <tr>
                    <th scope="row" class="py-3">주차구획 수</th>
                    <td class="py-3">${dto.prkcmprt}</td>
                </tr>
                <tr>
                    <th scope="row" class="py-3">주차장 구분</th>
                    <td class="py-3">${dto.prkplcese}</td>
                </tr>
                <tr>
                    <th scope="row" class="py-3">요금정보</th>
                    <td class="py-3">${dto.parkingchrgeinfo}</td>
                </tr>
                <tr>
                    <th scope="row" class="py-3">전화번호</th>
                    <td class="py-3">${dto.phonenumber}</td>
                </tr>
                </tbody>
            </table>
        </div>
			<div class="text-center">
			<div id="good" class="btn btn-outline-warning mx-1" goodCheck="${map.goodCheck}">
  			 추천 ${map.goodCount}개
			</div>
			</div>
    </div>

<div class="col">

	<div class="pt-4 border-bottom border-dark">
    <h5 class="fw-bold">차박 경험을 공유해보세요!</h5>
</div>
<%-- 댓글 입력 폼 --%>
<div class="d-flex align-items-center mt-2">
    <div class="form-floating flex-grow-1 px-2">
    <textarea class="form-control" placeholder="Leave a comment here"
name="commentContent" id="commentContent"
style="height: 100px; resize: none;"></textarea>
<div class="invalid-feedback">1자 이상 입력해주세요</div>
<c:if test="${sessionScope.loginId eq null}">
    <label for="commentContent">경험을 작성하시려면, 로그인 해주세요</label>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <label for="commentContent">${sessionScope.loginId}님 이곳에 경험을 공유해보세요</label>
</c:if>
</div>
<c:if test="${sessionScope.loginId ne null}">
    <a id="cmInsertBtn" class="btn btn-warning btn-sm">등록</a>
</c:if>
</div>
<%-- 댓글리스트 --%>
<div id="commentLists" class="container px-5 my-4">
    <c:forEach items="${map.cmList}" var="dto">
<%-- 댓글 내용 --%>
<div class="listForm">
    <div class="fw-bold fs-4">${dto.id}</div>
<div class="lh-sm">${dto.content}</div>
<div class="d-flex justify-content-end">
    <div>
        <c:if test="${sessionScope.loginId ne dto.id && sessionScope.loginId != null}">
            <a class="btn btn-warning btn-sm" href="${path}/cm/cmReportForm/${dto.cmNum}">신고</a>
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
</div>
</div>

<input id="infoList" type = "hidden" contentId="${dto.prknum}" division="parking" path="${path}"/>
    
</div>    
</div>

<script>

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
        if (sessionId != dto.id) {
            content += '<a class="btn btn-secondary btn-sm" href="">신고</a>'
        } else {
            content += '<a class="cmUpdateBtnForm btn btn-warning btn-sm">수정</a>'
            content += '<a cmNum="' + dto.cmNum + '" class="cmDelBtn btn btn-warning btn-sm ms-1">삭제</a>'
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

</script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script src="${path}/resources/js/cm.js"></script>
<script src="${path}/resources/js/recomend.js"></script>

</body>
</html>
