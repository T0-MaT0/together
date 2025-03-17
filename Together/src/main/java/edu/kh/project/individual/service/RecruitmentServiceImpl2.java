package edu.kh.project.individual.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.individual.dao.RecruitmentDAO2;

@Service
public class RecruitmentServiceImpl2 implements RecruitmentService2{

	@Autowired
	private RecruitmentDAO2 dao;

	// 모집글 상태 변경(모집장 memberNo 조회)
	@Override
	public int getHostMemberNo(int boardNo) {
		return dao.getHostMemberNo(boardNo);
	}

	// 모집글 상태 변경
	@Override
	public void updateRecruitmentStatus(int boardNo) {
		dao.updateRecruitmentStatus(boardNo);
	}

	
	
}
