package edu.kh.project.business.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Category {

	private int categoryNo;            // 카테고리 번호
    private String categoryName;       // 카테고리 이름
    private Integer parentCategoryNo;  // 부모 카테고리 번호 (nullable)
}
