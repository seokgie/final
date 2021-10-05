<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <link href="${path}/resources/css/common.css?var=5" rel="stylesheet">
    <link href="${path}/resources/css/mainWeather.css?var=9" rel="stylesheet">
    <style>
        .imgPlus img {
            transition: all 0.2s linear;
        }

        .imgPlus:hover img {
            transform: scale(1.4);
        }

        .imgPlus {
            overflow: hidden;
        }
    </style>
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="fix/menu.jsp"/>
<%-- 슬라이드 바 --%>
<section class="page-section">
    <div path="${path}" id="carousels" class="carousel slide carousel-fade" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${path}/resources/img/test1.jpg" class="d-block w-100"
                     style="image-rendering:smooth;height: 330px" alt="...">
            </div>
            <div class="carousel-item">
                <img src="${path}/resources/img/test2.jpg" class="d-block w-100"
                     style="image-rendering:smooth;height: 330px" alt="...">
            </div>
            <div class="carousel-item">
                <img src="${path}/resources/img/test3.jpg" class="d-block w-100" style="height: 330px" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carousels"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carousels"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>
<%-- 가고싶어요 상위 4개 --%>
<section class="px-2 py-2">
    <div class="container my-3">
        <div class="border-bottom mb-3">
            <h2 class="">가장 많이 가고싶은곳!</h2>
        </div>
        <div class="row g-4">
            <c:forEach items="${map.goodList}" var="lists">
                <div class="col-md-3">
                    <div class="card h-100">
                        <a href="${path}/reserve/campingDetail/${lists.contentId}" class="imgPlus">
                            <img src="${lists.firstImageUrl}" class="card-img-top" style="height: 180px">
                        </a>
                        <div class="card-body">
                            <a href="${path}/reserve/campingDetail/${lists.contentId}"
                               class="card-title text-decoration-none text-dark h5">
                                    ${lists.facltNm}</a>
                            <p class="card-text text-muted">
                                <c:forTokens items="${lists.themaEnvrnCl}" delims="," var="tag">
                                    #${tag}
                                </c:forTokens>
                            </p>
                        </div>
                        <div class="card-footer">
                            가고싶어요 : ${lists.goodCount}개
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<%-- 날씨 나타내기 --%>
<section class="pt-2" style="background-color: #f1f3f9">
    <div class="lb-widget mb-0">
        <div class="lb-main">
            <select class="beom" id="select-box">
                <option value="1">Seoul, 서울</option>
                <option value="2">Incheon, 인천</option>
                <option value="3">Daejeon, 대전</option>
                <option value="4">Gwangju, 광주</option>
                <option value="5">Daegu, 대구</option>
                <option value="6">Ulsan, 울산</option>
                <option value="7">Busan, 부산</option>
                <option value="8">Jeju, 제주</option>
            </select>
        </div>
        <div id="lb-1" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=37.5266&lon=127.0403&name=Seoul, 서울&color=&font=&units=si"></iframe>
        </div>
        <div id="lb-2" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=37.4496&lon=126.7074&name=Incheon, 인천&color=#F6A8A6&font=&units=si"></iframe>
        </div>
        <div id="lb-3" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=36.3512&lon=127.3954&name=Daejeon, 대전&color=#5BC065&font=&units=si"></iframe>
        </div>
        <div id="lb-4" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=35.1787&lon=126.8974&name=Gwangju, 광주(전남)&color=#A5C8E4&font=&units=si"></iframe>
        </div>
        <div id="lb-5" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=35.8759&lon=128.5964&name=Daegu, 대구&color=#C0ECCC&font=&units=si"></iframe>
        </div>
        <div id="lb-6" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=35.538&lon=129.324&name=울산&color=#F9F0C1&font=&units=si"></iframe>
        </div>
        <div id="lb-7" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=35.1334&lon=129.1058&name=부산&color=#BA55D3&font=&units=si"></iframe>
        </div>
        <div id="lb-8" class="lb-weather">
            <iframe src="https://forecast.io/embed/#lat=33.5007&lon=126.5288&name=제주&color=#ffc261&font=&units=si"></iframe>
        </div>
    </div>
