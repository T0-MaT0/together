package edu.kh.project.common.model.dto;

import java.util.List;

import edu.kh.project.business.model.dto.OrderDetail;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review {
  private int reviewNo;               // 리뷰 고유 번호
  private String reviewContent;       // 리뷰 내용
  private int reviewStar;             // 별점
  private String reviewCreatedDate;   // 리뷰 작성일
  private String reviewUpdateDate;    // 리뷰 수정일
  private String reviewDelFl;         // 삭제 여부
  private String reviewType;          // 리뷰 유형 (ex. "RECRUITMENT")
  private int reviewTypeNo;           // 리뷰 대상 고유 번호
  private int memberNo;               // 작성자 번호
  private int orderNo;                // 주문 번호

  private String memberNickname;      // 작성자 닉네임
  private String memberProfile;       // 작성자 프로필 이미지
  private String businessThumbnail;   // 브랜드 썸네일 (해당 경우만)
  private String optionName;          // 주문 옵션명
  private int quantity;               // 주문 수량

  private List<Image> imageList;      // 리뷰에 첨부된 이미지 목록
  private List<Reply> replyList;      // 해당 리뷰에 달린 댓글 목록

  private String productTitle;        // 게시글 제목 (JOIN PRODUCT)
  private int productNo;              // 게시글 번호 (JOIN PRODUCT)
}
