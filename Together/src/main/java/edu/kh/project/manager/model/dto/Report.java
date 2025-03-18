package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Report {
	
	private String reportType;
	private int reportNo;
	private String memberNick;
	private String reportedUserNick;
	private String reportTitle;
	private String reportDate;
	private String reportStatus;
}
