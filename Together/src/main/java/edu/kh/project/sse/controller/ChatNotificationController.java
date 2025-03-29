package edu.kh.project.sse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.sse.model.dto.ChatNotification;
import edu.kh.project.sse.model.service.ChatNotificationService;

@RestController
@RequestMapping("/chat/notification")
public class ChatNotificationController {

    @Autowired
    private ChatNotificationService service;

    // SSE 연결
    @GetMapping(value = "/connect", produces = "text/event-stream")
    public SseEmitter connect(@SessionAttribute("loginMember") Member loginMember) {
        return service.connect(loginMember.getMemberNo());
    }

    // 알림 보내기
    @PostMapping("/send")
    public void sendNotification(@RequestBody Map<String, Integer> data,
                                  @SessionAttribute("loginMember") Member loginMember) {
    	int roomNo = data.get("roomNo");
        int senderNo = loginMember.getMemberNo();

        ChatNotification noti = new ChatNotification();
        noti.setRoomNo(roomNo);
        noti.setMemberNo(senderNo);

        service.sendChatNotification(noti);
    }

    // 알림 목록 조회
    @GetMapping("/list")
    public List<ChatNotification> getList(@SessionAttribute("loginMember") Member loginMember) {
        return service.getNotifications(loginMember.getMemberNo());
    }

    // 읽음 처리
    @PutMapping("/read")
    public void read(@SessionAttribute("loginMember") Member loginMember,
                     @RequestBody Map<String, Integer> param) {
        int roomNo = param.get("roomNo");
        service.markAsRead(loginMember.getMemberNo(), roomNo);
    }
    
    // 안 읽은 모든 채팅 수
    @GetMapping("/count")
    public int getTotalUnreadCount(@SessionAttribute("loginMember") Member loginMember) {
    	int memberNo = loginMember.getMemberNo();
        return service.getTotalUnreadCount(memberNo);
    }
}
