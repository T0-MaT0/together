package edu.kh.project.chatting.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Message {
	private int messageNo;           // 메시지 PK
    private String messageContent;   // 메시지 내용
    private String messageType;      // 메시지 타입 (TEXT, IMAGE, EMOJI 등)
    private String sendTime;         // 보낸 시간 (가공된 문자열)

    private int senderNo;            // 보낸 사람 회원번호
    private int chattingNo;          // 채팅방 번호 (ROOM_NO)
    
    private int roomNo;
    private int targetNo; 

    // 추가 정보 (조인으로 가져오는 값들)
    private String senderNickname;   // 보낸 사람 닉네임
    private String senderProfile;    // 보낸 사람 프로필 이미지
}