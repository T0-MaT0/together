package edu.kh.project.business.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Order {
	private int orderNo;
	private int quantity;
	private String orderAddress;
	private String trackingNo;
	private int boardNo;
	private int memberNo;
}
