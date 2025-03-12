package edu.kh.project.manager.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int customerQuestionCount() {
		return sqlSession.selectOne("customerQuestionCount");
	}

	public int brandQuestCount() {
		return sqlSession.selectOne("brandQuestCount");
	}

	
}
