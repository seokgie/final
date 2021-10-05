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
	<h3>자유게시판</h3>
    
    <table class="table table-hover">
	  	<thead>
		    <tr>
		    	<th scope="col">게시글 번호</th>
		    	<th scope="col">제목</th>
		    	<th scope="col">작성자</th>
		    	<th scope="col">조회수</th>
		    	<th scope="col">작성일</th>
		    </tr>
		</thead>
	  
		<tbody>
			<c:forEach items="${dtoList}" var="dto">
				<tr>
				   	<td scope="row" class="py-3">${dto.boardNum}</td>
					<td class="py-3"><a href="${path}/campingTalk/freeDetail/${dto.boardNum}" style="text-decoration:none;">${dto.title}</a></td>
					<td class="py-3">${dto.id}</td>
					<td class="py-3">${dto.boardHit}</td>
					<td class="py-3">${dto.dates}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>    
	
	<ul class="pagination justify-content-center">
		<c:if test="${map.startPage ne 1}">
			<li class="page-item">
				<a class="page-link" href="${path}/campingTalk/freeBoard/${map.startPage-1}" aria-label="Previous">
                	<span aria-hidden="true">&laquo;</span>
                </a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
			<c:if test="${i ne map.currPage}">
				<li class="page-item">
					<a class="page-link" href="${path}/campingTalk/freeBoard/${i}">${i}</a>
				</li>
			</c:if>
			<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link">${i}</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${map.totalPage ne map.endPage}">
			<li class="page-item">
				<a class="page-link" href="${path}/campingTalk/freeBoard/${map.endPage+1}" aria-label="Next">
                	<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
	</ul>
	<c:if test="${sessionScope.loginId ne null}">
		<div class="d-flex flex-row-reverse">
	    	<input class="btn btn-primary d-flex" type="button" value="글쓰기" onclick="location.href='${path}/campingTalk/freeWriteForm'">
	    </div>
    </c:if>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>

<script>
	var currPage = 1;
	var per = 10;

	var delMsg = "${delMsg}"
	if (delMsg != "") {
		alert(delMsg);
	}
</script>
</body>
</html>
