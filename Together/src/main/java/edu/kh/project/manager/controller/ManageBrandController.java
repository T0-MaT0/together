package edu.kh.project.manager.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.Report;
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
	
	
	//-------------------------------------------------------------------------------
	//브랜드 프로필 조회
	@GetMapping("/brandProfile/{brandBoardCode}")
	public String brandProfile(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
							,int boardNo, Model model
							, @PathVariable("brandBoardCode") int brandBoardCode) {
		
		
		Map<String, Object> map = service.brandProfile(boardNo, cp, brandBoardCode);
		model.addAttribute("map",map);
		model.addAttribute("brandBoardCode",brandBoardCode);
		model.addAttribute("boardNo", boardNo);
		System.out.println(map.get("brandList"));
		
		return "/manager/brand/brandProfile";
	}
	
	// 브랜드 신고 상세 조회
	@GetMapping(value="/reportDetail" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Report reportDetail(int reportNo) {
		return service.reportDetailSelect(reportNo);
	}
	
	
	// 브랜드 제휴 상세 조회
	@GetMapping(value="/boardDetail/{boardCode}", produces="application/json; charset=UTF-8")
	@ResponseBody
	public BrandBoard applyDetail(int boardNo
						, @PathVariable("boardCode") int boardCode) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("boardNo", boardNo);
		map.put("boardCode", boardCode);
		
		return service.boardDetailSelect(map);
	}
}
