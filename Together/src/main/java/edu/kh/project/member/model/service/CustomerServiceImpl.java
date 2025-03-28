package edu.kh.project.member.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.utility.Utill;
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
	public Map<String, Object> searchNoticeList(String query, int cp) {
		int boardCode = 3; // 공지사항 보드 코드
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("query", query);
		
		
		int listCount = dao.getSearchNoticeBoardCount(map);
		
		Pagination pagination = new Pagination(cp, listCount);
		
		
		map.put("pagination", pagination);
		
		List<Board> noticeList = dao.selectSearchNoticeBoardList(map);
		
		map.put("noticeList", noticeList);
		map.put("pagination", pagination);
		return map;
	}
	

	@Override
	public Map<String, Object> FAQBoardList(int boardCode, int cp) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		
		if(boardCode == 0) {
			int listCount = dao.getFAQAllListCount();
			System.out.println("listCount : " + listCount);
			
			Pagination pagination = new Pagination(cp, listCount);
			List<Board> FAQList = dao.allFAQList(pagination);
			map.put("FAQList", FAQList);
			map.put("pagination", pagination);
			System.out.println("pagination : " + pagination);
			
		} else {
			int listCount = dao.getListCount(boardCode);
			System.out.println("listCount : " + listCount);
			
			Pagination pagination = new Pagination(cp, listCount);
			List<Board> FAQList = dao.selectboardList(boardCode, pagination);
			map.put("FAQList", FAQList);
			map.put("pagination", pagination);
			System.out.println("pagination : " + pagination);
			
		}
		return map;
	}

	@Override
	public Map<String, Object> selectBoardDetail(int boardNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Board boardDetail = dao.selectBoardDetail(boardNo);
		List<Board> beforeAfterBoard = dao.selectBeforeAfterBoard(boardNo);
		Reply customerReply = dao.selectReply(boardNo);
		
		map.put("customerReply", customerReply);
		
		map.put("boardDetail", boardDetail);
		map.put("beforeAfterBoard", beforeAfterBoard);
		return map;
	}
	


	// 게시글 삽입
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int boardInsert(Board board, List<MultipartFile> images, String webPath, String filePath)
			throws IllegalStateException, IOException, FileUploadException {

	// 0. XSS 방지 처리
	board.setBoardTitle(Utill.XSSHandling(board.getBoardTitle()));
	board.setBoardContent(Utill.XSSHandling(board.getBoardContent()));


	int boardNo = dao.boardInsert(board);

	if (boardNo != 0) {

		List<Image> uploadList = new ArrayList<Image>();

		// images에 담겨 있는 파일 중 실제로 업로드된 파일만 분류
		for (int i = 0; i < images.size(); i++) {

			// i 번재 요소에 업로드한 파일이 있다면
			if (images.get(i).getSize() > 0) {
				Image img = new Image();

				// img에 파일 정보를 담아서 uploadList에 추가
				img.setImagePath(webPath);// 웹 접근경로

				String fileName = images.get(i).getOriginalFilename();
				img.setImageReName(Utill.fileRename(fileName));// 파일 변경명
				img.setImageOriginal(fileName);// 파일 원본명
				img.setImageLevel(i); // 이미지 순서
				img.setImageTypeNo(boardNo);// 게시글 번호
				
				if(board.getBoardCd() == 3) { // 공지사항
					img.setImageType(9);
				} else if(board.getBoardCd() == 6){ // 1대1 문의
					img.setImageType(10);
				} 
				

				uploadList.add(img);

			}

		}
		if (!uploadList.isEmpty()) {

			int result = dao.insertImageList(uploadList);

			if (result == uploadList.size()) {

				for (int i = 0; i < uploadList.size(); i++) {
					int index = uploadList.get(i).getImageLevel();

					String rename = uploadList.get(i).getImageReName();

					images.get(index).transferTo(new File(filePath + rename));
				}

			} else {
				throw new FileUploadException(); // 예외 강제 발생
			}
		}

	}


	return boardNo;
}

	@Override
	public Map<String, Object> searchFAQ(String query, int cp) {
	    int listCount = dao.getSearchListCount(query);
	    Pagination pagination = new Pagination(cp, listCount);

	    List<Board> FAQList = dao.searchFAQList(query, pagination);

	    Map<String, Object> map = new HashMap<>();
	    map.put("FAQList", FAQList);
	    map.put("pagination", pagination);
	    map.put("boardCode", 0); // 전체로 설정
	    map.put("query", query);

	    return map;
	}

	@Override
	public Map<String, Object> askBoardList(Map<String, Object> map) {
		
		int listCount = dao.getAskListCount(map);
		
		Pagination pagination = new Pagination((int) map.get("cp"), listCount);
		
		map.put("pagination", pagination);
		
		List<Board> askList = dao.selectAskBoardList(map);
		
		map.put("askList", askList);
		map.put("pagination", pagination);
		return map;
	}
	

	
	



}
