package edu.kh.project.member.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.PointTransaction;
import edu.kh.project.member.model.service.MemberService;

@Controller
@RequestMapping("/openbanking")
public class BankingController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/charge")
	public String chargePoint(
	    @RequestParam("amount") int amount,
	    @RequestParam("method") String method,
	    @SessionAttribute("loginMember") Member loginMember,
	    Model model
	) {
	    // 1. 사용자 정보 확인
	    int memberNo = loginMember.getMemberNo();

	    // 2. 포인트 충전 내역 생성 및 저장
	    PointTransaction transaction = new PointTransaction();
	    transaction.setMemberNo(memberNo);
	    transaction.setAmount(amount);
	    transaction.setPaymentMethod(method);
	    
	    int result = service.insertPointTransaction(transaction); // DB 저장

	    // 3. 결제 방식이 계좌이체인 경우 → 오픈뱅킹 연동 페이지로 리디렉트
	    if("bank".equals(method)) {
	        // 오픈뱅킹 인증 요청 URL 생성
	        String clientId = "5105f4f4-66a1-4f6c-9d08-134cf47bec61";
	        String redirectUri = "http://localhost/openbanking/callback";
	        String state = UUID.randomUUID().toString().replace("-", "").substring(0, 32);
	        
	        String url = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
	            + "response_type=code"
	            + "&client_id=" + clientId
	            + "&redirect_uri=" + redirectUri
	            + "&scope=login inquiry transfer"
	            + "&state=" + state
	            + "&auth_type=0";

	        return "redirect:" + url;
	    }

	    // 4. 그 외 결제 수단 (카카오페이, 토스 등) → 모의 페이지 이동
	    model.addAttribute("amount", amount);
	    model.addAttribute("method", method);
	    return "member/paymentSuccess";
	}

    @GetMapping("/callback")
    public String openBankingCallback(@RequestParam("code") String code, HttpSession session, Model model) {
        System.out.println("\uD310 받은 인가코드: " + code);

        // 1. Access Token 요청
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("code", code);
        params.add("client_id", "5105f4f4-66a1-4f6c-9d08-134cf47bec61");
        params.add("client_secret", "7b98eb24-6df5-4989-8260-33411e18aeb8");
        params.add("redirect_uri", "http://localhost/openbanking/callback");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(
                "https://testapi.openbanking.or.kr/oauth/2.0/token", request, String.class);

        String tokenJson = response.getBody();
        System.out.println("access token 응답: " + tokenJson);

        JSONObject json = new JSONObject(tokenJson);
        String accessToken = json.getString("access_token");
        String userSeqNo = json.getString("user_seq_no");

        session.setAttribute("accessToken", accessToken);
        session.setAttribute("userSeqNo", userSeqNo);

        return "redirect:/openbanking/accountList";
    }

    @GetMapping("/accountList")
    public String getAccountList(HttpSession session, Model model) {
        String accessToken = (String) session.getAttribute("accessToken");
        String userSeqNo = (String) session.getAttribute("userSeqNo");

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<?> entity = new HttpEntity<>(headers);

        String url = "https://testapi.openbanking.or.kr/v2.0/user/me?user_seq_no=" + userSeqNo;

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        System.out.println("계좌 목록 응답: " + response.getBody());

        model.addAttribute("accountListJson", response.getBody());
        return "member/accountSelect";
    }

    @PostMapping("/withdraw")
    @ResponseBody
    public String withdraw(HttpSession session,
                           @RequestParam String fintechUseNum,
                           @RequestParam String amount) {

        String accessToken = (String) session.getAttribute("accessToken");
        

        System.out.println("출금 요청 - accessToken: " + accessToken);
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> body = new HashMap<>();
        
        // 실제 기관식별코드 10자리 (내가 발급받은 Client ID 앞자리로 수정!)
        String orgCode = "M202405012";

        // 고유값 생성 (숫자 9자리 등으로 랜덤)
        String unique = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);

        String bankTranId = orgCode + unique;

        body.put("bank_tran_id", bankTranId);
        
        
        body.put("cntr_account_type", "N");
        body.put("cntr_account_num", "1234567890"); // 예시 계좌
        body.put("dps_print_content", "포인트충전");
        body.put("fintech_use_num", fintechUseNum);
        body.put("tran_amt", amount);
        body.put("tran_dtime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        body.put("req_client_name", "홍길동");
        body.put("req_client_num", "9876543210");
        body.put("transfer_purpose", "TR");

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(
                "https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num",
                request,
                String.class);
        
        System.out.println("accessToken: " + accessToken);
        System.out.println("fintechUseNum: " + fintechUseNum);
        System.out.println("출금 요청 헤더: " + headers.toString());
        System.out.println("출금 요청 바디: " + body.toString());

        return response.getBody();
    }
}
