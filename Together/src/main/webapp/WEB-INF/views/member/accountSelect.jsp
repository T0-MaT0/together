<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>

<%
    // 컨트롤러에서 넘어온 JSON 문자열 파싱
    String accountListJson = (String) request.getAttribute("accountListJson");

    JSONArray accounts = null;
    try {
        JSONObject json = new JSONObject(accountListJson);
        accounts = json.getJSONArray("res_list");
    } catch (JSONException e) {
        out.println("계좌 목록 파싱 실패: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 선택</title>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

<h2>계좌를 선택하세요</h2>

<form action="/openbanking/withdraw" method="post">
    <table border="1">
        <tr>
            <th>선택</th>
            <th>은행명</th>
            <th>계좌번호</th>
            <th>핀테크번호</th>
        </tr>

        <%
            if (accounts != null) {
                for (int i = 0; i < accounts.length(); i++) {
                    JSONObject acc = accounts.getJSONObject(i);
                    String fintechUseNum = acc.getString("fintech_use_num");
                    String bankName = acc.getString("bank_name");
                    String accountNum = acc.getString("account_num_masked");
        %>
        <tr>
            <td><input type="radio" name="fintechUseNum" value="<%= fintechUseNum %>" required></td>
            <td><%= bankName %></td>
            <td><%= accountNum %></td>
            <td><%= fintechUseNum %></td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <br>
    <label>출금 금액 입력:
        <input type="number" name="amount" required>
    </label>

    <br><br>
    <button type="submit">출금 요청</button>
</form>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
