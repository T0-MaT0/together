package edu.kh.project.manager.model.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
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


	/** 브랜드 신고 상세 조회
	 * @param reportNo
	 * @return
	 */
	Report reportDetailSelect(int reportNo);

	/** 브랜드 제휴 문의 상세 조회
	 * @param map
	 * @return
	 */
	BrandBoard boardDetailSelect(Map<String, Object> map);
	

	// **** 브랜드 프로필 조회 ***//
	
	/** 브랜드 프로필 정보 조회
	 * @param memberNo
	 * @return
	 */
	BrandProfile brandProfile(int memberNo);

	/** 브랜드 프로필 게시판 조회
	 * @param cp
	 * @param boardCode
	 * @param memberNo
	 * @return
	 */
	Map<String, Object> profileBoardList(int cp, int boardCode, int memberNo);

	
	/// --- update insert
	/** 브랜드 제휴 문의 답변 처리
	 * @param brandBoard
	 * @return
	 */
	int applySubmit(BrandBoard brandBoard);

	/** 브랜드 신고 처리
	 * @param report
	 * @return
	 */
	int reportSubmit(Report report);

	/** 브랜드 프로필 조회
	 * @param memberNo
	 * @return
	 */
	BrandProfile profile(int memberNo);

	/** 신고 대상 회원의 신고 목록 조회
	 * @param memberNo
	 * @param boardCode
	 * @return
	 */
	List<BrandProfile> infoList(int memberNo, int boardCode);

	/**신고 대상 회원의 신고 상세 정보 조회
	 * @param reportNo
	 * @return
	 */
	Report infoDetail(int reportNo);

	/** 광고 이미지 조회
	 * @param no
	 * @return
	 */
	List<Image> promotionImageSelect(int no);

	/** 광고 이미지 제출 처리
	 * @param boardNo
	 * @param imgType
	 * @param imageNo
	 * @param state 
	 * @return
	 */
	int promotionApproval( Map<String, Object> requestData);

	/** 조건 적용 브랜드 상품 목록조회
	 * @param customerState
	 * @param cp
	 * @return
	 */
	Map<String, Object> productCondition(String customerState, int cp);

	/** 조건 적용 브랜드 대상 신고 목록 조회
	 * @param customerState
	 * @param cp
	 * @return
	 */
	Map<String, Object> reportCondition(String customerState, int cp);

	/** 조건 적용 브랜드 제휴 조회
	 * @param customerState
	 * @param cp
	 * @return
	 */
	Map<String, Object> brandApplyCondition(String customerState, int cp);

	/** 조건 적용 브랜드 광고 조회
	 * @param customerState
	 * @param cp
	 * @return
	 */
	Map<String, Object> brandPromCondition(String customerState, int cp);

	
	
	
	
	
	
}
