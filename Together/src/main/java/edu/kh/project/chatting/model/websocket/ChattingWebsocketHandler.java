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
	    
	    // 1. 로그인한 사용자 정보 가져오기
	    Member loginMember = (Member) session.getAttributes().get("loginMember");

	    // 2. 메시지에 보낸 사람 프로필, 닉네임 세팅
	    msg.setSenderProfile(loginMember.getProfileImg());
	    msg.setSenderNickname(loginMember.getMemberNick());

	    // 3. DB 저장
	    int result = service.insertMessage(msg);

	    if(result > 0) {
	        // 4. 전송 시간 추가
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	        msg.setSendTime(sdf.format(new Date()));

	        // 5. 대상자에게만 메시지 전달
	        for(WebSocketSession s : sessions) {
	            Member m = (Member)s.getAttributes().get("loginMember");
	            if(m == null) continue;

	            int loginMemberNo = m.getMemberNo();

	            if(loginMemberNo == msg.getTargetNo() || loginMemberNo == msg.getSenderNo()) {
	                s.sendMessage(new TextMessage(new Gson().toJson(msg)));
	            }
	        }
	    }
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}
	
	
}
