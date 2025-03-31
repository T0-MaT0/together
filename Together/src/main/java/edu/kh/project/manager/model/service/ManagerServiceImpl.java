package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.manager.model.dao.ManagerDAO;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Member;

@Service
public class ManagerServiceImpl implements ManagerService {
	//*** 메인 화면***
	@Autowired
	private ManagerDAO dao;
	
	@Override
	public int customerQuestionCount() {
		
		return dao.customerQuestionCount();
	}
	
	@Override
	public int cusReportListCount() {
		return dao.cusReportListCount();
	}

	@Override
	public int brandQuestCount() {
		return dao.brandQuestCount();
	}

	@Override
	public int brandAdCount() {
		return dao.brandAdCount();
	}

	@Override
	public int brandReportCount() {
		return dao.brandReportCount();
	}
	
	@Override
	public int productCount() {
		return dao.productCount();
	}
	
	

	@Override
	public int customerboardCount() {
		return dao.customerboardCount();
	}
	//===========================MAIN END===================//
	
	// 브랜드 메인 실적 수 조회
	@Override
	public Map<String, Object> selectNum() {
		/*상품 판매 건수*/
		// 총 상품 건수 
		int totalSellCount = dao.totalSellCount();
		// 판매 진행 중이 건수
		int sellingCount = dao.sellingCount();
		// 판매 종료 건수
		int soldCount = dao.soldCount();
		// 총 판매 상품 수
		int quantityCount = dao.quantityCount();
		
		/*브랜드 대상 신고*/
		// 대기수
		int waitCount = dao.watiCount();
		// 반려 수
		int returnCount = dao.returnCount();
		// 경고 수
		int warnCount = dao.warnCount();
		// 블랙 수
		int blackCount = dao.blackCount();
		
		/*제휴 문의*/
		//총 건수
		int totalApplyCount = dao.totalApplyCount();
		//대기
		int waitApplyCount = dao.waitApplyCount();
		//승인
		int acceptApplyCount = dao.acceptApplyCount();
		//거절
		int refuseApplyCount = dao.refuseApplyCount();
		
		//제휴 문의 목록 조회
		List<BrandBoard> applyList = dao.applyList();
		
		
		/*광고 문의*/
		//진행 중
		int totalPromCount = dao.totalPromCount();
		//대기
		int waitPromCount = dao.waitPromCount();
		//승인
		int acceptPromCount = dao.acceptPromCount();
		//거절
		int refusePromCount = dao.refusePromCount();
		
		// 광고 목록 조회
		List<BrandBoard> promList = dao.promList();
		
		// 광고 문의 목록 조회
		Map<String, Object> map = new HashMap<>();
		map.put("totalSellCount", totalSellCount);
		map.put("sellingCount", sellingCount);
		map.put("soldCount", soldCount);
		map.put("quantityCount", quantityCount);
		
		map.put("waitCount", waitCount);
		map.put("returnCount", returnCount);
		map.put("warnCount", warnCount);
		map.put("blackCount", blackCount);
		
		map.put("totalApplyCount", totalApplyCount);
		map.put("waitApplyCount", waitApplyCount);
		map.put("acceptApplyCount", acceptApplyCount);
		map.put("refuseApplyCount", refuseApplyCount);
		
		map.put("totalPromCount", totalPromCount);
		map.put("waitPromCount", waitPromCount);
		map.put("acceptPromCount", acceptPromCount);
		map.put("refusePromCount", refusePromCount);
		
		map.put("applyList", applyList);
		map.put("promList", promList);
		
		
		return map;
	}


	//고객 메인 화면 실적 수 조회
	@Override
	public Map<String, Object> customerMain() {
		Map<String, Object> map = new HashMap<>();
		
		//총 회원 수
		int customerTotalCount = dao.customerTotalCount();
		map.put("customerTotalCount", customerTotalCount);
		// 신규 가입 수
		int customerNewCount = dao.customerNewCount();
		map.put("customerNewCount", customerNewCount);
		
		// 회원 탈퇴 수
		int customerOutCount = dao.customerOutCount();
		map.put("customerOutCount", customerOutCount);
		
		// 블랙 리스트
		int customerBlackCount = dao.customerBlackCount();
		map.put("customerBlackCount", customerBlackCount);
		
		
		//고객 상태 리스트 목록 조회
		List<Member> customerStateList = dao.customerStateList();
		map.put("customerStateList", customerStateList);
		
		
		// 총 공구 모집 수
		int GatherTotalCount = dao.GatherTotalCount();
		map.put("GatherTotalCount", GatherTotalCount);
		// 성사된 모집
		int GatherSuccessCount = dao.GatherSuccessCount();
		map.put("GatherSuccessCount", GatherSuccessCount);
		// 취소된 모집
		int GatherCancelCount = dao.GatherCancelCount();
		map.put("GatherCancelCount", GatherCancelCount);
		// 정지된 모집
		int GatherStopCount = dao.GatherStopCount();
		map.put("GatherStopCount", GatherStopCount);
		
		
		
		// 총 문의 개수
		int questTotalCount = dao.questTotalCount();
		map.put("questTotalCount", questTotalCount);
		// 미처리 문의
		int questWaitCount = dao.questWaitCount();
		map.put("questWaitCount", questWaitCount);
		// 처리 문의
		int questAcceptCount = dao.questAcceptCount();
		map.put("questAcceptCount", questAcceptCount);
		
		
		//고객 신고
		String customerReport = "3, 4, 5";
		//미처리
		int customerWaitReport = dao.customerWaitReport(customerReport);
		map.put("customerWaitReport", customerWaitReport);
		//처리
		int customerDoneReport = dao.customerDoneReport(customerReport);
		map.put("customerDoneReport", customerDoneReport);
		
		//모집글 신고
		customerReport = "2";
		//미처리
		int gatherWaitReport = dao.gatherWaitReport(customerReport);
		map.put("gatherWaitReport", gatherWaitReport);
		//처리
		int gatherDoneReport = dao.gatherDoneReport(customerReport);
		map.put("gatherDoneReport", gatherDoneReport);
		
		
		//고객 신고 리스트 목록 조회
		List<Report> customerReportFourList = dao.customerReportFourList();
		map.put("customerReportFourList", customerReportFourList);
		//모집글 신고 리스트 목록 조회
		List<Report> gatherReportFourList = dao.gatherReportFourList();
		map.put("gatherReportFourList", gatherReportFourList);
		
		
		return map;
	}

	
	//--------------------------------------------
	// 그래프 7일 조회
	@Override
	public Map<String, Object> graphWeek() {
		return dao.graphWeek();
	}
	// 개인 회원 수 조회
	@Override
	public List<Number> dayCustomerCount() {
		return dao.dayCustomerCount();
	}
	// 브랜드 회원 수 조회
	@Override
	public List<Number> dayBrandCount() {
		return dao.dayBrandCount();
	}


	//-------------------------------------
	
	@Override
	public int custQuestCount() {
		return dao.questWaitCount();
	}

	@Override
	public int notPassApplyCount() {
		return dao.notPassApplyCount();
	}

	@Override
	public int brandAddCount() {
		return dao.brandAddCount();
	}

	@Override
	public int waitCount() {
		return dao.waitCount();
	}

	@Override
	public int cusWaitCount() {
		return dao.cusWaitCount();
	}

	
	//--------------------------------------------------
	// 고객 검색
	@Override
	public List<Member> managerSearchMember(String query) {
		return dao.managerSearchMember(query);
	}
	




	
	
	
}
