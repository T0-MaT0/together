package edu.kh.project.manager.controller;

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

import edu.kh.project.manager.model.dto.CustomerBoard;
import edu.kh.project.manager.model.dto.CustomerProfile;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.manager.model.service.ManageCustomerService;

@Controller
@RequestMapping("/manageCustomer")
public class ManageCustomerController {
	@Autowired
	private ManageCustomerService service;
	
	//고객 규모 리스트 화면 
	@GetMapping("/state")
	public String state(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 고객 정보 목록 조회
		Map<String, Object> map = service.customerState(cp);
		model.addAttribute("map", map);
				
		return "/manager/customer/customerState";
	}
	
	// 모집글 규모 리스트 화면
	@GetMapping("/board")
	public String board(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
			, Model model) {
		
		// 고객 정보 목록 조회
		Map<String, Object> map = service.customerboard(cp);
		model.addAttribute("map", map);
		System.out.println(map);
		
		return "/manager/customer/customerBoard";
	}
	
	
	// 문의 리스트 화면
	@GetMapping("/question")
	public String question(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
							, Model model) {
		// 고객 문의 리스트 조회
		Map<String, Object> map = service.questSelect(cp);
		model.addAttribute("map", map);
		return "/manager/customer/customerQuestion";
	}
	
	// 신고 리스트 화면
	@GetMapping("/report")
	public String report(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
										, Model model) {
		//고객 대상 신고 대상 목록 조회
		Map<String, Object> map =  service.reportSelect(cp);
		
		model.addAttribute("map", map);
		
		
		return "/manager/customer/customerReport";
	}
	
	
	
	//----------------------------------------------
	//고객 대상 신고 대상 목록 조회
	@GetMapping(value="/reportSelect", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> reportSelect(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
											) {
		return  service.reportSelect(cp);
	}
	
	
	
	// 고객 문의 상세 페이지 조회
	@GetMapping(value="/questDetail", produces="application/json; charset=UTF-8")
	@ResponseBody
	public CustomerBoard questDetail(int boardNo) {
		
		return service.questDetail(boardNo);
	}
	
	@GetMapping(value="/reportDetail", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Report reportDetail(int reportNo) {
		return service.reportDetail(reportNo);
	}
	
	/// 고객 프로필 화면 -------------------------------------
	
	//고객 프로필 화면
	@GetMapping("/customerProfile")
	public String customerProfile(int memberNo, Model model) {
		
		CustomerProfile profile = service.customerProfile(memberNo);
		model.addAttribute("profile", profile);
		
		return "/manager/customer/customerProfile";
	}
	
	// 목록 조회 화면
	@GetMapping(value="/customerProfile/{boardCode}", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> customerProfile(@RequestParam( value="cp",required=false,defaultValue = "1") int cp
								,@PathVariable("boardCode") int boardCode
								,int memberNo) {
		
		Map<String, Object> map = service.profileBoardList(cp, boardCode, memberNo );
		
		return map;
	}
	
	
	/// INSERT UPDATE 기능 --------------------------------
	
	//고객 문의 답변 제출
	@PostMapping(value="/submit", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int questInsert(@RequestBody CustomerBoard customerBoard) {
		
		return service.questInsert(customerBoard);
	}
	
	
	
	// 고객 신고 답변 제출
	@PostMapping(value="/reportSubmit", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int reportSubmit(@RequestBody Report Report) {
		
		return service.reportSubmit(Report);
	}
	
}
