<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 차트용 Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

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
    
<!-- 차트용 스타일 -->    
<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
path {
cursor:pointer;
}

</style>

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

<div class="row mb-2">

<div class="col mt-3">
  <h5>차박지도 (전국의 무료·공영 주차장을 확인하세요!)</h5>
</div>

<div class="col d-flex flex-row-reverse mt-2">
 <button onclick="location.href='./payPark'" class="btn btn-warning btn-sm">유료</button>
 <button onclick="location.href='./campingParking'" class="btn btn-warning btn-sm me-1">무료</button>
</div>

</div>

<!-- 장소정보, 지도 담고있는 div -->
<div class="d-flex justify-content-center">
<!-- 장소 정보 표출하는 곳 -->
<div class="list col-3" style="overflow-y:scroll; height:600px; border:1 solid #000000;">
<div style="text-align:center; margin-top:50px">
<p style="color:#b4b4b4;">지도를 드래그 하세요<p>
</div>
</div>  
<!-- 지도 -->
<div id="map" style="width:100%;height:600px;"></div>    
</div>

<br/>
<hr/>

<!-- 지도 아래부분 -->
<div class="row">

<!-- 차박지 순위 -->
<div class="col">
<h5>무료 차박지 추천 순위</h5>
<div id="chartdiv"></div>
</div>


<!-- 추천태그? 물, 바다, 산 -->
<!-- 
<div class="col">
<h5>추천 태그 영역</h5>
<div class="col d-flex flex-row-reverse mt-2">
 <button onclick="location.href=''" class="btn btn-warning btn-sm">산</button>
 <button onclick="location.href=''" class="btn btn-warning btn-sm me-2">물</button>
 <button onclick="location.href=''" class="btn btn-warning btn-sm me-2">바다</button>
</div>


<div class="row">
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">주차장명</th>
      <th scope="col">주소</th>

    </tr>
  </thead>
  <tbody>
  	<c:forEach items="${tags}" var="tag">
  		<tr>
  		<td>${tag.prkplcenm}</td>
  		<td>주소</td>
  		</tr>
  	</c:forEach>
  </tbody>
</table>

<ul class="pagination justify-content-center">
            <c:if test="${map.startPage ne 1}">
                <li class="page-item">
                <a class="page-link" href="${path}/campingTalk/reviewBoard/${map.startPage-1}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                </a>
                </li>
            </c:if>
            <c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
                <c:if test="${i ne map.currPage}">
                    <li class="page-item"><a class="page-link" href="${path}/campingTalk/reviewBoard/${i}">${i}</a></li>
                </c:if>
                <c:if test="${i eq map.currPage}">
                    <li class="page-item active"><a class="page-link">${i}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${map.totalPage ne map.endPage}">
                <li class="page-item">
                <a class="page-link" href="${path}/campingTalk/reviewBoard/${map.endPage+1}" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                </a>
                </li>
            </c:if>
    </ul>
</div>
 
 
</div>
-->

</div> <!-- 지도 아래부분 div 끝 -->






</div><!-- 전체 div -->


