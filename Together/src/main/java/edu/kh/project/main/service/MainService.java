package edu.kh.project.main.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.individual.dto.Recruitment;

public interface MainService {

	List<Recruitment> selectRecruitmentList(int boardCode, int memberNo);

	Map<String, Object> selectBusinessList(int boardCode);

}
