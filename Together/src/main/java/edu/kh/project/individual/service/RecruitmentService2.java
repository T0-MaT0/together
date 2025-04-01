package edu.kh.project.individual.service;

import java.util.List;

import edu.kh.project.common.model.dto.Reply;

public interface RecruitmentService2 {

	// 모집글 상태 변경(모집장 memberNo 조회)
	int getHostMemberNo(int boardNo);
	
	// 모집글 상태 변경
	void updateRecruitmentStatus(int boardNo);

	// 모집글 삭제 변경
	void deleteRecruitment(int boardNo);

	// 선택 댓글 삭제
	boolean deleteComments(List<Integer> replyNos);

	// 선택 리뷰 삭제
	boolean deleteReviews(List<Integer> reviewNos);

	// 모집글 상세 댓글 등록 
	int insertReply(Reply replyDTO);

	// 댓글 삭제
	int deleteReply(int replyNo, int memberNo);

	// 게시글 삭제(관리자)
	int deleteBoard(int boardNo);


	

}
