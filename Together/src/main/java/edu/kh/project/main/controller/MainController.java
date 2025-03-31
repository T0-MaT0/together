package edu.kh.project.main.controller;

import java.util.HashMap;
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

	@RequestMapping("/")
	public String mainForward(Model model,
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {
		
		int boardCode = 1; 
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);
	    model.addAttribute("recruitmentList", recruitmentList);

	    

	    boardCode = 2;

		Map<String, Object> map = service.selectBusinessList(boardCode);
		
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("map", map);
		
		return "/common/main";
	}
}
