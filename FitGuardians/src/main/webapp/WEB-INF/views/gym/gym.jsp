<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스장 검색</title>
<!-- 카카오 맵 API -->
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=57f0695801af1e56dd83dfbbcc27ad69&libraries=services"></script>
<style>
    #map {
        width: 100%;
        height: 400px;
    }
    #autocomplete-list {
        position: absolute;
        border: 1px solid #ccc;
        max-height: 150px;
        overflow-y: auto;
        z-index: 9999;
        background-color: white;
    }
    .autocomplete-item {
        padding: 10px;
        cursor: pointer;
    }
    .autocomplete-item:hover {
        background-color: #f0f0f0;
    }

</style>
</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <jsp:include page="../common/sideTrainee.jsp" />
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <jsp:include page="../common/topBar.jsp"/>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-1 text-gray-800">주변 헬스장 정보</h1><br>
                    <p class="mb-4">회원님의 위치 정보를 이용하여 주변 헬스장을 찾아보세요!<br>
                        주소 입력을 통하여 주변 헬스장을 검색하는 것도 가능합니다!</p>

                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- 현재 위치 -->
							<div class="card mb-4">
							    <div class="card-header py-3">
							        <h6 class="m-0 font-weight-bold text-primary">현재 위치</h6>
							    </div>
							    <div class="card-body">
							        <span id="current-location">위치를 불러오는 중...</span>
							    </div>
							</div>


                            <!-- 주소 입력 -->
                            <div class="card mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">주소 입력</h6>
                                </div>
                                <div class="card-body">
                                    <div class="input-group">
                                        <input type="text" id="addressInput" style="border: 1px solid #ccc; padding: 0.5rem; flex: 1;" placeholder="주소를 입력하세요." autocomplete="off">
                                        <button type="button" class="btn btn-primary ms-2" id="searchBtn">확인</button>
                                    </div>
                                    <ul id="autocomplete-list" style="list-style-type: none; padding: 0; margin: 0;"></ul>
                                </div>
                            </div>

                            <!-- 가까운 헬스장 3개 -->
							<div class="card mb-4">
							    <div class="card-header py-3">
							        <h6 class="m-0 font-weight-bold text-primary">가까운 헬스장</h6>
							    </div>
							    <div class="card-body">
							        <ul id="nearby-gyms-list" style="list-style-type: none; padding: 0; margin: 0;"></ul>
							    </div>
							</div>
                        </div>

                        <div class="col-lg-6">
                            <!-- 지도 정보 -->
                            <div class="card">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">지도 정보</h6>
                                </div>
                                <div class="card-body text-center">
                                    <div id="map"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 지도를 표시할 div
        var mapContainer = document.getElementById('map');
        var mapOptions = {
            center: new kakao.maps.LatLng(37.508091, 127.063504), // 초기 좌표 (서울 강남구 역삼동)
            level: 3, // 지도의 확대 레벨
        };

        var map = new kakao.maps.Map(mapContainer, mapOptions); // 지도 생성
        
        console.log('초기 지도 레벨:', map.getLevel()); // 초기 레벨 확인
        
        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 }); // InfoWindow 생성
        var mapTypeControl = new kakao.maps.MapTypeControl();
        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        
        kakao.maps.event.addListener(map, 'zoom_changed', function() {
            console.log('현재 지도 레벨:', map.getLevel());
        });


        // 가까운 헬스장 배열 초기화
        let nearbyGyms = []; // 가까운 헬스장을 저장할 배열

        // 주소 검색 및 관련 주소 표시
        function searchAddress(keyword) {
            const geocoder = new kakao.maps.services.Geocoder();
            if (keyword.length < 2) {
                document.getElementById('autocomplete-list').innerHTML = ''; // 최소 2자 이상일 경우에만 검색
                return;
            }

            geocoder.addressSearch(keyword, (result, status) => {
                const autocompleteList = document.getElementById('autocomplete-list');
                autocompleteList.innerHTML = ''; // 이전 검색 결과 초기화

                if (status === kakao.maps.services.Status.OK) {
                    result.forEach(item => {
                        const li = document.createElement('li');
                        li.className = 'autocomplete-item';
                        li.textContent = item.address_name; // 주소명 표시
                        li.onclick = () => {
                            document.getElementById('addressInput').value = item.address_name; // 클릭 시 입력창에 값 넣기
                            autocompleteList.innerHTML = ''; // 리스트 초기화
                            searchGyms(item.address_name); // 선택한 주소로 헬스장 검색
                        };
                        autocompleteList.appendChild(li);
                    });
                    autocompleteList.style.display = 'block'; // 목록 표시
                } else {
                    autocompleteList.style.display = 'none'; // 결과가 없을 경우 목록 숨김
                }
            });
        }

        // 헬스장 마커 이미지 커스텀
        const markerImageSrc = '/fitguardians/resources/images/gymMarker.png';
        const markerImageSize = new kakao.maps.Size(25, 25); // 이미지 크기 설정
        const markerImage = new kakao.maps.MarkerImage(markerImageSrc, markerImageSize);

        // 헬스장 검색 및 마커 표시
        function searchGyms(address) {
            const places = new kakao.maps.services.Places();
            places.keywordSearch(address + " 헬스장", (data, status) => {
                if (status === kakao.maps.services.Status.OK) {
                    let bounds = new kakao.maps.LatLngBounds();
                    nearbyGyms = []; // 헬스장 검색 시 배열 초기화
                    data.forEach(place => {
                        const marker = new kakao.maps.Marker({
                            map: map,
                            position: new kakao.maps.LatLng(place.y, place.x),
                            image: markerImage // 변경된 마커 이미지
                        });
                        bounds.extend(marker.getPosition());

                        // 마우스 호버 이벤트 추가
                        kakao.maps.event.addListener(marker, 'mouseover', function() {
                            infowindow.setContent(
                                '<div style="padding: 5px; font-size: 12px; max-width: 300px; min-width: 200px; white-space: nowrap;">' + 
                                '<strong>' + place.place_name + '</strong><br>' + 
                                place.address_name + 
                                '</div>'
                            );
                            // 인포윈도우를 마커 위치에 표시
                            infowindow.open(map, marker);
                        });

                        // 마커에 마우스아웃 이벤트를 등록
                        kakao.maps.event.addListener(marker, 'mouseout', function() {
                            infowindow.close();
                        });

                        // 가까운 헬스장 배열에 추가
                        nearbyGyms.push({
                            name: place.place_name,
                            address: place.address_name,
                            lat: place.y,
                            lng: place.x
                        });
                    });
                    map.setBounds(bounds);
                    map.setLevel(3);
                    // 가까운 헬스장 3개를 표시하는 함수 호출
                    displayNearbyGyms(nearbyGyms);
                } else {
                    alert('헬스장을 찾을 수 없습니다.');
                }
            });
        }

        // 가까운 헬스장 3개를 표시하는 함수
        function displayNearbyGyms(gyms) {
            // 가까운 헬스장을 거리 기준으로 정렬
            gyms.sort((a, b) => {
                const distanceA = calculateDistance(a.lat, a.lng);
                const distanceB = calculateDistance(b.lat, b.lng);
                return distanceA - distanceB;
            });

            // 가까운 헬스장 3개만 선택
            const closestGyms = gyms.slice(0, 3);
            
            // 리스트에 추가
            const nearbyGymsList = document.getElementById('nearby-gyms-list');
            nearbyGymsList.innerHTML = ''; // 리스트 초기화
            closestGyms.forEach(gym => {
                const li = document.createElement('li');
                li.textContent = gym.name + ' - ' + gym.address; // 헬스장 이름과 주소 표시
                nearbyGymsList.appendChild(li);
            });
        }

        // 두 좌표 간 거리 계산하는 함수
        function calculateDistance(lat, lng) {
            const userLat = map.getCenter().getLat(); // 현재 사용자 위치 (중심 좌표)
            const userLng = map.getCenter().getLng();
            
            const toRad = (x) => x * Math.PI / 180; // 각도를 라디안으로 변환하는 함수

            const dLat = toRad(lat - userLat);
            const dLng = toRad(lng - userLng);
            
            const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                      Math.cos(toRad(userLat)) * Math.cos(toRad(lat)) * 
                      Math.sin(dLng / 2) * Math.sin(dLng / 2);
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            const distance = 6371 * c; // 반환되는 값은 거리 (km 단위)

            return distance; 
        }

        // 주소 입력 시 자동완성 기능
        document.getElementById('addressInput').addEventListener('input', () => {
            const address = document.getElementById('addressInput').value;
            searchAddress(address); // 주소 검색 함수 호출
        });

        // 주소 입력 후 검색 버튼 클릭 이벤트
        document.getElementById('searchBtn').addEventListener('click', () => {
            const address = document.getElementById('addressInput').value;
            searchGyms(address); // 헬스장 검색 함수 호출
        });

        // 엔터 키 입력 이벤트
        document.getElementById('addressInput').addEventListener('keypress', (event) => {
            if (event.key === 'Enter') { // 엔터 키가 눌렸을 때
                const address = document.getElementById('addressInput').value;
                searchGyms(address); // 헬스장 검색 함수 호출
            }
        });

        // 페이지 로드 시 현재 위치 가져오기 및 헬스장 검색
        getCurrentLocation();

        // 현재 위치를 가져오는 함수
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
            } else {
                alert('이 브라우저는 Geolocation을 지원하지 않습니다.');
            }
        }

        // 성공적으로 위치를 가져온 경우
        function successCallback(position) {
            const userLat = position.coords.latitude + 0.00228869; // 위도
            const userLng = position.coords.longitude + 0.00633914; // 경도
            console.log(userLat); // 위도 잘 찍힘
            console.log(userLng); // 경도 잘 찍힘

            // 사용자 위치 표시
            const userLocation = new kakao.maps.LatLng(userLat, userLng); // 순서가 맞음 카카오 API가 뭔가 이상한듯

            map.setCenter(userLocation); // 지도 중심을 현재 위치로 설정
            map.setLevel(3); // 초기 레벨 설정
            
            console.log('현재 위치 레벨:', map.getLevel());


            // 현재 위치를 주소로 변환
            const geocoder = new kakao.maps.services.Geocoder();
            geocoder.coord2Address(userLng, userLat, (result, status) => {
                if (status === kakao.maps.services.Status.OK) {
                    const address = result[0].address.address_name; // 변환된 주소
                    console.log('현재 위치 주소:', address);
                    document.getElementById('current-location').textContent = address; // 현재 위치 요소에 주소 설정
                    searchGyms(address); // 헬스장 검색
                } else {
                    console.error('주소 변환 실패:', status); // 주소 변환 실패 시 오류 메시지
                    alert('현재 위치의 주소를 찾을 수 없습니다.');
                }
            });
        }

        // 위치 정보를 가져오지 못한 경우
        function errorCallback() {
            alert('현재 위치를 가져올 수 없습니다. 위치 정보 권한을 확인하세요.');
        }
    });
</script>












</body>
</html>
