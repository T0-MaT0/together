package edu.kh.project.individual.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Image {
	private int imageNo;
	private String imageReName;
	private String imagePath;
	private String imageOriginal;
	private int imageLevel;
	private int imageType;
	private int imageTypeNo;
}
