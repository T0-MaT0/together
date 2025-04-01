package edu.kh.project.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.CustomerService;

@Controller
@RequestMapping("/customer2")
@SessionAttributes("loginMember")
public class BoardInsertController {

	@Autowired
	private CustomerService service;

	// 게시글 작성 화면 전환
	@GetMapping("/{boardCode:[0-9]+}/insert")
	public String boardInsert(@PathVariable("boardCode") int boardCode) {
		// @PathVariable : 주소 값 가져오기 + request scope에 세팅
		// System.out.println("boardCode: "+ boardCode);
		// 1 공지사항 2 큐앤에이 3 1대1
		return "/customer/customerBoardWrite";
	}

	//게시글 작성
	@PostMapping("/{boardCode:[0-9]+}/insert")
	public String boardInsert(@PathVariable("boardCode") int boardCode
							, Board board /*커멘드 객체(필드에 전달받은 파라미터 값 담겨 있음*/
							, @RequestParam(value="images", required=false) List<MultipartFile> images
							, @SessionAttribute("loginMember") Member loginMember
							, RedirectAttributes ra
							, HttpSession session) throws IllegalStateException, IOException, FileUploadException {
		
		

		System.out.println("넣기전 : " + board);
		
		if (boardCode == 4 && board.getBoardCd() > 0) {
	        boardCode = board.getBoardCd();
	        System.out.println("FAQ 선택으로 boardCode 교체됨: " + boardCode);
	    }
		
		board.setBoardCd(boardCode);
		board.setMemberNo(loginMember.getMemberNo());
		
		System.out.println("넣은후 : " + board);
	
		

		String webPath = "/resources/images/customer/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		System.out.println(images);
		
		//3. 게시글 삽입 서비스 호출 후 
		int boardNo = service.boardInsert(board, images, webPath, filePath);
		
		String path = "redirect:";
		String message = null;
		if(boardNo > 0) {
			
			message = "1대1 게시글이 등록되었습니다.";
			if(boardCode == 6) { // 1대1
				path += "/";
			} else if (boardCode == 3) { // 공지사항
				message = "공지사항 게시글이 등록되었습니다.";
				path += "/customer/customerBoardDetail/"+boardNo;
				
			} else { // FAQ
				message = "FAQ 게시글이 등록되었습니다.";
				path += "/customer/FAQBoard/0";
			}
			
			
			
		}else{
			message = "게시글 등록 실패.";
			path +="insert";
			
			
		}
		
		
		ra.addFlashAttribute("message", message);
		
		
		return path;

	}
	
	// 게시글 수정 화면 전환
	@GetMapping("/{boardCode}/{boardNo}/update")
	public String boardUpdate(@PathVariable("boardCode") int boardCode,
								@PathVariable("boardNo") int boardNo,
								Model model // 데이터 전달용 객체(기본 request scope)
								) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("boardCode", boardCode);
		map.put("boardNo", boardNo);
		
		// 게시글 상세 조회 서비스 호출
		map = service.selectBoardDetail(boardNo);
		// System.out.println(board);
		
		model.addAttribute("map", map);
		return "customer/customerBoardUpdate";

	}
	
	// 게시글 수정
	@PostMapping("/{boardCode}/{boardNo}/update")
	public String boardUpdate(@PathVariable("boardCode") int boardCode,
							  @PathVariable("boardNo") int boardNo,
							  @RequestParam(value="cp", required=false, defaultValue = "1") String cp,
							  // 삭제할 이미지 순서
							  @RequestParam(value="deleteList", required=false) String deleteList,
							  // 업로드된 파일 리스트
							  @RequestParam(value="images", required=false) List<MultipartFile> images,
							  Board board, // 커맨드 객체
							  RedirectAttributes ra, // 리다이렉트 시 값 전달용
							  HttpSession session // 서버 파일 저장 경로를 얻어올 용도
							  ) throws IllegalStateException, IOException {
		
		if (boardCode == 4 && board.getBoardCd() > 0) {
	        boardCode = board.getBoardCd();
	        System.out.println("FAQ 선택으로 boardCode 교체됨: " + boardCode);
	    }
		
		// 1. boardCode, boardNo를 커맨드 객체에 세팅
		board.setBoardCd(boardCode);
		board.setBoardNo(boardNo);
		
		System.out.println("cp : " + cp);
		
		System.out.println("삭제 리스트 : " + deleteList);
		
		// 2. 이미지 서버 저장 경로, 웹 접근 경로
		String webPath = "/resources/images/customer/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		// 3. 게시글 수정 서비스 호출
		int result = service.boardUpdate(board, images, webPath, filePath, deleteList);
		
		// 4. 결과에 따라 message, path 설정
		// - 수정 성공 시 : 상세조회 페이지 + "게시글이 수정되었습니다."
		// - 수정 실패 시 : 수정 페이지 + "게시글 수정 실패"
		String path = "redirect:";
		String message = null;
		if(result > 0) {
			if(boardCode == 3) {
				path += "/customer/customerBoardDetail/"+boardNo + "?cp=" +cp;
			} else {
				path += "/customer/FAQBoard/0";
			}
			message = "게시글이 수정되었습니다.";
			
		}else{
			message = "게시글 수정 실패.";
			path +="update";
		}
		ra.addFlashAttribute("message", message);

		return path;
	}
	
	// 게시물 삭제
	@GetMapping("/{boardCode}/{boardNo}/delete")
	public String boardDelete(@PathVariable("boardCode") int boardCode,
				  @PathVariable("boardNo") int boardNo,
				  @RequestParam(value="cp", required=false, defaultValue = "1") String cp,
				  RedirectAttributes ra, // 리다이렉트 시 값 전달용
				  @RequestHeader("referer") String referer // 이전 요청 주소
				  ) {
		
		int result = service.boardDelete(boardNo);
		String path = "redirect:";
		String message = null;
		if(result > 0) {
			message = "게시글이 삭제되었습니다.";
			if(boardCode == 3) {
				path +="/customer/noticeBoardList?cp=1";
			} else {
				path += "/customer/FAQBoard/0";
			}
		} else {
			message =  "게시글이 삭제 실패";
			// path += "/board/"+boardCode + "/" +boardNo + "?cp=" +cp;
			path += referer;
		}
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	@GetMapping("/pin-check")
	@ResponseBody
	public String checkPinCount() {
	    int count = service.countPinnedNotices(); // B_STATE = 'S'인 공지사항 개수
	    return String.valueOf(count);
	}

	@GetMapping("/pin/{boardNo}")
	public String pinNotice(@PathVariable int boardNo, RedirectAttributes ra) {
	    int result = service.setNoticePinned(boardNo);
	    ra.addFlashAttribute("message", result > 0 ? "고정 완료" : "고정 실패");
	    return "redirect:/customer/customerBoardDetail/" + boardNo;
	}

	@GetMapping("/unpin/{boardNo}")
	public String unpinNotice(@PathVariable int boardNo, RedirectAttributes ra) {
	    int result = service.setNoticeUnpinned(boardNo);
	    ra.addFlashAttribute("message", result > 0 ? "고정 해제 완료" : "해제 실패");
	    return "redirect:/customer/customerBoardDetail/" + boardNo;
	}

}
