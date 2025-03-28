package edu.kh.project.manager.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.manager.model.dto.CustProfileBoard;
import edu.kh.project.manager.model.dto.CustomerBoard;
import edu.kh.project.manager.model.dto.CustomerProfile;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.manager.model.dto.ReportChatting;

@Repository
public class ManageCustomerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 고객 상태 목록 수
	 * @return
	 */
	public int customerStateCount() {
		return sqlSession.selectOne("managerMapper.customerStateCount");
	}
	/** 조건에 따른 고객 목록 
	 * @return
	 */
	public int customerStateCount(char customerState) {
		return sqlSession.selectOne("managerMapper.customerStateCountCondition", customerState);
	}
	
	
	/** 고객 상태 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> customerStateList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.customerStateList", null, rowBounds);
	}
	
	/** 조건에 따른 고객 상태 목록 조회
	 * @param pagination
	 * @param customerState
	 * @return
	 */
	public List<QuestCustomer> customerStateList(Pagination pagination, char customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.customerStateListCondition", customerState, rowBounds);
	}
	
	/** 총 회원 수 조회
	 * @return
	 */
	public int customerTotal() {
		return sqlSession.selectOne("managerMapper.customerTotal");
	}
	
	
	/** 신규 회원 수
	 * @return
	 */
	public int newCustomerCount() {
		return sqlSession.selectOne("managerMapper.newCustomerCount");
	}


	/** 기존 회원, 블랙, 탈퇴 회원 수
	 * @return
	 */
	public List<Map<String, Object>> CustomersSelect() {
		
		return sqlSession.selectList("managerMapper.CustomersSelect");
	}
	
	
	//-----------------------------------------------------------------------
	
	/** 고객 모집글 목록 수
	 * @return
	 */
	public int customerboardCount() {
		return sqlSession.selectOne("managerMapper.customerboardCount");
	}
	/** 조건 적용한 모집글 목록 수
	 * @return
	 */
	public int customerboardCount(String customerState) {
		return sqlSession.selectOne("managerMapper.customerboardCountCondition", customerState);
	}

	/** 고객 모집글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> boardList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.boardList", null, rowBounds);
	}
	/** 조건 적용 고객 모집글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> boardList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.boardListCondition", customerState, rowBounds);
	}

	
	/** 총 진행 중인 모집글 수
	 * @return
	 */
	public int totalCustomerBoard() {
		return sqlSession.selectOne("managerMapper.totalCustomerBoard");
	}
	
	
	/** 마감, 진행, 완료 , 정지
	 * @return
	 */
	public List<Map<String, Object>> cusBoardStateCount() {
		return sqlSession.selectList("managerMapper.cusBoardStateCount");
	}
	
	//-------------------------------------------------------------------------
	/** 고객 문의 목록 수
	 * @return
	 */
	public int questSelect() {
		return sqlSession.selectOne("managerMapper.questListCount");
	}
	/** 조건 적용 고객 문의 목록 수
	 * @return
	 */
	public int questSelect(String customerState) {
		return sqlSession.selectOne("managerMapper.questListCountCondition", customerState);
	}
	
	/** 고객 문의 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> questList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.questList", null, rowBounds );
	}
	
	/** 조건 적용 고객 문의 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> questList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.questListCondition", customerState, rowBounds );
	}

	
	/** 고객 대상 신고 수
	 * @return
	 */
	public int reportListCount() {
		return sqlSession.selectOne("managerMapper.reportListCount");
	}
	
	/** 조건 적용 고객 대상 신고 수
	 * @return
	 */
	public int reportListCount(String customerState) {
		return sqlSession.selectOne("managerMapper.reportListCountCondition", customerState);
	}
	
	/** 고객 대상 신고 목록 조회
	 * @param cp 
	 * @return
	 */
	public List<Report> reportList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("managerMapper.reportSelect", null, rowBounds );
	}
	
	/** 조건 적용 고객 대상 신고 목록 조회
	 * @param cp 
	 * @return
	 */
	public List<Report> reportList(Pagination pagination, String customerState) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("managerMapper.reportSelectCondition", customerState, rowBounds );
	}


	/** 고객 문의 상세 페이지 조회
	 * @param boardNo
	 * @return
	 */
	public CustomerBoard questDetail(int boardNo) {
		return sqlSession.selectOne("managerMapper.questDetail", boardNo);
	}


	/** 고객 신고 상세 페이지 조회
	 * @param reportNo
	 * @return
	 */
	public Report reportDetail(int reportNo) {
		return sqlSession.selectOne("managerMapper.reportDetailSelect", reportNo);
	}


	/** 고객 프로필 조회
	 * @param memberNo
	 * @return
	 */
	public CustomerProfile customerProfile(int memberNo) {
		return sqlSession.selectOne("managerMapper.customerProfile", memberNo);
	}


	/** 프로필 게시판 목록 수 조회
	 * @param boardCode
	 * @param memberNo
	 * @return
	 */
	public int cusProfileBoardCount(int boardCode, int memberNo) {
		Map <String, Object> map = new HashMap<>();
		map.put("boardCode",boardCode);
		map.put("memberNo", memberNo);
		return sqlSession.selectOne("managerMapper.cusProfileBoardCount", map);
	}


	/** 프로필 게시판 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<CustProfileBoard> cusProfileBoardList(Pagination pagination, int boardCode, int memberNo) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		Map <String, Object> map = new HashMap<>();
		map.put("boardCode",boardCode);
		map.put("memberNo", memberNo);
		
		return sqlSession.selectList("managerMapper.cusProfileBoardList", map, rowBounds);
	}

	/// INSERT UPDATE 기능 --------------------------------
	
	
	/** Y 처리 
	 * @param customerBoard
	 * @return
	 */
	public int questUpdate(CustomerBoard customerBoard) {
		return sqlSession.update("managerMapper.questUpdate", customerBoard);
	}
	
	/**고객 문의 답변 제출
	 * @param customerBoard
	 * @return
	 */
	public int questInsert(CustomerBoard customerBoard) {
		return sqlSession.insert("managerMapper.replyInsert", customerBoard);
	}


	/** 고객 신고 처리 답변
	 * @param report
	 * @return
	 */
	public int reportUpdate(Report report) {
		return sqlSession.update("managerMapper.reportUpdate", report);
	}


	/** 해당 고객 경고 횟수
	 * @param report
	 * @return
	 */
	public int personWarnCount(Report report) {
		return sqlSession.selectOne("managerMapper.personWarnCount", report);
	}


	/** 블랙 처리
	 * @param report
	 * @return
	 */
	public int blackUpdate(Report report) {
		return sqlSession.update("managerMapper.blackUpdate", report);
	}


	/** 해당 고객 신고 리스트 조회
	 * @param memberNo
	 * @param boardCode
	 * @return
	 */
	public List<CustProfileBoard> infoList(int memberNo, int boardCode) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("boardCode", boardCode);
		
		return sqlSession.selectList("managerMapper.cusProfileBoardList", map);
	}


	/**  해당 고객 신고 상세 내용 조회
	 * @param reportNo
	 * @return
	 */
	public Report infoDetail(int reportNo) {
		return sqlSession.selectOne("managerMapper.reportDetailSelect", reportNo);
	}

	
	/** 해당 문제의 모집글
	 * @param no
	 * @return
	 */
	public int getherSelect(int no) {
		return sqlSession.selectOne("managerMapper.getherSelect", no);
	}



	/** 해당 문제의 댓글
	 * @param no
	 * @return
	 */
	public List<Reply> replySelect(int no) {
		return sqlSession.selectList("managerMapper.replySelect", no);
	}


	/** 해당 문제의 채팅
	 * @param no
	 * @return
	 */
	public List<ReportChatting> chattingSelect(int no) {
		return sqlSession.selectList("managerMapper.chattingSelect", no);
	}


	/** 해당 문제의 리뷰
	 * @param no 
	 * @return
	 */
	public Review reviewSelect(int no) {
		return sqlSession.selectOne("managerMapper.reviewSelect", no);
	}


	public List<Image> reviewImageList(int no) {
		Map <String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("imgType", 3);
		return sqlSession.selectList("imageMapper.selectImageList", no);
	}

	
	// 문제의 댓글 삭제
	public int replyUpdate(int replyNo) {
		return sqlSession.update("managerMapper.replyDelete", replyNo);
	}


	// 문제의 리뷰 삭제
	public int reviewUpdate(int reviewNo) {
		return sqlSession.update("managerMapper.reviewUpdate", reviewNo);
	}































	
	
	
}
