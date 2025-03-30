package edu.kh.project.sse.model.service;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.google.gson.Gson;

import edu.kh.project.sse.model.dao.ChatNotificationDAO;
import edu.kh.project.sse.model.dto.ChatNotification;

@Service
public class ChatNotificationServiceImpl implements ChatNotificationService {

    private final ConcurrentMap<Integer, SseEmitter> emitterMap = new ConcurrentHashMap<>();

    @Autowired
    private ChatNotificationDAO dao;

    @Override
    public SseEmitter connect(int memberNo) {
        SseEmitter emitter = new SseEmitter(10 * 60 * 1000L); // 10분 유지
        emitterMap.put(memberNo, emitter);

        emitter.onCompletion(() -> emitterMap.remove(memberNo));
        emitter.onTimeout(() -> emitterMap.remove(memberNo));
        emitter.onError(e -> emitterMap.remove(memberNo));

        try {
            emitter.send(SseEmitter.event().name("connect").data("connected"));
        } catch (IOException e) {
            emitter.completeWithError(e);
        }

        return emitter;
    }

    @Override
    public void sendChatNotification(ChatNotification noti) {
        int roomNo = noti.getRoomNo();
        int senderNo = noti.getMemberNo();

        // 마지막 메시지 번호 조회
        int messageNo = dao.selectLastMessageNo(roomNo);
        noti.setMessageNo(messageNo);

        // 상대방 memberNo 리스트 조회 (나를 제외한 참가자들)
        List<Integer> targetMemberNoList = dao.selectTargetMemberNoList(roomNo, senderNo);

        for (int targetNo : targetMemberNoList) {
            noti.setMemberNo(targetNo); // 개별 대상자에게 알림 세팅

            int exists = dao.checkExistingNotification(noti);

            if (exists > 0) {
                dao.updateNotification(noti);
            } else {
                dao.insertNotification(noti);
            }

            SseEmitter emitter = emitterMap.get(targetNo);
            if (emitter != null) {
                try {
                    emitter.send(SseEmitter.event()
                        .name("chat")
                        .data(new Gson().toJson(noti)));
                } catch (IOException e) {
                    emitterMap.remove(targetNo); // 에러 발생 시 제거
                }
            }
        }
    }

    @Override
    public List<ChatNotification> getNotifications(int memberNo) {
        return dao.selectNotificationList(memberNo);
    }

    // 읽음 처리
    @Override
    public void markAsRead(int memberNo, int roomNo) {
        dao.markAsRead(memberNo, roomNo);
    }

    // 읽지 않은 모든 채팅 수 
	@Override
	public int getTotalUnreadCount(int memberNo) {
		return dao.getTotalUnreadCount(memberNo);
	}
}
