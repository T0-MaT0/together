package edu.kh.project.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
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
	
	// **  부랜드 프로필 **
	//브랜드 프로필 조회
	
	@GetMapping("/brandProfile")
	public String brandProfile(int memberNo, Model model) {
		
		BrandProfile profile = service.brandProfile(memberNo);
		model.addAttribute("profile", profile);
		
		return "/manager/brand/brandProfile";
	}
	
	
	@GetMapping("/brandProfile/{boardCode}")
	@ResponseBody
	public Map<String, Object> brandProfile(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
								,int memberNo
								, @PathVariable("boardCode") int boardCode) {
		
		
		Map<String, Object> map = service.profileBoardList(cp, boardCode, memberNo);
		
		return map;
	}
	
	// ** brand Profile End**//
	
	
	
	
	/// INSERT UPDATE
	
	@PostMapping("/submit")
	@ResponseBody
	public int applySubmit(@RequestBody BrandBoard brandBoard) {
		
		return service.applySubmit(brandBoard);
	}
	
	// 신고 처리
	@PostMapping(value="/reportSubmit", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int reportSubmit(@RequestBody Report Report) {
		
		return service.reportSubmit(Report);
	}
	
	
	/// 신고 모달 정보 조회
	
	//신고 대상 브랜드 회원 정보 조회
	@GetMapping(value="/modalInfo", produces="application/json; charset=UTF-8")
	@ResponseBody
	public BrandProfile modalInfo(int memberNo) {
			
		
		return service.profile(memberNo);
	}
	
	// 신고 대상 회원의 신고 목록 조회
	@GetMapping(value="/infoList/{boardCode}", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<BrandProfile> infoList(int memberNo, @PathVariable int boardCode) {
			
		
		return service.infoList(memberNo, boardCode);
	}
	
	// 신고 대상 회원의 신고 상세 정보 조회
	@GetMapping(value="/infoDetail", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Report infoDetail(int reportNo) {
			
		
		return service.infoDetail(reportNo);
	}
	
	// 신고 대상 게시물 조회
	@GetMapping(value="/boardModal/{type}")
	public String boardModal(int no, @PathVariable int type, Model model) {
		
		model.addAttribute("no", no);
		model.addAttribute("type",type);
		
		return "/manager/common/detailBoardModal";
	}
	
	
	// 광고 이미지 조회하기
	@GetMapping(value="/promotionImageSelect", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Image> promotionImageSelect(int no) {
		return service.promotionImageSelect(no);
	}
	
	// 광고 이미지/보드 update
	@PostMapping(value="/promotionApproval", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int promotionApproval(@RequestBody Map<String, Object> requestData) {
		return service.promotionApproval(requestData);
	}
	
	///*** 조건 적용 영역
	//조건 적용 브랜드 상품 목록조회
	@GetMapping(value="productCondition", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> productCondition(
			@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			,String customerState){
		return service.productCondition(customerState, cp);
	}
	
	//조건 적용 브랜드 대상 신고 목록 조회
	@GetMapping(value="reportCondition", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> reportCondition(
			@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			,String customerState){
		return service.reportCondition(customerState, cp);
	}
	
	//조건 적용 브랜드 제휴 조회
	@GetMapping(value="brandApplyCondition", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> brandApplyCondition(
			@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			,String customerState){
		return service.brandApplyCondition(customerState, cp);
	}
	
	//조건 적용 브랜드 광고 조회
	@GetMapping(value="brandPromCondition", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> brandPromCondition(
			@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			,String customerState){
		return service.brandPromCondition(customerState, cp);
	}
	
}
