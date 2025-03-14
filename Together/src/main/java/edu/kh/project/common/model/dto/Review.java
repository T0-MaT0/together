package edu.kh.project.common.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review {
	private int reviewNo;
	private String reviewContent;
	private int reviewStar;
	private String reviewCreatedDate;
	private String reviewUpdateDate;
	private String reviewDelFleg;
	private int reviewType;
	private int reviewTypeNo;
	private int memberNo;
}
