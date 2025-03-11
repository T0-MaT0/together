package edu.kh.project.business.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BusinessController {
	// 사업자 메인 화면
	@GetMapping("/{boardCode:2}")
	public String selectBusinessList() {
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/{boardCode:2}/search")
	public String searchBusinessList() {
		return "board/business/businessList";
	}
}
