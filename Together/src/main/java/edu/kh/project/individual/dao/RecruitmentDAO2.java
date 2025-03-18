package edu.kh.project.individual.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RecruitmentDAO2 {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 모집글 상태 변경(모집장 memberNo 조회)
	public int getHostMemberNo(int boardNo) {
	    return sqlSession.selectOne("recruitmentMapper.getHostMemberNo", boardNo);
	}

	// 모집글 상태 변경
	public void updateRecruitmentStatus(int boardNo) {
		sqlSession.update("recruitmentMapper.updateRecruitmentStatus", boardNo);
	}

	


}
