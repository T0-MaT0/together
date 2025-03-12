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
	@PostMapping("/signUp1")
	public String signUp(Member inputMember, String[] memberAddr, String businessNo
			, RedirectAttributes ra) {
		

		if(inputMember.getMemberAddr().equals(",,")) {
			
			inputMember.setMemberAddr(null);
			
		} else { 
			
			String addr = String.join("^^^", memberAddr);
			inputMember.setMemberAddr(addr);
			
		}

		int result = service.signUp(inputMember);

		String path = "redirect:";
		String message = null;
		
		if(result > 0) {
			
			if()

			path += "/";
			message = inputMember.getMemberNick() + "님의 가입을 환영합니다.";
			
		} else {
			path += "/member/signUp"; 
			message = "회원 가입 실패.";
		}
		
		ra.addFlashAttribute("message", message);
		
		
		return path;
	}
		


	// 현재 클래스에서 발생하는 모든 예외를 모아서 처리
	public String exceptionHandler(Exception e, Model model) {
		
		e.printStackTrace();
		
		model.addAttribute("e", e);
		
		return "common/error";
	}
	
	
}
