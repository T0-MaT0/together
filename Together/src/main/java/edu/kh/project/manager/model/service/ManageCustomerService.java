package edu.kh.project.manager.model.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.manager.model.dto.CustProfileBoard;
import edu.kh.project.manager.model.dto.CustomerBoard;
import edu.kh.project.manager.model.dto.CustomerProfile;
import edu.kh.project.manager.model.dto.Report;

public interface ManageCustomerService {

	
	
	/** 고객 상태 목록 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> customerState(int cp);
	
	
	/** 고객 모집글 목록 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> customerboard(int cp);
	
	/** 고객 문의 목록 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> questSelect(int cp);
	
	
	/** 고객 대상 신고 목록 조회
	 * @param cp 
	 * @return
	 */
	Map<String, Object> reportSelect(int cp);


	/** 고객 문의 상세 페이지 화면
	 * @param boardNo
	 * @return
	 */
	CustomerBoard questDetail(int boardNo);


	/** 고객 신고 상세 페이지 조회
	 * @param reportNo
	 * @return
	 */
	Report reportDetail(int reportNo);


	/** 고객 프로필 조회
	 * @return
	 */
	CustomerProfile customerProfile(int memberNo);



	/** 고객 프로필 화면 게시판 조회
	 * @param cp
	 * @param boardCode
	 * @param memberNo 
	 * @return
	 */
	Map<String, Object> profileBoardList(int cp, int boardCode, int memberNo);

	/// INSERT UPDATE 기능 --------------------------------
	
	

	/** 고객 문의 답변 제출
	 * @param customerBoard
	 * @return
	 */
	int questInsert(CustomerBoard customerBoard);


	/** 고객 신고 답변 제출 처리
	 * @param report
	 * @return
	 */
	int reportSubmit(Report report);


	/** 해당 고객 신고 리스트 조회
	 * @param memberNo
	 * @param boardCode
	 * @return
	 */
	List<CustProfileBoard> infoList(int memberNo, int boardCode);


	/** 해당 고객 신고 상세 내용 조회
	 * @param reportNo
	 * @return
	 */
	Report infoDetail(int reportNo);


	Map<String, Object> boardModal(int type, int no);









	
}
