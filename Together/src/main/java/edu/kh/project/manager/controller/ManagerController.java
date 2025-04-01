package edu.kh.project.manager.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.manager.model.service.ManagerService;

@Controller
@RequestMapping("/managerArea")
public class ManagerController {
	
	@Autowired
	private ManagerService service;
	
	//관리자 메인
	@GetMapping("/main")
	public String managerMain(Model model) {
		
		// 고객 문의 수 조회
		int customerQuestCount = service.customerQuestionCount();
		model.addAttribute("customerQuestCount", customerQuestCount);
		
		// 고객 대상 신고 수
		int cusReportListCount = service.cusReportListCount();
		model.addAttribute("cusReportListCount", cusReportListCount);
		
		// 브랜드 제휴 수
		int brandQuestCount = service.brandQuestCount();
		model.addAttribute("brandQuestCount", brandQuestCount);
		// 브랜드 광고 신청 수
		int brandAdCount = service.brandAdCount();
		model.addAttribute("brandAdCount", brandAdCount);
		
		// 브랜드 신고 수
		int brandReportCount = service.brandReportCount();
		model.addAttribute("brandReportCount", brandReportCount);
		
		
		//브랜드 상품 수/ 고객 모집글 수
		int productCount = service.productCount();
		int customerboardCount = service.customerboardCount();
		model.addAttribute("productCount", productCount);
		model.addAttribute("customerboardCount", customerboardCount);
		
		
		
		//(일간) 회원 수, 브랜드 수
		Map<String, Object> graph  = service.graphWeek();
		model.addAttribute("graph", graph);
		
		List<Number> dayCustomerCount = service.dayCustomerCount();
		List<Number> dayBrandCount = service.dayBrandCount();
		model.addAttribute("dayCustomerCount", dayCustomerCount);
		model.addAttribute("dayBrandCount", dayBrandCount);
		
		//1:1문의 수
		int custQuestCount = service.custQuestCount();
		model.addAttribute("custQuestCount", custQuestCount);
		//제휴 수
		int notPassApplyCount = service.notPassApplyCount();
		model.addAttribute("notPassApplyCount", notPassApplyCount);
		//광고 수
		int brandAddCount = service.brandAddCount();
		model.addAttribute("brandAddCount", brandAddCount);
		
		
		// 미처리 신고
		// 고객 대상
		int cusWaitCount = service.cusWaitCount();
		model.addAttribute("cusWaitCount", cusWaitCount);
		// 브랜드  대상
		int waitCount = service.waitCount();
		model.addAttribute("waitCount", waitCount);
		
		return "manager/managerMain";
	}
	
	//고객 관리 화면
	@GetMapping("/customer")
	public String manageCustomer(Model model) {
		Map<String, Object> map = service.customerMain();
		
		model.addAttribute("map", map);
		
		return "manager/customer/customerMain";
	}
	
	//브랜드 관리 화면
	@GetMapping("/brand")
	public String manageBrand(Model model) {
		
		Map<String, Object> map = service.selectNum();
		
		model.addAttribute("map", map);
		
		return "manager/brand/brandMain";
	}
	
	// 홈페이지 편집 화면
	@GetMapping("/home")
	public String manageHome() {
		return "manager/home/manageHome";
	}
	
	

}
