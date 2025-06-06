package edu.kh.project.member.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import edu.kh.project.member.model.dto.FaqCategory;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.service.CustomerService;

@Controller
@RequestMapping("/customer2")
@SessionAttributes("loginMember")
public class BoardInsertController {

	@Autowired
	private CustomerService service;

	// 공지사항 작성 페이지
	@GetMapping("/notice/insert")
	public String noticeWrite(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			Model model) {
		
		if(loginMember == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("boardType", "NOTICE");
		return "customer/customerBoardWrite";
	}

	// FAQ 작성 페이지
	@GetMapping("/faq/insert")
	public String faqWrite(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			Model model) {
		
		if(loginMember == null) {
			return "redirect:/member/login";
		}
		
		// FAQ 카테고리 목록 조회
		List<Map<String, Object>> categories = service.selectFAQCategories();
		System.out.println("카테고리 목록: " + categories); // 디버깅용 로그
		
		model.addAttribute("categories", categories);
		model.addAttribute("boardType", "FAQ");
		return "customer/customerBoardWrite";
	}

	// 1:1 문의 작성 페이지
	@GetMapping("/inquiry/insert")
	public String inquiryWrite(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			Model model) {
		
		if(loginMember == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("boardType", "INQUIRY");
		return "customer/customerBoardWrite";
	}

	// 게시글 작성 처리
	@PostMapping("/{boardType}/insert")
	public String boardInsert(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			Board board,
			@RequestParam(value = "images", required = false) List<MultipartFile> images,
			@PathVariable("boardType") String boardType,
			RedirectAttributes ra,
			HttpSession session) {
		
		if(loginMember == null) {
			return "redirect:/member/login";
		}
		System.out.println("이미지 목록: " + images);
		board.setMemberNo(loginMember.getMemberNo());
		
		// 이미지 업로드 경로 설정
		String webPath = "/resources/images/customer/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		int result = 0 ;
		try {
			result = service.boardInsert(board, images, webPath, filePath, boardType);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		String message = null;
		if(result > 0) {
			message = "게시글이 등록되었습니다.";
		} else {
			message = "게시글 등록 실패";
		}
		
		ra.addFlashAttribute("message", message);
		
		return "redirect:/customer2/" + boardType.toLowerCase() +"/insert";
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
		
		// 1. boardCode, boardNo를 커맨드 객체에 세팅
		board.setBoardCode(boardCode);
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
			path += "/customer/customerBoardDetail/"+boardNo + "?cp=" +cp;
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
