package edu.kh.project.individual.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.individual.dao.CategoryDAO;


@Service
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	private CategoryDAO categoryDAO;

	// 부모 카테고리 목록 조회
	@Override
	public List<Category> getParentCategories() {
		return categoryDAO.selectParentCategories();	
	}

	// 자식 카테고리 ajax
	@Override
	public List<Category> getChildCategories(int parentNo) {
		return categoryDAO.selectChildCategories(parentNo);
	}

	// 부모 카테고리 번호
	@Override
	public Integer selectParentNo(int childCategoryNo) {
		return categoryDAO.selectParentNo(childCategoryNo);
	}
}
