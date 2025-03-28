package edu.kh.project.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.RestTemplate;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.PointTransaction;
import edu.kh.project.member.model.service.MemberService;

@Controller
@RequestMapping("/toss")
public class TossController {

    @Autowired
    private MemberService service;

    @GetMapping("/success")
    public String tossSuccess(@RequestParam String paymentKey,
                              @RequestParam String orderId,
                              @RequestParam String amount,
                              @SessionAttribute("loginMember") Member loginMember,
                              Model model) {

        // 1. 결제 검증 요청
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth("test_sk_test_5o8rK9bLX3vW2XzG2MJ6pQjN", ""); // Toss 테스트 Secret Key
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> body = new HashMap<>();
        body.put("orderId", orderId);
        body.put("amount", amount);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(
            "https://api.tosspayments.com/v1/payments/" + paymentKey,
            request,
            String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            // 2. 포인트 충전 내역 저장
            PointTransaction transaction = new PointTransaction();
            transaction.setMemberNo(loginMember.getMemberNo());
            transaction.setAmount(Integer.parseInt(amount));
            transaction.setPaymentMethod("tosspay");

            int result = service.insertPointTransaction(transaction);

            if (result > 0) {
                model.addAttribute("msg", "포인트 충전이 완료되었습니다!");
                return "member/paymentSuccess"; // 성공 페이지
            } else {
                model.addAttribute("msg", "충전 내역 저장 실패 😥");
                return "member/paymentFail";
            }

        } else {
            model.addAttribute("msg", "결제 검증 실패: " + response.getBody());
            return "member/paymentFail"; // 검증 실패 시
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
