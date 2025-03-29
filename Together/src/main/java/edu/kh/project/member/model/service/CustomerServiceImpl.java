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

import edu.kh.project.common.ImageDeleteException;
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
		pagination.setLimit(5);       // 한 페이지 게시글 수
		pagination.setPageSize(5);    // 하단 페이지 번호 수
		
		map.put("pagination", pagination);
		
		List<Board> askList = dao.selectAskBoardList(map);
		
		map.put("askList", askList);
		map.put("pagination", pagination);
		return map;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int boardUpdate(Board board, List<MultipartFile> images, String webPath, String filePath, String deleteList)
			throws IllegalStateException, IOException {
		// 0. XSS 방지 처리
		board.setBoardTitle(Utill.XSSHandling(board.getBoardTitle()));
		board.setBoardContent(Utill.XSSHandling(board.getBoardContent()));

		// 1. 게시글 제목/내용만 수정
		int result = dao.boardUpdate(board);

		// 2. 게시글 수정 성공 했을 때
		if (result > 0) {
			// 3. 삭제할 이미지가 존재한다면
			// deleteList에 작성된 이미지 모두 삭제
			if (!deleteList.equals("")) {

				/* java에서 확인
				 * // 3-1) 삭제할 이미지의 ORDER 확인을 위한 dao 호출 // -> 현재 게시글의 IMG_ORDER 조회 List<String>
				 * orderList = dao.checkImage(board.getBoardNo()); //
				 * System.out.println(orderList);
				 * 
				 * // 3-2) 조회해온 IMG_ORDER가 deleteList에 존재한다면 String[] deleteArr =
				 * deleteList.split(",");
				 * 
				 * boolean flag = false; for(int i = 0; i<orderList.size(); i++) { for(int j =0;
				 * j <deleteArr.length; j++) { if(orderList.get(i).equals(deleteArr[j])) { //
				 * 일치하는 게 있는 경우 flag = true; break; } }
				 * 
				 * }
				 * 
				 * 
				 * for(int i = 0; i < orderList.size(); i++) {
				 * if(deleteList.contains(orderList.get(i))) {
				 * 
				 * } }
				 * 
				 * if(flag) { // 3-3) deleteList에 작성된 이미지 모두 삭제 }
				 */
				
				Map<String, Object> deleteMap = new HashMap<String, Object>();
				deleteMap.put("deleteList", deleteList);
				deleteMap.put("boardNo", board.getBoardNo());

				/* DB에서 조회 */
				// deleteList가 존재하는 게시글 이미지인 경우
				// -> deleteList에 있는 값이 IMG_ORDER에 일치하는 값이 하나도 없으면 에러 발생
				
				int count = dao.checkImageOrder(deleteMap);
				if(count > 0) {
					// 3-3) deleteList에 작성된 이미지 모두 삭제
					result = dao.imageDelete(deleteMap);
					
					// 이미지 삭제 실패 시 전체 롤백 -> 예외 강제로 발생시키기
					// String[] delete = deleteList.split(Character.toString(','));
					if (result == 0) {
						throw new ImageDeleteException();
					}
					
				}
				
				
			}
			// 4. 새로 업로드된 이미지 분류 작업 후
			// 이미지 수정 -> 실패 시 이미지 삽입
			// 실제로 업로드된 파일의 정보를 기록할 List
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
					img.setImageTypeNo(board.getBoardNo());// 게시글 번호

					uploadList.add(img);

					// 오라클은 다중UPDATE를 지원하지 않기 때문에
					// 하나씩 UPDATE 수행
					result = dao.imageUpdate(img);

					if (result == 0) { // 수정 실패 == DB에 이미지가 없는 경우
						// -> 이미지 삽입 진행
						result = dao.imageInsert(img);

					}

				}

			} // 분류 for문 종료

			// 5. uploadList에 있는 이미지들만 서버에 저장

			if (!uploadList.isEmpty()) {

				// 서버에 파일 저장 (transferTo())
				for (int i = 0; i < uploadList.size(); i++) {
					int index = uploadList.get(i).getImageLevel();

					// 변경명
					String rename = uploadList.get(i).getImageReName();

					images.get(index).transferTo(new File(filePath + rename));

				}
			}

		}
		return result;
	}

	// 게시글 삭제
	// @Transactional(rollbackFor = Exception.class) -하나만 있으면 생략 가능
	@Override
	public int boardDelete(int boardNo) {
		return dao.boardDelete(boardNo);
	}

	public int countPinnedNotices() {
	    return dao.countPinned(); // B_STATE = 'S' 카운트
	}

	public int setNoticePinned(int boardNo) {
	    return dao.updateBStateS(boardNo);
	}

	public int setNoticeUnpinned(int boardNo) {
	    return dao.updateBStateNull(boardNo);
	}
	
	@Override
	public List<Board> selectFixedNoticeList() {
	    return dao.selectFixedNoticeList();
	}



}
