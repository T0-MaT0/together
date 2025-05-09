package edu.kh.project.individual.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.PointHistory;
import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Member;

@Repository
public class RecruitmentDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

    // 공동구매 모집방 목록 조회(최신순).
	public List<Recruitment> selectRecruitmentList(int memberNo) {
	    return sqlSession.selectList("recruitmentMapper.selectRecruitmentList", memberNo);
	}

    // 현재 참가자 수 조회.
    public int countParticipants(int recruitmentNo) {
        return sqlSession.selectOne("recruitmentMapper.countParticipants", recruitmentNo);
    }
    
    // 메인 배너 조회. 
	public List<Image> selectAllBannerImages() {
	    return sqlSession.selectList("recruitmentMapper.selectAllBannerImages");
	}

	// 개인 공동구매 모집방 페이지(조회수순).
	public List<Recruitment> selectRecruitmentListByViewCount(int memberNo) {
	    return sqlSession.selectList("recruitmentMapper.selectRecruitmentListByViewCount", memberNo);
	}

	// 내 모집 중 현황 조회.
	public List<Recruitment> selectMyRecruitmentList(Map<String, Object> paramMap) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentList", paramMap);
	}

	
	// 내 댓글 조회.
	public List<Reply> selectMyRecruitmentComments(int memberNo) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentComments", memberNo);
	}

	// 내 리뷰 조회.
	public List<Review> selectMyRecruitmentReviews(int memberNo) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentReviews", memberNo);	
	}
	
	// 조회수 증가.
	public void increaseReadCount(int recruitmentNo) {
		sqlSession.update("recruitmentMapper.increaseReadCount", recruitmentNo);
		
	}

	// 모집방 상세 내용 조회.
	public Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int memberNo) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("recruitmentNo", recruitmentNo);
	    paramMap.put("memberNo", memberNo);

	    return sqlSession.selectOne("recruitmentMapper.selectRecruitmentRoomDetail", paramMap);
	}
	
	// 내가 차지한 수량 조회.
	public int selectMyParticipationCount(int recruitmentNo, int memberNo) {
	 	Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("recruitmentNo", recruitmentNo);
	    paramMap.put("memberNo", memberNo);

	    return sqlSession.selectOne("recruitmentMapper.selectMyParticipationCount", paramMap);
	}

	// 1) PRODUCT 테이블 INSERT.
	public int insertProduct(Recruitment product) {
		return sqlSession.insert("recruitmentMapper.insertProduct", product);
	}

	// 2) RECRUITMENT_ROOM 테이블 INSERT.
	public int insertRecruitmentRoom(Recruitment room) {
		int result = sqlSession.insert("recruitmentMapper.insertRoom", room);
        if(result>0) return room.getRecruitmentNo();
        return 0;
	}

	// 3) 방장 참가자 등록.
	public int insertParticipant(Recruitment part) {
		return sqlSession.insert("recruitmentMapper.insertParticipant", part);
	}

	// 4) 이미지 업로드 -> IMG 테이블.
	public int insertImgList(List<Image> uploadList) {
		return sqlSession.insert("recruitmentMapper.insertImageList", uploadList);
	}
	
	// 포인트 변경.
	public void updateMemberPoint2(Map<String, Object> map) {

		sqlSession.update("recruitmentMapper.updateMemberPoint2", map);
	}
	
	// 포인트 사용 내역 인서트.
	public void insertPointUsage(PointHistory pointHistory) {
	    sqlSession.insert("recruitmentMapper.insertPointUsage", pointHistory);
	}

	// 1. 모집방 정보 수정.
	public int updateRecruitment(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateRecruitment", paramMap);
	}
	
	// 2. 상품 정보 수정.
	public int updateProduct(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateProduct", paramMap);
	}

	// 3. 내 참여 수량 수정.
	public int updateMyQuantity(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateMyQuantity", paramMap);
	}
	
	// 선택한 이미지 정보.
	public Image selectImageInfo(int imgNo) {
		return sqlSession.selectOne("recruitmentMapper.selectImageInfo", imgNo);
	}

	// 4. 이미지 삭제.
	public int deleteImage(int parseInt) {
		return sqlSession.delete("recruitmentMapper.deleteImage", parseInt);
		
	}

	// 5. 이미지 등록.
	public void insertImage(Image image) {
		sqlSession.insert("recruitmentMapper.insertImage", image);
		
	}
	
	// 1. 포인트 차감.
	public int updateMemberPoint(Map<String, Object> pointMap) {
		return sqlSession.update("recruitmentMapper.updateMemberPoint", pointMap);
	}
	
	// 2. RECRUITMENT_PARTICIPANT 테이블에 insert.
	public int insertRecruitmentParticipant(Map<String, Object> map) {
		return sqlSession.insert("recruitmentMapper.insertRecruitmentParticipant", map);
	}
	
	// 4. 최대 인원 조회.
	public int selectMaxParticipants(int recruitmentNo) {
	    return sqlSession.selectOne("recruitmentMapper.selectMaxParticipants", recruitmentNo);
	}

	// 5.모집상태 변경.
	public void updateRecruitmentStatusToClosed(int recruitmentNo) {
	    sqlSession.update("recruitmentMapper.updateRecruitmentStatusToClosed", recruitmentNo);
	}
	
	// 현재 포인트 조회.
	public int selectMemberPoint(int memberNo) {
		return sqlSession.selectOne("recruitmentMapper.selectMemberPoint", memberNo);
	}
	
	// 후기 작성여부.
	public boolean checkIfUserReviewed(Map<String, Object> map) {
	    int count = sqlSession.selectOne("recruitmentMapper.checkIfUserReviewed", map);
	    return count > 0;
	}
	
	// 포인트 사용내역 조회.
	public int selectUsedAmount(Map<String, Object> map) {
		return sqlSession.selectOne("recruitmentMapper.selectUsedAmount", map);
	}
	
	// POINT_USAGE 상태 '취소'로 변경.
	public void updatePointUsageStatusToCancel(Map<String, Object> map) {
		sqlSession.update("recruitmentMapper.updatePointUsageStatusToCancel", map);		
	}

	// 모집글 삭제.
	public int softDeleteRecruitment(int recruitmentNo) {
		return sqlSession.update("recruitmentMapper.softDeleteRecruitment", recruitmentNo);
	}

	// 모집장이 모집 마감.
	public int updateRecruitmentStatus(int recruitmentNo) {
		return sqlSession.update("recruitmentMapper.updateRecruitmentStatus2", recruitmentNo);
	}
	
	// 4-1. 배송 정보 업데이트.
	public int updateRecruitmentDelivery(Map<String, Object> deliveryMap) {
		return sqlSession.update("recruitmentMapper.updateRecruitmentDelivery", deliveryMap);
	}
	
	// 4-2. QR 인증 테이블 업데이트.
	public int updateVerificationFormWithQr(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updateVerificationFormWithQr", map);
	}
	
	// 모집 인증 폼 수정.
	public int updateVerificationForm(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updateVerificationForm", map);
	}
	
	// 참가 취소.
	public int deleteRecruitmentParticipant(int memberNo, int recruitmentNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("memberNo", memberNo);
	    map.put("recruitmentNo", recruitmentNo);
	    return sqlSession.delete("recruitmentMapper.deleteRecruitmentParticipant", map);
	}

	// 신고 제출.
	public int insertReport(Report report) {
		return sqlSession.insert("recruitmentMapper.insertReport", report);
	}
 
	// 토큰 유효성 확인.
	public int checkTokenValid(int recruitmentNo, String token) {
		 Map<String, Object> params = new HashMap<>();
        params.put("recruitmentNo", recruitmentNo);
        params.put("token", token);

        return sqlSession.selectOne("recruitmentMapper.checkTokenValid", params);
	}

	// 인증상태 업데이트.
	public void updateCertStatus(int recruitmentNo, String token, int memberNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("recruitmentNo", recruitmentNo);
        params.put("token", token);
        params.put("memberNo", memberNo);

        sqlSession.update("recruitmentMapper.updateCertStatus", params);
		
	}

	// 모집장 정보 조회.
	public Member selectHostInfo(int recruitmentNo) {
		return sqlSession.selectOne("recruitmentMapper.selectHostInfo", recruitmentNo);
	}

	// 리뷰 작성.
	public int insertReview(Review review) {
		return sqlSession.insert("recruitmentMapper.insertReview", review);
	}

	// 구매 확정.
	public int updatePointUsageToComplete(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updatePointUsageToComplete", map);
	}
	
	// 모두 구매 확정인지 체크.
	public int selectIncompletePointUsageCount(int recruitmentNo) {
		return sqlSession.selectOne("recruitmentMapper.selectIncompletePointUsageCount", recruitmentNo);
	}
	
	// 모집방 상태 변경.
	public void updateRecruitmentStatusToComplete(int recruitmentNo) {
		sqlSession.update("recruitmentMapper.updateRecruitmentStatusToComplete", recruitmentNo);
	}

	// 맴버 등급 업데이트.
	public void updateMemberGradeByReview(int memberNo) {
		double avg = sqlSession.selectOne("recruitmentMapper.selectAverageReviewStar", memberNo);

	    Map<String, Object> map = new HashMap<>();
	    map.put("memberNo", memberNo);
	    map.put("avg", avg);

	    sqlSession.update("recruitmentMapper.updateMemberGrade", map);
	}
	
}
