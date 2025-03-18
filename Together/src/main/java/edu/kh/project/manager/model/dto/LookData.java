package edu.kh.project.manager.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class LookData {
	
    private int boardNo;
    private int memberNick;
    private String brandName;
    private String boardTitle;
    private String productTitle;
    private String createDate;
    
    private int readCount;
    private int quantity;
    
    

}
