package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReportChatting {
	private String memberNick;
    private int messageNo;
    private String messageContent;
    private String messageType;
    private String sendDate;
    private String sendTime;
    private int memberNo;
    private int roomNo;
    private int reportedMemberNo;
}
