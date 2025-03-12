package edu.kh.project.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.MemberService;


@Controller 
@RequestMapping("/member")
@SessionAttributes("loginMember")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	// 로그인 전용 화면 이동
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	// 개인 회원가입 전용 화면 이동
	@GetMapping("/signUp1")
	public String signUp1() {
		return "member/signUp1";
	}
	// 개인 회원가입 전용 화면 이동
	@GetMapping("/signUp2")
	public String signUp2() {
		return "member/signUp2";
	}
	
	/** 로그인 요청 처리 
	 * @return 메인페이지 redirect 주소
	 */
	@PostMapping("/login")
	public String login(Member inputMember, Model model
			, @RequestHeader(value="referer") String referer
			, @RequestParam(value="saveId", required=false) String saveId
			, HttpServletResponse resp
			, RedirectAttributes ra) {

		System.out.println(inputMember);
		Member loginMember = service.login(inputMember);
		System.out.println("loginMember : " + loginMember);
		
		
		String path = "redirect:";
		
		if(loginMember != null) {
			path += "/";
			
			model.addAttribute("loginMember", loginMember);
			
			Cookie cookie = new Cookie("saveId", loginMember.getMemberId());
			if(saveId != null) { 
				cookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				cookie.setMaxAge(0);
			}
			cookie.setPath("/");
			resp.addCookie(cookie);
			
		} else {
			path += referer;
			ra.addFlashAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		return path;
		
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status, HttpSession session,
			RedirectAttributes ra) {
		
		status.setComplete();
	
		return "redirect:/";
	}
	
	// 개인 회원 가입 진행 
	/*@PostMapping("/signUp1")
	public String signUp(Member inputMember, String[] memberAddress
			, RedirectAttributes ra) {
		
		// Member inputMember : 커맨드 객체(제출된 파라미터가 저장된 객체)
		// RedirectAttributes ra : 리다이렉트 시 데이터를 request scope로 전달하는 객체
		
		// 1234^^^서울시^^^강남구
		// 주소 구분자 , -> ^^^ 변경
		// String addr = inputMember.getMemberAddress().replaceAll(",", "^^^");
		// inputMember.setMemberAddress(addr);
		// -> 클라이언트가 ,를 직접 입력하면 문제 발생
		
		// 주소를 입력하지 않은 경우 (,,) null로 변경
		if(inputMember.getMemberAddress().equals(",,")) {
			
			inputMember.setMemberAddress(null);
			
		} else { // 주소를 입력한 경우
			// String.join("구분자", String[])
			// 배열의 요소를 하나의 문자열로 변경
			// 단, 요소 사이에 "구분자" 추가
			
			String addr = String.join("^^^", memberAddress);
			inputMember.setMemberAddress(addr);
			
		}
		// 회원 가입 서비스 호출
		int result = service.signUp(inputMember);
		
		// 가입 여부에 따라서 주소 작성
		
		String path = "redirect:";
		String message = null;
		
		if(result > 0) { // 가입 성공
			// 메인 페이지
			path += "/";
			message = inputMember.getMemberNickname() + "님의 가입을 환영합니다.";
			
		} else {
			// 회원 가입 페이지
			path += "/member/signUp"; // 절대 경로
			// path += "signUp"; // 상대 경로
			message = "회원 가입 실패.";
		}
		
		
		
		// 리다이렉트 시 session에 잠깐 올라갔다가 내려오도록 세팅
		ra.addFlashAttribute("message", message);
		
		
		return path;
	}*/
		


	// 현재 클래스에서 발생하는 모든 예외를 모아서 처리
	public String exceptionHandler(Exception e, Model model) {
		
		e.printStackTrace();
		
		model.addAttribute("e", e);
		
		return "common/error";
	}
	
	
}
