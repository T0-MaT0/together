package edu.kh.project.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.MemberService;


@Controller
@RequestMapping("/oauth/kakao")
@SessionAttributes("loginMember")
public class KakaoController {
	
	@Autowired
    private MemberService service;

    
    
	@GetMapping("/callback")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) throws Exception {
	    System.out.println("🔐 카카오 인가코드: " + code);

	    // 1. Access Token 요청
	    RestTemplate rt = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	    params.add("grant_type", "authorization_code");
	    params.add("client_id", "e676fa2ec68895d32e1d6e251f7e9e52");
	    params.add("redirect_uri", "http://localhost/oauth/kakao/callback");
	    params.add("code", code);

	    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
	    ResponseEntity<String> response = rt.postForEntity("https://kauth.kakao.com/oauth/token", request, String.class);

	    ObjectMapper objectMapper = new ObjectMapper();
	    String accessToken = objectMapper.readTree(response.getBody()).get("access_token").asText();

	    // 2. 사용자 정보 요청
	    HttpHeaders userHeaders = new HttpHeaders();
	    userHeaders.set("Authorization", "Bearer " + accessToken);
	    HttpEntity<?> userRequest = new HttpEntity<>(userHeaders);

	    ResponseEntity<String> userResponse = rt.exchange(
	        "https://kapi.kakao.com/v2/user/me",
	        HttpMethod.POST,
	        userRequest,
	        String.class
	    );

	    JsonNode userInfo = objectMapper.readTree(userResponse.getBody());
	    // [3] 사용자 정보 꺼내기
	    String email = userInfo.get("kakao_account").get("email").asText();
	    String profileImg = userInfo.get("properties").has("profile_image") ?
	        userInfo.get("properties").get("profile_image").asText() : null;

	    System.out.println("📧 이메일: " + email);
	    System.out.println("🖼 프로필 이미지: " + profileImg);

	    // [4] DB에 이메일로 조회
	    Member loginMember = service.kakaoLogin(email);

	    if (loginMember != null) {
	        // 로그인 성공 → 세션에 저장
	        session.setAttribute("loginMember", loginMember);
	        session.setAttribute("loginType", "kakao");
	        return "redirect:/"; // 메인페이지 이동
	    } else {
	        // 기존 회원 아님 → 회원가입 폼으로 이동 + 이메일 전달
	        model.addAttribute("kakaoEmail", email);
	        model.addAttribute("profileImg", profileImg);
	        return "member/signUp1"; // 기존 회원가입 뷰 사용
	    }
	}


}

