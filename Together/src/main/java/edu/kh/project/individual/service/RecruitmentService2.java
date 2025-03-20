package edu.kh.project.individual.service;

import java.util.List;

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


	

}
