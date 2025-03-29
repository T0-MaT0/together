package edu.kh.project.individual.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.chatting.service.ChattingService;
import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.individual.service.CategoryService;
import edu.kh.project.individual.service.RecruitmentService;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Member;

@Controller
public class RecruitmentController {

	@Autowired
	private RecruitmentService service;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ChattingService chatService;
	
	// 개인 공동구매 모집방 페이지 (boardCode=1 고정)
	@GetMapping("/Individual/1")
	public String individualMainPage(
	        Model model,
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

	    int boardCode = 1; 
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);
	    model.addAttribute("recruitmentList", recruitmentList);
	    model.addAttribute("boardCode", boardCode);

	    return "Individual/mainIndividual";  
	}
	
	
	// 개인 공동구매 모집방 목록 JSON 응답 - boardCode = 1 고정
	@GetMapping("/api/recruitment")
	@ResponseBody
	public List<Recruitment> getRecruitmentList(
	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

	    int boardCode = 1; 
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);

	    return recruitmentList; 
	}
	
	// 개인 공동구매 모집방 목록 JSON 응답 - 조회수 높은 순 (BEST)
    @GetMapping("/api/recruitment/popular")
    @ResponseBody
    public List<Recruitment> getPopularRecruitmentList(
            @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

        int boardCode = 1;
        int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

        List<Recruitment> recruitmentList = service.selectRecruitmentListByViewCount(boardCode, memberNo);

        return recruitmentList;
    }
    
    // 개인 공동구매 모집방 목록 상세 페이지 (boardCode=1 고정)
 	@GetMapping("/Individual/detail")
 	public String individualDetail(
 	        Model model,
 	        @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

 	    int boardCode = 1; 
 	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

 	    List<Recruitment> recruitmentList = service.selectRecruitmentList(boardCode, memberNo);
 	    model.addAttribute("recruitmentList", recruitmentList);
 	    model.addAttribute("boardCode", boardCode);

 	    return "Individual/individualDetail";  
 	}
 	
 	// 내 모집 현황 조회
 	@GetMapping("/myRecruitment")
    public String myRecruitment(
    		@RequestParam(value = "key", required = false, defaultValue = "myRecruitment") String key,
            Model model,
            @SessionAttribute(value = "loginMember", required = false) Member loginMember,
            RedirectAttributes redirectAttributes) {

 		int boardCode = 1;
 		if (loginMember == null) {
 	        redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
 	        return "redirect:/member/login";
 	    }
 		
 		int memberNo = loginMember.getMemberNo();
        List<Recruitment> recruitments = service.getMyRecruitmentList(memberNo, key);
        model.addAttribute("recruitments", recruitments);
        model.addAttribute("boardCode", boardCode);
        model.addAttribute("selectedKey", key);

        return "Individual/myRecruitmentInProgress/myRecruitment";
    }
 	
 	// 댓글 조회
 	@GetMapping("/myRecruitment/comments")
    public String myRecruitmentComments(
            @SessionAttribute(value = "loginMember", required = false) Member loginMember,
            Model model,
            RedirectAttributes redirectAttributes) {

 		int boardCode = 1;
        if (loginMember == null) {
            redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
            return "redirect:/member/login";
        }

        int memberNo = loginMember.getMemberNo();
        List<Reply> comments = service.getMyRecruitmentComments(memberNo);

        model.addAttribute("comments", comments);
        model.addAttribute("boardCode", boardCode);
        model.addAttribute("key", "comments");

        return "Individual/myRecruitmentInProgress/myRecruitmentComment";  
    }
        
 	
 	// 리뷰 조회
 	@GetMapping("/myRecruitment/reviews")
    public String myRecruitmentReviews(
            @SessionAttribute(value = "loginMember", required = false) Member loginMember,
            Model model,
            RedirectAttributes redirectAttributes) {

 		int boardCode = 1;

        if (loginMember == null) {
            redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
            return "redirect:/member/login";
        }

        int memberNo = loginMember.getMemberNo();
        List<Review> reviews = service.getMyRecruitmentReviews(memberNo);

        model.addAttribute("reviews", reviews);
        model.addAttribute("key", "reviews"); 
        model.addAttribute("boardCode", boardCode);

        return "Individual/myRecruitmentInProgress/myRecruitmentReview";  
    }
 	
 	// 모집창 경로
 	@GetMapping("/group/create")
 	public String createGroup(
 	        @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	        RedirectAttributes redirectAttributes,
 	        Model model) {
 	    
 	    int boardCode = 1; // 모집 게시판 코드

 	    if (loginMember == null) {
 	        redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
 	        return "redirect:/member/login";
 	    }

 	    List<Category> parentList = categoryService.getParentCategories();
 	    model.addAttribute("parentList", parentList);
 	    model.addAttribute("boardCode", boardCode);

 	    return "Individual/CreateGroup"; 
 	}
 	
 	// 모집창 상세 경로
 	@GetMapping("/partyRecruitmentList/{recruitmentNo}/{boardNo}")
 	public String partyRecruitmentList(
 			@PathVariable("recruitmentNo") int recruitmentNo,
 			@PathVariable("boardNo") int boardNo,
 	        @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	        RedirectAttributes redirectAttributes,
 	        Model model) {
 	    
 	    int boardCode = 1; // 모집 게시판 코드
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
	    

 	    if (loginMember == null) {
 	        redirectAttributes.addFlashAttribute("message", "로그인을 먼저 해주세요.");
 	        return "redirect:/member/login";
 	    }
 	    Recruitment recruitmentDetail = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, memberNo);
 	    System.out.println("recruitmentDetail : " + recruitmentDetail);
 	   if (recruitmentDetail == null) {
 	        redirectAttributes.addFlashAttribute("message", "해당 모집글을 찾을 수 없습니다.");
 	        return "redirect:/partyRecruitmentList";
 	    }
 	   
	    model.addAttribute("recruitmentDetail", recruitmentDetail);
	    model.addAttribute("boardCode", boardCode);
	    model.addAttribute("boardNo", boardNo);


 	    return "Individual/partyRecruitmentList"; 
 	}
 	
 	// 모집글 작성
 	@PostMapping("/group/create/insert")
    public String createGroupInsert(Recruitment dto,
        @RequestParam("images") List<MultipartFile> images,
        @SessionAttribute(value="loginMember", required=false) Member loginMember,
        HttpSession session,
        RedirectAttributes ra,
        HttpServletResponse response) throws IOException {

        if(loginMember == null) {
            ra.addFlashAttribute("message","로그인해주세요.");
            return "redirect:/member/login";
        }

        // 파일 저장 경로
        String webPath = "/resources/images/recruitment/";
	    String filePath = session.getServletContext().getRealPath(webPath);
        int recruitNo = 0;
        try {
            recruitNo = service.createRecruitment(dto, images,
                                        loginMember.getMemberNo(), 
                                        webPath, filePath);
        } catch(Exception e){
            e.printStackTrace();
        }

        if (recruitNo > 0) {
        	// 채팅방 생성
            int result = chatService.createGroupChatRoom(dto.getBoardTitle(), loginMember.getMemberNo());
        	
            
            if(result > 0) {
                String script = "<script>"
                        + "alert('모집글 등록 + 채팅방 생성 성공!');"
                        + "window.opener.location.href='/Individual/" + 1 + "';"
                        + "window.close();"
                        + "</script>";
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().write(script);
                return null;
            }

            ra.addFlashAttribute("message", "모집글 등록은 성공했지만 채팅방 생성 실패");
            return "redirect:/group/create";
        }

        ra.addFlashAttribute("message", "모집글 등록 실패");
        return "redirect:/group/create";
    }
	
 	// 수정 버튼 조회
 	@GetMapping("/group/edit")
 	public String editRecruitmentForm(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                  @RequestParam("boardNo") int boardNo,
 	                                  @SessionAttribute("loginMember") Member loginMember,
 	                                  Model model,
 	                                  RedirectAttributes ra) {

 		int boardCode = 1;
 		// 1. 로그인 여부 확인
 	    if (loginMember == null) {
 	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
 	        return "redirect:/member/login";
 	    }

 	    int memberNo = loginMember.getMemberNo();

 	    // 2. 모집글 상세 조회
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, memberNo);
 	    if (dto == null) {
 	        ra.addFlashAttribute("message", "존재하지 않는 모집글입니다.");
 	        return "redirect:/";
 	    }

 	    // 3. 작성자 권한 확인 (내가 작성한 모집글이 아닐 경우)
 	    if (!loginMember.getMemberNick().equals(dto.getHostName())) {
 	        ra.addFlashAttribute("message", "수정 권한이 없습니다.");
 	        return "redirect:/partyRecruitmentList/" + recruitmentNo + "/" + boardNo;
 	    }

 	    //  자식 카테고리 번호로 → 부모 카테고리 조회
 	    int childCategoryNo = dto.getCategoryNo();
 	    Integer parentCategoryNo = categoryService.selectParentNo(childCategoryNo); // 없으면 null 반환
 	    dto.setParentCategoryNo(parentCategoryNo);

 	   // 5. 부모/자식 카테고리 목록 조회
 	    List<Category> parentList = categoryService.getParentCategories();
 	    List<Category> childList = (parentCategoryNo != null)
 	            ? categoryService.getChildCategories(parentCategoryNo)
 	            : null;
 	    
 	    // 자식 카테고리 

 	    // 모델 전달
 	    model.addAttribute("boardCode", boardCode);
 	    model.addAttribute("recruitment", dto);
 	    model.addAttribute("parentList", parentList);
 	    model.addAttribute("childList", childList);
 	    
 	    return "Individual/editGroup"; 
 	}
 	
 	// 모집글 수정
 	@PostMapping("/group/edit/submit")
 	public void editGroupSubmit(
 	        @RequestParam Map<String, Object> paramMap,
 	        @RequestParam("recruitmentNo") int recruitmentNo,
 	        @RequestParam("boardNo") int boardNo,
 	        @RequestParam(value = "images", required = false) List<MultipartFile> imageList,
 	        @SessionAttribute("loginMember") Member loginMember,
 	        HttpServletResponse response,
 	        RedirectAttributes ra,
 	        Model model) throws Exception {
 		int boardCode = 1;
 		response.setContentType("text/html; charset=UTF-8");

 	    if (loginMember == null) {
 	    	response.getWriter().write("<script>alert('로그인 후 이용해주세요.'); window.close();</script>");
 	        return;
 	    }

 	    model.addAttribute("boardCode", boardCode);
 	    try {
 	        // 수정 시 필요한 값 추가
 	        paramMap.put("memberNo", loginMember.getMemberNo());
 	        paramMap.put("recruitmentNo", recruitmentNo);
 	        paramMap.put("boardNo", boardNo);

 	        // 실제 수정 로직 호출 (서비스에서 UPDATE 처리)
 	        int result = service.updateRecruitment(paramMap, imageList);

 	       if (result > 0) {
 	            response.getWriter().write(
 	                "<script>" +
 	                "alert('모집글 수정 성공!');" +
 	                "window.opener.location.reload();" +
 	                "window.close();" +
 	                "</script>"
 	            );
 	        } else {
 	            response.getWriter().write(
 	                "<script>" +
 	                "alert('모집글 수정 실패');" +
 	                "window.history.back();" +
 	                "</script>"
 	            );
 	        }

 	    } catch (Exception e) {
 	        e.printStackTrace();
 	        response.getWriter().write(
 	            "<script>" +
 	            "alert('오류 발생: 모집글 수정 실패');" +
 	            "window.history.back();" +
 	            "</script>"
 	        );
 	    }
 	}
 	
 	// 참여하기 화면
 	@GetMapping("/group/participate")
 	public String participatePage(@RequestParam("recruitmentNo") int recruitmentNo,
 	                              @RequestParam("boardNo") int boardNo,
 	                              @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	                              Model model,
 	                              RedirectAttributes ra) {

 		int boardCode = 1;
 		
 	    if (loginMember == null) {
 	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
 	        return "redirect:/member/login";
 	    }

 	    // 참여 폼에 필요한 데이터 조회
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, loginMember.getMemberNo());
 	    if (dto == null) {
 	        ra.addFlashAttribute("message", "모집글을 찾을 수 없습니다.");
 	        return "redirect:/";
 	    }

 	    model.addAttribute("boardCode", boardCode);
 	    model.addAttribute("recruitment", dto);
 	    return "Individual/recruitmentParticipation";  // JSP 경로
 	}
 	
 	// 참여하기 제출
 	@PostMapping("/group/participate/submit")
 	public String participateSubmit(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                @RequestParam("myQuantity") int myQuantity,
 	                                @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	                                Model model,
 	                                RedirectAttributes ra) {
 		
 		int boardCode = 1;
 	    // 1. 로그인 체크
 	    if (loginMember == null) {
 	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
 	        return "redirect:/member/login";
 	    }

 	   // 모집글 정보 조회
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, 0, loginMember.getMemberNo());
 	    if (dto == null) {
 	        ra.addFlashAttribute("message", "모집글을 찾을 수 없습니다.");
 	        return "redirect:/";
 	    }

 	    dto.setMyParticipationCount(myQuantity); 
 	    model.addAttribute("boardCode", boardCode);
 	    model.addAttribute("recruitment", dto);
 	    return "Individual/recruitment_settlement"; 
 	}
 	
 	// 정산 완료
 	@PostMapping("/group/settlement/complete")
 	public String settlementComplete(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                 @RequestParam("paymentAmount") double paymentAmount2,
 	                                 @RequestParam("boardNo") int boardNo,
 	                                 @SessionAttribute("loginMember") Member loginMember,
 	                                 @RequestParam("myQuantity") int myQuantity,
 	                                 RedirectAttributes ra,HttpSession session,
 	                                 Model model) {

 		int boardCode = 1;
 	    try {
 	    	int point = loginMember.getPoint();
 	        int memberNo = loginMember.getMemberNo();
 	        int paymentAmount = (int) paymentAmount2;
 	        // 포인트 차감 + 참가 INSERT + 모집 마감 여부 확인
 	        int result = service.participateRecruitment(memberNo, recruitmentNo, myQuantity, paymentAmount,point);
 	        System.out.println("boardNo1213 : " + boardNo);
 	        if (result > 0) {
 	        	String roomName = chatService.selectBoardTitle(boardNo);
 	            int roomNo = chatService.selectRoomNoByRoomName(roomName);
 	            chatService.insertChatRoomUser(roomNo, memberNo);
 	        	
 	        	int updatedPoint = service.selectMemberPoint(memberNo);
 	            loginMember.setPoint(updatedPoint);
 	            session.setAttribute("loginMember", loginMember);

 	            // 결과 페이지에 보여줄 정보 전달
 	            model.addAttribute("paymentAmount", paymentAmount);
 	            model.addAttribute("myQuantity", myQuantity);
 	            model.addAttribute("recruitmentNo", recruitmentNo);
 	            model.addAttribute("boardNo", boardNo);
 	            model.addAttribute("boardCode", boardCode);
 	            ra.addFlashAttribute("message", "참여가 완료되었습니다.");
 	            
 	           return "Individual/recruitment_settlement_complete";
 	        } else {
 	            ra.addFlashAttribute("message", "참여 처리 중 오류 발생.");
 	        }

 	   } catch (IllegalArgumentException e) {
 		    ra.addFlashAttribute("alertMessage", e.getMessage());
 		   return "redirect:/partyRecruitmentList/" + recruitmentNo + "/" + boardNo;

 		} catch (Exception e) {
 		    e.printStackTrace();
 		    ra.addFlashAttribute("alertMessage", "정산 중 오류가 발생했습니다.");
 		   return "redirect:/partyRecruitmentList/" + recruitmentNo + "/" + boardNo;
 		}

 	    return "redirect:/partyRecruitmentList/" + recruitmentNo + "/0";
 	}
 	
 	// 모집 상세 맴버 정보 페이지(모집원)
 	@GetMapping("/purchase_in_progress_member")
 	public String showMemberProgressDetail(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                       @RequestParam("boardNo") int boardNo,
 	                                       @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	                                       Model model, RedirectAttributes ra) {

 		int boardCode = 1;
 	    if (loginMember == null) {
 	        ra.addFlashAttribute("alertMessage", "로그인 후 이용해주세요.");
 	        return "redirect:/member/login";
 	    }

 	    // 참여 정보 조회 (recruitmentNo, boardNo 기준)
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, loginMember.getMemberNo());
 	    if (dto == null) {
 	        ra.addFlashAttribute("alertMessage", "상세 정보를 찾을 수 없습니다.");
 	        return "redirect:/";
 	    }
 	    model.addAttribute("boardCode", boardCode);
 	    model.addAttribute("recruitment", dto);
 	    return "Individual/purchase_in_progress_member";
 	}
 	
 	// 모집 상세 맴버 정보 페이지(모집장)
 	@GetMapping("/purchase_in_progress_host")
 	public String showHostProgressDetail(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                     @RequestParam("boardNo") int boardNo,
 	                                     @SessionAttribute(value = "loginMember", required = false) Member loginMember,
 	                                     Model model,
 	                                     RedirectAttributes ra) {

 		int boardCode = 1;
 	    // 1. 로그인 여부 확인
 	    if (loginMember == null) {
 	        ra.addFlashAttribute("alertMessage", "로그인 후 이용해주세요.");
 	        return "redirect:/member/login";
 	    }

 	    int memberNo = loginMember.getMemberNo();

 	    // 2. 모집글 상세 조회 (내가 모집장인지 확인 포함)
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, memberNo);
 	    if (dto == null) {
 	        ra.addFlashAttribute("alertMessage", "해당 모집글을 찾을 수 없습니다.");
 	        return "redirect:/";
 	    }

 	    // 3. JSP에 전달
 	    model.addAttribute("recruitment", dto);
 	    model.addAttribute("boardCode", boardCode);
 	    return "Individual/purchase_in_progress_host";
 	}
 	
 	// 모집 취소
 	@PostMapping("/group/participation/cancel")
 	public String cancelParticipation(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                  @SessionAttribute("loginMember") Member loginMember,
 	                                  @RequestParam("boardNo") int boardNo,
 	                                  RedirectAttributes ra,
 	                                  Model model) {
 		int boardCode = 1;
 	    int memberNo = loginMember.getMemberNo();

 	    try {
 	        int result = service.deleteParticipation(memberNo, recruitmentNo);

 	        if (result > 0) {
 	        	// 모집 취소 성공 시 모집방 안보이게
 	        	String roomName = chatService.selectBoardTitle(boardNo);
 	            int roomNo = chatService.selectRoomNoByRoomName(roomName);
 	            chatService.deleteChatRoomUser(roomNo, memberNo);
 	            
 	            ra.addFlashAttribute("message", "참가가 성공적으로 취소되었습니다.");
 	        } else {
 	            ra.addFlashAttribute("alertMessage", "이미 취소되었거나 참가 정보가 없습니다.");
 	        }

 	    } catch (Exception e) {
 	        e.printStackTrace();
 	        ra.addFlashAttribute("alertMessage", "참가 취소 중 오류가 발생했습니다.");
 	    }
 	    model.addAttribute("boardCode", boardCode);
 	    return "Individual/mainIndividual"; // 또는 다른 이동 경로
 	}
 	
 	// 모집글 삭제
 	@PostMapping("/group/delete")
 	public String deleteRecruitment(@RequestParam("boardNo") int boardNo,
 	                                RedirectAttributes ra, Model model) {

 		int boardCode = 1;
 	    int result = service.softDeleteBoard(boardNo); 

 	    if (result > 0) {
 	        ra.addFlashAttribute("message", "모집글이 삭제되었습니다.");
 	    } else {
 	        ra.addFlashAttribute("alertMessage", "삭제에 실패했습니다.");
 	    }
 	    model.addAttribute("boardCode", boardCode);
 	    return "redirect:/myRecruitment"; // 또는 돌아갈 화면
 	}
 	
 	// 모집장이 모집 마감
 	@PostMapping("/group/complete/update")
 	public String completeRecruitment(@RequestParam("recruitmentNo") int recruitmentNo,
 									  @RequestParam("boardNo") int boardNo,
 	                                  RedirectAttributes ra, Model model) {
 		int boardCode = 1;
 	    int result = service.updateRecruitmentStatusToClosed(recruitmentNo);

 	    if (result > 0) {
 	        ra.addFlashAttribute("message", "모집이 마감되었습니다.");
 	    } else {
 	        ra.addFlashAttribute("alertMessage", "마감 처리에 실패했습니다.");
 	    }
 	   model.addAttribute("boardCode", boardCode);
 	   return "redirect:/purchase_in_progress_host?recruitmentNo=" + recruitmentNo + "&boardNo=" + boardNo;
 	}
 	
 	// 모집 인증 폼
 	@GetMapping("/group/verification/form")
 	public String showVerificationForm(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                   @RequestParam("boardNo") int boardNo,
 	                                  @SessionAttribute("loginMember") Member loginMember,
 	                                   Model model) {
 		int boardCode = 1;
 		int memberNo = loginMember.getMemberNo();

 	    model.addAttribute("recruitmentNo", recruitmentNo);
 	    model.addAttribute("boardNo", boardNo);

 	    // 모집 상세 정보 조회
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, memberNo);
 	    model.addAttribute("recruitment", dto); 

 	    boolean isVerificationFormExists = 
 	        dto.getTrackingNumber() != null && !dto.getTrackingNumber().isBlank();

 	    model.addAttribute("isVerificationFormExists", isVerificationFormExists);
 	    model.addAttribute("boardCode", boardCode);
 	    return "Individual/recruit_verification_form_host"; // JSP 경로
 	}

 	// 모집 인증 폼
 	@PostMapping("/group/verification/register")
 	public String registerVerificationForm(@RequestParam("recruitmentNo") int recruitmentNo,
		            @RequestParam("boardNo") int boardNo,
		            @RequestParam("trackingNumber") String trackingNumber,
		            @RequestParam("deliveryExpected") String deliveryExpected,
		            @RequestParam("memberReceiveDate") String memberReceiveDate,
		            HttpSession session,
		            RedirectAttributes ra,
		            Model model) {
 		int boardCode = 1;
		try {
		// QR 코드 이미지 저장 경로 설정
		String webPath = "/resources/images/qrcode/";
		String realPath = session.getServletContext().getRealPath(webPath);
		
		// 서비스 호출 (QR 생성 + DB 저장)
		int result = service.registerVerificationFormWithQr(
		recruitmentNo, trackingNumber, deliveryExpected, memberReceiveDate, realPath, webPath);
		
		if (result > 0) {
		ra.addFlashAttribute("message", "모집 인증 폼 등록이 완료되었습니다.");
		} else {
		ra.addFlashAttribute("alertMessage", "등록에 실패했습니다.");
		}
		
		} catch (Exception e) {
		e.printStackTrace();
		ra.addFlashAttribute("alertMessage", "서버 오류 발생");
		}
		model.addAttribute("boardCode", boardCode);
		return "redirect:/purchase_in_progress_host?recruitmentNo=" + recruitmentNo + "&boardNo=" + boardNo;
	}

 	// 모집 인증 폼 수정
 	@PostMapping("/group/verification/update")
 	public String updateVerificationForm(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                     @RequestParam("boardNo") int boardNo,
 	                                     @RequestParam("trackingNumber") String trackingNumber,
 	                                     @RequestParam("deliveryExpected") String deliveryExpected,
 	                                     @RequestParam("memberReceiveDate") String memberReceiveDate,
 	                                     RedirectAttributes ra,
 	                                     Model model) {
 		int boardCode = 1;
 	    try {
 	        int result = service.updateVerificationForm(recruitmentNo, trackingNumber, deliveryExpected, memberReceiveDate);
 	        if (result > 0) {
 	            ra.addFlashAttribute("message", "모집 인증 폼이 수정되었습니다.");
 	        } else {
 	            ra.addFlashAttribute("alertMessage", "수정 실패");
 	        }

 	    } catch (Exception e) {
 	        e.printStackTrace();
 	        ra.addFlashAttribute("alertMessage", "서버 오류 발생");
 	    }
 	    model.addAttribute("boardCode", boardCode);
 	    return "redirect:/purchase_in_progress_host?recruitmentNo=" + recruitmentNo + "&boardNo=" + boardNo;
 	}
 	
 	@GetMapping("/group/verification/memberForm")
 	public String showVerificationFormMember(@RequestParam("recruitmentNo") int recruitmentNo,
 	                                         @RequestParam("boardNo") int boardNo,
 	                                         @SessionAttribute("loginMember") Member loginMember,
 	                                         Model model) {
 		int boardCode = 1;
 		int memberNo = loginMember.getMemberNo();
 	    // DB에서 모집 정보, 인증 폼 정보 등을 가져오기
 	    Recruitment dto = service.selectRecruitmentRoomDetail(recruitmentNo, boardNo, memberNo);
 	    
 	    // JSP에서 쓸 수 있도록 model에 담기
 	    model.addAttribute("recruitment", dto);
 	    model.addAttribute("boardCode", boardCode);
 	    return "Individual/recruit_verification_form_member";
 	}
 	
 	@GetMapping("/recruit/verify")
    public String verify(
            @RequestParam("recruitmentNo") int recruitmentNo,
            @RequestParam("token") String token,
            Model model) {
 		int boardCode = 1;
        boolean success = service.verifyParticipant(recruitmentNo, token);

        if (success) {
            model.addAttribute("message", "인증이 성공적으로 완료되었습니다!");
        } else {
            model.addAttribute("message", "인증 실패: 유효하지 않은 접근입니다.");
        }
        model.addAttribute("boardCode", boardCode);
        // 인증 결과 안내 페이지로 이동
        return "Individual/result"; 
    }
 	
 	// 신고
 	@PostMapping("/report/submit")
 	@ResponseBody
    public Map<String, Object> submitReport(@RequestBody Report report,
                                            @SessionAttribute("loginMember") Member loginMember) {

        report.setMemberNo(loginMember.getMemberNo()); // 로그인한 사용자 설정
        report.setReportStatus("대기");

        int result = service.insertReport(report);

        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        return response;
    }
}
