package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.manager.model.dao.CustomerDAO;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;

@Service
public class CustomerServiceImpl implements CustomerService{

	@Autowired
	private CustomerDAO dao;

	//고객 상태 목록 조회
	@Override
	public Map<String, Object> customerState(int cp) {
		int listCount = dao.customerStateCount();
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<QuestCustomer> stateList = dao.customerStateList(pagination);

		//총 회원 수 조회
		int customerTotal = dao.customerTotal();
		
		// 신규 회원 조회
//		int newCustomerCount = dao.newCustomerCount();
		//탈퇴, 블랙, 회원 조회
		List<Map<String, Object>> CustomersSelect = dao.CustomersSelect();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stateList", stateList);
		map.put("pagination", pagination);
		map.put("customerTotal", customerTotal);
		map.put("CustomersSelect", CustomersSelect);
//		map.put("newCustomerCount", newCustomerCount);
		
		return map;
	}

	// 고객 모집글 목록 조회
	@Override
	public Map<String, Object> customerboard(int cp) {
		int listCount = dao.customerboardCount();
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<QuestCustomer> boardList = dao.boardList(pagination);
		
		int totalCustomerBoard = dao.totalCustomerBoard();
		List<Map<String, Object>> cusBoardStateCount = dao.cusBoardStateCount();
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		map.put("pagination", pagination);
		map.put("totalCustomerBoard", totalCustomerBoard);
		map.put("cusBoardStateCount", cusBoardStateCount);
		
		return map;
	}
	
	
	// 고객 문의 목록 조회
	@Override
	public Map<String, Object> questSelect(int cp) {
		
		int listCount = dao.questSelect();
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<QuestCustomer> questList = dao.questList(pagination);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("questList", questList);
		map.put("pagination", pagination);
		
		return map;
	}
	
	
	// 고객 대상 신고 목록 조회
	@Override
	public Map<String, Object> reportSelect(int cp) {
		
		int listCount = dao.reportListCount();
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<Report> reportList = dao.reportList(pagination);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportList", reportList);
		map.put("pagination", pagination);
		
		return map;
	}



	

}
