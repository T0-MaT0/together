package edu.kh.project.business.model.dto;

import java.util.List;

import edu.kh.project.common.model.dto.Image;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Business {
	private int boardNo;
	private String boardName;
	private String boardTitle;
	private String boardContent;
	private String boardCreateDate;
	private String boardUpdateDate;
	private int boardCode;
	
	// 상품 join
	private int productPrice;
	private int productCount;
	private int deliveryFee;
	private int readCount;
	private int categoryNo;
	
	// 상품 카테고리 join
	private String categoryName;

	// 회원 join
	private int memberNo;
	private String memberNickname;
	private String profileImage;
	
	// 서브쿼리
	private String parentCategoryName;
	private String thumbnail;
	
	// 배너 목록
	private List<Image> bannerList;
	
	// 상품 옵션 목록
	private List<BusinessOption> optionList;
	
	// 이미지 목록
	private List<Image> imageList;

	// 댓글 목록
//	private List<Comment> commentList;
}
