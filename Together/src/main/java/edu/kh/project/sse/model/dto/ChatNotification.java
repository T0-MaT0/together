package edu.kh.project.sse.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatNotification {
    private int notiId;
    private int unreadCount;
    private int memberNo;     // 알림 받을 사람
    private int messageNo;
    private int roomNo;
}