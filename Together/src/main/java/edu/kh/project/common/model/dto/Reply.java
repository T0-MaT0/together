package edu.kh.project.common.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply {
	private int replyNo;
	private String replyCreatedDate;
	private String replyDelFlag;
	private String replyContent;
	private String secretReplyStatus;
	private int memberNo;
	private int replyType;
	private int replyTypeNo;
	private int parentNo;
	
	private String memberNickname;

	private String thumbnail;
	
	private List<Reply> commentList;
}
