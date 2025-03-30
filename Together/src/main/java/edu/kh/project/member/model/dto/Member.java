package edu.kh.project.member.model.dto;



import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Member {

	

    private int memberNo;
    private String memberId;
    private String memberPw;
    private String memberNick;
    private String memberName;
    private String memberAddr;
    private String memberTel;
    private String profileImg;
    private Date enrollDate;
    private String memberEmail;
    private String memberDelFl;
    private int authority;
    private String memberGrade;
    private String memberBirth;
    private int point;

	  


}
