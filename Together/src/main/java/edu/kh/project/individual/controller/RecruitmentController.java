package edu.kh.project.individual.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.individual.service.RecruitmentService;
import edu.kh.project.member.model.dto.Member;

@Controller
public class RecruitmentController {

	@Autowired
	private RecruitmentService service;
	
	// 개인 공동구매 모집방 페이지 (boardCode=1 고정)
	@GetMapping("/Individual/1")
	public String individualMainPage(
	        Model model,
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

	    int boardCode = 1; 
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);
	    model.addAttribute("recruitmentList", recruitmentList);
	    model.addAttribute("boardCode", boardCode);

	    return "Individual/mainIndividual";  
	}
	
	
	// 개인 공동구매 모집방 목록 JSON 응답 - boardCode = 1 고정
	@GetMapping("/api/recruitment")
	@ResponseBody
	public List<Recruitment> getRecruitmentList(
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

	    int boardCode = 1; 
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);

	    return recruitmentList; 
	}
	
	// 개인 공동구매 모집방 목록 JSON 응답 - 조회수 높은 순 (BEST)
    @GetMapping("/api/recruitment/popular")
    @ResponseBody
    public List<Recruitment> getPopularRecruitmentList(
            @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

        int boardCode = 1;
        int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

        List<Recruitment> recruitmentList = service.selectRecruitmentListByViewCount(boardCode, memberNo);

        return recruitmentList;
    }
    
    // 개인 공동구매 모집방 목록 상세 페이지 (boardCode=1 고정)
 	@GetMapping("/Individual/detail")
 	public String individualDetail(
 	        Model model,
 	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

 	    int boardCode = 1; 
 	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

 	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);
 	    model.addAttribute("recruitmentList", recruitmentList);
 	    model.addAttribute("boardCode", boardCode);

 	    return "Individual/individualDetail";  
 	}
 	
 	// 내 모집 현황 조회
 	@GetMapping("/myRecruitment")
    public String myRecruitment(
    		@RequestParam(value = "key", required = false, defaultValue = "myRecruitment") String key,
            Model model,
            @SessionAttribute(value = "loginMember", required = false) Member loginMember,
            RedirectAttributes redirectAttributes) {

 		int boardCode = 1;
 		if (loginMember == null) {
 	        redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
 	        return "redirect:/member/login";
 	    }
 		
 		int memberNo = loginMember.getMemberNo();
        List<Recruitment> recruitments = service.getMyRecruitmentList(memberNo, key);
        model.addAttribute("recruitments", recruitments);
        model.addAttribute("boardCode", boardCode);
        model.addAttribute("selectedKey", key);

        return "Individual/myRecruitmentInProgress/myRecruitment";
    }
        
    
	
	
}
