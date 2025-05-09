package edu.kh.project.business.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetail {
	private int orderDetailNo;
	private int quantity;
	private int orderNo;
	private int optionNo;
	private int productNo;
}
