package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CustProfileBoard {
    private Long no;             // 게시글 번호
    private String title;        // 게시글 제목
    private String createDate;   // 작성일 (YYYY-MM-DD 형식)
    private String state;        // 상태 
}
