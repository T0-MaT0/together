package edu.kh.project.chatting.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatEmoji {
    private int emojiNo;         // 이모지 고유 번호
    private int messageId;       // 메시지 연동용 (큰 이모지)
    private String emojiCode;    // 미니이모지 / 큰 이모지
    private String emojiType;    // MINI or BIG
}
