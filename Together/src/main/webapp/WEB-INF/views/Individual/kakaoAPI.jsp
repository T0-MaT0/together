<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5d26cc6e12c846fe1e1829589f8933de&libraries=services"></script>
    <style>
        /* 지도 영역 */
        .map_wrap {
            position: relative;
            width: 100%;
            height: 500px;
            margin-bottom: 20px; /* 지도와 버튼 사이 여백 추가 */
        }
        #map {
            width: 100%;
            height: 100%;
        }
        
        /* 검색 영역 */
        .search-box {
            display: inline-flex; /* 버튼과 인풋을 가로 배치 */
            margin-bottom: 10px;
            gap: 8px; 
        }
        .search-box input {
            width: 250px;
            padding: 5px;
        }
        
        /* 검색 버튼 핑크 스타일 */
        .search-box button {
            background-color: #ff66b2; /* 핑크 */
            border: none;
            border-radius: 18px;
            color: white;
            padding: 5px 12px;
            cursor: pointer;
        }
        .search-box button:hover {
            background-color: #e658a2;
        }

        /* 지도중심 주소 표기 */
        .hAddr {
            position: absolute;
            left: 10px;
            top: 10px;
            border-radius: 2px;
            background: #fff;
            background: rgba(255,255,255,0.8);
            z-index: 1;
            padding: 5px;
        }
        .hAddr .title {
            font-weight: bold;
        }
        #centerAddr {
            display: block;
            margin-top: 2px;
            font-weight: normal;
        }
        .bAddr {
            padding: 5px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        /* "주소 선택" 버튼 오른쪽 정렬 컨테이너 */
        .select-btn-container {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            margin-bottom: 20px; /* 지도 아래쪽 여백 */
        }
        /* "주소 선택" 버튼 핑크 스타일 */
        #selectBtn {
            background-color: #ff66b2;
            border: none;
            border-radius: 18px;
            color: white;
            padding: 6px 15px;
            cursor: pointer;
        }
        #selectBtn:hover {
            background-color: #e658a2;
        }
    </style>
</head>
<body>
<!-- 검색 영역 -->
<div class="search-box">
    <input type="text" id="addressInput" placeholder="주소를 입력하세요">
    <button id="searchBtn">검색</button>
</div>

<!-- 지도 영역 -->
<div class="map_wrap">
    <div id="map"></div>
    <!-- 지도중심 주소 표시 -->
    <div class="hAddr">
        <span class="title">지도중심기준 행정동 주소정보</span>
        <span id="centerAddr"></span>
    </div>
</div>

<!-- "주소 선택" 버튼 -->
<div class="select-btn-container">
    <button id="selectBtn">주소 선택</button>
</div>

<script>
    var map, geocoder, marker, infowindow;
    var selectedJibunAddr = ""; // 최종 선택된 지번주소
    
    ////////////////////////////////////////////////////
    // 지도 초기화
    ////////////////////////////////////////////////////
    function initMap() {
        var mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };
        map = new kakao.maps.Map(document.getElementById("map"), mapOption);
        geocoder = new kakao.maps.services.Geocoder();
        marker = new kakao.maps.Marker();
        infowindow = new kakao.maps.InfoWindow({ zindex:1 });
    
        // 지도 idle → 중심좌표 행정동 주소 표시
        kakao.maps.event.addListener(map, 'idle', function() {
            var center = map.getCenter();
            geocoder.coord2RegionCode(center.getLng(), center.getLat(), displayCenterInfo);
        });
    
        // 지도 클릭 → 클릭 좌표의 상세 주소 표시
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            var latlng = mouseEvent.latLng;
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = "";
                    if (result[0].road_address) {
                        detailAddr += "<div>도로명주소 : " 
                                    + result[0].road_address.address_name + "</div>";
                    }
                    var jibun = result[0].address.address_name;
                    detailAddr += "<div>지번 주소 : " + jibun + "</div>";
    
                    var content = '<div class="bAddr">'
                                + '<span class="title">법정동 주소정보</span>'
                                + detailAddr
                                + '</div>';
    
                    marker.setPosition(latlng);
                    marker.setMap(map);
    
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
    
                    // 선택 버튼을 눌렀을 때 반환할 지번 주소
                    selectedJibunAddr = jibun;
                }
            });
        });
    }
    
    ////////////////////////////////////////////////////
    // "지도중심기준" 행정동 주소 표시
    ////////////////////////////////////////////////////
    function displayCenterInfo(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var centerAddrEl = document.getElementById("centerAddr");
            for (var i=0; i<result.length; i++) {
                if (result[i].region_type === 'H') {
                    centerAddrEl.innerHTML = result[i].address_name;
                    break;
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////
    // 주소 검색
    ////////////////////////////////////////////////////
    function doSearch() {
        var address = document.getElementById("addressInput").value.trim();
        if (!address) {
            alert("주소를 입력하세요.");
            return;
        }
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                map.setCenter(coords);
    
                marker.setPosition(coords);
                marker.setMap(map);
    
                var roadAddr = result[0].road_address 
                    ? "도로명주소 : " + result[0].road_address.address_name
                    : "";
                var jibunAddr = "지번 주소 : " + result[0].address.address_name;
    
                var content = '<div class="bAddr">'
                            + '<span class="title">검색한 주소</span><br>'
                            + roadAddr + '<br>' + jibunAddr
                            + '</div>';
                infowindow.setContent(content);
                infowindow.open(map, marker);
    
                // 선택시 반환할 지번주소
                selectedJibunAddr = result[0].address.address_name;
            } else {
                alert("검색 결과가 없습니다.");
            }
        });
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        // 지도 초기화
        initMap();
    
        // 검색 버튼/엔터 처리
        document.getElementById("searchBtn").addEventListener("click", doSearch);
        document.getElementById("addressInput").addEventListener("keyup", function(e) {
            if (e.key === "Enter") {
                doSearch();
            }
        });
    
        // "주소 선택" 버튼
        document.getElementById("selectBtn").addEventListener("click", function() {
            if (!selectedJibunAddr) {
                alert("지번 주소가 선택되지 않았습니다.");
                return;
            }
            // 메인창 함수 호출 (CreateGroup.jsp)
            // window.opener -> 부모 창의 window 객체
            window.opener.setJibunAddress(selectedJibunAddr);
    
            // 팝업 닫기
            window.close();
        });
    });
    </script>

</body>
</html>