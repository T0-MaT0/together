package edu.kh.project.member.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.member.model.dto.Company;
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
	// 기업 회원가입 전용 화면 이동
	@GetMapping("/signUp2")
	public String signUp2() {
		return "member/signUp2";
	}
	// 개인 아이디 찾기 화면 이동
	@GetMapping("/findId")
	public String findId() {
		return "member/findId";
	}
	
	// 기업 아이디 찾기 화면 이동
	@GetMapping("/findId2")
	public String findId2() {
		return "member/findId2";
	}
	// 개인 비밀번호 찾기 화면 이동
	@GetMapping("/findPw")
	public String findPw() {
		return "member/findPw";
	}
	// 기업 비밀번호 찾기 화면 이동
	@GetMapping("/findPw2")
	public String findPw2() {
		return "member/findPw2";
	}
	
	// 비밀번호 변경 화면 이동
	@GetMapping("/changePw")
	public String changePw() {
		return "member/changePw";
	}
	
	// 포인트 충전 화면 이동
	@GetMapping("/chargePoint")
	public String chargePoint() {
		return "member/chargePoint";
	}
	// 포인트 계좌이체 결과 화면 이동
	@GetMapping("/openbankingResult")
	public String openbankingResult() {
		return "member/openbankingResult";
	}
	
	/** 로그인 요청 처리 
	 * @return 메인페이지 redirect 주소
	 */
	@PostMapping("/login")
	public String login(Member inputMember, Model model
			, @RequestHeader(value="referer") String referer
			, @RequestParam(value="saveId", required=false) String saveId
			, @RequestParam(value="redirect", required=false) String redirect
			, HttpServletResponse resp
			, RedirectAttributes ra, HttpSession session) {

		System.out.println("inputMember: " + inputMember);
		Member loginMember = service.login(inputMember);
		System.out.println("loginMember : " + loginMember);
		
		
		String path = "redirect:";
		
		if(loginMember != null) {
			 path += (redirect != null && !redirect.isEmpty()) ? redirect : "/";
			
			model.addAttribute("loginMember", loginMember);
			session.setAttribute("loginType", "default");
			
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
	public String logout(SessionStatus status, HttpSession session, RedirectAttributes ra) {

	   

	    // 세션 정리
	    status.setComplete();
	    session.invalidate();

	    return "redirect:/";
	}

	
	
	// 개인 회원 가입 진행 
	@PostMapping("/signUp1")
	public String signUp(Member inputMember, String[] memberAddr, Company inputCompany, 
			 RedirectAttributes ra) {
		
		System.out.println("inputMember : " + inputMember);
		System.out.println("inputCompany : " + inputCompany);
		

		if(inputMember.getMemberAddr().equals(",,")) {
			
			inputMember.setMemberAddr(null);
			
		} else { 
			
			String addr = String.join("^^^", memberAddr);
			inputMember.setMemberAddr(addr);
			
		}

		int result = service.signUp(inputMember);
		
		System.out.println("다시 나온 inputMember : " + inputMember);
		
		inputCompany.setMemberNo(inputMember.getMemberNo());
		
		System.out.println("다시 세팅한 inputCompany : " + inputCompany);

		String path = "redirect:";
		String message = null;
		
		// 기업 회원일 경우
		if(inputMember.getAuthority() == 3) {
			
			int result2 = service.signUpCompany(inputCompany);
			
			if(result2 > 0) {
				path += "/";
				message = inputMember.getMemberNick() + "님의 가입을 환영합니다.";
				
			} else {
				path += "/member/signUp2"; 
				message = "회원 가입 실패.";
			}
			
		} else { // 개인 회원일 경우
			if(result > 0) {
				path += "/";
				message = inputMember.getMemberNick() + "님의 가입을 환영합니다.";
				
			} else {
				path += "/member/signUp1"; 
				message = "회원 가입 실패.";
			}
		}
		
		
		ra.addFlashAttribute("message", message);
		
		
		return path;
	}
	
	// 개인 아이디 찾기
	@PostMapping("/findId")
	public String findId(Member inputMember , Model model) {

		System.out.println("inputMember : " + inputMember);
		Member findMember = service.findId(inputMember);
		System.out.println("findMember : " + findMember);

		model.addAttribute("findMember", findMember);
		
		String path = "";
		
		if(inputMember.getAuthority() == 2) {
			path = "member/findIdResult";
		}
		if(inputMember.getAuthority() == 3) {
			path = "member/findIdResult2";
			
		}
		return path;
			
	}

	// 개인 패스워드 재설정을 위한 확인
	@PostMapping("/findPw")
	public String findPw(Member inputMember, Model model , RedirectAttributes ra) {

		System.out.println("inputMember : " + inputMember);
		Member findMember = service.findPw(inputMember);

		String path = "";
		

		if (findMember == null){

			path = "redirect:/member/findPw"; 
			String message = "일치하는 회원이 없습니다.";
			ra.addFlashAttribute("message", message);

		} else{
			model.addAttribute("findMember", findMember);
			path = "/member/changePw";

		}

		
		return path;
	}

	@PostMapping("/changePw")
	public String changePw(Member inputMember, RedirectAttributes ra) {

		System.out.println("비번 변경 inputMember : " + inputMember);
		int result = service.changePw(inputMember);

		String path = "redirect:";
		String message = null;

		if(result > 0){
			message = "비밀번호 변경 성공.";
			path += "/";
		} else{
			message = "비밀번호 변경 실패.";
			path += "/member/findPw";
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
	
	@PostMapping(value = "/checkPw", produces="application/json; charset=UTF-8")
	@ResponseBody 
	public int WriteBoardCheckPw(@RequestBody Map<String, String> paramMap) {


	    return service.WriteBoardCheckPw(paramMap);

	}
	
	
}
