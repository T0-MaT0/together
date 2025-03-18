package edu.kh.project.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.member.model.dao.CustomerDAO;
import edu.kh.project.member.model.dto.Board;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerDAO dao;
	
	@Autowired 
	private BCryptPasswordEncoder bcrypt;

	@Override
	public Map<String, Object> selectBoardList() {
		
		List<Board> noticeList = dao.selectNoticeBoardList();
		
		int boardCode = 9;
		List<Board> FAQList9 = dao.selectFAQBoardList(boardCode);
		boardCode = 10;
		List<Board> FAQList10 = dao.selectFAQBoardList(boardCode);
		boardCode = 11;
		List<Board> FAQList11 = dao.selectFAQBoardList(boardCode);
		boardCode = 12;
		List<Board> FAQList12 = dao.selectFAQBoardList(boardCode);
		boardCode = 13;
		List<Board> FAQList13 = dao.selectFAQBoardList(boardCode);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("FAQList9", FAQList9);
		map.put("FAQList10", FAQList10);
		map.put("FAQList11", FAQList11);
		map.put("FAQList12", FAQList12);
		map.put("FAQList13", FAQList13);
		System.out.println("가져오는지 확인" + map);
		
		return map;
	}

	@Override
	public Map<String, Object> noticeBoardList(int cp) {
		int boardCode = 3; // 공지사항 보드 코드
		int listCount = dao.getListCount(boardCode);
		
		Pagination pagination = new Pagination(cp, listCount);
		
		List<Board> noticeList = dao.selectboardList(boardCode, pagination);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("pagination", pagination);
		return map;
	}

	@Override
	public Map<String, Object> FAQBoardList(int boardCode, int cp) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(boardCode == 0) {
			int listCount = dao.getFAQAllListCount();
			
			System.out.println(listCount);
			
			Pagination pagination = new Pagination(cp, listCount);
			List<Board> FAQList = dao.allFAQList(pagination);
			map.put("boardCode", boardCode);
			map.put("FAQList", FAQList);
			map.put("pagination", pagination);
			
		} else {
			int listCount = dao.getListCount(boardCode);
			
			Pagination pagination = new Pagination(cp, listCount);
			List<Board> FAQList = dao.selectboardList(boardCode, pagination);
			map.put("boardCode", boardCode);
			map.put("FAQList", FAQList);
			map.put("pagination", pagination);
			
		}
		return map;
	}

	@Override
	public Map<String, Object> noticeBoardDetail(int boardNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Board noticeBoardDetail = dao.selectNoticeBoardDetail(boardNo);
		List<Board> beforeAfterBoard = dao.selectBeforeAfterBoard(boardNo);
		
		map.put("noticeBoardDetail", noticeBoardDetail);
		map.put("beforeAfterBoard", beforeAfterBoard);
		return map;
	}



}
