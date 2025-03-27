<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 팝업창 닫기</title>

    <script>
        window.opener.location.href="/board/2/${boardNo}";
        window.close();
    </script>
</head>

<body>
</body>
</html>