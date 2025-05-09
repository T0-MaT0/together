package edu.kh.project.business.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Order {
	private int orderNo;
	private String orderAddress;
	private String trackingNo;
	private String status;
	private int memberNo;
	
	private List<OrderDetail> orderDetailList;
}
