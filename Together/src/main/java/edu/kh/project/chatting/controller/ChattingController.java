package edu.kh.project.chatting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.chatting.service.ChattingService;
import edu.kh.project.member.model.dto.Member;

@Controller
public class ChattingController {

	@Autowired
	private ChattingService service;
	
	// 비동기 채팅방 목록 불러오기
	@GetMapping(value = "/chatting/roomList", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<ChattingRoom> selectRoomList(@SessionAttribute("loginMember") Member loginMember) {
	    return service.getChattingList(loginMember.getMemberNo());
	}
	
	// 채팅방 목록 jsp연결
	@GetMapping("/sidebar/chat")
	public String loadChatSidebar() {
	    return "common/sidebar/sideBar-chat"; 
	}
	
	// 채팅 화면 연결
	@GetMapping("/sidebar/chatOpen")
	public String loadChatOpenSidebar(@RequestParam("chattingNo") int chattingNo) {
	    return "common/sidebar/sideBar-chatOpen"; 
	}
	
	// 메세지 조회
	@GetMapping(value = "/chatting/selectMessageList", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Message> selectMessageList(@RequestParam Map<String, Object> paramMap){
		System.out.println("paramMap : " + paramMap);
	    return service.selectMessageList(paramMap);
	}
	
	// 상대 프로필 표시용 
	@GetMapping("/chatting/targetInfo")
	@ResponseBody
	public Member getChatTargetInfo(@RequestParam("roomNo") int roomNo,
	                                @SessionAttribute("loginMember") Member loginMember) {
	    return service.selectChatTarget(roomNo, loginMember.getMemberNo());
	}
	
//	// 채팅 화면
//	@GetMapping("/chatting")
//	public String chatting(@SessionAttribute("loginMember") Member loginMember
//							,Model model) {
//		
//        int memberNo = loginMember.getMemberNo();
//        
//        List<ChattingRoom> chattingList = service.getChattingList(memberNo);
//        
//        model.addAttribute("chattingList", chattingList);
//
//        return "chatting/chatting";
//		
//		
//		
//	}
//	
//	// 닉네임 또는 이메일로 회원 검색 
//    @GetMapping(value = "/chatting/selectTarget", produces="application/json; charset=UTF-8")
//    @ResponseBody
//    public List<Member> searchTarget(String query
//    								,@SessionAttribute("loginMember") Member loginMember) {
//    	
//    	Map<String, Object> map = new HashMap<String, Object>();
//    	map.put("query", query);
//    	map.put("memberNo", loginMember.getMemberNo());
//    	
//    	
//        return service.searchTargetList(map);
//    }
//    
//    // 채팅방 존재여부 확인(없으면 생성)
//    @GetMapping("/chatting/enter")
//    @ResponseBody
//    public int chattingEnter(int targetNo
//    							,@SessionAttribute("loginMember") Member loginMember){
//    	
//    	
//    	Map<String, Integer> map = new HashMap<String, Integer>();
//    	map.put("targetNo", targetNo);
//    	map.put("loginMemberNo", loginMember.getMemberNo());
//    	
//    	int chattingNo = service.chattingEnter(map);
//    	
//    	if(chattingNo == 0) { // 기존에 채팅방이 없는 경우
//    		
//    		// 채팅방 생성
//    		chattingNo = service.createChattingRoom(map);
//    	}
//    	return chattingNo;
//    }
//    
//    
//    // 비동기로 글 읽음으로 변경
//    @PutMapping("/chatting/updateReadFlag")
//    @ResponseBody
//    public int updateReadFlag(@RequestBody Map<String, Object> paramMap) {
//
//        int result = service.updateReadFlag(paramMap);
//
//        return result;
//    }
//    
//    // 채팅방 메세지 목록 조회
//    @GetMapping(value = "chatting/selectMessageList", produces = "application/json; charset=UTF-8")
//    @ResponseBody
//    public List<Message> selectMessageList(@RequestParam Map<String, Object> paramMap){
//    	return service.selectMessageList(paramMap);
//    }
 
}
