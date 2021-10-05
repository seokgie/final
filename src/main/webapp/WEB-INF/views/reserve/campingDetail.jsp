<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
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
    <jsp:include page="../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="w-100 img-fluid border-white"
     style="height:300px;background-image: url('${path}/resources/img/bgHansol.jpg')">
    <div class="container pt-5 border-bottom border-white">
        <h1 id="infoAttr" class="text-white display-4" path="${path}" loginId="${sessionScope.loginId}"
            contentId="${map.dto.contentId}">${map.dto.facltNm}</h1>
        <div class="container pt-2">
            <h3 class="text-white ">
                <c:forTokens var="val" items="${map.dto.themaEnvrnCl}" delims=",">
                    #${val}
                </c:forTokens>
            </h3>
        </div>
    </div>
    <div class="container pt-2">
        <h3 class="text-white ">${map.dto.featureNm}</h3>
    </div>
</div>
<div class="container px-3 my-5">
    <div class="row">
        <div class="col-md-6 pt-2">
            <c:if test="${map.dto.firstImageUrl eq null}">
                <img src="${path}/resources/img/noImage.png" class="rounded img-fluid mx-auto d-block"
                     style="width: 500px; height: 360px;object-fit: cover;"/>
            </c:if>
            <c:if test="${map.dto.firstImageUrl ne null}">
                <img src="${map.dto.firstImageUrl}" class="rounded img-fluid mx-auto d-block"
                     style="width: 500px; height: 360px;object-fit: cover;"/>
            </c:if>
        </div>
        <div class="col-md-5">
            <table class="table table-hover align-middle">
                <tr>
                    <td class="col-3 py-3">주소</td>
                    <td>${map.dto.addr1}</td>
                </tr>
                <tr>
                    <td class="py-3">문의처</td>
                    <td>${map.dto.tel}</td>
                </tr>
                <tr>
                    <td class="py-3">캠핑장 환경</td>
                    <td>${map.dto.lctCl}</td>
                </tr>
                <tr>
                    <td class="py-3">캠핑장 유형</td>
                    <td>${map.dto.induty}</td>
                </tr>
                <tr>
                    <td class="py-3">운영기간</td>
                    <td>${map.dto.operPdCl}</td>
                </tr>
                <tr>
                    <td class="py-3">운영일</td>
                    <td>${map.dto.operDeCl}</td>
                </tr>
                <tr>
                    <c:if test="${not fn:contains(map.dto.homepage, 'http')}">
                        <td class="py-3">홈페이지</td>
                        <td><a href="https://${map.dto.homepage}">홈페이지로</a></td>
                    </c:if>
                    <c:if test="${fn:contains(map.dto.homepage, 'http')}">
                        <td class="py-3">홈페이지</td>
                        <td><a href="${map.dto.homepage}">홈페이지로</a></td>
                    </c:if>
                </tr>
            </table>
        </div>
    </div>
    <div class="text-center mt-3">
        <div>
            <a id="reserveBtn" href="${path}/reserve/campingReserveForm/${map.dto.contentId}"
               class="btn btn-warning mx-1">예약하기</a>
            <div id="good" class="btn btn-outline-warning mx-1" goodCheck="${map.goodCheck}">
                가고싶어요 ${map.goodCount}개
            </div>
        </div>
    </div>
    <div class="pt-4 border-bottom border-dark">
        <h4 class="fw-bold">캠핑장 소개</h4>
    </div>
    <div class="py-4 d-flex justify-content-between border-bottom border-dark">
        <c:if test="${fn:length(map.imgArr) eq 3}">
            <c:forEach items="${map.imgArr}" var="arr">
                <img src="${arr}" style="width: 400px; height: 250px"
                     onerror="this.src='${path}/resources/img/noImage.png';">
            </c:forEach>
        </c:if>
        <c:if test="${fn:length(map.imgArr) ne 3}">
            <img src="${path}/resources/img/noImage.png" style="width: 400px; height: 250px">
            <img src="${path}/resources/img/noImage.png" style="width: 400px; height: 250px">
            <img src="${path}/resources/img/noImage.png" style="width: 400px; height: 250px">
        </c:if>
    </div>
    <div class="pt-4">
        <p class="fs-6">
            ${map.dto.intro}
        </p>
    </div>
    <div class="pt-4 border-bottom border-dark">
        <h4 class="fw-bold">캠핑장 시설정보</h4>
    </div>
    <div class="py-4 my-2 rounded" style="height: 150px; background-color: #F6F5F4">
        <div class="container my-3 px-2 text-center d-flex justify-content-around">
            <c:forTokens var="val" items="${map.dto.sbrsCl}" delims=",">
                <c:if test="${val eq '무선인터넷'}">
                    <div>
                        <i class="bi bi-wifi fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '전기'}">
                    <div>
                        <i class="bi bi-plug fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '물놀이장'}">
                    <div>
                        <i class="bi bi-water fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '온수'}">
                    <div>
                        <i class="bi bi-droplet fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '산책로'}">
                    <div>
                        <i class="bi bi-bicycle fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '놀이터'}">
                    <div>
                        <i class="bi bi-emoji-laughing fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '장작판매'}">
                    <div>
                        <i class="bi bi-tree fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
                <c:if test="${val eq '마트.편의점'}">
                    <div>
                        <i class="bi bi-basket2 fs-3"></i>
                        <h5 class="align-middle">${val}</h5>
                    </div>
                </c:if>
            </c:forTokens>
        </div>
    </div>
    <div class="pt-4 border-bottom border-dark">
        <h4 class="fw-bold">기타 주요시설</h4>
    </div>
    <table class="table table-hover align-middle">
        <tr>
            <td class="col-3 py-3">주요시설</td>
            <td>${map.dto.posblFcltyCl}</td>
        </tr>
        <tr>
            <td class="py-3">기타 부대시설</td>
            <td>${map.dto.sbrsEtc}</td>
        </tr>
        <tr>
            <td class="py-3">바닥환경</td>
            <td>
                <c:if test="${map.dto.sitebottomCl1 ne 0}">
                    잔디
                </c:if>
                <c:if test="${map.dto.sitebottomCl2 ne 0}">
                    파쇄석
                </c:if>
                <c:if test="${map.dto.sitebottomCl3 ne 0}">
                    테크
                </c:if>
                <c:if test="${map.dto.sitebottomCl4 ne 0}">
                    자갈
                </c:if>
                <c:if test="${map.dto.sitebottomCl5 ne 0}">
                    맨흙
                </c:if>
            </td>
        </tr>
        <tr>
            <td class="py-3">반려동물 출입</td>
            <td>${map.dto.animalCmgCl}</td>
        </tr>
        <tr>
            <td class="py-3">화로대</td>
            <td>${map.dto.brazierCl}</td>
        </tr>
    </table>
    <div class="pt-4 border-bottom border-dark">
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
    <br/>
</div>
<jsp:include page="../fix/alarm.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js?var=56"></script>
<script src="${path}/resources/js/campingDetailCm.js?var=4"></script>
<script src="${path}/resources/js/campingDetailGood.js?var=4"></script>
</body>
</html>
