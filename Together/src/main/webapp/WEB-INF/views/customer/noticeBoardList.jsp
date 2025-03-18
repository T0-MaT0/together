<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지 리스트</title>
    <link rel="stylesheet" href="/resources/css/customer/noticeBoardList-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="notice-header">
            <div id="notice-header-title">📢  공지사항</div>
            
            <form action="/board/search" method="GET">
                <fieldset class="search-area">
    
                    <input type="search" name="query" id="query"
                    placeholder="검색어를 입력해주세요.">
    
                    <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
    
                </fieldset>
            </form>
        </section>
    
        <section id="notice-content">
         
            <div id="bg-color">

                <table class="list-table">
                    
                    <thead id="fix-notice">
                        <tr>
                            <th id="notice-num">355</th>
                            <th id="notice-title">
                                <a href="#">
                                    [업데이트] 공동구매 채팅 기능 추가 🚀   
                                </a></th>
                            <th id="notice-date">2024-02-10</th>
                        </tr>
                        <tr>
                            <th>354</th>
                            <th><a href="#">
                                [공지] 설 연휴 고객센터 운영 시간 안내 🏡</a></th>
                            <th>2024-02-05</th>
                        </tr>
                        <tr>
                            <th>347</th>
                            <th><a href="#">
                                [주의] 사기 피해 예방 안내 🚨
                            </a></th>
                            <th>2023-12-30</th>
                        </tr>
                        <tr>
                            <th>349</th>
                            <th><a href="#">
                                [이벤트] 친구 초대하면 적립금 지급 💰
                            </a></th>
                            <th>2024-01-10</th>
                        </tr>
                    </thead>
    
                    <tbody>
                        <tr>
                            <td>355</td>
                            <td><a href="#">
                                [업데이트] 공동구매 채팅 기능 추가 🚀
                            </a></td>
                            <td>2024-02-10</td>
                        </tr>
                        <tr>
                            <td>354</td>
                            <td><a href="#">
                                [공지] 설 연휴 고객센터 운영 시간 안내 🏡
                            </a></td>
                            <td>2024-02-05</td>
                        </tr>
                        <tr>
                            <td>353</td>
                            <td><a href="#">
                                [점검] 2월 15일(목) 서버 점검 예정 ⚙️
                            </a></td>
                            <td>2024-02-01</td>
                        </tr>
                        <tr>
                            <td>352</td>
                            <td><a href="#">
                                [이벤트] 신규 회원 웰컴 쿠폰 증정 🎁
                            </a></td>
                            <td>2024-01-28</td>
                        </tr>
                        <tr>
                            <td>351</td>
                            <td><a href="#">
                                [안내] 공동구매 취소 및 환불 정책 변경 📜
                            </a></td>
                            <td>2024-01-20</td>
                        </tr>
                        <tr>
                            <td>350</td>
                            <td><a href="#">
                                [기능 추가] 공동구매 알림 설정 기능 도입 🔔
                            </a></td>
                            <td>2024-01-15</td>
                        </tr>
                        <tr>
                            <td>349</td>
                            <td><a href="#">
                                [이벤트] 친구 초대하면 적립금 지급 💰
                            </a></td>
                            <td>2024-01-10</td>
                        </tr>
                        <tr>
                            <td>348</td>
                            <td><a href="#">
                                [업데이트] 공동구매 리뷰 기능 추가 ✍️
                            </a></td>
                            <td>2024-01-05</td>
                        </tr>
                        <tr>
                            <td>347</td>
                            <td><a href="#">
                                [주의] 사기 피해 예방 안내 🚨
                            </a></td>
                            <td>2023-12-30</td>
                        </tr>
                        <tr>
                            <td>346</td>
                            <td><a href="#">
                                [점검] 1월 5일 시스템 안정화 작업 🔧 
                            </a></td>
                            <td>2023-12-25</td>
                        </tr>
        
                    </tbody>
                </table>
            </div>

    
        </section>
    
        <section id="pageNAtion">
            <<  <  1 2 3 4 5  >  >> 
        </section>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>