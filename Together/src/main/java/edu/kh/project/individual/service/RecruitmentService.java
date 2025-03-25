package edu.kh.project.individual.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

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
	Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int boardNo, int memberNo);

	// 모집글 작성
	int createRecruitment(Recruitment dto, List<MultipartFile> images, int memberNo, String webPath, String filePath) throws Exception;

	// 모집글 수정
	int updateRecruitment(Map<String, Object> paramMap, List<MultipartFile> imageList) throws Exception;

	// 참여 폼 제출
	int participateRecruitment(int memberNo, int recruitmentNo, int myQuantity, int paymentAmount, int point) throws Exception;

	// 현재 포인트 조회
	int selectMemberPoint(int memberNo);

	// 참가 취소
	int deleteParticipation(int memberNo, int recruitmentNo);

	// 모집글 삭제
	int softDeleteBoard(int boardNo);

	// 모집 마감시키기
	int updateRecruitmentStatusToClosed(int recruitmentNo);

	// 모집 인증 폼 만들기
	int registerVerificationFormWithQr(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate, String realPath, String webPath) throws Exception;

	// 모집 인증 폼 수정
	int updateVerificationForm(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate);

	boolean verifyParticipant(int recruitmentNo, String token);

}
