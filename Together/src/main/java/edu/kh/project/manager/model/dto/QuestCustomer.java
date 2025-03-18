package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class QuestCustomer {

	private int boardNo;
	private String profileImg;
	private String memberNick;
	private String boardTitle;
	private String createDate;
	private String boardDelFl;
}
