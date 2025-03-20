package edu.kh.project.main.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;

@Repository
public class MainDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

    // 공동구매 모집방 목록 조회 (BOARD_CD = 1인 글만)
    public List<Recruitment> selectRecruitmentList(Map<String, Object> paramMap) {
        return sqlSession.selectList("mainMapper.selectRecruitmentList", paramMap);
    }

    // 현재 참가자 수 조회
    public int countParticipants(int recruitmentNo) {
        return sqlSession.selectOne("mainMapper.countParticipants", recruitmentNo);
    }

    /** 이미지 리스트 조회
	 * @param recruitmentNo
	 * @return
	 */
	public List<Image> selectAllBannerImages() {
	    return sqlSession.selectList("mainMapper.selectAllBannerImages");
	}
	

	public List<Business> selectBusinessNewList(int boardCode) {
		return sqlSession.selectList("mainMapper.selectBusinessNewList", boardCode);
	}
	
	public List<Business> selectBusinessHotList(int boardCode) {
		return sqlSession.selectList("mainMapper.selectBusinessHotList", boardCode);
	}

}
