package edu.kh.project.member.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.member.model.dto.Board;

@Repository
public class CustomerDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;

	public List<Board> selectNoticeBoardList() {
		return sqlSession.selectList("customerMapper.selectNoticeBoardList");
	}

	public List<Board> selectFAQBoardList(int boardCode) {
		return sqlSession.selectList("customerMapper.selectFAQBoardList", boardCode);
	}

	public int getListCount(int boardCode) {
	
		return sqlSession.selectOne("customerMapper.getListCount", boardCode);
	}


	public List<Board> selectboardList(int boardCode, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

		return sqlSession.selectList("customerMapper.selectboardList", boardCode, rowBounds);
	}

	public int getFAQAllListCount() {
		return sqlSession.selectOne("customerMapper.getFAQAllListCount");
	}

	public List<Board> allFAQList(Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

		return sqlSession.selectList("customerMapper.allFAQList", rowBounds);
	}

	public Board selectNoticeBoardDetail(int boardNo) {
		return sqlSession.selectOne("customerMapper.selectNoticeBoardDetail", boardNo);
	}

	public List<Board> selectBeforeAfterBoard(int boardNo) {
		return sqlSession.selectList("customerMapper.selectBeforeAfterBoard", boardNo);
	}


}
