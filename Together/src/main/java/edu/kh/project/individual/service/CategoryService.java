package edu.kh.project.individual.service;

import java.util.List;

import edu.kh.project.common.model.dto.Category;

public interface CategoryService {

	// 부모 카테고리 목록
	List<Category> getParentCategories();

	// 자식 카테고리 ajax
	List<Category> getChildCategories(int parentNo);

	// 부모 카테고리 번호
	Integer selectParentNo(int childCategoryNo);

}
