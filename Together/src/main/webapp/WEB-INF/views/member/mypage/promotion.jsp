<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <link rel="stylesheet" href="../../../../resources/css/my_info/promotion.css" />
  <link rel="stylesheet" href="../../../../resources/css/manager-css/brand/ad-list.css" />
  <!-- <link rel="stylesheet" href="/resources/css/manager-css/brand/ad-list.css" />
  <link rel="stylesheet" href="/resources/css/manager-css/modal.css" /> -->
</head>
<body>
  


<div id="modal" class="modal">
  <div class="modal-content">
    <h2> 광고 신청</h2>

    <div class="modalInner brandInner">

      <div class="modalTop">
        <div class="input-group">
          <strong>제목:</strong>
          <input type="text" name="title" id="title" class="title">
        </div>
        <div class="input-group">
          <strong>브랜드명:</strong>
          <input type="text" name="brandName" id="brandName" class="brandName">
        </div>
      </div>
        <div class="modal-submit">
        </div>
      </div>
      
      <h3>요청사항</h3>
      <textarea class="modalMid" all-agree-text="true" name="content" id="content" class="customerText"></textarea>

      <div class="midBtn barndBtn brandBtn">
        <div class="preview-container">
          <img id="preview" src="#" alt="첨부 사진 미리보기" style="display: none;" />
        </div>
        <div class="button-container">
          <!-- 첨부사진 미리보기 -->
          <img src="" alt="">
          
          <button id="proImgBtn">첨부 사진</button>
          <input type="file" name="file" id="file" accept="image/*" style="display: none;" />
          <button type="button" id="submitBtn">제출</button>
        </div>
      </div>
    </div>

  </div>
</div>

<script>
  const urlParams = new URLSearchParams(window.location.search);
  const memberNo = urlParams.get('memberNo');
  console.log("Received memberNo:", memberNo);

  // 파일 첨부 버튼 클릭 시 파일 선택 트리거
  document.getElementById('proImgBtn').addEventListener('click', function () {
    this.nextElementSibling.click();
  });

  // 파일 선택 시 미리보기 표시
  document.getElementById('file').addEventListener('change', function (event) {
    const file = event.target.files[0];
    const preview = document.getElementById('preview');
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
      };
      reader.readAsDataURL(file);
    } else {
      preview.src = '#';
      preview.style.display = 'none';
    }
  });

  // 제출 버튼 클릭 시 입력값 확인
  document.getElementById('submitBtn').addEventListener('click', function promotionSubmit() {
    const title = document.getElementById('title').value.trim();
    const brandName = document.getElementById('brandName').value.trim();
    const content = document.getElementById('content').value.trim();
    const fileInput = document.getElementById('file');
    if (!memberNo) {
      alert('회원 정보를 가져올 수 없습니다. 로그인 후 다시 시도해주세요.');
      return;
    }

    if (!title || !brandName || !content) {
      alert('모든 필드를 입력해주세요.');
      return;
    }

    if (fileInput.files.length === 0) {
      alert('사진을 첨부해주세요.');
      return;
    }

    const formData = new FormData();
    formData.append('memberNo', memberNo);
    formData.append('title', title);
    formData.append('brandName', brandName);
    formData.append('content', content);
    formData.append('file', fileInput.files[0]);
    
    fetch('/mypage/promotion', {
      method: 'POST',
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert(data.error);
        return;
      }
      alert('광고 신청이 완료되었습니다.');
      window.close();
    });

  });


</script>

</body>
</html>

