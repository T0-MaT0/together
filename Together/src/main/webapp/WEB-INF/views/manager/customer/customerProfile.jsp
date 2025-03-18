<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../manager-css/manager-common.css" />
    <link rel="stylesheet" href="../../manager-css/customer/customer-profile.css" />
</head>

<body>

</body>

<main>
    
    <!-- 사이드 메뉴 -->
    <div id="container-side">
        <!-- 로고 -->
        <img src="../../image-manager/Group 2411.png" alt="로고 이미지">


        <!-- 메뉴 -->
        <div id="menu-items">
            <div id="dash-board">대시보드</div>
            <button class="accordion">고객관리</button>
            <div class="panel">
                <p>내용</p>
                <p>내용</p>
                <p>내용</p>
            </div>

            <button class="clicked">브랜드 관리</button>
            <div class="open-menu">
                <p>내용</p>
            </div>

            <button class="accordion">홈페이지 관리</button>
            <div class="panel">
                <p>내용</p>
            </div>

        </div>

    </div>


    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>고객 관리</div>
             &nbsp; <div> - 프로필</div>
        </div>
    </header>

    <!-- 본문(중앙) -->
    <div id="container-center">
        <section class="pro-board">
            <div class="board-title bottom-line">
                <div class="title">회원 프로필</div>
                <div class="btn-area">
                    <a href="#">블랙</a>
                    <a href="#">경고</a>
                </div>
            </div>

            <div class="profile-area">
                <img src="../../image-manager/profile.png" alt="프로필">
                <div class="nickname">닉네임</div>
            </div>

            <div class="status-area">
                <div class="ch-number">
                    <div class="status-title">상태</div>
                    <div class="status-content">회원</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">댓글</div>
                    <div class="status-content">10</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">모집글</div>
                    <div class="status-content">10</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">경고</div>
                    <div class="status-content">2</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">신고</div>
                    <div class="status-content">10</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">문의</div>
                    <div class="status-content">10</div>
                </div>
            </div>

            <div class="info-wrap">
                <div class="info-item">
                    <div>아이디: </div> <div>kimmara</div>
                </div>
                <div class="info-item">
                    <div>이름: </div> <div>김마리</div>
                </div>
                <div class="info-item">
                    <div>생년월일: </div> <div>2000.01.01</div>
                </div>
                <div class="info-item">
                    <div>가입일자: </div> <div>2000.01.01</div>
                </div>
                <div class="info-item">
                    <div>이메일: </div> <div>mari@gmail.com</div>
                </div>
                <div class="info-item">
                    <div>전화번호: </div> <div>010-1234-1234</div>
                </div>
                <div class="info-item">
                    <div>주소: </div> <div>122228</div>
                </div>
                <div class="address">
                    <div>122228</div>
                </div>
                <div class="address">
                    <div>122228</div>
                </div>
            </div>

        </section>
        <section class="pro-board">
            <div class="subMenu-area">
                <a href="#" class="select">문의</a>
                <a href="#" >신고</a>
                <a href="#">경고</a>
            </div>
        
            <div class="board-title">
                <div class="title">판매 상품 이력</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>미처리</option>
                        <option>처리</option>
                    </select>
                </div>

            </div>
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>문의제목</div>
                    <div>문의일자</div>
                    <div>상태</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                
            </div>

            <ul id="pagination">
                <li>&lt;&lt;</li>
                <li>&lt;</li>
                <li class="curr">1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
                <li>6</li>
                <li>7</li>
                <li>8</li>
                <li>9</li>
                <li>10</li>
                <li>&gt;</li>
                <li>&gt;&gt;</li>
            </ul>

        </section>
        
    </div>


</main>

<script>
    const acc = document.getElementsByClassName("accordion");

    for (let i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            let panel = this.nextElementSibling;
            console.log(panel.style.maxHeight);
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });

    }
</script>
</body>

</html>