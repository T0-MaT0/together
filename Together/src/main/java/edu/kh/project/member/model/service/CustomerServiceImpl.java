package edu.kh.project.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

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
		List<Board> FAQList = dao.selectFAQBoardList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("FAQList", FAQList);
		System.out.println("가져오는지 확인" + map);
		
		return map;
	}

}
