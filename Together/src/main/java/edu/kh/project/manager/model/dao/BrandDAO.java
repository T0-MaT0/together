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
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
import edu.kh.project.manager.model.dto.BrandProfileBoard;
import edu.kh.project.manager.model.dto.CustProfileBoard;
import edu.kh.project.manager.model.dto.CustomerProfile;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;

@Repository
public class BrandDAO {
	@Autowired 
	private SqlSessionTemplate sqlSession;

	/** 상품 수
	 * @return
	 */
	public int goodsCount() {
		return sqlSession.selectOne("managerMapper.goodsCount");
	}
	/** 조건 적용 상품 수
	 * @return
	 */
	public int goodsCount(String customerState) {
		return sqlSession.selectOne("managerMapper.goodsCounCondition", customerState);
	}

	/** 상품 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> goodsList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.goodsList", null, rowBounds);
	}
	
	/** 조건 적용 상품 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> goodsList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.goodsListCondition", customerState, rowBounds);
	}
	

	/** 판매 중인 상품 수
	 * @return
	 */
	public int goodsBoardCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("managerMapper.goodsBoardCount");
	}
	
	
	/** 판매 상태 상품 수 
	 * @return
	 */
	public List<Map<String, Object>> goodsStateCount() {
		return sqlSession.selectList("managerMapper.goodsStateCount");
	}
	
	//-----------------------------------------------------------------

 	/** 브랜드 대상 신고 수
	 * @return
	 */
	public int reportCount() {
		return sqlSession.selectOne("managerMapper.brandReportCount");
	}
	
	/** 조건 적용 브랜드 대상 신고 수
	 * @return
	 */
	public int reportCount(String customerState) {
		return sqlSession.selectOne("managerMapper.brandReportCountCondition", customerState);
	}

	/** 브랜드 대상 신고 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> reportList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.brandReportList", null, rowBounds);
	}
	
	/** 조건 적용 브랜드 대상 신고 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> reportList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.brandReportListCondition", customerState, rowBounds);
	}

	
	//-----------------------------------------------------------------------
	
	
	/** 제휴문의 수
	 * @return
	 */
	public int applyCount() {
		return sqlSession.selectOne("managerMapper.applyCount");
	}
	
	/** 조건 적용 제휴문의 수
	 * @return
	 */
	public int applyCount(String customerState) {
		return sqlSession.selectOne("managerMapper.applyCountCondition", customerState);
	}
	
	/** 제휴 문의 상태 수
	 * @return
	 */
	public List<Map<String, Object>> applyStateCount() {
		return sqlSession.selectList("managerMapper.applyStateCount");
	}

	
	//-------------------------------------------------------------------

	/** 제휴 문의 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> applyList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.applyList", null, rowBounds);
	}
	
	/** 조건 적용 제휴 문의 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> applyList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.applyListCondition", customerState, rowBounds);
	}
	
	//------------------------------------------------------------------

	/** 광고 신청 수
	 * @return
	 */
	public int promotionCount() {
		return sqlSession.selectOne("managerMapper.promotionCount");
	}
	
	/** 조건 적용 광고 신청 수
	 * @return
	 */
	public int promotionCount(String customerState) {
		return sqlSession.selectOne("managerMapper.promotionCountCondition", customerState);
	}

	/**  광고 신청 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> promotionList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.promotionList", null, rowBounds);
	}
	
	/**  조건 적용 광고 신청 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> promotionList(Pagination pagination, String customerState) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.promotionListCondition", customerState, rowBounds);
	}

	/** 광고 상태 수
	 * @return
	 */
	public List<Map<String, Object>> promStateCount() {
		return sqlSession.selectList("managerMapper.promStateCount");
	}
	
	//------------------------------------------------------------------
	
	/** 데이터 성과 리스트 수
	 * @return
	 */
	public int dataLookCount() {
		return sqlSession.selectOne("managerMapper.dataLookCount");
	}

	/** 데이터 성과 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> dataLookList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.dataLookList", null, rowBounds);
	}

	public List<Map<String, Object>> dataRank() {
		return sqlSession.selectList("managerMapper.dataRank");
	}


	/** report detail ajax
	 * @param reportNo
	 * @return
	 */
	public Report reportDetailSelect(int reportNo) {
		return sqlSession.selectOne("managerMapper.reportDetailSelect", reportNo);
	}

	/** 제휴 문의 상세 조회 ajax
	 * @param boardNo
	 * @return
	 */
	public BrandBoard boardDetailSelect(Map<String, Object> map) {
		return sqlSession.selectOne("managerMapper.boardDetailSelect", map);
	}


	
	/// *** 브랜드 프로필 ***///

	
	/** 브랜드 프로필 조회
	 * @param boardNo
	 * @return
	 */
	public BrandProfile brandProfileSelect(int memberNo) {
		return sqlSession.selectOne("managerMapper.brandProfileSelect", memberNo);
	}

	
	
	/** 브랜드 프로필 게시글 수
	 * @param boardNo
	 * @param brandBoardCode
	 * @return
	 */
	public int brandProfileBoardCount(int memberNo, int brandBoardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", brandBoardCode);
		map.put("memberNo", memberNo);
		
		return sqlSession.selectOne("managerMapper.brandProfileBoardCount",map);
	}
	
	/// *** PROFILE END ***
	
	/** 브랜드 프로필 리스트 목록 조회
	 * @param pagination 
	 * @param brandBoardCode
	 * @param boardNo 
	 * @return
	 */
	public List<BrandProfileBoard> brandProfileProducts(Pagination pagination, int brandBoardCode, int memberNo) {
		
		Map<String, Object> brandMap = new HashMap<>();
		brandMap.put("boardCode", brandBoardCode);
		brandMap.put("memberNo", memberNo);
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("managerMapper.brandProfileProducts", brandMap, rowBounds);
	}

	public int applyUpdate(BrandBoard brandBoard) {
		return sqlSession.update("managerMapper.applyUpdate", brandBoard);
	}

	public int applyInsert(BrandBoard brandBoard) {
		return sqlSession.insert("managerMapper.replyInsert", brandBoard);
	}

	/** 제휴 승인 처리
	 * @param brandBoard 
	 * @return
	 */
	public int applyAccept(BrandBoard brandBoard) {
		return sqlSession.update("managerMapper.permissionCompany", brandBoard);
	}

	public int reportUpdate(Report report) {
		return sqlSession.update("managerMapper.reportUpdate", report);
	}

	public int personWarnCount(Report report) {
		return sqlSession.selectOne("managerMapper.personWarnCount", report);
	}

	public int blackUpdate(Report report) {
		return sqlSession.update("managerMapper.blackUpdate", report);
	}

	public int companyBlackUpdate(Report report) {
		return sqlSession.update("managerMapper.companyBlackUpdate", report);
	}

	public BrandProfile profile(int memberNo) {
		return sqlSession.selectOne("managerMapper.brandProfileSelect", memberNo);
	}

	public List<BrandProfile> infoList(int memberNo, int boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("boardCode", boardCode);
		
		return sqlSession.selectList("managerMapper.cusProfileBoardList", map);
	}

	public Report infoDetail(int reportNo) {
		return sqlSession.selectOne("managerMapper.reportDetailSelect", reportNo);
	}

	public List<Image> promotionImageSelect(int no) {
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("imgType", 4);
		
		return sqlSession.selectList("imageMapper.selectImageList", map);
	}

	/** 광고 문의 대기 변경
	 * @param boardNo
	 * @param state
	 */
	public int promotionBoardUpdate( Map<String, Object> requestData) {
		
		return sqlSession.update("managerMapper.promotionBoardUpdate", requestData);
	}

	public int promotionImageUpdate( Map<String, Object> requestData) {
		
		return sqlSession.insert("imageMapper.promotionImageUpdate", requestData);
	}



	/// ***회원 프로필 상태 업데이트
	/** 회원 복구
	 * @param memberNo
	 * @return
	 */
	public int BeRecover(int memberNo) {
		return sqlSession.update("managerMapper.BeRecover", memberNo);
	}
	/** 회원 블랙
	 * @param memberNo
	 * @return
	 */
	public int BeBlack(int memberNo) {
		return sqlSession.update("managerMapper.BeBlack", memberNo);
	}
	
	
	
	
	
	
}
