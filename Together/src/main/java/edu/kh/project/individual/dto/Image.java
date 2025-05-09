package edu.kh.project.individual.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Image {
    private int imageNo;          // 이미지 고유 번호 (PK)
    private String imageReName;   // 저장된 파일명
    private String imagePath;     // 저장 경로
    private String imageOriginal; // 원본 파일명
    private int imageLevel;       // 이미지 레벨 (0 = 대표, 1~ = 추가)
    private String imageType;     // 이미지 타입 (ex: RECRUITMENT, PRODUCT, REVIEW 등)
    private int imageTypeNo;      // 타입에 해당하는 대상 번호 (모집글 번호 등)
}
