<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>

<title>Final</title>
<style>
.weather-number {
	color: red;
}

.info-title {
    display: block;
    background: #50627F;
    color: #fff;
    text-align: center;
    line-height:22px;
    border-radius:4px;
    padding:0px 10px;
}

</style>
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
<link href="${path}/resources/css/campingWeather.css?var=9"
	rel="stylesheet">
</head>
<body >
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
	<div class="container px-3 py-3">
		<div class="border-bottom mb-3">
			<h2 class="">날씨</h2>
		</div>
		<div class="row">
		<div class="text-center">
			<div id="staticMap" style="width: 100%; height: 600px;"></div>
		</div>
		</div>
		<div class="row mt-3">
			<%-- <div style="position: absolute; z-index: -1;">
				<img src="${path}/resources/img/koreaMap.png">
			</div> --%>
			<div class="col-8">
				<div class="row row-cols-1 row-cols-md-6 g-1 text-center" id="list">
				</div>
			</div>
			<div class="col-4">
				<!-- 첫번째 날씨 위젯-->
				<div class="lb-widget" style="margin-top: 150px;">
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
						<iframe
							src="https://forecast.io/embed/#lat=37.5266&lon=127.0403&name=Seoul, 서울&color=&font=&units=si"></iframe>
					</div>
					<div id="lb-2" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=37.4496&lon=126.7074&name=Incheon, 인천&color=#F6A8A6&font=&units=si"></iframe>
					</div>
					<div id="lb-3" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=36.3512&lon=127.3954&name=Daejeon, 대전&color=#5BC065&font=&units=si"></iframe>
					</div>
					<div id="lb-4" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=35.1787&lon=126.8974&name=Gwangju, 광주(전남)&color=#A5C8E4&font=&units=si"></iframe>
					</div>
					<div id="lb-5" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=35.8759&lon=128.5964&name=Daegu, 대구&color=#C0ECCC&font=&units=si"></iframe>
					</div>
					<div id="lb-6" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=35.538&lon=129.324&name=울산&color=#F9F0C1&font=&units=si"></iframe>
					</div>
					<div id="lb-7" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=35.1334&lon=129.1058&name=부산&color=#BA55D3&font=&units=si"></iframe>
					</div>
					<div id="lb-8" class="lb-weather">
						<iframe
							src="https://forecast.io/embed/#lat=33.5007&lon=126.5288&name=제주&color=#ffc261&font=&units=si"></iframe>
					</div>
				</div>
			</div>

		</div>


		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="${path}/resources/js/bootstrap.js"></script>
		<script src="${path}/resources/js/bootstrap.bundle.js"></script>
		<script src="${path}/resources/js/common.js"></script>
		<script src="${path}/resources/js/campingWeather.js?var=5"></script>
		<script
			src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=de13013a67053c1d19922fa8b31042a9"></script>
		<script>
			// var apiURI = "http://maps.openweathermap.org/maps/2.0/weather/TA2/10/36.57601009561782/127.9369886453819?appid=55d3503973ed8cc55f407d450e0c3899";
			var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
			staticMapOption = {
				center : new kakao.maps.LatLng(36.95515042152855,127.61079401234034),
				level : 13
			// 이미지 지도의 확대 레벨
			};
			
			var map = new kakao.maps.Map(staticMapContainer,staticMapOption);
			
					
			function addMarker(position,imageSrc,city,temp) {
	            var imageSize = new kakao.maps.Size(40, 42),  // 마커 이미지의 크기
	            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize)
		       	           
	            var marker = new kakao.maps.Marker({
	            	position: position, // 마커의 위치
		                map: map,
		                image: markerImage
		              });
	            console.log(temp);
	            
	            var infowindow = new kakao.maps.InfoWindow({
	                content: "<div class='info-title' style='width:150px; height:70px; padding-top:12px; text-align:center'<h3>"+city+"</h3><div>"+temp+" ℃</div></div>"
	            });
	            
		       // console.log(position);
		        marker.setMap(map);
		    	
				kakao.maps.event.addListener(marker, 'mouseover', function () {
						infowindow.open(map, marker);
                });
				kakao.maps.event.addListener(marker, 'mouseout', function () {
					infowindow.close();
                });
				
		        		         }
			
			

			// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
			var staticMap = new kakao.maps.StaticMap(staticMapContainer,staticMapOption);
			var suc = [];
			
			
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=seoul&appid=55d3503973ed8cc55f407d450e0c3899";
			$(document)	.ready(	function() {
				
								var array = [ 'seoul', 'busan', 'jeju',
										'chuncheon', 'suwon', 'daegu',
										'gwangju', 'incheon', 'sokcho',
										'daejeon', 'ulsan', 'yeosu' ];
								var xArray = [ 162, 297, 136, 227, 170, 268,
										158, 122, 271, 209, 324, 230, 273, 190 ];
								var yArray = [ 48, 270, 346, 20, 112, 199, 247,
										54, 17, 156, 214, 85, 135, 284 ];

								for (i = 0; i < array.length; i++) {
									//console.log(array[i]);
									var locationName = array[i];
									var pointX = xArray[i];
									var pointY = yArray[i];
									chano(locationName);
								}
									//console.log(suc);

								
								function chano(locationName) {
									var nationUrl = "http://api.openweathermap.org/data/2.5/weather?q="+ locationName + "&appid=55d3503973ed8cc55f407d450e0c3899";
									$.ajax({
												url : nationUrl,
												dataType : "json",
												type : "GET",
												async : false,
												success : function(resp) {
												//console.log(resp);

													
													
													//console.log(position);
													
													var wImage = "";
													var wName = "";
													
										           /*     if(resp.weather[0].main=="Clouds"){ // 구름꼇을때
										                   wImage="<i class='bi bi-cloud'></i>"
										                }else if(resp.weather[0].main=="Rain"){ // 비올때
										                   wImage="<i class='bi bi-cloud-rain-heavy'></i>"
										                }else if(resp.weather[0].main=="Snow"){ // 눈올때
										                   wImage="<i class='bi bi-cloud-snow'></i>"
										                }else{ // 맑을때 기모링
										                   wImage="<i class='bi bi-brightness-high'></i>"
										                } */
													


													if (resp.name == "Seoul") {
														wName = "서울";
													} else if (resp.name == "Busan") {
														wName = "부산";
													} else if (resp.name == "Jeju City") {
														wName = "제주";
													} else if (resp.name == "Suwon-si") {
														wName = "수원";
													} else if (resp.name == "Chuncheon") {
														wName = "춘천";
													} else if (resp.name == "Daegu") {
														wName = "대구";
													} else if (resp.name == "Gwangju") {
														wName = "광주";
													} else if (resp.name == "Incheon") {
														wName = "인천";
													} else if (resp.name == "Sokcho") {
														wName = "속초";
													} else if (resp.name == "Daejeon") {
														wName = "대전";
													} else if (resp.name == "Ulsan") {
														wName = "울산";
													} else if (resp.name == "Wŏnju") {
														wName = "원주";
													} else if (resp.name == "Andong") {
														wName = "안동";
													} else if (resp.name == "Yeosu") {
														wName = "여수";
													}
													
										                var position = new kakao.maps.LatLng(resp.coord.lat, resp.coord.lon); 
										                var tem = (resp.main.temp - 273.15).toFixed(1)										                
										                //console.log(tem);
													if (resp.weather[0].main == "Clouds") { // 구름꼇을때
														wImage = "<img src='${path}/resources/img/cloud.png' >"
														addMarker(position,'${path}/resources/img/cloud.png',wName,tem);
													} else if (resp.weather[0].main == "Rain") { // 비올때
														wImage = "<img src='${path}/resources/img/rain.png' >"
															addMarker(position,'${path}/resources/img/rain.png',wName,tem);
													} else if (resp.weather[0].main == "Snow") { // 눈올때
														wImage = "<img src='${path}/resources/img/snow.png' >"
															addMarker(position,'${path}/resources/img/snow.png',wName,tem);
													} else { // 맑을때 기모링
														wImage = "<img src='${path}/resources/img/brightness.png' >"
															addMarker(position,'${path}/resources/img/brightness.png',wName,tem);
													}
												
													
													var data = '<div class="col-2"><div class="card  border-white">'
															+ wImage
															+ '<div class="card-body"><h5 class="card-title">'
															+ wName
															+ '</h5><p class="card-text">'
															+ (resp.main.temp - 273.15)	.toFixed(1)
															+ ' ℃</p></div></div></div>';

													$('#list').append(data);
													
													
													
												}
											});
								}
								
			/* function test(p){
				suc.push(p);
				console.log(suc);
			} */
							});
			

			/* <p>var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
			 $("html컴포넌트").attr("src", imgURL);
			 </p> */
		</script>
</body>
</html>
