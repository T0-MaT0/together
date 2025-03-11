package edu.kh.project.business.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BusinessDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
}
