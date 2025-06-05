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

    // RECRUITMENT_ROOM 테이블
    private int recruitmentNo;         // 모집방 고유 번호 (PK)
    private int productNo;             // 상품 번호 (FK -> PRODUCT)
    private int currentParticipants;   // 현재 모집 인원 (계산값)
    private int maxParticipants;       // 모집 최대 인원
    private String recruitmentStatus;  // 모집 상태 (진행, 마감, 완료 등)
    private String recEndDate;         // 모집 마감일 (YYYY-MM-DD)
    private String region;             // 지역 코드 또는 명칭
    private String productUrl;         // 상품 URL 주소

    // RECRUITMENT_PARTICIPANT 테이블
    private String joinDate;           // 참가일 (SYSDATE)
    private String cancelDate;         // 취소일
    private int myQuantity;            // 내가 담은 수량
    private int myParticipationCount;  // 내가 현재 참여 중인 수량

    // PRODUCT 테이블
    private String productTitle;       // 상품명
    private String productContent;     // 상품 설명
    private int productPrice;          // 상품 가격
    private int productCount;          // 총 재고
    private int deliveryFee;           // 배송비
    private int readCount;             // 조회수
    private int categoryNo;            // 카테고리 번호
    private Integer parentCategoryNo;  // 상위 카테고리 번호
    private Date pCreateDate;        // 등록일자
    
    // MEMBER (방장) 정보
    private int hostNo;                // 방장 회원 번호
    private String hostName;           // 방장 닉네임
    private String hostGrade;          // 방장 등급명
    private String hostProfile;        // 방장 프로필 이미지 경로

    // MEMBER (로그인 유저) 정보
    private int memberNo;              // 회원 번호
    private String memberNick;         // 회원 닉네임
    private String memberAddr;         // 회원 주소
    private int point;                 // 회원 보유 포인트
    private String memberGrade;        // 회원 등급명
    private String profileImg;         // 회원 프로필 이미지

    // IMG 테이블
    private List<Image> imageList;     // 이미지 전체 리스트
    private String thumbnail;          // 대표 썸네일 경로
    private List<Image> mainBannerList;// 메인 배너 이미지 리스트

    // 댓글 (REPLY)
    private List<Reply> commentList;   // 댓글 리스트

    // 배송/QR 인증 (RECRUITMENT_DELIVERY / QR_AUTH)
    private int deliveryId;            // 배송 고유 ID
    private String trackingNumber;     // 운송장 번호
    private Date deliveryExpected;     // 택배 도착 예정일
    private Date memberReceiveDate;    // 파티원 수령 예정일
    private String qrToken;            // QR 인증 토큰
    private int qrId;                  // QR 인증 ID
    private String qrImagePath;        // QR 이미지 경로

    // 인증 상태
    private String certStatus;         // 'Y' or 'N'
}