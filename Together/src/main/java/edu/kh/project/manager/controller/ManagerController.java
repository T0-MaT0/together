package edu.kh.project.manager.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.kh.project.manager.model.service.ManagerService;

@Controller
@RequestMapping("/managerArea")
public class ManagerController {
	
	@Autowired
	private ManagerService service;
	
	//관리자 메인
	@GetMapping("/main")
	public String managerMain(Model model) {
		
		// 고객 문의 수 조회
		int customerQuestCount = service.customerQuestionCount();
		model.addAttribute("customerQuestCount", customerQuestCount);
		
		// 고객 신고 수
		
		
		// 브랜드 제휴 수
		int brandQuestCount = service.brandQuestCount();
		model.addAttribute("brandQuestCount", brandQuestCount);
		// 브랜드 광고 신청 수
		int brandAdCount = service.brandAdCount();
		model.addAttribute("brandAdCount", brandAdCount);
		
		// 브랜드 신고 수
		
		
		
		//브랜드 상품 수/ 고객 모집글 수
		
		// 회원 수, 브랜드 수
		
		
		return "manager/managerMain";
	}
	
	//고객 관리 화면
	@GetMapping("/customer")
	public String manageCustomer() {
		return "manager/customer/customerMain";
	}
	
	//브랜드 관리 화면
	@GetMapping("/brand")
	public String manageBrand() {
		return "manager/brand/brandMain";
	}
	
	// 홈페이지 편집 화면
	@GetMapping("/home")
	public String manageHome() {
		return "manager/home/manageHome";
	}
	

}
