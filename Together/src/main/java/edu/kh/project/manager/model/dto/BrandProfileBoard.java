package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BrandProfileBoard {
    private int no; // BOARD_NO
    private String title; // BOARD_TITLE
    private String createDate; // CREATE_DATE (TO_CHAR 형식 'YYYY-MM-DD')
    private String state; // STATE (판매, 완료 등)
}
