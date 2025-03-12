package edu.kh.project.business.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BusinessImage {
	private int imageNo;
	private String imagePath;
	private String imageReName;
	private String imageOriginal;
	private int imageLevel;
	private int imageType;
	private int imageTypeNo;
}
