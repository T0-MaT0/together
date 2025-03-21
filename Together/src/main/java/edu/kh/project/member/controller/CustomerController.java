package edu.kh.project.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kh.project.member.model.dto.Board;
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
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp
			, @RequestParam Map<String, Object> paramMap) {
		

		//System.out.println(boardCode);
		Map<String, Object> map = new HashMap<String, Object>();
		if(paramMap.get("key") == null) {
			map = service.FAQBoardList(boardCode, cp);			
		} else { // 검색어가 있을 경우
			paramMap.put("boardCode", boardCode);
			//map = service.FAQBoardList(paramMap, cp);			

		}
		
		
		model.addAttribute("map",map);
		
		return "customer/FAQBoard";
	}
	//  공지사항 리스트 페이지 가져옴
	@GetMapping("/noticeBoardList")
	public String noticeBoardList(Model model
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp
			, @RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(paramMap.get("key") == null) {
			map = service.noticeBoardList(cp);
			
		} else { 
			//map = service.noticeBoardList(paramMap, cp);	
			
		}
		
		//System.out.println(map);

		
		model.addAttribute("map", map);
		return "customer/noticeBoardList";
	}
	//  공지사항 디테일 페이지 가져옴
	@GetMapping("/noticeBoardDetail/{boardNo}")
	public String noticeBoardDetail(@PathVariable("boardNo") int boardNo ,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map = service.noticeBoardDetail(boardNo);
		
		model.addAttribute("map",map);
		
		return "customer/noticeBoardDetail";
	}
	
	// 비동기 카테고리 가져옴
	@GetMapping("/FAQBoard/{boardCode}/fragment")
	public String getFAQFragment(@PathVariable("boardCode") int boardCode ,Model model
			, @RequestParam(value = "cp", required=false, defaultValue="1") int cp
			, @RequestParam Map<String, Object> paramMap) {
		

		//System.out.println(boardCode);
		Map<String, Object> map = new HashMap<String, Object>();
		if(paramMap.get("key") == null) {
			map = service.FAQBoardList(boardCode, cp);			
		} else { // 검색어가 있을 경우
			paramMap.put("boardCode", boardCode);
			//map = service.FAQBoardList(paramMap, cp);			

		}
		
		
		model.addAttribute("map",map);
		
		return "customer/FAQBoard-fragment";
	}
	
	
	


}
