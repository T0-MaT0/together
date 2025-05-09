package edu.kh.project.individual.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.common.model.dto.PointHistory;
import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Member;

public interface RecruitmentService {

	// 개인 공동구매 모집방 페이지(최신순).
	List<Recruitment> selectRecruitmentList(int memberNo);

	// 개인 공동구매 모집방 페이지(조회수순).
	List<Recruitment> selectRecruitmentListByViewCount(int memberNo);

	// 내 모집 중 현황.
	List<Recruitment> getMyRecruitmentList(int memberNo, String key);

	// 내 댓글 조회.
	List<Reply> getMyRecruitmentComments(int memberNo);

	// 내 리뷰 조회.
	List<Review> getMyRecruitmentReviews(int memberNo);
	
	// 조회수 증가.
	void increaseReadCount(int recruitmentNo);

	// 모집방 내용 상세 조회.
	Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int memberNo);

	// 모집글 작성.
	int createRecruitment(Recruitment dto, List<MultipartFile> images, int memberNo, String webPath, String filePath) throws Exception;
	
	// 포인트 수정.
	void updateMemberPoint(int memberNo, int updatedPoint);
	
	// 포인트 사용 내역 인서트.
	void insertPointUsage(PointHistory pointHistory);

	// 모집글 수정.
	int updateRecruitment(Map<String, Object> paramMap, List<MultipartFile> imageList) throws Exception;

	// 참여 폼 제출.
	int participateRecruitment(int memberNo, int recruitmentNo, int myQuantity, int paymentAmount, int point) throws Exception;

	// 현재 포인트 조회.
	int selectMemberPoint(int memberNo);
	
	// 후기 작성 여부.
	boolean checkIfUserReviewed(int recruitmentNo, int memberNo);
	
	// 포인트 사용 내역 조회.
	int selectUsedAmount(int recruitmentNo, int memberNo, String pointType);
	
	// POINT_USAGE 상태 '취소'로 변경.
	void updatePointUsageStatusToCancel(int recruitmentNo, int memberNo, String usageType);

	// 모집글 삭제.
	int softDeleteRecruitment(int recruitmentNo);
	
	// 모집장이 모집 마감.
	int updateRecruitmentStatusToClosed(int recruitmentNo);
	
	// 모집 인증 폼 등록.
	int registerVerificationFormWithQr(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate, String realPath, String webPath) throws Exception;
	
	// 모집 인증 폼 수정.
	int updateVerificationForm(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate);
	
	// 참가 취소.
	int deleteParticipation(int memberNo, int recruitmentNo);

	// 신고제출. 
	int insertReport(Report report);
	
	// 참가자 중복검사.
	boolean verifyParticipant(int recruitmentNo, String token, int memberNo);

	// 모집장 정보 조회.
	Member selectHostInfo(int recruitmentNo);

	// 리뷰 등록.
	int insertReview(Review review);

	// 구매 확정.
	int updatePointUsageToComplete(int recruitmentNo, int memberNo);
	
	// 모집방 상태 변경 및 중복체크.
	void checkAndUpdateRecruitmentComplete(int recruitmentNo);

	// 맴버 등급 업데이트.
	void updateMemberGradeByReview(int memberNo);



	



	
	
	

	

}
