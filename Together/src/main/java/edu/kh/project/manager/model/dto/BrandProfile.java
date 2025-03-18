package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BrandProfile {


    private int memberNo;               // 회원 번호
    private String memberNick;          // 회원 닉네임
    private String memberId;            // 회원 ID
    private String memberName;          // 회원 이름
    private String memberBirth;           // 회원 생년월일
    private String enrollDate;            // 가입일
    private String memberEmail;         // 회원 이메일
    private String memberTel;           // 회원 전화번호
    private String memberAddr;          // 회원 주소
    private String permissionTFl;       // 제휴 여부 ('미제휴' 또는 '제휴')
    private int replyCount;             // 댓글 개수
    private int productCount;           // 상품 개수
    private int promCount;              // 프로모션 개수
    private int counselCount;              // 프로모션 개수
    private int wranCount;              // 경고 받은 횟수
    private int reportedCount;          // 신고 받은 횟수
    private int reportCount;            // 총 신고한 횟수
    
    private String businessNo;
    private String bankName;
    private String bankNo;
    
}
