package edu.kh.project.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.CustomerService;

@Controller
@RequestMapping("/customer")
@SessionAttributes("loginMember")
public class CustomerController {

	@Autowired
	private CustomerService service;

	// 고객센터 메인 페이지 가져옴
	@GetMapping("/customerMain")
	public String customerMain(Model model) {
		
		Map<String, Object> map = service.selectBoardList();
		
		//System.out.println(map);
		
		model.addAttribute("map", map);
		
		return "customer/customerMain";
	}
	//  FAQ 페이지 가져옴
	@GetMapping("/FAQBoard/{boardCode}")
	public String FAQBoard(@PathVariable("boardCode") int boardCode ,Model model
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp) {
		
		Map<String, Object> map = new HashMap<String, Object>();

		map = service.FAQBoardList(boardCode, cp);			
		
		
		
		model.addAttribute("map",map);
		
		return "customer/FAQBoard";
	}
	@GetMapping("/FAQBoard/{boardCode}/fragment/list")
	public String getFAQListFragment(@PathVariable int boardCode,
	                                 @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                                 Model model) {
	    Map<String, Object> map = service.FAQBoardList(boardCode, cp);
	    model.addAttribute("map", map);
	    return "customer/FAQBoardListFragment";
	}

	@GetMapping("/FAQBoard/{boardCode}/fragment/page")
	public String getFAQPaginationFragment(@PathVariable int boardCode,
	                                       @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                                       Model model) {
	    Map<String, Object> map = service.FAQBoardList(boardCode, cp);
	    model.addAttribute("map", map);
	    return "customer/FAQPaginationFragment";
	}
	@GetMapping("/FAQBoard/search")
	public String searchFAQ(@RequestParam("query") String query,
	                        @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                        Model model) {

	    Map<String, Object> map = service.searchFAQ(query, cp);
	    model.addAttribute("map", map);
	    return "customer/FAQBoard";
	}


	
	//  공지사항 리스트 페이지 가져옴
	@GetMapping("/noticeBoardList")
	public String noticeBoardList(Model model
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp
			, @RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> map = new HashMap<String, Object>();

		map = service.noticeBoardList(cp);
		
		model.addAttribute("map", map);
		return "customer/noticeBoardList";
	}
	//  1:1 문의 리스트 페이지 가져옴
	@GetMapping("/askBoardList")
	public String askBoardList(Model model
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp
			, @RequestParam Map<String, Object> paramMap
			, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		map.put("boardCd", 6); // 1:1 게시판 가져오는거 
		map.put("memberNo", loginMember.getMemberNo());
		map.put("cp", cp);
		map = service.askBoardList(map);
		
		
		model.addAttribute("map", map);
		return "customer/askBoardList";
	}
	
	@GetMapping("/notice/search")
	public String searchNotice(@RequestParam("query") String query,
	                           @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                           Model model) {

	    Map<String, Object> map = service.searchNoticeList(query, cp);
	    model.addAttribute("map", map);
	    return "customer/noticeBoardList";
	}
	
	//  공지사항과 1:1문의 디테일 페이지 가져옴
	@GetMapping("/customerBoardDetail/{boardNo}")
	public String noticeBoardDetail(@PathVariable("boardNo") int boardNo , Model model
			,  @RequestParam(value = "cp", required=false, defaultValue="1") int cp) {
		Map<String, Object> map = new HashMap<String, Object>();
		map = service.selectBoardDetail(boardNo);
		
		model.addAttribute("map",map);
		
		return "customer/CustomerBoardDetail";
	}
	


	
	


}
