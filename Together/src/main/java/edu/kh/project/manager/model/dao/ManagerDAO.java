package edu.kh.project.manager.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Member;

@Repository
public class ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	// ** MAIN ***
	/** 고객 문의 수 조회
	 * @return
	 */
	public int customerQuestionCount() {
		return sqlSession.selectOne("managerMapper.customerQuestionCount");
	}
	
	/** 고객 신고 수 조회
	 * @return
	 */
	public int cusReportListCount() {
		return sqlSession.selectOne("managerMapper.reportListCount");
	}

	/** 브랜드 제휴 문의 수 조회
	 * @return
	 */
	public int brandQuestCount() {
		return sqlSession.selectOne("managerMapper.brandQuestCount");
	}

	/** 브랜드 광고 문의 수 조회
	 * @return
	 */
	public int brandAdCount() {
		return sqlSession.selectOne("managerMapper.brandAdCount");
	}

	/** 브랜드 대상 신고 수 조회
	 * @return
	 */
	public int brandReportCount() {
		return sqlSession.selectOne("managerMapper.brandReportCount");
	}
	
	/** 브랜드 상품 수 조회
	 * @return
	 */
	public int productCount() {
		
		return sqlSession.selectOne("managerMapper.goodsCount");
	}
	
	/** 고객 모집글 수 조회
	 * @return
	 */
	public int customerboardCount() {
		return sqlSession.selectOne("managerMapper.customerboardCount");
	}

	// ==== MAIN END ====
	
	
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
	
	
	
	/// --------------------고객 관리 메인 페이지----------------------------///
	/** 총 회원 수
	 * @return
	 */
	public int customerTotalCount() {
		return sqlSession.selectOne("managerMapper.customerTotalCount");
	}

	/** 신규 가입 수
	 * @return
	 */
	public int customerNewCount() {
		return sqlSession.selectOne("managerMapper.newCustomerCount");
	}

	/**탈퇴 회원 수
	 * @return
	 */
	public int customerOutCount() {
		return sqlSession.selectOne("managerMapper.customerOutCount");
	}

	/** 블랙 수
	 * @return
	 */
	public int customerBlackCount() {
		return sqlSession.selectOne("managerMapper.customerBlackCount");
	}

	/** 고객 목록 조회
	 * @return
	 */
	public List<Member> customerStateList() {
		RowBounds rowBounds = new RowBounds(0, 5);
		return sqlSession.selectList("managerMapper.customerStateList", null, rowBounds);
	}

	/** 총 공구 모집 수
	 * @return
	 */
	public int GatherTotalCount() {
		return sqlSession.selectOne("managerMapper.totalCustomerBoard");
	}

	/** 성사된 모집
	 * @return
	 */
	public int GatherSuccessCount() {
		return sqlSession.selectOne("managerMapper.GatherSuccessCount");
	}

	/** 취소된 모집
	 * @return
	 */
	public int GatherCancelCount() {
		return sqlSession.selectOne("managerMapper.GatherCancelCount");
	}

	/**정지된 모집
	 * @return
	 */
	public int GatherStopCount() {
		return sqlSession.selectOne("managerMapper.GatherStopCount");
	}

	/** 총 문의 개수
	 * @return
	 */
	public int questTotalCount() {
		return sqlSession.selectOne("managerMapper.questListCount");
	}

	/**미처리 문의
	 * @return
	 */
	public int questWaitCount() {
		char fl = 'N';
		return sqlSession.selectOne("managerMapper.questWaitCount", fl);
	}

	/**처리 문의
	 * @return
	 */
	public int questAcceptCount() {
		char fl = 'Y';
		return sqlSession.selectOne("managerMapper.questWaitCount", fl);
	}

	/** 미처리 고객 신고 수
	 * @param customerReport 
	 * @return
	 */
	public int customerWaitReport(String customerReport) {
		
		String str = "'대기'";
		
		Map<String, Object> map = new HashMap<>();
		map.put("str", str);
		map.put("customerReport", customerReport);
		return sqlSession.selectOne("managerMapper.customerWaitDoneReport", map);
	}

	/** 처리 고객 신고 수
	 * @param customerReport 
	 * @return
	 */
	public int customerDoneReport(String customerReport) {
		String str = "'처리 완료', '반려', '블랙', '경고'";
		Map<String, Object> map = new HashMap<>();
		map.put("str", str);
		map.put("customerReport", customerReport);
		return sqlSession.selectOne("managerMapper.customerWaitDoneReport", map);
	}

	/** 모집글 신고 미처리 수
	 * @param customerReport
	 * @return
	 */
	public int gatherWaitReport(String customerReport) {
		String str = "'대기'";
		
		Map<String, Object> map = new HashMap<>();
		map.put("str", str);
		map.put("customerReport", customerReport);
		return sqlSession.selectOne("managerMapper.customerWaitDoneReport", map);
	}

	/** 모집글 신고 처리 수
	 * @param customerReport
	 * @return
	 */
	public int gatherDoneReport(String customerReport) {
		String str = "'처리 완료', '반려', '블랙', '경고'";
		Map<String, Object> map = new HashMap<>();
		map.put("str", str);
		map.put("customerReport", customerReport);
		return sqlSession.selectOne("managerMapper.customerWaitDoneReport", map);
	}

	/**고객 신고 리스트 목록 조회
	 * @return
	 */
	public List<Report> customerReportFourList() {
		RowBounds rowBounds = new RowBounds(0, 5);
		return sqlSession.selectList("managerMapper.reportSelect", null ,rowBounds);
	}

	/**모집글 신고 리스트 목록 조회
	 * @return
	 */
	public List<Report> gatherReportFourList() {
		RowBounds rowBounds = new RowBounds(4, 5);
		return sqlSession.selectList("managerMapper.reportSelect", null ,rowBounds);
	}

	//--------------------------------------------------
	/** 그래프 7일 조회
	 * @return
	 */
	public Map<String, Object> graphWeek() {
		return sqlSession.selectOne("managerMapper.graphWeek");
	}

	/**개인 회원 수 조회
	 * @return
	 */
	public List<Number> dayCustomerCount() {
		int authority = 2;
		return sqlSession.selectList("managerMapper.dayCount", authority);
	}

	public List<Number> dayBrandCount() {
		int authority = 3;
		return sqlSession.selectList("managerMapper.dayCount", authority);
	}

	/** 미처리 제휴 수
	 * @return
	 */
	public int notPassApplyCount() {
		int boardCd = 8;
		return sqlSession.selectOne("managerMapper.notPassBrandCount", boardCd);
	}

	public int brandAddCount() {
		int boardCd = 7;
		return sqlSession.selectOne("managerMapper.notPassBrandCount", boardCd);
	}

	/** 브랜드 대상 신고 대기 수
	 * @return
	 */
	public int waitCount() {
		return sqlSession.selectOne("managerMapper.watiCount");
	}

	/** 개인 대상 신고 대기 수
	 * @return
	 */
	public int cusWaitCount() {
		return sqlSession.selectOne("managerMapper.waitCustReportCount");
	}






	
	
	

	
}
