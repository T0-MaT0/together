package edu.kh.project.manager.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;

@Repository
public class ManageCustomerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 고객 상태 목록 수
	 * @return
	 */
	public int customerStateCount() {
		return sqlSession.selectOne("managerMapper.customerStateCount");
	}
	
	
	/** 고객 상태 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> customerStateList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.customerStateList", null, rowBounds);
	}
	
	/** 총 회원 수 조회
	 * @return
	 */
	public int customerTotal() {
		return sqlSession.selectOne("managerMapper.customerTotal");
	}
	
	
	/** 신규 회원 수
	 * @return
	 */
	public int newCustomerCount() {
		return sqlSession.selectOne("managerMapper.newCustomerCount");
	}


	/** 기존 회원, 블랙, 탈퇴 회원 수
	 * @return
	 */
	public List<Map<String, Object>> CustomersSelect() {
		
		return sqlSession.selectList("managerMapper.CustomersSelect");
	}
	
	
	//-----------------------------------------------------------------------
	
	/** 고객 모집글 목록 수
	 * @return
	 */
	public int customerboardCount() {
		return sqlSession.selectOne("managerMapper.customerboardCount");
	}

	/** 고객 모집글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> boardList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.boardList", null, rowBounds);
	}

	
	/** 총 진행 중인 모집글 수
	 * @return
	 */
	public int totalCustomerBoard() {
		return sqlSession.selectOne("managerMapper.totalCustomerBoard");
	}
	
	
	/** 마감, 진행, 완료 , 정지
	 * @return
	 */
	public List<Map<String, Object>> cusBoardStateCount() {
		return sqlSession.selectList("managerMapper.cusBoardStateCount");
	}
	
	//-------------------------------------------------------------------------
	/** 고객 문의 목록 수
	 * @return
	 */
	public int questSelect() {
		return sqlSession.selectOne("managerMapper.questListCount");
	}
	
	/** 고객 문의 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QuestCustomer> questList(Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("managerMapper.questList", null, rowBounds );
	}

	
	/** 고객 대상 신고 수
	 * @return
	 */
	public int reportListCount() {
		return sqlSession.selectOne("managerMapper.reportListCount");
	}
	
	/** 고객 대상 신고 목록 조회
	 * @param cp 
	 * @return
	 */
	public List<Report> reportList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("managerMapper.reportSelect", null, rowBounds );
	}























	
	
	
}
