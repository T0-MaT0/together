package edu.kh.project.main.dao;

import java.util.List;

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

	// 개인 공동구매 모집글 조회 
	public List<Recruitment> selectRecruitmentList(int memberNo) {
	    return sqlSession.selectList("mainMapper.selectRecruitmentList", memberNo);
	}

    // 현재 참가자 수 조회
    public int countParticipants(int recruitmentNo) {
        return sqlSession.selectOne("mainMapper.countParticipants", recruitmentNo);
    }

    // 메인 배너 이미지 목록 조회(타입이 AD_BANNER, 타입 넘버가 1)
	public List<Image> selectMainBannerImages() {
	    return sqlSession.selectList("mainMapper.selectMainBannerImages");
	}
	
	// 최신순 상품 조회
	public List<Business> selectBusinessNewList() {
	    return sqlSession.selectList("mainMapper.selectBusinessNewList");
	}

	// 조회수 기준 인기 상품 조회
	public List<Business> selectBusinessHotList() {
	    return sqlSession.selectList("mainMapper.selectBusinessHotList");
	}

}
