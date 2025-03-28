package edu.kh.project.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.main.dao.MainDAO;
@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainDAO dao;
	
    @Override
    public List<Recruitment> selectRecruitmentList(int boardCode, int memberNo) {
    	Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("memberNo", memberNo);

        List<Recruitment> recruitments = dao.selectRecruitmentList(paramMap);
        
        
        
        List<Image> bannerImages = dao.selectAllBannerImages();
        
        List<Image> mainBannerList = new ArrayList<>();
        for (Image img : bannerImages) {
            if (img.getImageType() == 6 && img.getImageTypeNo() == 1) { // 메인 배너 조건
                mainBannerList.add(img); // 리스트에 추가
            }
        }
        
        // 참가자 수 설정
        for (Recruitment recruitment : recruitments) {
            int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
            recruitment.setCurrentParticipants(currentParticipants);

            recruitment.setMainBannerList(mainBannerList);
        }
        return recruitments;
    }

	@Override
	public Map<String, Object> selectBusinessList(int boardCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Business> businessNewList = dao.selectBusinessNewList(boardCode);
		
		List<Business> businessHotList = dao.selectBusinessHotList(boardCode);
		
		map.put("businessHotList", businessHotList);
		map.put("businessNewList", businessNewList);
		return map;
	}

}
