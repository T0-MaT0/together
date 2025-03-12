package edu.kh.project.business.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.kh.project.business.model.service.BusinessService;

@Controller
@RequestMapping("/board")
public class BusinessController {
	@Autowired
	private BusinessService service;
	
	// 사업자 메인 화면
	@GetMapping("/{boardCode:2}")
	public String selectBusinessList(
			@PathVariable("boardCode") int boardCode,
			Model model) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, 1);
		
		model.addAttribute("map", map);
		
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/{boardCode:2}/search")
	public String searchBusinessList(
			@PathVariable("boardCode") int boardCode,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, cp);
		
		model.addAttribute("map", map);
		
		return "board/business/businessList";
	}
}
