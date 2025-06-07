package edu.kh.project.main.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.individual.dto.Recruitment;

public interface MainService {

	// 개인 공동구매 모집글 조회
	Map<String, Object> selectRecruitmentList(int memberNo);

	// 브랜드 상품 리스트 조회
	Map<String, Object> selectBusinessList();

}
