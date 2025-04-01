package edu.kh.project.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardType {
	
	private int boardCd;           // 게시판 코드
    private String boardName;      // 게시판 이름
    private Integer parentBoardCd; // 부모 게시판 코드 (nullable)

}
