package edu.kh.project.main.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.main.service.MainService;
import edu.kh.project.member.model.dto.Member;



@Controller
@SessionAttributes("loginMember")
public class MainController {
	
	@Autowired
	private MainService service;

	// 메인
	@RequestMapping("/")
	public String mainForward(Model model,
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {
	    
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    // 개인 공동구매 모집글 조회
	    List<Recruitment> recruitmentList = service.selectRecruitmentList(memberNo);
	    model.addAttribute("recruitmentList", recruitmentList);

	    // 브랜드 상품 리스트 조회
	    Map<String, Object> map = service.selectBusinessList(); 
	    model.addAttribute("map", map);

	    model.addAttribute("loginMember", loginMember);

	    return "/common/main";
	}
}