<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=379ea69d5a147ed25817ca69e93842c3&​&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 6, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.RoadMap // 지도종류
		    };
		
		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
           		
		     	// 지도 중심좌표를 접속위치로 변경합니다
			    map.setCenter(locPosition);
		    });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);
			
		 	// 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);

		}
		
		// 지도 타입 변경 컨트롤을 생성한다
		//var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
		//map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	

		// 지도에 확대 축소 컨트롤을 생성한다
		//var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		//map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 지도위에 생성된 마커들을 담는 배열임!
		var markers = [];
		
		// 지도위에 표시될 마커들을 담는 배열임!
		var infowindows = [];
		
		// 마커 아이콘 입히기
		var imageSrc = "${path}/resources/img/chaback.png",
		 	 imageSize = new kakao.maps.Size(40, 42),
		 	 markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
			
		// 지도 중심 좌표 변화 이벤트를 등록한다
		kakao.maps.event.addListener(map, 'dragend', function (){
			
			// 지도위에 표시된 마커들 제거
			// 지도위에 생성된 마커들을 담는 배열임 => 하나하자 지움!
			for (var e = 0; e < markers.length; e++) {
				markers[e].setMap(null);
			}
			$(".list").empty();
			
			// 지도에 표시된 인포윈도우 닫기
			for (var e = 0; e < infowindows.length; e++) {
				infowindows[e].close();
			}
		
			console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
			var aaa = map.getCenter().toString()
			
			var bbb = aaa.replace(/\(|\)| /g,'');
			console.log(bbb);
			
			var ccc = bbb.split(",");
			console.log(ccc[0]);//위도 
			console.log(ccc[1]);//경도
			
			var wido = ccc[0];
			var kyongdo = ccc[1];
			
			
			
			$.ajax({
				type:"POST",
				url:"./getZapyo",
				data:{
					"wido":wido,
					"kyongdo":kyongdo
				},
				success:function(data){ //dto 배열 받아옴
					console.log("받아온 DTO::",data);

					// 지도에 마커를 생성하고 표시한다	
					for (var i = 0; i < data.length; i++) {
						
						//마커생성 여러번!
						var marker = new kakao.maps.Marker({
						    position: new kakao.maps.LatLng(data[i].latitude, data[i].longitude), // 마커의 좌표
						    map: map, // 마커를 표시할 지도 객체
						    image: markerImage   
						});
						
						//marker.setMap(map);
						
						// 생성된 마커들을 배열에 담음(지도 이동할때마다, 이전에 표시된 마커 지우려고 담는거임)
						markers.push(marker);
						
						//리스트 그리기
						listPrint(data[i]);
					
						//var iwContent = '<div style="margin-right: 50px;">'+data[i].prkplcenm+'</div>'
						var iwContent = '<div style="padding:3px; background:#fff;">'+data[i].prkplcenm+'</div>';
						
						// 인포윈도우를 생성합니다
						var infowindow = new kakao.maps.InfoWindow({
						    content : iwContent
						});
						infowindows.push(infowindow);
						
						
						//마우스 이벤트 등록
						kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
					    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
					    kakao.maps.event.addListener(marker, 'click', makeClickListener(data[i].prknum));				
					}		
				},
				error: function(data){
					console.log(data);
					
					dragPrint();
				}
			});			
		});
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		        
		    };
		}
		
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		
		function makeClickListener(prknum) {
		    return function() {
		      location.href="./freeParkDetail/"+prknum;    
			};
		}
		
		function listPrint(data){
			var content = "";
			
			var xxx = data.latitude;
			var yyy = data.longitude;
			var prk = data.prkplcenm;

			content +=  '<div class="card mb-1">'
            content +=   '<div class="ms-2 mt-2 col-md">'
            content +=    '<h5 class="card-title"><a onmouseover="moe('+xxx+','+yyy+')" onmouseout="moeClose()" href="./freeParkDetail/'+data.prknum+'" style="text-decoration:none;">'+prk+'</a></h5>';
            content +=    '<div class="card-text"><small>'+"주차구획 수: "+data.prkcmprt+'</small></div>';
            content +=    '<div class="card-text"><small>'+"추천수: "+data.count+'</small></div>';
            content +=    '<div class="card-text mb-1"><small class="text-muted">'+"전화번호: "+data.phonenumber+'</small></div></div></div>';
            $(".list").append(content);
		}
       	
		function dragPrint(){
			var content = "";
			
			content += '<div style="text-align:center; margin-top:50px">';
			content += '<p style="color:#b4b4b4;">지도를 드래그 하세요<p>'	;
			content += '</div>';
			
			$(".list").append(content);
		}
		
		
		//마우스 오버시 반응할 놈
		var markers2 = [];
		
		var imageSrc = "${path}/resources/img/chaback.png", // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(75, 80), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		
		function moe(xxx,yyy){
			map.panTo(new kakao.maps.LatLng(xxx, yyy));
			
		 	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		        markerPosition = new kakao.maps.LatLng(xxx, yyy); // 마커가 표시될 위치입니다
		 	// 마커를 생성합니다
		    var marker2 = new kakao.maps.Marker({
		        		position: markerPosition, 
		        		image: markerImage // 마커이미지 설정 
		    });
		    // 마커가 지도 위에 표시되도록 설정합니다
		    marker2.setMap(map);
		    markers2.push(marker2);	    
		}
		
		function moeClose(){
			for (var e = 0; e < markers2.length; e++) {
				markers2[e].setMap(null);
			}
		}
		
		
</script>

<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>

