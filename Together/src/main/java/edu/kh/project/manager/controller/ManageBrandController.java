package edu.kh.project.manager.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.kh.project.manager.model.service.BrandService;

@Controller
@RequestMapping("/manageBrand")
public class ManageBrandController {
	
	@Autowired
	private BrandService service;
	
	// 상품 리스트 화면
	@GetMapping("/goods")
	public String goods(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 상품 리스트 조회
		Map<String, Object> map = service.goods(cp);
		model.addAttribute("map", map);
		
		return "/manager/brand/goods";
	}
	
	// 신고관리 리스트 화면
	@GetMapping("/report")
	public String report(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 신고관리 리스트 조회
		Map<String, Object> map = service.report(cp);
		model.addAttribute("map", map);
		return "/manager/brand/report";
	}
	
	// 제휴문의 화면
	@GetMapping("/apply")
	public String apply(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 제휴 문의 리스트 조회
		Map<String, Object> map = service.apply(cp);
		model.addAttribute("map", map);
		
		return "/manager/brand/apply";
	}
	
	
	
	// 광고 신청 리스트 화면
	@GetMapping("/promotion")
	public String promotion(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 광고 신청 리스트 조회
		Map<String, Object> map = service.promotion(cp);
		model.addAttribute("map", map);

		return "/manager/brand/promotion";
	}
	
	// 성과 데이터 리스트 화면
	@GetMapping("/dataLook")
	public String dataLook(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		// 성과 데이터 리스트 조회
		Map<String, Object> map = service.dataLook(cp);
		model.addAttribute("map", map);
		return "/manager/brand/dataLook";
	}
	
}
