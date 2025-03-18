package edu.kh.project.manager.model.service;

import java.util.Map;

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







	
}
