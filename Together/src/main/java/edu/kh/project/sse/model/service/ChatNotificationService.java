package edu.kh.project.sse.model.service;

import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.kh.project.sse.model.dto.ChatNotification;

public interface ChatNotificationService {

	SseEmitter connect(int memberNo);

	void sendChatNotification(ChatNotification noti);

	List<ChatNotification> getNotifications(int memberNo);

	// 읽음 처리
	void markAsRead(int memberNo, int roomNo);

	// 읽지 않은 모든 채팅 수 
	int getTotalUnreadCount(int memberNo);

	
}
