package edu.kh.project.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointTransaction {
	
	private int transactionNo;       
	private int amount;            
	private String paymentMethod;   
	private String chargedDate;        
	private int memberNo;

}
