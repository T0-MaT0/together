package edu.kh.project.individual.service;

import java.util.List;

public interface RecruitmentService2 {

	// 모집글 상태 변경(모집장 memberNo 조회)
	int getHostMemberNo(int boardNo);
	
	// 모집글 상태 변경
	void updateRecruitmentStatus(int boardNo);


	

}