</section>
<%-- 지역별 리스트 나타내기 --%>
<section class="px-2 py-2">
    <div class="container my-3">
        <div class="border-bottom mb-3">
            <h2 class="">지역별로 찾아보세요!</h2>
        </div>
        <div class="row">
            <div class="col-md-4 mt-3 border-end">
                <div class="d-grid gap-2 pe-1">
                    <div class="btn btn-outline-secondary locationBtn">경기</div>
                    <div class="btn btn-outline-secondary locationBtn">경북</div>
                    <div class="btn btn-outline-secondary locationBtn">경남</div>
                    <div class="btn btn-outline-secondary locationBtn">전북</div>
                    <div class="btn btn-outline-secondary locationBtn">전남</div>
                    <div class="btn btn-outline-secondary locationBtn">강원</div>
                    <div class="btn btn-outline-secondary locationBtn">충남</div>
                    <div class="btn btn-outline-secondary locationBtn">충북</div>
                </div>
            </div>
            <div class="col-md-8 mt-2">
                <div class="row g-4 ps-1" id="locationBox">
                    <c:forEach items="${map.list}" var="lists">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <a href="${path}/reserve/campingDetail/${lists.contentId}" class="imgPlus">
                                    <img src="${lists.firstImageUrl}" class="card-img-top" style="height: 130px">
                                </a>
                                <div class="card-body">
                                    <a href="${path}/reserve/campingDetail/${lists.contentId}"
                                       class="card-title text-decoration-none text-dark h5">
                                            ${lists.facltNm}</a>
                                    <p class="text-muted fs-6">
                                            ${lists.addr1}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div id="paginationBox">
                    <ul class="pagination justify-content-center mt-3">
                        <c:if test="${map.startPage ne 1}">
                            <li class="page-item">
                                <a location="${map.location}" class="page-link page-info" aria-label="Previous"
                                   style="cursor:pointer;"
                                   page=${map.startPage+1}>
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
                            <c:if test="${i ne map.currPage}">
                                <li class="page-item"><a class="page-link page-info" style="cursor:pointer;"
                                                         page=${i} location="${map.location}">${i}</a></li>
                            </c:if>
                            <c:if test="${i eq map.currPage}">
                                <li class="page-item active"><a class="page-link">${i}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${map.totalPage ne map.endPage}">
                            <li class="page-item">
                                <a class="page-link page-info" aria-label="Next"
                                   location="${map.location}" page=${map.endPage+1} style="cursor:pointer;">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- 다양한 소식 --%>
<section class="px-2 pb-5 pt-2" style="background-color: #f1f3f9">
    <div class="container my-3 pb-3">
        <div class="border-bottom">
            <h2 class="">다양한 소식</h2>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-3 border-end text-center">
                <div class="d-flex">
                    <h1>캠핑리뷰</h1>
                    <a href="${path}/campingTalk/reviewBoard/1" class="ms-2 mt-1 text-decoration-none text-dark"><i
                            class="bi bi-plus-circle fs-1"></i></a>
                </div>
                <table class="table table-hover px-2">
                    <tbody>
                    <c:forEach items="${map.reviewBoardList}" var="lists">
                        <tr onclick="location.href='${path}/campingTalk/reviewDetail/${lists.boardNum}'"
                            style="cursor: pointer">
                            <td class="py-3">
                                <div class="target">
                                    <a class="text-decoration-none text-dark"
                                       href="${path}/campingTalk/reviewDetail/${lists.boardNum}">${lists.title}</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-md-3 border-end text-center">
                <div class="d-flex">
                    <h1>자유게시판</h1>
                    <a href="${path}/campingTalk/freeBoard/1" class="ms-2 mt-1 text-decoration-none text-dark"><i
                            class="bi bi-plus-circle fs-1"></i></a>
                </div>
                <table class="table table-hover px-2">
                    <tbody>
                    <c:forEach items="${map.freeBoardList}" var="lists">
                        <tr onclick="location.href='${path}/campingTalk/freeDetail/${lists.boardNum}'" style="cursor: pointer">
                            <td class="py-3">
                                <div class="target">
                                    <a class="text-decoration-none text-dark" href="">${lists.title}</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-md-3 border-end text-center">
                <div class="d-flex">
                    <h1>문의하기</h1>
                    <a href="${path}/serviceCenter/questionBoard/1" class="ms-2 mt-1 text-decoration-none text-dark"><i
                            class="bi bi-plus-circle fs-1"></i></a>
                </div>
                <table class="table table-hover px-2">
                    <tbody>
                    <c:forEach items="${map.questionBoardList}" var="lists">
                        <tr onclick="location.href='${path}/serviceCenter/questionDetail/${lists.boardNum}'"
                            style="cursor: pointer">
                            <td class="py-3">
                                <div class="target">
                                    <a class="text-decoration-none text-dark">${lists.title}</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-md-3 text-center">
                <div class="d-flex">
                    <h1>공지사항</h1>
                    <a href="${path}/serviceCenter/noticeBoard/1" class="ms-2 mt-1 text-decoration-none text-dark"><i
                            class="bi bi-plus-circle fs-1"></i></a>
                </div>
                <table class="table table-hover px-2">
                    <tbody>
                    <c:forEach items="${map.noticeBoardList}" var="lists">
                        <tr onclick="location.href='${path}/serviceCenter/noticeDetail/${lists.boardNum}'"
                            style="cursor: pointer">
                            <td class="py-3">
                                <div class="target">
                                    <a class="text-decoration-none text-dark">${lists.title}</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<%-- 푸터영역 --%>
<footer class="py-5" style="background-color: #d9dbe9">
    <div class="container text-center">
        <p class="fs-5 mb-1">구디아카데미의 전설 마지막 프로젝트</p>
        <p class="fs-6 mb-0">Copyright &copy; Your Website</p>
    </div>
</footer>
<jsp:include page="fix/alarm.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js?var=3"></script>
<script src="${path}/resources/js/mainWeather.js?var=2"></script>
<script src="${path}/resources/js/mainLocation.js?var=3"></script>
</body>
</html>
