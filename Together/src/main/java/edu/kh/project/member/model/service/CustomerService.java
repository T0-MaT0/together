package edu.kh.project.member.model.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.member.model.dto.Board;

public interface CustomerService {

	Map<String, Object> selectBoardList();

	Map<String, Object> noticeBoardList(int cp);

	Map<String, Object> FAQBoardList(int boardCode, int cp);

	Map<String, Object> noticeBoardDetail(int boardNo);


}
