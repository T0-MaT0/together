<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- tbody 부분 -->
<tbody>
<c:forEach var="FAQ" items="${FAQList}">
  <tr>
    <td onclick="openAnswer(event)">Q. ${FAQ.boardTitle}</td>
    <td>▼</td>
  </tr>
  <tr class="answer-style hidden-answer">
    <td colspan="2">A. ${FAQ.boardContent}</td>
  </tr>
</c:forEach>
</tbody>

