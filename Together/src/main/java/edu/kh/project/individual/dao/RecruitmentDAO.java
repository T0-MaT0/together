package edu.kh.project.individual.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;

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

	
	
}
