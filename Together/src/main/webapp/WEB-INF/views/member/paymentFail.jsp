<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포인트 결제</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
    <style>
        .find-container {
            max-width: 500px;
            margin: 100px auto;
            padding: 40px 30px;
            background-color: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .find-container h2 {
            font-size: 24px;
            margin-bottom: 30px;
            font-weight: bold;
        }

        .find-container a {
            display: inline-block;
            padding: 12px 24px;
            font-size: 16px;
            background-color: #2f80ed;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .find-container a:hover {
            background-color: #1c62d1;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="find-container">
    <h2 style="color:red">${msg}</h2>
    <a href="/member/point">다시 시도하기</a>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>

