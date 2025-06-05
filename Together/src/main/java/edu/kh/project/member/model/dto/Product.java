package edu.kh.project.member.model.dto;

import lombok.Data;

@Data
public class Product {

    // 기본 상품 정보
    private int productNo;
    private String productTitle;
    private String productContent;
    private int price;
    private int readCount;

    // 이미지 경로 (썸네일)
    private String imgPath;

    // 카테고리 정보
    private String category;
    private int categoryNo;

    // 구매일자 (찜, 검색 결과 등에서 사용될 수 있음)
    private String purchaseDate;

    // 리뷰 정보 (선택적으로 사용)
    private int reviewNo;
    private String reviewContent;
    private int reviewScore;
    private String reviewDate;

    // 공동구매 관련 정보 (검색 결과에서 표시 가능)
    private int currentParticipants;
    private int maxParticipants;
}
