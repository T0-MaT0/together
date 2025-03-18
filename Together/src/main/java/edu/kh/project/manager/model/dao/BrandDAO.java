package edu.kh.project.manager.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
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

	/** 상품 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> goodsList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.goodsList", null, rowBounds);
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

	/** 브랜드 대상 신고 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> reportList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.brandReportList", null, rowBounds);
	}

	
	//-----------------------------------------------------------------------
	
	
	/** 제휴문의 수
	 * @return
	 */
	public int applyCount() {
		return sqlSession.selectOne("managerMapper.applyCount");
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
	
	//------------------------------------------------------------------

	/** 광고 신청 수
	 * @return
	 */
	public int promotionCount() {
		return sqlSession.selectOne("managerMapper.promotionCount");
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

	
	/** 브랜드 프로필 조회
	 * @param boardNo
	 * @return
	 */
	public BrandProfile brandProfileSelect(int boardNo) {
		return sqlSession.selectOne("managerMapper.brandProfileSelect", boardNo);
	}

	
	
	/** 브랜드 프로필 게시글 수
	 * @param boardNo
	 * @param brandBoardCode
	 * @return
	 */
	public int brandProfileBoardCount(int boardNo, int brandBoardCode) {
		Map<String, Object> brandMap = new HashMap<>();
		brandMap.put("boardCode", brandBoardCode);
		brandMap.put("boardNo", boardNo);
		
		return sqlSession.selectOne("managerMapper.brandProfileBoardCount",brandMap);
	}
	/** 브랜드 프로필 리스트 목록 조회
	 * @param pagination 
	 * @param brandBoardCode
	 * @param boardNo 
	 * @return
	 */
	public List<BrandBoard> brandProfileProducts(Pagination pagination, int brandBoardCode, int boardNo) {
		
		Map<String, Object> brandMap = new HashMap<>();
		brandMap.put("boardCode", brandBoardCode);
		brandMap.put("boardNo", boardNo);
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("managerMapper.brandProfileProducts", brandMap, rowBounds);
	}

	/** report detail ajax
	 * @param reportNo
	 * @return
	 */
	public Report reportDetailSelect(int reportNo) {
		return sqlSession.selectOne("managerMapper.reportDetailSelect", reportNo);
	}







	
	
	
	
	
	
}
