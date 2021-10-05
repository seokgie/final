<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
	<div class="container px-3">
		<div class="row">
			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
					<div class="layout mt-2" id="layout_3" >
					<c:if test="${!empty map.list}">
							<div class="tag_title">
								<span class="tag_stt">검색 내용은
								</span>
							<div class="tagBtn_group">
								<ul style="list-style:none;">
									<c:forEach var="i" items="${map.word}">
										<li style="float:left; margin-right:10px; padding:5px;" >
										<a class="tagBtn "  value="${i}" style=" text-align:center; padding-top:10px; text-decoration:none; color:#000000;">${i}</a>
										</li>
									</c:forEach>
									<li style="float:left; margin-right:10px; padding:5px;" >
										<a class="tagBtn " style=" text-align:center; padding-top:10px; text-decoration:none; color:#000000;">입니다.</a>
										</li>
										<li style="float:left; margin-right:10px; background-color:#97DD93; padding:5px;" >
										<a href="${path}/campingSearch/tagSearch/1" style=" text-align:center; padding-top:10px; text-decoration:none; color:#000000;">태그검색</a>
										</li>
								</ul>
							</div>
							</div>
						</div>
                    </div>
					</div>
					<br/><br/>
						</c:if>
				<%-- 	<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<form action="${path}/campingSearch/search/${i}" class="text-center" method="post">
						</c:forEach>
							<div class="d-flex justify-content-center mt-3">
								<input class="form-control w-50 me-2" type="text" id="keyword" name="word" >
								<button class="btn btn-warning btn-sm" type="submit">검색</button>
							</div>
						</form> --%>
					</div>
				</div>
						<c:if test="${empty map.list}">
					<div class="row mt-3 mb-3 text-center">
					<div>
				검색결과가 없습니다. 다시 입력해주세요.
					</div>
					</div>
				</c:if>
				<c:forEach var="map" items="${map.list}">
					<div class="card border-white" style="background-color: #f8fcfe">
						<div class="row g-0">
							<div class="col-md-4">
								<a href="${path}/reserve/campingDetail/${map.contentId}"> <img
									src="${map.firstImageUrl}" class="img-fluid rounded-start"
									alt="${map.facltNm}" style="height: 300px; width: 500px">
								</a>
							</div>
							<div class="col-md-8">
								<div class="card-body">
									<a href="${path}/reserve/campingDetail/${map.contentId}" style="text-decoration: none; color:#000000;">
										<h5 class="card-title">${map.facltNm}</h5>
									</a>
									${map.addr1}
									<p><small style="white-space: normal; display:-webkit-box; -webkit-box-orient:vertical; -webkit-line-clamp:3; overflow: hidden;">${map.intro}</small></p>
									<p class="card-text">
										<small class="text-muted">
										<c:forTokens items="${map.themaEnvrnCl}" delims="," var="word">
										<span>#${word}</span>
									</c:forTokens>
										</small>
									</p>
									<div
										class="container pt-2 my-3 px-2 text-center d-flex justify-content-around"
										style="background-color: #F6F5F4">

										<c:forTokens var="val" items="${map.sbrsCl}" delims=",">
											<c:if test="${val eq '무선인터넷'}">
												<div>
													<i class=" bi bi-wifi fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '전기'}">
												<div>
													<i class="bi bi-plug fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '물놀이장'}">
												<div>
													<i class="bi bi-water fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '온수'}">
												<div>
													<i class="bi bi-droplet fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '산책로'}">
												<div>
													<i class="bi bi-bicycle fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '놀이터'}">
												<div>
													<i class="bi bi-emoji-laughing fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '장작판매'}">
												<div>
													<i class="bi bi-tree fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
											<c:if test="${val eq '마트.편의점'}">
												<div>
													<i class="bi bi-basket2 fs-6"></i>
													<h6 class="align-middle">${val}</h6>
												</div>
											</c:if>
										</c:forTokens>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
					<c:if test="${!empty map.list}">
				<ul class="pagination justify-content-center">
					<c:if test="${map.startPage ne 1}">
						<li class="page-item"><a class="page-link"
							href="${path}/campingSearch/${map.url}/${map.startPage-1}/${map.word}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<c:if test="${i ne map.currPage}">
							<li class="page-item"><a class="page-link"
								href="${path}/campingSearch/${map.url}/${i}/${map.word}">${i}</a></li>
						</c:if>
						<c:if test="${i eq map.currPage}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${map.totalPage ne map.endPage}">
						<li class="page-item"><a class="page-link"
							href="${path}/campingSearch/${map.url}/${map.endPage+1}/${map.word}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
					</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../../fix/alarm.jsp"/>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=de13013a67053c1d19922fa8b31042a9"></script>
	<script>
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/bootstrap.js"></script>
	<script src="${path}/resources/js/bootstrap.bundle.js"></script>
	<script src="${path}/resources/js/common.js"></script>
</body>
</html>