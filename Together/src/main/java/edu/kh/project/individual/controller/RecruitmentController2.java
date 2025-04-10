package edu.kh.project.individual.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.individual.service.RecruitmentService2;
import edu.kh.project.member.model.dto.Member;

@RestController
public class RecruitmentController2 {

	@Autowired
	private RecruitmentService2 service;
	private static final Gson gson = new Gson();
	
	// 모집글 상태 변경
	@PostMapping("/updateRecruitmentStatus")
	public ResponseEntity<Map<String, Object>> updateRecruitmentStatus(@RequestBody Map<String, Integer> requestData) {
        int boardNo = requestData.get("boardNo");
        int loginMemberNo = requestData.get("loginMemberNo");

        Map<String, Object> response = new HashMap<>();

        int hostMemberNo = service.getHostMemberNo(boardNo); 

        if (hostMemberNo != loginMemberNo) {
            response.put("success", false);
            response.put("message", "방장만 모집을 마감할 수 있습니다.");
            return ResponseEntity.ok(response);
        }

        service.updateRecruitmentStatus(boardNo);

        response.put("success", true);
        return ResponseEntity.ok(response);
    }
	
	// 모집글 삭제 (BOARD_DEL_FL = 'Y' 업데이트)
    @PostMapping("/deleteRecruitment")
    public ResponseEntity<Map<String, Object>> deleteRecruitment(@RequestBody Map<String, Integer> requestData) {
        int boardNo = requestData.get("boardNo");
        int loginMemberNo = requestData.get("loginMemberNo");

        Map<String, Object> response = new HashMap<>();
        int hostMemberNo = service.getHostMemberNo(boardNo); 

        if (hostMemberNo != loginMemberNo) {
            response.put("success", false);
            response.put("message", "방장만 모집글을 삭제할 수 있습니다.");
            return ResponseEntity.ok(response);
        }

        service.deleteRecruitment(boardNo); 

        response.put("success", true);
        return ResponseEntity.ok(response);
    }
    
    // 선택 댓글 삭제
    @PostMapping("/reply/deleteComments")
    public ResponseEntity<String> deleteComments(@RequestBody String jsonRequest) {

        // JSON을 파싱하여 replyNos 리스트 추출
        JsonObject jsonObject = gson.fromJson(jsonRequest, JsonObject.class);
        java.lang.reflect.Type listType = new TypeToken<List<Integer>>(){}.getType();
        List<Integer> replyNos = gson.fromJson(jsonObject.get("replyNos"), listType);


        // 서비스 호출하여 댓글 삭제
        boolean isDeleted = service.deleteComments(replyNos);

        if (isDeleted) {
            return ResponseEntity.ok("{\"success\": true, \"message\": \"삭제 완료\"}");
        } else {
            return ResponseEntity.ok("{\"success\": false, \"message\": \"삭제 실패\"}");
        }
    }
    
    // 리뷰 삭제
    @PostMapping("/review/deleteReviews")
    public ResponseEntity<Map<String, Object>> deleteReviews(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> reviewNos = requestData.get("reviewNos");
        
        boolean result = service.deleteReviews(reviewNos);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result);
        
      
        return ResponseEntity.ok(response);
    }
    
    // 댓글 등록
    @PostMapping("/reply/add")
    public String addReply(@RequestBody Reply reply, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null) {
            return "로그인이 필요합니다."; 
        }

        reply.setMemberNo(loginMember.getMemberNo());
        reply.setReplyType(1);

        int result = service.insertReply(reply);

        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
    
    // 댓글 삭제
    @PostMapping("/reply/delete")
    public String deleteReply(@RequestBody Map<String, Integer> requestData,
                              HttpSession session) {

        // 로그인 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "loginNeeded";
        }

        int replyNo = requestData.get("replyNo");
        // 댓글 작성자와 같은지 확인한 뒤 삭제 처리
        int result = service.deleteReply(replyNo, loginMember.getMemberNo());

        return (result > 0) ? "success" : "fail";
    }
    
    // 관리자
    @PostMapping("/board/delete")
    public String deleteBoard(@RequestBody Map<String, Integer> param,
                              @SessionAttribute("loginMember") Member loginMember) {

        int boardNo = param.get("boardNo");

        // 관리자만 허용
        if (loginMember.getAuthority() != 1) {
            return "unauthorized";
        }

        int result = service.deleteBoard(boardNo);
        return result > 0 ? "success" : "fail";
    }
        
 
      
}
