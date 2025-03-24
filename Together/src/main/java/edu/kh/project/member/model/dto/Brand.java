package edu.kh.project.member.model.dto;

import lombok.Data;

@Data
public class Brand {
    private int memberNo;
    private String memberName;
    private String memberNick;
    private String memberEmail;
    private String memberAddr;
    private String memberTel;
    private String memberGrade;
    private String profileImage;
    private String businessNo;
    private int sumReadCount;

}
