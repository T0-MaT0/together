package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.manager.model.dao.ManagerDAO;
import edu.kh.project.manager.model.dto.BrandBoard;

@Service
public class ManagerServiceImpl implements ManagerService {
	
	@Autowired
	private ManagerDAO dao;
	
	@Override
	public int customerQuestionCount() {
		
		return dao.customerQuestionCount();
	}

	@Override
	public int brandQuestCount() {
		return dao.brandQuestCount();
	}

	@Override
	public int brandAdCount() {
		return dao.brandAdCount();
	}

	
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
	
	
	
	
}
