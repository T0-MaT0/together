<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>토큰 결과 확인</title>
    <link rel="stylesheet" href="/resources/css/member/point-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="point-container">
      <h2>금융결제원 Access Token 응답 결과</h2>
      <pre>
  ${tokenJson}
      </pre>
  
      <a href="/">← 메인으로 돌아가기</a>


    </section>



    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

      
      
    
</body>
</html>