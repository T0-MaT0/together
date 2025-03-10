package edu.kh.project.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	//관리자 메인
	@GetMapping("/main")
	public String managerMain() {
		
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
