<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="mx-4">
    <div class="row mt-1" >
        <div class="col-4" >
            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <form onsubmit="searchPlaces(); return false;" class="text-center"
                          id="searchList">
                        <div class="d-flex justify-content-center mt-2">
                            <select class="form-select form-select-sm col"
                                    aria-label=".form-select-sm example" required="required" id="type">
                                <option value="addr" selected>지역</option>
                                <option value="name">업체명</option>
                            </select> <input class="form-control w-50 me-2" type="text" id="keyword">
                            <button class="btn btn-warning btn-sm" type="submit">검색하기</button>
                        </div>
                    </form>
                </div>
                <hr>
                <div class="list" style="overflow-y: scroll; height: 560px;">
                    <div>
                        <ul id="placesList" class="list-group list-group">
                            <!-- 리스트 -->
                        </ul>
                        <div id="pagination"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-8 ms-0" style="position: relative;">
            <div id="map"
                 style="width: 100%; height: 645px; position: relative; overflow: hidden;  position: absolute; "></div>
            <div id="map1"
                 style="width: 100%; height: 645px; position: relative; overflow: hidden; visibility:hidden; position: absolute;">
                <div id="close"
                     style="padding: 5px; position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2; cursor: pointer;">
                    닫기
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../fix/alarm.jsp"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=de13013a67053c1d19922fa8b31042a9"></script>
<script>
    // 마커를 담을 배열입니다
    var markers = [];
    var markers1 = [];
    var infowindow = new kakao.maps.InfoWindow({zIndex: 1, removable: true});

    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 12, // 지도의 확대 레벨
            mapTypeId: kakao.maps.MapTypeId.HYBRID
        };

    /* var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); */

    var mapContainer1 = document.getElementById('map1'), // 지도를 표시할 div
        mapOption1 = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 12, // 지도의 확대 레벨
            mapTypeId: kakao.maps.MapTypeId.ROADMAP
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);
    var map1 = new kakao.maps.Map(mapContainer1, mapOption1);
    var currPage = 1;
    var type = document.getElementById("type").options[document.getElementById("type").selectedIndex].value;
    var word = "";

    listCall(currPage, word, type);

    //지도 드래그시 이벤트
    kakao.maps.event.addListener(map, 'dragend', function () {
        // console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
        var aaa = map.getCenter().toString()
        var bbb = aaa.replace(/\(|\)| /g, '');
        // console.log(bbb);
        var ccc = bbb.split(",");
        //console.log(ccc[0]);//위도
        // console.log(ccc[1]);//경도
        var wido = ccc[0];
        var kyongdo = ccc[1];
        $.ajax({
            type: "POST",
            url: "./zapyo",
            data: {
                "wido": wido,
                "kyongdo": kyongdo
            },
            success: function (data) { //dto 배열 받아옴
                //console.log(data);
                displayPlaces(data);
            },
            error: function (data) {
                console.log(data);
            }
        });
    });


    // 마커를 생성하고 드래그 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = "${path}/resources/img/mapMarker.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(40, 42),  // 마커 이미지의 크기
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });
        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다
        return marker;
    }

    // 마커를 생성하고 일반 지도 위에 마커를 표시하는 함수입니다
    function addMarker1(position, idx, title) {
        var imageSrc = "${path}/resources/img/mapMarker.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(40, 42),  // 마커 이미지의 크기
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });
        marker.setMap(map1); // 지도 위에 마커를 표출합니다
        markers1.push(marker);  // 배열에 생성된 마커를 추가합니다
        return marker;
    }


    function displayPlaces(place) {
        var bounds = new kakao.maps.LatLngBounds();

        for (var i = 0; i < place.length; i++) {
            //마커생성 여러번!
            var placePosition = new kakao.maps.LatLng(place[i].mapY, place[i].mapX),
                marker = addMarker(placePosition, i);

            (function (marker, title) {
                kakao.maps.event.addListener(marker, 'click', function () {
                    displayInfowindow(marker, title);
                    map.setLevel(7, {anchor: marker.n});
                    map.panTo(marker.n);
                });

                /* kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                }); */

            })(marker, place[i]);

        }
    }

    function displayPlaces1(place) {
        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment();
        //마커 바꾸기
        
      	var  cimageSrc = "${path}/resources/img/clickMarker.png",
			        cimageSize = new kakao.maps.Size(50, 52),
			        cmarkerImage = new kakao.maps.MarkerImage(cimageSrc, cimageSize);

        removeAllChildNods(listEl);
        for (var i = 0; i < place.length; i++) {

            //마커생성 리스트!
            var placePosition = new kakao.maps.LatLng(place[i].mapY, place[i].mapX),
                marker1 = addMarker1(placePosition, i),
                itemEl = listPrint(i, place[i]);

            (function (marker1, title) {
                kakao.maps.event.addListener(marker1, 'click', function () {
                    displayInfowindow1(marker1, title);
                    map1.setLevel(5, {anchor: marker1.n});
                    map1.panTo(marker1.n);
                    resetMarker();
                    //마커바꾸기
                    marker1.setImage(cmarkerImage);
                });


                itemEl.onclick = function () {
                    open();
                    displayInfowindow1(marker1, title);
                    map1.setLevel(7, {anchor: marker1.n});
                    map1.panTo(marker1.n);
                    resetMarker();
                    //마커바꾸기
                    marker1.setImage(cmarkerImage);

                };


            })(marker1, place[i]);
            fragment.appendChild(itemEl);
             
        }
        listEl.appendChild(fragment);
    }

    //정보띄우는 함수
    function displayInfowindow(marker, title) {
        var content = '<div class="card mx-1 my-1" style="max-width: 350px;"><div class="row g-0"><div class="col-md-4">';
        content += '<img src="' + title.firstImageUrl + '" class="img-fluid w-100 h-100 rounded-start me-1" alt="' + title.facltNm + '">';
        content += '</div><div class="ms-2 col-md-7">';
        content += '<h5 class="card-title">' + title.facltNm + '</h5>';
        content += '<p class="card-text">' + title.addr1 + '</p>';
        content += '<p class="card-text"><small class="text-muted"><a href="${path}/reserve/campingDetail/' + title.contentId + '">상세보기</a></small></p></div></div></div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    };

    //정보띄우는 함수
    function displayInfowindow1(marker, data) {
        var content = '<div class="card mx-1 my-1" style="max-width: 350px;"><div class="row g-0 border-white"><div class="col-md-4">';
        content += '<img src="' + data.firstImageUrl + '" class="img-fluid w-100 h-100 rounded-start me-1" alt="' + data.facltNm + '">';
        content += '</div><div class="ms-2 col-md-7">';
        content += '<h5 class="card-title">' + data.facltNm + '</h5>';
        content += '<p class="card-text">' + data.addr1 + '</p>';
        content += '<p class="card-text"><small class="text-muted"><a href="${path}/reserve/campingDetail/' + data.contentId + '">상세보기</a></small></p></div></div></div>';
        infowindow.setContent(content);
        infowindow.open(map1, marker);
    };


    //검색 함수
    function searchPlaces() {
        type = document.getElementById("type").options[document.getElementById("type").selectedIndex].value;
        word = document.getElementById('keyword').value;
        console.log(type);

        if (!word.replace(/^\s+|\s+$/g)) {
            alert('키워드를 입력해주세요!');
            return false;
        }
        listCall(currPage, word, type);
    };

    //리스트 부르는 함수
    function listCall(page, word, type) {
        //{pagePerNum}/{page}
        var reqUrl = 'mapSearchList/' + page;
        //console.log('request page' + reqUrl);
        $.ajax({
            url: reqUrl,
            type: 'post',
            data: {
                "word": word, "type": type
            },
            dataType: 'json',
            success: function (data) { //데이터가 성공적으로 들어왔다면
                var check = true;
                //console.log(data);
                //listPrint(data.list); //리스트 그리기
                pagePrint(data);
                removeMarker1(data.list);
                displayPlaces1(data.list);
                displayPlaces(data.list);

                if (!data.list.length) {
                    //console.log("널~!")
                    printNone();
                }

            },
            error: function (error) {
                console.log(error);
            }
        });
    };

    //리스트 부르기
    function listPrint(index, list) {
        var el = document.createElement('li'),
            /* for (var i = 0; i < list.length; i++) { */
            content = '<div class="card mb-1 marker_' + (index) + '" style="max-width: 500px; cursor: pointer; background-color:#f0f8ff;"><div class="row g-0"><div class="col-md-4">'
        content += '<img src="' + list.firstImageUrl + '" class="img-fluid w-100 h-100 rounded-start me-1" alt="' + list.facltNm + '">'
        content += '</div><div class="ms-2 col-md-7">'
        content += '<h5 class="card-title">' + list.facltNm + '</h5>'
        content += '<p class="card-text">' + list.addr1 + '</p>'
        content += '<p class="card-text"><small class="text-muted">' + list.tel + '</small></p></div></div></div>'
        //$("#placesList").empty();
        //$("#placesList").append(content);
        el.innerHTML = content;
        el.className = 'item';

        return el;

        
    };

    //페이징 그리기
    function pagePrint(map) {
        //console.log(map);
        content = '';
        content += '<ul class="pagination justify-content-center">'
        if (map.startPage != 1) {
            content += '<li class="page-item">'
            content += '<a class="page-link page-info" page="'
                + (map.startPage - 1)
                + '" aria-label="Previous" style="cursor:pointer;">'
            content += '<span aria-hidden="true">&laquo;</span>'
            content += '</a>'
            content += '</li>'
        }
        for (let i = map.startPage; i <= map.endPage; i++) {
            if (map.currPage != i) {
                content += '<li class="page-item"><a style="cursor:pointer;" class="page-link page-info" page="' + i + '" >'
                    + i + '</a></li>'
            } else {
                content += '<li class="page-item active"><a class="page-link">'
                    + i + '</a></li>'
            }
        }
        if (map.totalPage != map.endPage) {
            content += '<li class="page-item">'
            content += '<a class="page-link page-info" page="'
                + (map.endPage + 1)
                + '" aria-label="Next" style="cursor:pointer;">'
            content += '<span aria-hidden="true">&raquo;</span>'
            content += '</a>'
            content += '</li>'
        }
        content += '</ul>'
        $('#pagination').empty();
        $('#pagination').append(content);
    }

    //마커 리셋
    function resetMarker() {
    	 var imageSrc = "${path}/resources/img/mapMarker.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(40, 42),  // 마커 이미지의 크기
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
        for (var i = 0; i < markers1.length; i++) {
            markers1[i].setImage(markerImage);
        }
    }; 
    //marker1 지우기
    function removeMarker1() {
        for (var i = 0; i < markers1.length; i++) {
            markers1[i].setMap(null);
        }
        markers1 = [];
    };

    //페이지 클릭시
    $(document).on('click', '.page-info', function () {
        page = $(this).attr('page');
        $.ajax({
            type: "post",
            url: 'mapSearchList/' + page,
            data: {
                "word": word
                , "type": type
            },
            dataType: 'JSON',
            success: function (data) { //성공시
                //console.log(data);
                //listPrint(data.list); //리스트 그리기
                pagePrint(data);
                removeMarker1(data.list);
                displayPlaces1(data.list);
            },
            error: function (e) { //실패시
                console.log(e);
            }
        });
    })

    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }

    function open() {
        document.getElementById('map1').style.visibility = "visible";
        document.getElementById('map').style.visibility = "hidden";
    }

    $("#close").click(function () {
        document.getElementById('map').style.visibility = "visible";
        document.getElementById('map1').style.visibility = "hidden";
    });

    function printNone() {
        var content = '<div class="text-center " style="max-width: 500px;"><div class="row g-0">';
        content += '<h5 class="card-title">검색 결과가 없습니다. 다시 검색해주세요.</h5>'
        content += '</div>'
        $('#placesList').append(content);
        $('#pagination').empty();
    }
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>