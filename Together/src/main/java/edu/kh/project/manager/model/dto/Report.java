package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Report {
	
	private String reportTypeName;
	private String reportType;
	private int reportTypeNo;
	
	private int reportNo;
	private String reportTitle;
	private String reportDetail;
	
	private String memberNick;
	private String reportedUserNick;
	private int memberNo;
	private int reportedUserNo;
	
	private String reportDate;
	private String reportStatus;
	
	private String reply;
	
}
