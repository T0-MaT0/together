package edu.kh.project.sse.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.sse.model.dto.ChatNotification;

@Repository
public class ChatNotificationDAO {

	@Autowired
    private SqlSessionTemplate sqlSession;

	// 알림 업데이트 (기존 알림 존재 시 UNREAD_COUNT + 1, 마지막 메시지 갱신)
    public int updateNotification(ChatNotification noti) {
        return sqlSession.update("chatNotificationMapper.updateNotification", noti);
    }

    // 새로운 알림 삽입
    public void insertNotification(ChatNotification noti) {
        sqlSession.insert("chatNotificationMapper.insertNotification", noti);
    }

    // 로그인한 회원의 알림 목록 조회
    public List<ChatNotification> selectNotificationList(int memberNo) {
        return sqlSession.selectList("chatNotificationMapper.selectNotificationList", memberNo);
    }

    // 알림 읽음 처리 (room 기준 삭제)
    public void markAsRead(int memberNo, int roomNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("roomNo", roomNo);
        sqlSession.update("chatNotificationMapper.markAsRead", map);
    }

	public int selectLastMessageNo(int roomNo) {
		return sqlSession.selectOne("chatNotificationMapper.selectLastMessageNo", roomNo);
	}

	public int selectTargetMemberNo(int roomNo, int senderNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("roomNo", roomNo);
	    map.put("senderNo", senderNo);
	    return sqlSession.selectOne("chatNotificationMapper.selectTargetMemberNo", map);
	}

	// 알림 중복 체크
	public int checkExistingNotification(ChatNotification noti) {
		return sqlSession.selectOne("chatNotificationMapper.checkExistingNotification", noti);
	}

	// 읽지 않은 모든 채팅 수 
	public int getTotalUnreadCount(int memberNo) {
		return sqlSession.selectOne("chatNotificationMapper.getTotalUnreadCount", memberNo);
	}
}
