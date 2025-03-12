package edu.kh.project.business.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.business.model.dto.Business;

@Repository
public class BusinessDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount(Map<String, Object> paramMap) {
		return sqlSession.selectOne("boardMapper.getListCount", paramMap);
	}

	public List<Business> selectBusinessList(Map<String, Object> paramMap) {
		return sqlSession.selectList("boardMapper.selectBusinessList", paramMap);
	}
}
