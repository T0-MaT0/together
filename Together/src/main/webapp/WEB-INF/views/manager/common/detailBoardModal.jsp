<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 
모집 번호: ${map.RECRUITMENT_NO}
<br/>
모집 상태: ${map.RECRUITMENT_STATUS}
<br/>
모집 내용: ${map.BOARD_CONTENT}
<br/>
URL: ${map.PRODUCT_URL}
<br/>
BOARD_NO: ${map.BOARD_NO}
<br/>
CREATE_DATE: ${map.CREATE_DATE}
<br/>
BOARD_CD: ${map.BOARD_CD} 
<br/>
BOARD_TITLE: ${map.BOARD_TITLE}
<br/>
최대 인원: ${map.MAX_PARTICIPANTS}
<br/>
qr코드: ${map.QR_CODE}
<br/>
MEMBER_NO: ${map.MEMBER_NO}
<br/>
REGION: ${map.REGION}
<br/> -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/common/detailBoardModal.css">
</head>
<body>
    
    
    <div id="container">
        <section>제목</section>
        <section>이미지</section>
        <section>
            제품 명
            링크
            기간
            모집인원
            가격
            <button>참여하기</button>
        </section>
        <section>
            모집글 상세 내용
        </section>
    </div>

    <script>
        const no = Number(${no});
        const type = Number(${type});
    </script>
    <script src="/resources/js/manager-js/boardDetailModal.js"></script>
</body>
</html>