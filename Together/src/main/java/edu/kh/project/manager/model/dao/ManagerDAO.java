package edu.kh.project.manager.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	
}
