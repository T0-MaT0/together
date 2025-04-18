package edu.kh.project.member.model.dto;

import lombok.Data;

@Data
public class Product {
	private int boardNo;
    private String boardTitle;
    private String boardContent;
    private int boardCode;
    private String imgPath;
    private int price;
    private int readCount;
    private String category;
    private int categoryNo;

    private String purchaseDate;

    private int reviewNo;
    private String reviewContent;
    private int reviewScore;
    private String reviewDate;

}
