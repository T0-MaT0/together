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
    <h2> 프로필 이미지 변경</h2>

    <div class="modalInner brandInner">

      <div class="modalTop">
      </div>
        <div class="modal-submit">
        </div>
      </div>
      

      <div class="midBtn barndBtn brandBtn">
        <div class="preview-container">
          <img id="preview" src="#" alt="첨부 사진 미리보기" style="display: none;"  width="500" height="500" />
        </div>
        <div class="button-container">
          <!-- 첨부사진 미리보기 -->
          <%-- 사이즈 500 500 --%>
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
    const fileInput = document.getElementById('file');
    if (!memberNo) {
      alert('회원 정보를 가져올 수 없습니다. 로그인 후 다시 시도해주세요.');
      return;
    }

    if (fileInput.files.length === 0) {
      alert('사진을 첨부해주세요.');
      return;
    }

    const formData = new FormData();
    formData.append('memberNo', memberNo);
    formData.append('file', fileInput.files[0]);
    
    fetch('/mypage/profileUpdate', {
      method: 'POST',
      body: formData
    })
    .then(response => response.text())
    .then(result => {

      if (result == 0) {
        alert('변경에 실패했습니다. 다시 시도해주세요.');
        return;
      }
      alert('변경되었습니다.');
      window.close();
    });

  });


</script>

</body>
</html>

