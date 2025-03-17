package edu.kh.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String customerMain() {
		return "customer/customerMain";
	}


}
