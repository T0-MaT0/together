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
	private int productNo;
	private String productTitle;
	private String productContent;
	private String productCreateDate;
	private int productPrice;
	private int productCount;
	private int readCount;
	private int categoryNo;
	
	// 상품 join
	private int deliveryFee;
	
	// 상품 카테고리 join
	private String categoryName;
	private int parentCategoryNo;

	// 회원 join
	private int memberNo;
	private String memberNick;
	private String profileImage;
	
	// 서브쿼리
	private String parentCategoryName;
	private String thumbnail;
	
	// 상품 옵션 목록
	private List<BusinessOption> optionList;
	
	// 이미지 목록
	private List<Image> imageList;
}
