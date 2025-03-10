package edu.kh.project.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manageBrand")
public class ManageBrandController {
	
	// 광고 신청 리스트 화면
	@GetMapping("/promotion")
	public String promotion() {
		return "/manager/brand/promotion";
	}
	
	// 신고관리 리스트 화면
	@GetMapping("/report")
	public String report() {
		return "/manager/brand/report";
	}
	
	// 성과 데이터 리스트 화면
	@GetMapping("/dataLook")
	public String dataLook() {
		return "/manager/brand/dataLook";
	}
	
	// 상품 리스트 화면
	@GetMapping("/goods")
	public String goods() {
		return "/manager/brand/goods";
	}
	
	// 제휴문의 화면
	@GetMapping("/apply")
	public String apply() {
		return "/manager/brand/apply";
	}
}
