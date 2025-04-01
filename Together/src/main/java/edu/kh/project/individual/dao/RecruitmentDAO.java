package edu.kh.project.individual.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

    // 공동구매 모집방 목록 조회 (BOARD_CD = 1인 글만)
    public List<Recruitment> selectRecruitmentList(Map<String, Object> paramMap) {
        return sqlSession.selectList("recruitmentMapper.selectRecruitmentList", paramMap);
    }

    // 현재 참가자 수 조회
    public int countParticipants(int recruitmentNo) {
        return sqlSession.selectOne("recruitmentMapper.countParticipants", recruitmentNo);
    }

    // 상품 이미지 조회
    public String selectProductImage(int boardNo) {
        return sqlSession.selectOne("recruitmentMapper.selectProductImage", boardNo);
    }
	
	/** 모집방 상세 조회
	 * @param recruitmentNo
	 * @return 
	 */
	public Recruitment selectRecruitmentDetail(int recruitmentNo) {
		return sqlSession.selectOne("recruitmentMapper.selectRecruitmentDetail", recruitmentNo);
	}

	/** 조회순 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Recruitment> selectRecruitmentListByViewCount(Map<String, Object> paramMap) {
		return sqlSession.selectList("recruitmentMapper.selectRecruitmentListByViewCount", paramMap);
	}

	/** 이미지 리스트 조회
	 * @param recruitmentNo
	 * @return
	 */
	public List<Image> selectAllBannerImages() {
	    return sqlSession.selectList("recruitmentMapper.selectAllBannerImages");
	}

	/** 내 모집 중 현황
	 * @param paramMap
	 * @return
	 */
	public List<Recruitment> selectMyRecruitmentList(Map<String, Object> paramMap) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentList", paramMap);
	}

	
	/** 내 댓글 조회
	 * @param memberNo
	 * @return
	 */
	public List<Reply> selectMyRecruitmentComments(int memberNo) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentComments", memberNo);
	}

	/** 내 리뷰 조회
	 * @param memberNo
	 * @return
	 */
	public List<Review> selectMyRecruitmentReviews(int memberNo) {
		return sqlSession.selectList("recruitmentMapper.selectMyRecruitmentReviews", memberNo);	
	}

	/** 모집방 상세 내용 조회
	 * @param recruitmentNo
	 * @return
	 */
	public Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int boardNo, int memberNo) {
		 	Map<String, Object> paramMap = new HashMap<>();
		    paramMap.put("recruitmentNo", recruitmentNo);
		    paramMap.put("boardNo", boardNo);
		    paramMap.put("memberNo", memberNo);
		return sqlSession.selectOne("recruitmentMapper.selectRecruitmentRoomDetail", paramMap);
	}

	/** 모집글 작성(board)
	 * @param board
	 * @return
	 */
	public int insertBoard(Board board) {
		int result = sqlSession.insert("recruitmentMapper.insertBoard", board);
        if(result>0) return board.getBoardNo(); 
        return 0;
	}

	/** 모집글 작성(product)
	 * @param product
	 * @return
	 */
	public int insertProduct(Recruitment product) {
		return sqlSession.insert("recruitmentMapper.insertProduct", product);
	}

	/** 모집글 작성(recruitmentRoom)
	 * @param room
	 * @return
	 */
	public int insertRecruitmentRoom(Recruitment room) {
		int result = sqlSession.insert("recruitmentMapper.insertRoom", room);
        if(result>0) return room.getRecruitmentNo();
        return 0;
	}

	/** 모집글 작성(participant)
	 * @param part
	 * @return
	 */
	public int insertParticipant(Recruitment part) {
		return sqlSession.insert("recruitmentMapper.insertParticipant", part);
	}

	/** 모집글 작성(img)
	 * @param uploadList
	 * @return
	 */
	public int insertImgList(List<Image> uploadList) {
		return sqlSession.insert("recruitmentMapper.insertImageList", uploadList);
	}

	/** 내가 차지한 수량 조회
	 * @param recruitmentNo
	 * @param memberNo
	 * @return
	 */
	public int selectMyParticipationCount(int recruitmentNo, int memberNo) {
	 	Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("recruitmentNo", recruitmentNo);
	    paramMap.put("memberNo", memberNo);

	    return sqlSession.selectOne("recruitmentMapper.selectMyParticipationCount", paramMap);
	}

	
	/** 게시글 (BOARD) 테이블 업데이트
	 * @param paramMap
	 * @return
	 */
	public int updateBoard(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateBoard", paramMap);
	}

	/** 모집방 (RECRUITMENT_ROOM) 테이블 업데이트
	 * @param paramMap
	 * @return
	 */
	public int updateRecruitment(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateRecruitment", paramMap);
	}

	/** 참여 수량 업데이트
	 * @param paramMap
	 * @return
	 */
	public int updateMyQuantity(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateMyQuantity", paramMap);
	}

	/** 기존 이미지 삭제
	 * @param parseInt
	 * @return 
	 */
	public int deleteImage(int parseInt) {
		return sqlSession.delete("recruitmentMapper.deleteImage", parseInt);
		
	}

	/** 새로운 이미지 삽입
	 * @param image
	 */
	public void insertImage(Image image) {
		sqlSession.insert("recruitmentMapper.insertImage", image);
		
	}

	public int updateProduct(Map<String, Object> paramMap) {
		return sqlSession.update("recruitmentMapper.updateProduct", paramMap);
	}

	public Image selectImageInfo(int imgNo) {
		return sqlSession.selectOne("recruitmentMapper.selectImageInfo", imgNo);
	}

	
	/** 최대 참가자 수 조회
	 * @param recruitmentNo
	 * @return
	 */
	public int selectMaxParticipants(int recruitmentNo) {
	    return sqlSession.selectOne("recruitmentMapper.selectMaxParticipants", recruitmentNo);
	}

	/** 참여자 insert
	 * @param map
	 * @return
	 */
	public int insertRecruitmentParticipant(Map<String, Object> map) {
	    return sqlSession.insert("recruitmentMapper.insertRecruitmentParticipant", map);
	}

	/** 모집상태 변경
	 * @param recruitmentNo
	 */
	public void updateRecruitmentStatusToClosed(int recruitmentNo) {
	    sqlSession.update("recruitmentMapper.updateRecruitmentStatusToClosed", recruitmentNo);
	}

	
	/** member 포인트 차감
	 * @param pointMap
	 * @return
	 */
	public int updateMemberPoint(Map<String, Object> pointMap) {
		return sqlSession.update("recruitmentMapper.updateMemberPoint", pointMap);
	}

	
	/** 포인트 사용 내역
	 * @param usageMap
	 */
	public void insertPointUsage(Map<String, Object> usageMap) {
		sqlSession.insert("recruitmentMapper.insertPointUsage", usageMap);
		
	}

	
	/** 현재 포인트 조회
	 * @param memberNo
	 * @return
	 */
	public int selectMemberPoint(int memberNo) {
		return sqlSession.selectOne("recruitmentMapper.selectMemberPoint", memberNo);
	}


	/** 참가 취소
	 * @param memberNo
	 * @param recruitmentNo
	 * @return
	 */
	public int deleteRecruitmentParticipant(int memberNo, int recruitmentNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("memberNo", memberNo);
	    map.put("recruitmentNo", recruitmentNo);
	    return sqlSession.delete("recruitmentMapper.deleteRecruitmentParticipant", map);
	}

	/** 모집글 삭제 
	 * @param boardNo
	 * @return
	 */
	public int updateBoardDelFl(int boardNo) {
		return sqlSession.update("recruitmentMapper.updateBoardDelFl", boardNo);
	}

	/** 모집 마감시키기
	 * @param recruitmentNo
	 * @return
	 */
	public int updateRecruitmentStatus(int recruitmentNo) {
		return sqlSession.update("recruitmentMapper.updateRecruitmentStatus2", recruitmentNo);
	}
 

	/** 모집 인증 폼 만들기
	 * @param map
	 * @return
	 */
	public int updateVerificationFormWithQr(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updateVerificationFormWithQr", map);
	}

	/** 모집 인증 폼 수정
	 * @param map
	 * @return
	 */
	public int updateVerificationForm(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updateVerificationForm", map);
	}

	public int checkTokenValid(int recruitmentNo, String token) {
		 Map<String, Object> params = new HashMap<>();
        params.put("recruitmentNo", recruitmentNo);
        params.put("token", token);

        return sqlSession.selectOne("recruitmentMapper.checkTokenValid", params);
	}

	public void updateCertStatus(int recruitmentNo, String token, int memberNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("recruitmentNo", recruitmentNo);
        params.put("token", token);
        params.put("memberNo", memberNo);

        sqlSession.update("recruitmentMapper.updateCertStatus", params);
		
	}

	// 신고 제출
	public int insertReport(Report report) {
		return sqlSession.insert("recruitmentMapper.insertReport", report);
	}

	// 모집장 정보 조회
	public Member selectHostInfo(int recruitmentNo) {
		return sqlSession.selectOne("recruitmentMapper.selectHostInfo", recruitmentNo);
	}

	// 리뷰 작성
	public int insertReview(Review review) {
		return sqlSession.insert("recruitmentMapper.insertReview", review);
	}

	// 후기 작성여부
	public boolean checkIfUserReviewed(Map<String, Object> map) {
	    int count = sqlSession.selectOne("recruitmentMapper.checkIfUserReviewed", map);
	    return count > 0;
	}

	// 맴버 등급 업데이트
	public void updateMemberGradeByReview(int memberNo) {
		double avg = sqlSession.selectOne("recruitmentMapper.selectAverageReviewStar", memberNo);

	    Map<String, Object> map = new HashMap<>();
	    map.put("memberNo", memberNo);
	    map.put("avg", avg);

	    sqlSession.update("recruitmentMapper.updateMemberGrade", map);
	}

	// 구매 확정
	public int updatePointUsageToComplete(Map<String, Object> map) {
		return sqlSession.update("recruitmentMapper.updatePointUsageToComplete", map);
	}

	// 모두 구매 확정인지 체크
	public int selectIncompletePointUsageCount(int recruitmentNo) {
		return sqlSession.selectOne("recruitmentMapper.selectIncompletePointUsageCount", recruitmentNo);
	}

	// 모집방 상태 변경
	public void updateRecruitmentStatusToComplete(int recruitmentNo) {
		sqlSession.update("recruitmentMapper.updateRecruitmentStatusToComplete", recruitmentNo);
	}

	// 포인트 변경
	public void updateMemberPoint2(Map<String, Object> map) {

		sqlSession.update("recruitmentMapper.updateMemberPoint2", map);
	}

	// 포인트 사용내역 입력
	public void insertPointUsage(PointUsage pointUsage) {
		sqlSession.insert("recruitmentMapper.insertPointUsage2", pointUsage);		
	}

	// 포인트 사용내역 조회
	public int selectUsedAmount(Map<String, Object> map) {
		return sqlSession.selectOne("recruitmentMapper.selectUsedAmount", map);
	}
	
	// POINT_USAGE 상태 '취소'로 변경
	public void updatePointUsageStatusToCancel(Map<String, Object> map) {
		sqlSession.update("recruitmentMapper.updatePointUsageStatusToCancel", map);		
	}

	
	// 조회수 증가
	public void increaseReadCount(int boardNo) {
		sqlSession.update("recruitmentMapper.increaseReadCount", boardNo);
		
	}

	
	
}
