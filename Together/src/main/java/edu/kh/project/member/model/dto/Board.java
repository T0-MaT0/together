package edu.kh.project.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Board {
	
	private int boardNo;             // 게시글 고유 번호
    private String boardTitle;       // 제목
    private String boardContent;     // 내용
    private String bCreateDate;      // 작성일
    private String bUpdateDate;      // 수정일
    private String boardDelFl;       // 삭제 여부
    private String bState;           // 문의 상태 (ex: 답변대기, 답변완료)
    private int memberNo;            // 작성자(회원 번호)
    private int inquiryCategoryNo;   // 문의 카테고리 번호 (1: 광고, 2: 제휴, 3: 1:1)


}
