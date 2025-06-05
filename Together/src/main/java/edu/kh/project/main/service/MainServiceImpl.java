package edu.kh.project.main.service;

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
	
	// 개인 공동구매 모집글 조회
	@Override
	public List<Recruitment> selectRecruitmentList(int memberNo) {
	    List<Recruitment> recruitments = dao.selectRecruitmentList(memberNo);

	    // 메인 배너 이미지 목록 조회(타입이 AD_BANNER, 타입 넘버가 1)
	    List<Image> mainBannerList = dao.selectMainBannerImages();

	    // 각 모집글에 참가자 수 및 배너 이미지 설정
	    for (Recruitment recruitment : recruitments) {
	        int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
	        recruitment.setCurrentParticipants(currentParticipants);
	        recruitment.setMainBannerList(mainBannerList);
	    }

	    return recruitments;
	}

	// 브랜드 상품 리스트 조회 
	@Override
	public Map<String, Object> selectBusinessList() {

	    Map<String, Object> map = new HashMap<>();

	    // 최신순 상품 조회
	    List<Business> businessNewList = dao.selectBusinessNewList();

	    // 조회수 기준 인기 상품 조회
	    List<Business> businessHotList = dao.selectBusinessHotList();

	    map.put("businessNewList", businessNewList);
	    map.put("businessHotList", businessHotList);

	    return map;
	}

}
