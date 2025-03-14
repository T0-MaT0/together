package edu.kh.project.manager.model.service;


public interface ManagerService {

	/** 고객 문의 수 조회
	 * @return result
	 */
	int customerQuestionCount();

	/**브랜드 제휴 수 조회
	 * @return
	 */
	int brandQuestCount();

	/** 브랜드 광고 문의 개수 조회
	 * @return
	 */
	int brandAdCount();

}
