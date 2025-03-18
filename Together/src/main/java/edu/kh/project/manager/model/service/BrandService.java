package edu.kh.project.manager.model.service;

import java.util.Map;

import edu.kh.project.manager.model.dto.Report;

public interface BrandService {

	/** 상품 리스트 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> goods(int cp);

	/** 신고 리스트 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> report(int cp);

	/** 제휴 문의 리스트 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> apply(int cp);

	/** 광고 신청 목록 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> promotion(int cp);

	/** 성과 데이터 리스트 조회
	 * @param cp
	 * @return
	 */
	Map<String, Object> dataLook(int cp);

	/** Brand Profile
	 * @param boardNo
	 * @param brandBoardCode 
	 * @param cp 
	 * @return
	 */
	Map<String, Object> brandProfile(int boardNo, int cp, int brandBoardCode);

	/** 브랜드 신고 조회
	 * @param reportNo
	 * @return
	 */
	Report reportDetailSelect(int reportNo);
	
}
