package edu.kh.project.member.model.dao;

import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Category;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import edu.kh.project.member.model.dto.Member;

@Repository
public class AjaxDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public String dupCheckId(String id) {
		return sqlSession.selectOne("ajaxMapper.dupCheckId", id);
	}

	public String dupCheckEmail(String email) {
		return sqlSession.selectOne("ajaxMapper.dupCheckEmail", email);
	}

	public String dupCheckNickname(String nickname) {
		return sqlSession.selectOne("ajaxMapper.dupCheckNickname", nickname);
	}

	public Member selectMember(String email) {
		return sqlSession.selectOne("ajaxMapper.selectMember", email);
	}

	public List<Member> selectMemberList(String email) {

		return sqlSession.selectList("ajaxMapper.selectMemberList", email);
	}

	public List<Map<String, Object>> searchQueryList(String query) {
		return sqlSession.selectList("ajaxMapper.searchQueryList", query);
	}


    public List<Category> getCategory(int categoryNo) {
		int parentNo = categoryNo;
		return sqlSession.selectList("categoryMapper.selectChildCategories", parentNo);
    }
}
