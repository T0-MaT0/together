<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tbody id="faq-list-body">
  <c:forEach var="FAQ" items="${map.FAQList}">
    <tr>
      <td>Q. ${FAQ.boardTitle}</td>
      <td>▼</td>
    </tr>
    <tr class="answer-style hidden-answer">
      <td colspan="2">A. ${FAQ.boardContent}</td>
    </tr>
  </c:forEach>
</tbody>