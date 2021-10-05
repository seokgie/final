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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!-- 부트스트랩 css 추가 -->
<%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
	<%-- 상단 로그인 추가 --%>
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../../fix/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../../fix/loginNavbar.jsp" />
	</c:if>
	<%-- 상단 메뉴바 --%>
	<jsp:include page="../../fix/menu.jsp" />
	<%-- 내용 넣으세요 --%>
	<div class="container px-3 mt-2">
		<div class="container mx-2">

			<!-- 상단 -->
			<div class="row">
				<div class="col"><h3>${dto.title}</div>
				<c:if test="${sessionScope.admin eq 'Y' and sessionScope.loginId eq dto.id}">
				<div class="col d-flex flex-row-reverse">
				
					<input type="button" value="수정"
						onclick="location.href='../questionUpdateForm/${dto.boardNum}'" /> <input
						type="button" value="삭제"
						onclick="location.href='../questionDel/${dto.boardNum}'" />
				</div>
				</c:if>
			</div>

			<div class="row">
				<div class="col">${dto.id} l ${dto.dates}</div>

				<div class="col d-flex flex-row-reverse">조회수${dto.boardHit} 
					</div>
			</div>

			<hr />

			<!-- 중단 -->
			<div>
				<div class="d-flex justify-content-center row">
					<c:forEach var="photo" items="${phoDtos}">
						<div class="d-flex justify-content-center row mb-3">
							<img src="/photo/${photo.newFileName}"
								style="max-width: 400px; height: auto;"
								onerror="this.src='${path}/resources/img/noImage.png';" />
						</div>
					</c:forEach>
				</div>
				<br />
				<div>${dto.content}</div>
			</div>

			<div class="d-flex justify-content-center"">
				<div id="good" class="btn btn-outline-warning mx-1" goodCheck="${map.goodCheck}">
   					 좋아요 ${map.goodCount}개
				</div>
				<!--  <input type="button" value="신고" /> -->
			</div>

			<hr />

			<div class="d-flex flex-row-reverse">
				<input class="btn btn-primary" type="button" value="목록"
					onclick="location.href='../questionBoard/1'">
			</div>

				
			<!-- 댓글 -->
			<div class="pt-4 border-bottom border-dark">
				<h4 class="fw-bold">답변</h4>
			</div>
		
			<%-- 댓글 입력 폼 --%>	
			<c:if test="${sessionScope.admin eq 'Y' }">
			<div class="d-flex align-items-center mt-2">
				<div class="form-floating flex-grow-1 px-2">
					<textarea class="form-control" placeholder="Leave a comment here"
						name="commentContent" id="commentContent"
						style="height: 100px; resize: none;"></textarea>
					<div class="invalid-feedback">1자 이상 입력해주세요</div>
					<c:if test="${sessionScope.loginId  eq null}">
						<label for="commentContent">답변을 작성하려면, 로그인 해주세요</label>
					</c:if>
					<c:if test="${sessionScope.admin eq 'Y'}">
						<label for="commentContent">관리자님 이곳에
							답변을 작성하세요</label>
					</c:if>
				</div>
				<c:if test="${sessionScope.admin eq 'Y'}">
					<a id="cmInsertBtn" class="btn btn-warning btn-sm">등록</a>
				</c:if>
			</div>
			</c:if>
			
			
			<%-- 댓글리스트 --%>
			<div id="commentLists" class="container px-5 my-4">
				<c:forEach items="${map.cmList}" var="dto">
					<%-- 댓글 내용 --%>
					<div class="listForm">
						<div class="fw-bold fs-4">${dto.id}</div>
						<div class="lh-sm">${dto.content}</div>
						<div class="d-flex justify-content-end">
							<div>
								<%-- <c:if
									test="${sessionScope.loginId ne dto.id && sessionScope.loginId != null}">
									<a class="btn btn-warning btn-sm" href="">신고</a>
								</c:if> --%>
								<c:if test="${sessionScope.loginId eq dto.id and sessionScope.admin eq 'Y'}">
								
									<a class='cmUpdateBtnForm btn btn-warning btn-sm'>수정</a>
									<a cmNum="${dto.cmNum}" class='cmDelBtn btn btn-warning btn-sm'>삭제</a> 
								</c:if>
							</div>
						</div>
						<div class="d-flex justify-content-end">작성일 : ${dto.dates}</div>
						<hr />
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
							<a cmNum="${dto.cmNum}"
								class='cmUpdateBtn btn btn-warning btn-sm'>등록</a> <a
								class='cmUpdateCancel btn btn-warning btn-sm ms-1'>취소</a>
						</div>
						<hr />
					</div>
				</c:forEach>
			</div>
			
			<%-- 페이지 네이션 --%>
			 <%-- <div id="paginationBox">
				<ul class="pagination justify-content-center mb-3">
					<c:if test="${map.startPage ne 1}">
						<li class="page-item"><a class="page-link page-info"
							aria-label="Previous" style="cursor: pointer;"
							page=${map.startPage+1}> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
				
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<c:if test="${i ne map.currPage}">
							<li class="page-item"><a class="page-link page-info"
								style="cursor: pointer;" page=${i}>${i}</a></li>
						</c:if>
						<c:if test="${i eq map.currPage}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:if>
					</c:forEach>
					
					<c:if test="${map.totalPage ne map.endPage}">
						<li class="page-item"><a class="page-link page-info"
							aria-label="Next" page=${map.endPage+1 } style="cursor: pointer;">
            <span aria-hidden="true">&raquo;</span>
        			</a>
						</li>
					</c:if>
				</ul>
			</div> --%>
		</div>
	</div>  
	<input id="infoList" type = "hidden" contentId="${dto.boardNum}" division="question" path="${path}"/>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/bootstrap.js"></script>
	<script src="${path}/resources/js/bootstrap.bundle.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<script src="${path}/resources/js/cm.js"></script>
	<script src="${path}/resources/js/good.js"></script>
</body>
</html>