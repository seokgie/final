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
<style>
#dimention {
	height: 750px;
}

#blog {
	width: 800px;
	height: 750px;
}
</style>
</head>
<body>
	<%-- 상단 로그인 추가 --%>
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fix/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../fix/loginNavbar.jsp" />
	</c:if>
	<%-- 상단 메뉴바 --%>
	<jsp:include page="../fix/menu.jsp" />
	<%-- 내용 넣으세요 --%>
	<div class="mx-3">
		<div class="border-bottom mb-3 border-dark">
			<h2 class="">캠핑레시피</h2>
		</div>
		<h5 id="total"></h5>
		<div class="row">
			<div class="col-4 ms-3">
				<!-- 왼쪽으로 당기기 -->
				<div class="row mb-2">
					<!-- 검색 공간 -->
					<div class=" col-10 ps-3 pe-0">
						<input type="text" class="form-control" id="searchInput"
							name="searchInput" placeholder="레시피를 검색해주세요"/>
					</div>
					<!-- 검색 버튼 공간 -->
					<div class="form-group col-2 p-0">
						<button id="searchBtn" class="btn btn-dark">검색</button>
					</div>
				</div>
				<!-- 레시피 부분 -->
				<div id="scroll" class="overflow-scroll">
					<div id="dimention" class="d-flex justify-content-start row">
						<div id="card" class="row row-cols-1 row-cols-md-2 g-4"></div>
					</div>
				</div>
				<div id="paginationBox">
				</div>
			</div>
			<div id="blog" class="ms-3">
			<iframe id="link"
					src="https:\/\/blog.naver.com\/duri3576?Redirect=Log&logNo=222298424685" style="width:1200px;height:820px;margin-left:60px"> </iframe>
			</div>
		</div>
	</div>
	<jsp:include page="../fix/alarm.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/bootstrap.js"></script>
	<script src="${path}/resources/js/bootstrap.bundle.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<script>
	var search = "캠핑";
	$(document).on('click', '.page-info', function() {
		let page = $(this).attr('page');
		$("#card").empty();
		search += "레시피";
		$.ajax({
			url : 'RecipeApi/' + page + '/' + search,
			type : 'get',
			dataType : 'json',
			success : function(map) {
				console.log(map)
				RecipeList(map);
			},
			error : function(error) {
				console.log(error);
			}
		});
	})
	page = 1;
	var searchCount = 0;
	var firstLink = "";
	
	//카드가 클릭 되었을 때 
	$(document).on('click', ".clickCard", function() {
		let url = $(this).attr('url');
		console.log(url)
		$("#link").attr('src', url);
	});
	
	blog(search);

	//검색 클릭되었을때
	$('#searchBtn').on('click', function() {
		search = $("#searchInput").val();
		blog(search);
	});
	
	//검색칸 엔터가 눌렸을 때 
	$('#searchInput').on('keypress', function(e) {
		if (e.keyCode == '13') {
			$('#searchBtn').click();
		}
	});
	
	//초반, 검색 데이터 입력 map받음
	function blog(search) {
		$("#card").empty();
		search += "레시피";
		$.ajax({
			url : 'RecipeApi/' + page + '/' + search,
			type : 'GET',

			dataType : 'JSON',
			success : function(map) {
				console.log(map);
				RecipeList(map);

			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	//게시물들 출력
	function RecipeList(map) {
		
		
		$("#total").empty();
		$("#total").append("총 검색 수: " + map.total);
		var content = "";
		let url = $(this).attr('url');
		console.log(url)
		$("#link").attr('src', map.items[0].link);
		//블로그 게시물들
		for (var i = 0; i <10; i++) {
			//카드
			content += "<div class='col'>";
			content += "<div id='' class='clickCard card border-dark' url='"+map.items[i].link+"' style='cursor:pointer'>";
			content += "<div class='card-body'>";
			content += "<h5 class='card-title'>" + map.items[i].title
					+ "</h5>";
			content += "<p class='card-text'>" + map.items[i].description
					+ "</p>";
			content += "</div>";
			content += "</div>";
			content += "</div>";
			
		}$("#card").empty;
		$("#card").append(content);
		//페이지네이션
		content = '';
		content += '<ul class="pagination justify-content-center">'
		if (map.startPage != 1) {
			content += '<li class="page-item">'
			content += '<a class="page-link page-info" page="'
					+ (map.map.startPage - 1)
					+ '" aria-label="Previous" style="cursor:pointer;">'
			content += '<span aria-hidden="true">&laquo;</span>'
			content += '</a>'
			content += '</li>'
		}
		for (let i = map.map.startPage; i <= map.map.endPage; i++) {
			if (map.map.currPage != i) {
				content += '<li class="page-item"><a style="cursor:pointer;" class="page-link page-info" page="' + i + '" >'
						+ i + '</a></li>'
			} else {
				content += '<li class="page-item active"><a class="page-link">'
						+ i + '</a></li>'
			}
		}
		if (map.totalPage != map.map.endPage) {
			content += '<li class="page-item">'
			content += '<a class="page-link page-info" page="'
					+ (map.map.endPage + 1)
					+ '" aria-label="Next" style="cursor:pointer;">'
			content += '<span aria-hidden="true">&raquo;</span>'
			content += '</a>'
			content += '</li>'
		}
		content += '</ul>'
		$('#paginationBox').empty();
		$('#paginationBox').append(content);
	}
	</script>
</body>

</html>
