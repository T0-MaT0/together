package edu.kh.project.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Board {
	
	private int boardNo;           // 게시글 고유 번호
    private String boardTitle;     // 제목
    private String boardContent;   // 내용
    private String bCreateDate;      // 작성일
    private String bUpdateDate;      // 수정일
    private String boardDelFl;     // 삭제 여부
    private String bState;         // 문의 상태
    private int memberNo;          // 회원 번호
    private int boardCd;           // 게시판 코드

}
