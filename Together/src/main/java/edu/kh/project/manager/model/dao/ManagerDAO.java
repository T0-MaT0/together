package edu.kh.project.manager.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.manager.model.dto.BrandBoard;

@Repository
public class ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 고객 문의 수 조회
	 * @return
	 */
	public int customerQuestionCount() {
		return sqlSession.selectOne("customerQuestionCount");
	}

	/** 브랜드 제휴 문의 수 조회
	 * @return
	 */
	public int brandQuestCount() {
		return sqlSession.selectOne("brandQuestCount");
	}

	/** 브랜드 광고 문의 수 조회
	 * @return
	 */
	public int brandAdCount() {
		return sqlSession.selectOne("brandAdCount");
	}

	
	//---------브랜드 메인 실적 수 조회------------------------------//
	
	/** 브랜드 상품 판매 - 총 판매 건수
	 * @return
	 */
	public int totalSellCount() {
		return sqlSession.selectOne("managerMapper.brandTotalSellCount");
	}

	/** 상품 판매 진행중인 건 수
	 * @return
	 */
	public int sellingCount() {
		return sqlSession.selectOne("managerMapper.sellingCount");
	}

	/** 판매 종료한 건수
	 *  @return
	 */
	public int soldCount() {
		return sqlSession.selectOne("managerMapper.soldCount");
	}

	/** 총 판매 수량
	 * @return
	 */
	public int quantityCount() {
		return sqlSession.selectOne("managerMapper.quantityCount");
	}

	/*브랜드 대상 신고*/
	/** 대기 수
	 * @return
	 */
	public int watiCount() {
		return sqlSession.selectOne("managerMapper.watiCount");
	}

	/** 반려 수
	 * @return
	 */
	public int returnCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("managerMapper.returnCount");
	}

	/** 경고 수
	 * @return
	 */
	public int warnCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("managerMapper.warnCount");
	}

	/** 블랙 수
	 * @return
	 */
	public int blackCount() {
		return sqlSession.selectOne("managerMapper.blackCount");
	}

	
	
	// 제휴 문의
	
	/** 총 제휴 수
	 * @return
	 */
	public int totalApplyCount() {
		return sqlSession.selectOne("managerMapper.totalApplyCount");
	}

	/** 제휴 대기 수
	 * @return
	 */
	public int waitApplyCount() {
		return sqlSession.selectOne("managerMapper.waitApplyCount");
	}

	/** 제휴 수락 수
	 * @return
	 */
	public int acceptApplyCount() {
		return sqlSession.selectOne("managerMapper.acceptApplyCount");
	}

	/** 제휴 거절 수
	 * @return
	 */
	public int refuseApplyCount() {
		return sqlSession.selectOne("managerMapper.refuseApplyCount");
	}

	
	// 광고 실적 수
	/** 총 광고 문의
	 * @return
	 */
	public int totalPromCount() {
		return sqlSession.selectOne("managerMapper.totalPromCount");
	}

	/** 광고 대기 수
	 * @return
	 */
	public int waitPromCount() {
		return sqlSession.selectOne("managerMapper.waitPromCount");
	}

	/** 광고 승이 수
	 * @return
	 */
	public int acceptPromCount() {
		return sqlSession.selectOne("managerMapper.acceptPromCount");
	}

	/** 광고 거절 수
	 * @return
	 */
	public int refusePromCount() {
		return sqlSession.selectOne("managerMapper.refusePromCount");
	}

	/** 제휴 문의 목록 5개 조회
	 * @return
	 */
	public List<BrandBoard> applyList() {
		return sqlSession.selectList("managerMapper.mainApplyList");
	}

	/** 광고 문의 목록 5개 조회
	 * @return
	 */
	public List<BrandBoard> promList() {
		return sqlSession.selectList("managerMapper.mainPromList");
	}
	
	
	

	
}
