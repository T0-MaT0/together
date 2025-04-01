package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CustomerBoard {
	
	private int memberNo;
	private String memberNick;
	
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	
	private String createDate;
	private String endDate;
	private String recruitmentStatus;
	private String boardDelFl;
	private String state;
	
	
	private String reply;
}
