package edu.kh.project.common.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointHistory {
	
	 	private int pointHistoryNo;
	    private Date usedDate;
	    private int pointAmount;
	    private String usageDetail;
	    private String pointType;
	    private int pointTypeNo;
	    private int memberNo;
	
}
