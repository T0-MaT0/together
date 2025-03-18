package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CustomerBoard {
	private int boardNo;
	private String memberNick;
	private String boardTitle;
	private String createDate;
	private String endDate;
	private String recruitmentStatus;
	private String boardDelFl;
}
