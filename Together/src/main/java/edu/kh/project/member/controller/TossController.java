package edu.kh.project.member.controller;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.PointTransaction;
import edu.kh.project.member.model.service.MemberService;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/toss")
public class TossController {

    @Autowired
    private MemberService service;

    @GetMapping("/success")
    public String tossSuccess(@RequestParam String paymentKey,
                              @RequestParam String orderId,
                              @RequestParam int amount,
                              HttpSession session,
                              Model model) {

        JSONParser parser = new JSONParser();

        try {
            // 1. 토스 결제 승인 요청
            String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
            String encodedKey = Base64.getEncoder()
                    .encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

            HttpURLConnection connection = (HttpURLConnection)
                    new URL("https://api.tosspayments.com/v1/payments/confirm").openConnection();

            connection.setRequestProperty("Authorization", "Basic " + encodedKey);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);

            JSONObject reqBody = new JSONObject();
            reqBody.put("paymentKey", paymentKey);
            reqBody.put("orderId", orderId);
            reqBody.put("amount", amount);

            OutputStream os = connection.getOutputStream();
            os.write(reqBody.toString().getBytes(StandardCharsets.UTF_8));
            os.flush();
            os.close();

            int code = connection.getResponseCode();

            if (code == 200) {
                // 정상 응답만 처리
                InputStream is = connection.getInputStream();
                Reader reader = new InputStreamReader(is, StandardCharsets.UTF_8);
                JSONObject resultJson = (JSONObject) parser.parse(reader);

                // 2. 포인트 충전 내역 저장 및 포인트 반영
                Member loginMember = (Member) session.getAttribute("loginMember");

                PointTransaction pt = new PointTransaction();
                pt.setMemberNo(loginMember.getMemberNo());
                pt.setAmount(amount);

                String method = (String) resultJson.get("method");
                String paymentMethod = "카드".equals(method) ? "카드결제" : method;
                pt.setPaymentMethod(paymentMethod);

                service.insertPointTransaction(pt); // 결제 성공 시에만 insert 실행
                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("memberNo", loginMember.getMemberNo());
                paramMap.put("amount", amount);
                service.updateMemberPoint(paramMap);

                // 3. 세션 최신화
                Member updatedMember = service.selectMemberByNo(loginMember.getMemberNo());
                session.setAttribute("loginMember", updatedMember);

                // 4. 성공 화면 처리
                model.addAttribute("msg", amount + "포인트 충전 성공!");
                model.addAttribute("amount", amount);
                return "member/paymentSuccess";

            } else {
                // 실패 응답 처리
                InputStream is = connection.getErrorStream();
                Reader reader = new InputStreamReader(is, StandardCharsets.UTF_8);
                JSONObject errorJson = (JSONObject) parser.parse(reader);

                model.addAttribute("msg", "결제 실패: " + errorJson.get("message"));
                return "member/paymentFail";
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "결제 실패: " + e.getMessage());
            return "member/paymentFail";
        }
    }


    @GetMapping("/fail")
    public String tossFail(@RequestParam(required = false) String code,
                           @RequestParam(required = false) String message,
                           Model model) {
        model.addAttribute("msg", "결제 실패: " + message + " (" + code + ")");
        return "member/paymentFail";
    }
}
