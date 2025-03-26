package edu.kh.project.chatting.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChattingRoom {
	private int roomNo;
    private String roomName;

    private String lastMessage;
    private String lastSendTime;

    private String targetNickname;
    private String targetProfile;

    private int unreadCount;
    private int maxMessageNo;
    private String ownerProfile;
    private int ownerMemberNo;
}