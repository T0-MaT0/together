package edu.kh.project.individual.service;

import java.util.List;

import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.individual.dto.Recruitment;

public interface RecruitmentService {

	// 공동구매 모집글 조회 (BOARD_CD = 1인 글만) ,최신글
    List<Recruitment> selectRecruitmentList(int boardCode, int memberNo);

	// 모집방 상세 조회
	Recruitment selectRecruitmentDetail(int recruitmentNo);

	// 조회순 글
	List<Recruitment> selectRecruitmentListByViewCount(int boardCode, int memberNo);

	// 내 모집 중 현황
	List<Recruitment> getMyRecruitmentList(Integer memberNo, String key);

	// 내 댓글 조회
	List<Reply> getMyRecruitmentComments(int memberNo);

	// 내 리뷰 조회
	List<Review> getMyRecruitmentReviews(int memberNo);

	// 모집방 내용 상세 조회
	Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int boardNo);

}
