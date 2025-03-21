package edu.kh.project.member.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		
		

		board.setBoardCd(boardCode);
		board.setMemberNo(loginMember.getMemberNo());
		

		String webPath = "/resources/images/customer/";
		String filePath = session.getServletContext().getRealPath(webPath);
		

		int boardNo = service.boardInsert(board, images, webPath, filePath);
		
		String path = "redirect:";
		String message = null;
		if(boardNo > 0) {// 게시글 삽입 성공 시
		// -> 방금 삽입한 게시글의 상세 조회 페이지로 리다이렉트
		// -> /board/{boardCode}/boardNo
			
			message = "게시글이 등록되었습니다.";
			path += "/board/"+boardCode + "/" +boardNo;
			
			
			
		}else{// 게시글 삽입 실패 시
			// -> 게시글 작성 페이지로 리다이렉트
			message = "게시글 등록 실패.";
			path +="insert";
			
			
		}
		
		
		ra.addFlashAttribute("message", message);
		
		
		return path;
	}

}
