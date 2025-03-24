package edu.kh.project.individual.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Category;

@Repository
public class CategoryDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 부모 카테고리 목록 조회
	public List<Category> selectParentCategories() {
		return sqlSession.selectList("categoryMapper.selectParentCategories");
	}

	// 자식 카테고리 ajax
	public List<Category> selectChildCategories(int parentNo) {
		return sqlSession.selectList("categoryMapper.selectChildCategories", parentNo);
	}

	// 부모 카테고리 번호
	public Integer selectParentNo(int childCategoryNo) {
		return sqlSession.selectOne("categoryMapper.selectParentNo", childCategoryNo);
	}
}
