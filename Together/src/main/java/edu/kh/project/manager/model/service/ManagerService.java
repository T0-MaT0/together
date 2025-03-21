package edu.kh.project.manager.model.service;

import java.util.List;
import java.util.Map;

public interface ManagerService {

	
	// -----------------------*** 메인 화면 ***---------------------
	
	/** 고객 문의 수 조회
	 * @return result
	 */
	int customerQuestionCount();
	
	/** 고객 대상 신고 목록 수 조회
	 * @return
	 */
	int cusReportListCount();

	/**브랜드 제휴 수 조회
	 * @return
	 */
	int brandQuestCount();
	
	/** 브랜드 대상 신고 수
	 * @return
	 */
	int brandReportCount();
	
	/** 브랜드 상품 수
	 * @return
	 */
	int productCount();
	
	/** 고객 모집글 수
	 * @return
	 */
	int customerboardCount();

	//=======================**** 메인 화면 끝 ******====================
	
	/** 브랜드 광고 문의 개수 조회
	 * @return
	 */
	int brandAdCount();

	/** 브랜드 메인화면 실적 수 조회
	 * @return
	 */
	Map<String, Object> selectNum();

	/** 고객 메인 화면 실적 수 조회
	 * @return
	 */
	Map<String, Object> customerMain();

	
	//-----------------------------------------------------------
	/** 그래프 7일 조회
	 * @return
	 */
	Map<String, Object> graphWeek();

	/** 개인 회원 수 조회
	 * @return
	 */
	List<Number> dayCustomerCount();

	/** 브랜드 회원 수 조회
	 * @return
	 */
	List<Number> dayBrandCount();

	//------------------------------------
	/**미처리 1:1문의 수
	 * @return
	 */
	int custQuestCount();

	/** 미처리 제휴 수
	 * @return
	 */
	int notPassApplyCount();

	/** 대기 광고 수
	 * @return
	 */
	int brandAddCount();

	/** 브랜드 대상 신고 대기 수
	 * @return
	 */
	int waitCount();

	/** 고객 대상 신고 대기 수
	 * @return
	 */
	int cusWaitCount();

	






}
