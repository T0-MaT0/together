package edu.kh.project.business.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.kh.project.business.service.BusinessService;

@Controller
@RequestMapping("/board")
public class BusinessController {
	@Autowired
	private BusinessService service;
	
	// 사업자 메인 화면
	@GetMapping("/{boardCode:2}")
	public String selectBusinessList(
			@PathVariable("boardCode") int boardCode) {
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/{boardCode:2}/search")
	public String searchBusinessList(
			@PathVariable("boardCode") int boardCode,
			@RequestParam Map<String, Object> pranmMap,
			Model model) {
		Map<String, Object> map;
		
		return "board/business/businessList";
	}
}
