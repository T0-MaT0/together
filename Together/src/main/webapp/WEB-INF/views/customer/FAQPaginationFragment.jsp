<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pagination-area" id="faq-pagination">
  <c:set var="boardCode" value="${map.boardCode}" />
  <c:set var="pagination" value="${map.pagination}" />
  <c:set var="url" value="/customer/FAQBoard/${boardCode}/fragment?cp=" />

  <ul class="pagination">
    <li><a href="${url}1">&lt;&lt;</a></li>
    <li><a href="${url}${pagination.prevPage}">&lt;</a></li>

    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
      <c:choose>
        <c:when test="${pagination.currentPage == i}">
          <li><a class="current">${i}</a></li>
        </c:when>
        <c:otherwise>
          <li><a href="${url}${i}">${i}</a></li>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <li><a href="${url}${pagination.nextPage}">&gt;</a></li>
    <li><a href="${url}${pagination.maxPage}">&gt;&gt;</a></li>
  </ul>
</div>
