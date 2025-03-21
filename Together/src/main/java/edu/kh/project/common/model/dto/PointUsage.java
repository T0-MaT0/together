package edu.kh.project.common.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointUsage {
	private int usageNo;
	private int usageAmount;
	private int usageType;
	private int usageTypeNo;
	private String status;
	private String usageDate;
	private int memberNo;
}
