package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BrandBoard {
    private int boardNo;
    private String brandName;
    private String boardTitle;
    private String productTitle;
    private String createDate;
    private int productCount;
    private String boardDelFl;
}
