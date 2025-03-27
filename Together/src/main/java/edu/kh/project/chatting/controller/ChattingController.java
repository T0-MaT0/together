package edu.kh.project.chatting.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.chatting.service.ChattingService;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.individual.dto.Image;
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
	public List<Object> getChatTargetInfo(@RequestParam("roomNo") int roomNo,
	                                @SessionAttribute("loginMember") Member loginMember) {
	    return service.selectChatTarget(roomNo, loginMember.getMemberNo());
	}
	
	// 채팅방 삭제
	@PostMapping("/chatting/deleteRoom")
	@ResponseBody
	public Map<String, Object> deleteRoom(@RequestParam("roomNo") int roomNo, HttpSession session) {
	    Map<String, Object> map = new HashMap<>();

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        map.put("success", false);
	        map.put("error", "로그인 필요");
	        return map;
	    }

	    int loginMemberNo = loginMember.getMemberNo();
	    int ownerNo = service.selectOwnerNo(roomNo);

	    if (loginMemberNo != ownerNo) {
	        map.put("success", false);
	        map.put("error", "권한 없음");
	        return map;
	    }

	    int result = service.deleteRoom(roomNo, loginMemberNo);
	    map.put("success", result > 0);
	    return map;
	}
	
	// 이미지 입력
	@PostMapping("/chatting/image")
	@ResponseBody
	public Message uploadChatImage(@RequestParam("image") MultipartFile image,
	                               @RequestParam("roomNo") int roomNo,
	                               @RequestParam("senderNo") int senderNo,
	                               HttpSession session) throws Exception {

	    // 저장 경로 설정
	    String webPath = "/resources/images/chatting/";
	    String filePath = session.getServletContext().getRealPath(webPath);
	    System.out.println("filePath : " + filePath);
//	    String filePath = "C:/finalProject/Together/src/main/webapp/resources/images/chatting/";
//	    filePath : C:\workspace_git2\6_Framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Together\resources\images\chatting\

	    // 파일명 변경
	    String originalName = image.getOriginalFilename();
	    String renamed = Utill.fileRename(originalName);

	    // 이미지 정보 DTO 생성
	    Image img = new Image();
	    img.setImageOriginal(originalName);
	    img.setImageReName(renamed);
	    img.setImagePath(webPath + renamed);
	    img.setImageType(5); 
	    img.setImageTypeNo(0); 

	    // 이미지 저장
	    File directory = new File(filePath);
	    if (!directory.exists()) directory.mkdirs();

	    image.transferTo(new File(filePath + renamed));

	    // 메시지 먼저 저장
	    Message msg = new Message();
	    msg.setRoomNo(roomNo);
	    msg.setSenderNo(senderNo);
	    msg.setMessageType("IMAGE");
	    msg.setMessageContent(webPath + renamed); 

	    int messageNo = service.insertImageMessage(msg); 
	    msg.setMessageNo(messageNo);

	    // 이미지 IMG_TYPE_NO 갱신 후 저장
	    img.setImageTypeNo(messageNo);
	    service.insertChatImage(img);

	    // 닉네임, 프로필 동기화
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    msg.setSenderNickname(loginMember.getMemberNick());
	    msg.setSenderProfile(loginMember.getProfileImg());

	    return msg;
	}
	
	// 이모지 입력
	@PostMapping("/chatting/emoji")
	@ResponseBody
	public Message sendEmoji(@RequestBody Message msg, HttpSession session) {

	    Member loginMember = (Member) session.getAttribute("loginMember");

	    msg.setSenderNickname(loginMember.getMemberNick());
	    msg.setSenderProfile(loginMember.getProfileImg());
	    msg.setMessageType("EMOJI");

	    int result = service.insertMessage(msg);

	    if (result > 0) {
	        msg.setSendTime(new SimpleDateFormat("yyyy.MM.dd HH:mm").format(new Date()));
	        return msg;
	    } else {
	        return null;
	    }
	}
	
	// 이모지 조회
	@ResponseBody
	@GetMapping("/chatting/bigEmojis")
	public List<ChatEmoji> getBigEmojis() {
	    return service.getBigEmojiList();
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