//추천순위 클릭시 상세보기
$('document').ready(function(){
	
	$('g[role="menuitem"]:eq(0)').on("click",function(){
		console.log("0클릭");
		location.href="./freeParkDetail/${rank.get(0).getDivisionNum()}";
	});	
	
	$('g[role="menuitem"]:eq(1)').on("click",function(){
		console.log("1클릭");
		location.href="./freeParkDetail/${rank.get(1).getDivisionNum()}";
	});
	
	$('g[role="menuitem"]:eq(2)').on("click",function(){
		console.log("2클릭");
		location.href="./freeParkDetail/${rank.get(2).getDivisionNum()}";
	});
	
	$('g[role="menuitem"]:eq(3)').on("click",function(){
		console.log("3클릭");
		location.href="./freeParkDetail/${rank.get(3).getDivisionNum()}";
	});
	
	$('g[role="menuitem"]:eq(4)').on("click",function(){
		console.log("4클릭");
		location.href="./freeParkDetail/${rank.get(4).getDivisionNum()}";
	});
	
	$('g[role="menuitem"]:eq(5)').on("click",function(){
		console.log("5클릭");
		location.href="./freeParkDetail/${rank.get(5).getDivisionNum()}";
	});
	
	$('g[role="menuitem"]:eq(6)').on("click",function(){
		console.log("6클릭");
		location.href="./freeParkDetail/${rank.get(6).getDivisionNum()}";
	});
	
});

</script>



<!-- Chart code -->
<script>

am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

/**
 * Chart design taken from Samsung health app
 */

var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

chart.paddingBottom = 40;

chart.data = [{
    "name":  "${prkNames[0]}",
    "steps": "${rank.get(0).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[1]}",
    "steps": "${rank.get(1).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[2]}",
    "steps": "${rank.get(2).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[3]}",
    "steps": "${rank.get(3).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[4]}",
    "steps": "${rank.get(4).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[5]}",
    "steps": "${rank.get(5).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}, {
    "name": "${prkNames[6]}",
    "steps": "${rank.get(6).getCnt()}",
    "href": "${path}/resources/img/chaback.png"
}];



var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "name";
categoryAxis.renderer.grid.template.strokeOpacity = 0;
categoryAxis.renderer.minGridDistance = 10;
categoryAxis.renderer.labels.template.dy = 35;
categoryAxis.renderer.tooltip.dy = 35;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.inside = true;
valueAxis.renderer.labels.template.fillOpacity = 0.3;
valueAxis.renderer.grid.template.strokeOpacity = 0;
valueAxis.min = 0;
valueAxis.cursorTooltipEnabled = false;
valueAxis.renderer.baseGrid.strokeOpacity = 0;

var series = chart.series.push(new am4charts.ColumnSeries);
series.dataFields.valueY = "steps";
series.dataFields.categoryX = "name";
series.tooltipText = "{valueY.value}";
series.tooltip.pointerOrientation = "vertical";
series.tooltip.dy = - 6;
series.columnsContainer.zIndex = 100;

var columnTemplate = series.columns.template;
columnTemplate.width = am4core.percent(50);
columnTemplate.maxWidth = 66;
columnTemplate.column.cornerRadius(60, 60, 10, 10);
columnTemplate.strokeOpacity = 0;

series.heatRules.push({ target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46") });
series.mainContainer.mask = undefined;

var cursor = new am4charts.XYCursor();
chart.cursor = cursor;
cursor.lineX.disabled = true;
cursor.lineY.disabled = true;
cursor.behavior = "none";

var bullet = columnTemplate.createChild(am4charts.CircleBullet);
bullet.circle.radius = 30;
bullet.valign = "bottom";
bullet.align = "center";
bullet.isMeasured = true;
bullet.mouseEnabled = false;
bullet.verticalCenter = "bottom";
bullet.interactionsEnabled = false;

var hoverState = bullet.states.create("hover");
var outlineCircle = bullet.createChild(am4core.Circle);
outlineCircle.adapter.add("radius", function (radius, target) {
    var circleBullet = target.parent;
    return circleBullet.circle.pixelRadius + 10;
})

var image = bullet.createChild(am4core.Image);
image.width = 60;
image.height = 60;
image.horizontalCenter = "middle";
image.verticalCenter = "middle";
image.propertyFields.href = "href";

image.adapter.add("mask", function (mask, target) {
    var circleBullet = target.parent;
    return circleBullet.circle;
})

var previousBullet;
chart.cursor.events.on("cursorpositionchanged", function (event) {
    var dataItem = series.tooltipDataItem;

    if (dataItem.column) {
        var bullet = dataItem.column.children.getIndex(1);

        if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
        }

        if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = -bullet.parent.pixelHeight + 30;
            bullet.isHover = true;

            previousBullet = bullet;
        }
    }
})

}); // end am4core.ready()

</script>


</body>
</html>
