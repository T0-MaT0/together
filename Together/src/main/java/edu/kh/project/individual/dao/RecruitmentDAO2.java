package edu.kh.project.individual.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Reply;

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

	// 모집글 삭제 변경
	public void deleteRecruitment(int boardNo) {
		sqlSession.update("recruitmentMapper.deleteRecruitment", boardNo);
		
	}

	// 선택 댓글 삭제
	public int updateReplyStatus(List<Integer> replyNos) {
		 Map<String, Object> paramMap = new HashMap<>();
	     paramMap.put("replyNos", replyNos);
	     return sqlSession.update("recruitmentMapper.updateReplyStatus", paramMap);
	}

	// 선택 리뷰 삭제
	public int deleteReviews(List<Integer> reviewNos) {
		return sqlSession.update("recruitmentMapper.deleteReviews", reviewNos);
	}

	// 모집글 상세 댓글 등록
	public int insertReply(Reply replyDTO) {
		return sqlSession.insert("recruitmentMapper.insertReply", replyDTO);
	}

	// 댓글 삭제
	public int deleteReply(int replyNo, int memberNo) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("replyNo", replyNo);
        paramMap.put("memberNo", memberNo);
        
		return sqlSession.update("recruitmentMapper.deleteReply", paramMap);
	}

	// 게시글 삭제
	public int deleteBoard(int boardNo) {
		return sqlSession.update("recruitmentMapper.deleteBoard", boardNo);
	}

	


}
