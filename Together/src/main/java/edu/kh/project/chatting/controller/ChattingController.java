package edu.kh.project.chatting.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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

    /** 채팅방 목록 조회 */
    @GetMapping(value = "/chatting/roomList", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<ChattingRoom> selectRoomList( @SessionAttribute(name = "loginMember", required = false) Member loginMember) {
        return service.getChattingList(loginMember.getMemberNo());
    }

    /** 사이드바 채팅 목록 */
    @GetMapping("/sidebar/chat")
    public String loadChatSidebar() {
        return "common/sidebar/sideBar-chat";
    }

    /** 사이드바 채팅방 열기 */
    @GetMapping("/sidebar/chatOpen")
    public String loadChatOpenSidebar(@RequestParam("chattingNo") int chattingNo) {
        return "common/sidebar/sideBar-chatOpen";
    }

    /** 채팅 메시지 조회 */
    @GetMapping(value = "/chatting/selectMessageList", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Message> selectMessageList(@RequestParam Map<String, Object> paramMap) {
        return service.selectMessageList(paramMap);
    }

    /** 채팅 대상 정보 조회 */
    @GetMapping("/chatting/targetInfo")
    @ResponseBody
    public List<Object> getChatTargetInfo(@RequestParam("roomNo") int roomNo,
    										@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
        return service.selectChatTarget(roomNo, loginMember.getMemberNo());
    }

    /** 채팅방 삭제 */
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

    /** 이미지 전송 */
    @PostMapping("/chatting/image")
    @ResponseBody
    public Message uploadChatImage(@RequestParam("image") MultipartFile image,
                                   @RequestParam("roomNo") int roomNo,
                                   @RequestParam("senderNo") int senderNo,
                                   HttpSession session) throws Exception {

        String webPath = "/resources/images/chatting/";
        String filePath = session.getServletContext().getRealPath(webPath);

        String originalName = image.getOriginalFilename();
        String renamed = Utill.fileRename(originalName);

        Image img = new Image();
        img.setImageOriginal(originalName);
        img.setImageReName(renamed);
        img.setImagePath(webPath + renamed);
        img.setImageType("CHAT");
        img.setImageTypeNo(0);

        File directory = new File(filePath);
        if (!directory.exists()) directory.mkdirs();
        image.transferTo(new File(filePath + renamed));

        Message msg = new Message();
        msg.setRoomNo(roomNo);
        msg.setSenderNo(senderNo);
        msg.setMessageType("IMAGE");
        msg.setMessageContent(webPath + renamed);

        int messageNo = service.insertImageMessage(msg);
        msg.setMessageNo(messageNo);

        img.setImageTypeNo(messageNo);
        service.insertChatImage(img);

        Member loginMember = (Member) session.getAttribute("loginMember");
        msg.setSenderNickname(loginMember.getMemberNick());
        msg.setSenderProfile(loginMember.getProfileImg());

        return msg;
    }

    /** 이모지 전송 */
    @PostMapping("/chatting/emoji")
    @ResponseBody
    public Message sendEmoji(@RequestBody Message msg, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        msg.setSenderNickname(loginMember.getMemberNick());
        msg.setSenderProfile(loginMember.getProfileImg());
        msg.setMessageType("EMOJI");
        int result = service.insertMessage(msg);
        return result > 0 ? msg : null;
    }

    /** BIG 이모지 목록 조회 */
    @ResponseBody
    @GetMapping("/chatting/bigEmojis")
    public List<ChatEmoji> getBigEmojis() {
        return service.getBigEmojiList();
    }

    /** 채팅방 참여자 목록 */
    @GetMapping("/chatting/memberList")
    @ResponseBody
    public Map<String, Object> getChatRoomMembers(@RequestParam("roomNo") int roomNo) {
        List<Member> memberList = service.selectRoomMemberList(roomNo);
        ChattingRoom roomInfo = service.selectRoomName(roomNo);

        Map<String, Object> result = new HashMap<>();
        result.put("roomName", roomInfo.getRoomName());
        result.put("ownerMemberNo", roomInfo.getOwnerMemberNo());
        result.put("memberCount", memberList.size());
        result.put("members", memberList);

        return result;
    }

    /** 방장 - 채팅방 유저 추방 */
    @PostMapping("/chatting/kickMember")
    @ResponseBody
    public Map<String, Object> kickMemberFromRoom(@RequestBody Map<String, Integer> payload) {
        int roomNo = payload.get("roomNo");
        int targetMemberNo = payload.get("targetMemberNo");

        Map<String, Object> result = new HashMap<>();
        try {
            int deleteResult = service.kickMemberFromRoom(roomNo, targetMemberNo);
            result.put("success", deleteResult > 0);
            if (deleteResult <= 0) result.put("message", "이미 삭제되었거나 존재하지 않음");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류 발생");
        }
        return result;
    }

    /** 1:1 채팅 시작 */
    @PostMapping("/chatting/private/start")
    @ResponseBody
    public Map<String, Object> startPrivateChat(@RequestBody Map<String, Object> payload,
    											@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
        int myMemberNo = loginMember.getMemberNo();
        int targetMemberNo = Integer.parseInt(payload.get("targetMemberNo").toString());
        String roomName = (String) payload.get("targetNick");

        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> roomResult = service.createOrGetPrivateChatRoom(myMemberNo, targetMemberNo, roomName);
            result.put("success", true);
            result.put("roomNo", roomResult.get("roomNo"));
            result.put("isNew", roomResult.get("isNew"));
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

}