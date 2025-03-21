package edu.kh.project.individual.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.individual.dao.RecruitmentDAO2;

@Service
public class RecruitmentServiceImpl2 implements RecruitmentService2{

	@Autowired
	private RecruitmentDAO2 dao;

	// 모집글 상태 변경(모집장 memberNo 조회)
	@Override
	public int getHostMemberNo(int boardNo) {
		return dao.getHostMemberNo(boardNo);
	}

	// 모집글 상태 변경
	@Override
	public void updateRecruitmentStatus(int boardNo) {
		dao.updateRecruitmentStatus(boardNo);
	}

	// 모집글 삭제 변경
	@Override
	public void deleteRecruitment(int boardNo) {
		dao.deleteRecruitment(boardNo);

	}

	// 선택 댓글 삭제
	@Override
	public boolean deleteComments(List<Integer> replyNos) {
		int updatedRows = dao.updateReplyStatus(replyNos);
        return updatedRows > 0; // 업데이트 성공 여부 반환
	}

	// 선택 리뷰 삭제
	@Override
	public boolean deleteReviews(List<Integer> reviewNos) {
		 int updatedRows = dao.deleteReviews(reviewNos);
	        return updatedRows > 0;
	}

	// 모집글 상세 댓글 등록
	@Override
	public int insertReply(Reply replyDTO) {
		return dao.insertReply(replyDTO);
	}

	// 댓글 삭제
	@Override
	public int deleteReply(int replyNo, int memberNo) {
		return dao.deleteReply(replyNo, memberNo);
	}

	
	
}
