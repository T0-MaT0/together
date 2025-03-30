<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tbody id="faq-list-body">
  <c:forEach var="FAQ" items="${map.FAQList}">
    <tr>
      <td>Q. ${FAQ.boardTitle}</td>
      <td>▼</td>
    </tr>
    <tr class="answer-style hidden-answer">
      <td colspan="2">
        <div class="answer-wrapper">
          <div class="answer-text">
            <span class="answer-inner">A. ${FAQ.boardContent}</span>
          </div>
          <c:if test="${loginMember.authority == 1}">
            <div class="faq-admin-btns">
              <button onclick="editFAQ(${FAQ.boardNo})">수정</button>
              <button onclick="deleteFAQ(${FAQ.boardNo})">삭제</button>
            </div>
          </c:if>
        </div>
      </td>
    </tr>    
  </c:forEach>
</tbody>