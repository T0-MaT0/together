package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CustomerProfile {
	
    private Long memberNo;           // 회원 번호
    private String memberNick;       // 회원 닉네임
    private String profileImg;       // 프로필 이미지
    private String state;            // 회원 상태 (회원, 탈퇴, 블랙)
    
    private int replyCount;          // 작성한 댓글 개수
    private int getherCount;         // 작성한 게시글 개수 (BOARD_CD = 1)
    private int orderCount;          // 주문 개수
    private int warnCount;           // 받은 경고 개수
    private int reportCount;         // 신고한 횟수
    private int reportedCount;       // 신고당한 횟수
    private int questCount;          // 문의
    
    private String memberId;         // 회원 ID
    private String memberName;       // 회원 이름
    private String memberBirth;   // 회원 생년월일
    private String EnrollDate;   // 회원 가입일 
    private String memberEmail;      // 회원 이메일
    private String memberTel;        // 회원 전화번호
    private String memberAddr;       // 회원 주소

}
