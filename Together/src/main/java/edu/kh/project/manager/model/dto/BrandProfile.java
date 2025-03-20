package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BrandProfile {

    private int memberNo; // 회원 번호
    
    private String memberNick; // 회원 닉네임
    private String profileImg; // 프로필 이미지
    private String companyState; // 회사 제휴 상태
    private String state; // 회원 상태 (탈퇴, 블랙리스트 등)
    
    private int replyCount; // 댓글 수
    private int productCount; // 상품 수
    private int getherCount; // 모임 수
    private int promCount; // 프로모션 수
    private int sellCount; // 판매 수
    private int warnCount; // 경고 수
    private int reportCount; // 신고한 수
    private int reportedCount; // 신고받은 수
    private int questCount; // 질문 수
    
    private String memberId; // 회원 아이디
    private String memberName; // 회원 이름
    private String memberBirth; // 생일
    private String enrollDate; // 가입일
    private String memberEmail; // 이메일
    private String memberTel; // 전화번호
    
    private String businessNo; // 사업자 번호
    private String bankName; // 은행명
    private String bankNo; // 은행 계좌 번호
    private String memberAddr; // 주소
}
