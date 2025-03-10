package edu.kh.project.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manageCustomer")
public class ManageCustomerController {
	
	//고객 규모 리스트 화면 
	@GetMapping("/state")
	public String state() {
		return "/manager/customer/customerState";
	}
	
	// 모집글 규모 리스트 화면
	@GetMapping("/board")
	public String board() {
		return "/manager/customer/customerBoard";
	}
	
	// 문의 리스트 화면
	@GetMapping("/question")
	public String question() {
		return "/manager/customer/customerQuestion";
	}
	
	// 신고 리스트 화면
	@GetMapping("/report")
	public String report() {
		return "/manager/customer/customerReport";
	}
}
