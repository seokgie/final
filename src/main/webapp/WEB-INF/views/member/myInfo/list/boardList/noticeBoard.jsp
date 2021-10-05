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
    <link href="${path}/resources/css/bootstrap.css" rel="stylesheet">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=3" rel="stylesheet">
    <link href="${path}/resources/css/lineSmall.css?var=2" rel="stylesheet">
    <style>
        a {
            text-decoration-line: none;
        }

        .active {
            background-color: #ffc107 !important;
        }
    </style>
</head>
<body>
<%-- 상단 메뉴바 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../../../fix/loginNavbar.jsp"/>
</c:if>
<jsp:include page="../../../../fix/menu.jsp"/>
<div class="row">
    <jsp:include page="../../myInfoSidebar.jsp"/>
    <div class="col w-100 p-0">
        <div class="container px-3 my-2">
            <div class="pt-4 border-bottom border-dark">
                <h2 class="fw-bold">게시글 목록</h2>
            </div>
            <div class="container">
                <jsp:include page="boardListFix.jsp"/>
                <c:if test="${fn:length(map.list) ne 0}">
                    <table class="table table-hover mt-3">
                        <thead>
                        <tr>
                            <th class="fs-5 col-2" scope="col">제목</th>
                            <th class="fs-5 col-3" scope="col">작성일자</th>
                            <th class="fs-5 col-7" scope="col">내용</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.list}" var="lists">
                            <tr>
                                <td class="py-3 align-middle"><a
                                        href="${path}/serviceCenter/noticeDetail/${lists.boardNum}">${lists.title}</a>
                                </td>
                                <td class="py-3 align-middle">${lists.dates}</td>
                                <td class="py-3 align-middle lineSmall">${lists.content}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination justify-content-center">
                        <c:if test="${map.startPage ne 1}">
                            <li class="page-item">
                                <a class="page-link" href="${path}/myInfo/boardList/${map.startPage-1}/noticeBoard"
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
                            <c:if test="${i ne map.currPage}">
                                <li class="page-item"><a class="page-link"
                                                         href="${path}/myInfo/boardList/${i}/noticeBoard">${i}</a>
                                </li>
                            </c:if>
                            <c:if test="${i eq map.currPage}">
                                <li class="page-item active"><a class="page-link">${i}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${map.totalPage ne map.endPage}">
                            <li class="page-item">
                                <a class="page-link" href="${path}/myInfo/boardList/${map.endPage+1}/noticeBoard"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </c:if>
                <c:if test="${fn:length(map.list) eq 0}">
                    <hr/>
                    <div class="text-center mt-2">
                        <p class="text-muted">작성한 게시글이 없습니다</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>
    $('#menuFour').addClass('active');
</script>
</body>
</html>
