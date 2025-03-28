package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.manager.model.dao.ManageCustomerDAO;
import edu.kh.project.manager.model.dto.CustProfileBoard;
import edu.kh.project.manager.model.dto.CustomerBoard;
import edu.kh.project.manager.model.dto.CustomerProfile;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.manager.model.dto.ReportChatting;

@Service
public class ManagerCustomerServiceImpl implements ManageCustomerService{

	@Autowired
	private ManageCustomerDAO dao;

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

	// 고객 문의 상세 페이지 조회
	@Override
	public CustomerBoard questDetail(int boardNo) {
		return dao.questDetail(boardNo);
	}

	
	// 고객 신고 상세 페이지 조회
	@Override
	public Report reportDetail(int reportNo) {
		return dao.reportDetail(reportNo);
	}

	///-----------고객 프로필---------------
	
	// 고객 프로필 조회
	@Override
	public CustomerProfile customerProfile(int memberNo) {
		return dao.customerProfile(memberNo);
	}

	// 고객 프로필 게시판 조회
	@Override
	public Map<String, Object> profileBoardList(int cp, int boardCode, int memberNo) {
		int listCount = dao.cusProfileBoardCount(boardCode, memberNo);
		Pagination pagination = new Pagination(cp, listCount);
		
		List<CustProfileBoard> boardList = dao.cusProfileBoardList(pagination, boardCode, memberNo);
		
		System.out.println(boardList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("boardList", boardList);
		
		
		
		return map;
	}

	
	/// INSERT UPDATE 기능 --------------------------------
	
	
	// 고객 문의 답변 제출
	@Override
	public int questInsert(CustomerBoard customerBoard) {
		
		customerBoard.setReply(Utill.XSSHandling(customerBoard.getReply()));
		
		//Y 처리
		int result = dao.questUpdate(customerBoard);
		
		
		result = dao.questInsert(customerBoard);
		return result;
	}

	// 고객 신고 처리 답변
	@Override
	public int reportSubmit(Report report) {
		
		report.setReply(Utill.XSSHandling(report.getReply()));
		
		int result = 0;
			
			
		if("반려".equals(report.getReportStatus())||"경고".equals(report.getReportStatus())) { // 반려 경고
			
			result = dao.reportUpdate(report);
			
			int personWarnCount = dao.personWarnCount(report);
			
			if(personWarnCount >=4) {
				report.setReportStatus("블랙");
			}
			
		}
			
			
		if("블랙".equals(report.getReportStatus())) {
			result = dao.reportUpdate(report);
			result = dao.blackUpdate(report);
			
		}
		
		
		return result;
		
		
	}

	// 해당 고객 신고 리스트 조회
	@Override
	public List<CustProfileBoard> infoList(int memberNo, int boardCode) {
		return dao.infoList(memberNo, boardCode);
	}

	// 해당ㅣ 고객 신고 상세 내용 조회
	@Override
	public Report infoDetail(int reportNo) {
		return dao.infoDetail(reportNo);
	}
	
	//신고 대상 게시물/채팅/리뷰 내용 조회
	@Override
	public Map<String, Object> boardModal(int no, int type) {
		
		Map<String, Object> map = new HashMap<>();
		if(type==1) {
			
		}
		if(type==2) {
			int url= dao.getherSelect(no);
			map.put("url", url);
			
		}
		if(type==3) {
			List<Reply> reply = dao.replySelect(no);
			map.put("reply", reply);
			
		}
		if(type==4) {
			List<ReportChatting> reportChatting = dao.chattingSelect(no);
			map.put("chatting", reportChatting);
		}
		if(type==5) {
			Review review = dao.reviewSelect(no);
			review.setImageList(dao.reviewImageList(no));
			
			map.put("review", review);
		}
		
		
		return map;
	}

	
	// 문제의 댓글 삭제하기
	@Override
	public int replyUpdate(int replyNo) {
		return dao.replyUpdate(replyNo);
	}

	//문제의 리뷰 삭제
	@Override
	public int reviewUpdate(int reviewNo) {
		return dao.reviewUpdate(reviewNo);
	}

	
	//// ** 조건 리스트
	//회원, 탈퇴, 블랙 회원 리스트 조회 하기
	@Override
	public Map<String, Object> customerStateChange(char customerState, int cp) {
		int listCount = dao.customerStateCount(customerState);
		
		Pagination pagination = new Pagination(cp, listCount);
		List<QuestCustomer> stateList = dao.customerStateList(pagination, customerState);
		System.out.println("listCount: "+listCount);
		System.out.println("stateList: "+stateList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stateList", stateList);
		map.put("pagination", pagination);
		
		return map;
	}

	//마감,완료, 정지, 진행 리스트 조회 하기
	@Override
	public Map<String, Object> customerBoardCondition(String customerState, int cp) {
		int listCount = dao.customerboardCount(customerState);
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<QuestCustomer> boardList = dao.boardList(pagination, customerState);
		
		System.out.println("listCount: "+listCount);
		System.out.println("stateList: "+boardList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stateList", boardList);
		map.put("pagination", pagination);
		
		return map;
	}

	@Override
	public Map<String, Object> questionCondition(String customerState, int cp) {
		int listCount = dao.questSelect(customerState);
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<QuestCustomer> questList = dao.questList(pagination, customerState);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stateList", questList);
		map.put("pagination", pagination);
		
		return map;
	}

	//신고 조건 목록 조회
	@Override
	public Map<String, Object> reportCondition(String customerState, int cp) {
		
		int listCount = dao.reportListCount(customerState);
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<Report> reportList = dao.reportList(pagination, customerState);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stateList", reportList);
		map.put("pagination", pagination);
		
		return map;
	}



	

}
