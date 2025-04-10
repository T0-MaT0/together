package edu.kh.project.individual.dto;

import java.util.Date;
import java.util.List;

import edu.kh.project.common.model.dto.Reply;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Recruitment {

	// 공동구매 모집방 DTO
    private int recruitmentNo;       // 모집방 고유 번호
    private int currentParticipants; // 현재 모집 인원
    private int maxParticipants;     // 모집 최대 인원
    private String recruitmentStatus; // 모집 상태 (모집 중, 완료 등)
    private String recCreatedDate;   // 모집 생성일 (MM/DD HH:mm)
    private String recEndDate;       // 모집 마감일 (MM/DD HH:mm)
    private String region;              // 지역
    private String productUrl;       // 상품 URL
    private int qrCode;              // QR 코드
    private String qrImagePath;
    private int boardNo;             // 게시글 번호
    private int boardCode;           // 게시판 코드 (BOARD_TYPE에서 가져옴)

    // 공동구매 참가자 DTO
    private String joinDate;   // 참가일 (MM/DD HH:mm)
    private String cancelDate; // 취소일 (MM/DD HH:mm)

    // 공동구매 상품 DTO
    private String productName;  // 상품명
    private String boardTitle; // BOARD_TITLE
    private String boardContent; // 상품내용
    private Integer productPrice;    // 상품 가격
    private int productCount;    // 상품 재고 수량
    private int deliveryFee;     // 배송비
    private int readCount;       // 조회수
    private int categoryNo;      // 카테고리 번호
    private Integer parentCategoryNo; // 부모 카테고리 번호

    // 방장 정보
    private String hostNo;   // 방장 No
    private String hostName;   // 방장 닉네임
    private String hostGrade;     // 방장 등급
    private String hostProfile; // 방장 프로필 이미지
    private Integer myQuantity;     // 개인별 참여 몫
    private int myParticipationCount; // 내가 몇 인분 참여 중인지
    
    // 멤버 정보 추가
    private String memberNick;
    private String memberAddr;
    private int point;
    private String memberGrade;
    private String profileImg;
    private int memberNo;
    
    // 이미지 관련 정보
    private List<Image> imageList;   // 모집방 관련 이미지 리스트 (상품 이미지 포함)
    private String thumbnail;        // 대표 썸네일 이미지
    private List<Image> mainBannerList;
    
    // 댓글 관련 정보
    private List<Reply> commentList;
    
    // 배송/인증 관련 정보
    private String trackingNumber;      // 운송장 번호
    private String deliveryExpected;    // 택배 예상 도착일 (String 또는 Date)
    private String memberReceiveDate;   // 파티원 수령 예정일 (String 또는 Date)
    private String qrToken;
    
    // 인증용
    private String certStatus;
}
