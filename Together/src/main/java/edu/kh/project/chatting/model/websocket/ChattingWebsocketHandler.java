package edu.kh.project.chatting.model.websocket;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.chatting.service.ChattingService;
import edu.kh.project.member.model.dto.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChattingWebsocketHandler extends TextWebSocketHandler{

	private Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());
	
	@Autowired
	private ChattingService service;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		
		log.info("{}연결됨", session.getId());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

	    log.info("전달 받은 내용 : {}", message.getPayload());

	    ObjectMapper objectMapper = new ObjectMapper();
	    Message msg = objectMapper.readValue(message.getPayload(), Message.class);
	    log.info("Message : {}", msg);

	    // 로그인 회원 정보
	    Member loginMember = (Member) session.getAttributes().get("loginMember");
	    log.info("loginMember : {}", loginMember);

	    // 보낸 사람 정보 설정
	    msg.setSenderProfile(loginMember.getProfileImg());
	    msg.setSenderNickname(loginMember.getMemberNick());

	    int result = 0;

	    // 이미지가 아닌 경우 DB 저장
	    if (!"IMAGE".equals(msg.getMessageType())) {
	        result = service.insertMessage(msg);
	    } else {
	        result = 1; // 이미지 전송이면 그냥 성공 처리
	    }

	    // 저장 성공 후
	    if (result > 0) {

	        // 시간 설정
	        if (msg.getSendTime() == null || msg.getSendTime().isEmpty()) {
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	            msg.setSendTime(sdf.format(new Date()));
	        }

	        // 같은 roomNo를 가진 사용자에게 메시지 전송
	        for (WebSocketSession s : sessions) {
	            Member m = (Member) s.getAttributes().get("loginMember");
	            if (m == null) continue;

	            String sessionRoomNo = String.valueOf(s.getAttributes().get("roomNo"));
	            String msgRoomNo = String.valueOf(msg.getRoomNo());
	            log.info("🧾 세션 비교 - sessionRoomNo={}, msgRoomNo={}", sessionRoomNo, msgRoomNo);
	            if (sessionRoomNo.equals(msgRoomNo)) {
	                s.sendMessage(new TextMessage(new Gson().toJson(msg)));
	                log.info("💬 메시지 보냄 to {}", m.getMemberNick());
	            }
	        }
	    }
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}
	
	
}
