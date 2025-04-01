package edu.kh.project.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import edu.kh.project.member.model.GoogleOAuthConfig;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.MemberService;

@Controller
@RequestMapping("/oauth/google")
public class GoogleController {
	
	@Autowired
	private MemberService service;

    @GetMapping("/callback")
    public String googleCallback(@RequestParam("code") String code, Model model, HttpSession session) throws Exception {

        // 1. 액세스 토큰 요청
        RestTemplate restTemplate = new RestTemplate();

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("code", code);
        params.add("client_id", GoogleOAuthConfig.CLIENT_ID);
        params.add("client_secret", GoogleOAuthConfig.CLIENT_SECRET);
        params.add("redirect_uri", GoogleOAuthConfig.REDIRECT_URI);
        params.add("grant_type", GoogleOAuthConfig.GRANT_TYPE);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(GoogleOAuthConfig.TOKEN_URI, request, Map.class);

        // 2. 토큰 꺼내기
        String accessToken = (String) response.getBody().get("access_token");

        // 3. 사용자 정보 요청
        HttpHeaders userInfoHeaders = new HttpHeaders();
        userInfoHeaders.setBearerAuth(accessToken);
        HttpEntity<?> userInfoRequest = new HttpEntity<>(userInfoHeaders);

        ResponseEntity<Map> userInfoResponse = restTemplate.exchange(GoogleOAuthConfig.USERINFO_URI, HttpMethod.GET, userInfoRequest, Map.class);
        Map userInfo = userInfoResponse.getBody();

        // 이메일 정보 가져오기
        String email = (String) userInfo.get("email");
        String name = (String) userInfo.get("name");
        String profileImg = (String) userInfo.get("picture");

        System.out.println("구글 사용자 이메일: " + email);
        System.out.println("이름: " + name);
        System.out.println("프로필 이미지: " + profileImg);

        // DB에서 이메일로 회원 조회
        Member loginMember = service.snsLogin(email);

        if (loginMember != null) {
            session.setAttribute("loginMember", loginMember);
            session.setAttribute("loginType", "google");
            return "redirect:/";
        } else {
            model.addAttribute("kakaoEmail", email); // 동일하게 사용
            model.addAttribute("profileImg", profileImg);
            return "member/signUp1";
        }
    }
}
