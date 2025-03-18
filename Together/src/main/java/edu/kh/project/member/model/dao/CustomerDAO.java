package edu.kh.project.member.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.member.model.dto.Board;

@Repository
public class CustomerDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;

	public List<Board> selectNoticeBoardList() {
		return sqlSession.selectList("customerMapper.selectNoticeBoardList");
	}

	public List<Board> selectFAQBoardList() {
		return sqlSession.selectList("customerMapper.selectFAQBoardList");
	}
}
