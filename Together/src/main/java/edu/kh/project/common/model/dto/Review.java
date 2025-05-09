package edu.kh.project.common.model.dto;

import java.util.List;

import edu.kh.project.business.model.dto.OrderDetail;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review {
	private int reviewNo;
	private String reviewContent;
	private int reviewStar;
	private String reviewCreatedDate;
	private String reviewUpdateDate;
	private String reviewDelFleg;
	private String reviewType;
	private int reviewTypeNo;
	private int memberNo;
	private int orderNo;
	
	private String memberNick;
	private String memberProfile;
	private String businessThumbnail;
	private String optionName;
	private int quantity;
	
	private List<Image> imageList;
	private List<Reply> replyList;
	private List<OrderDetail> orderDetailList;

	private String productTitle;          // 댓글이 달린 게시글 제목 (JOIN BOARD)
	private int productNo;                // 댓글이 속한 게시글 번호
}
