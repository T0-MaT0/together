package edu.kh.project.individual.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import edu.kh.project.individual.dao.RecruitmentDAO;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;

@Service
public class RecruitmentServiceImpl implements RecruitmentService{

	@Autowired
	private RecruitmentDAO dao;

	// 공동구매 모집방 목록 조회 (BOARD_CD = 1인 경우만)
    @Override
    public List<Recruitment> selectRecruitmentList(int boardCode, int memberNo) {
    	Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("memberNo", memberNo);

        List<Recruitment> recruitments = dao.selectRecruitmentList(paramMap);
        List<Image> bannerImages = dao.selectAllBannerImages();
        
        List<Image> mainBannerList = new ArrayList<>();
        for (Image img : bannerImages) {
            if (img.getImageType() == 6 && img.getImageLevel() == 2) { // 메인 배너 조건
                mainBannerList.add(img); // 리스트에 추가
            }
        }
        
        // 참가자 수 설정
        for (Recruitment recruitment : recruitments) {
            int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
            recruitment.setCurrentParticipants(currentParticipants);
            
            recruitment.setImageList(bannerImages);
            recruitment.setMainBannerList(mainBannerList);
        }
        return recruitments;
    }

    // 개인 공동구매 모집방 상세 조회
    @Override
    public Recruitment selectRecruitmentDetail(int recruitmentNo) {
        return dao.selectRecruitmentDetail(recruitmentNo);
    }

    // 조회순 목록 조회
	@Override
	public List<Recruitment> selectRecruitmentListByViewCount(int boardCode, int memberNo) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("memberNo", memberNo);

        List<Recruitment> recruitments = dao.selectRecruitmentListByViewCount(paramMap);
        List<Image> bannerImages = dao.selectAllBannerImages();
        
        List<Image> mainBannerList = new ArrayList<>();
        for (Image img : bannerImages) {
            if (img.getImageType() == 6 && img.getImageLevel() == 2) { // 메인 배너 조건
                mainBannerList.add(img); // 리스트에 추가
            }
        }
        
        // 참가자 수 설정
        for (Recruitment recruitment : recruitments) {
            int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
            recruitment.setCurrentParticipants(currentParticipants);
            recruitment.setImageList(bannerImages);
            recruitment.setMainBannerList(mainBannerList);
        }

        return recruitments;
	}

	// 내 모집 중 현황 조회
	@Override
	public List<Recruitment> getMyRecruitmentList(Integer memberNo) {
		return dao.selectMyRecruitmentList(memberNo);
	}
	
}
