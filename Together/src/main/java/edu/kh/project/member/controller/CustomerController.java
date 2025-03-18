package edu.kh.project.member.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

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
		
		System.out.println(map);
		
		model.addAttribute("map", map);
		
		return "customer/customerMain";
	}
	//  FAQ 페이지 가져옴
	@GetMapping("/FAQBoard")
	public String FAQBoard() {
		return "customer/FAQBoard";
	}
	//  공지사항 리스트 페이지 가져옴
	@GetMapping("/noticeBoardList")
	public String noticeBoardList() {
		return "customer/noticeBoardList";
	}
	//  공지사항 디테일 페이지 가져옴
	@GetMapping("/noticeBoardDetail")
	public String noticeBoardDetail() {
		return "customer/noticeBoardDetail";
	}
	


}
