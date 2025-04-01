package edu.kh.project.member.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.member.model.dto.Product;
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

	public List<Product> totalSearchCompany(Map<String, Object> searchMap) {
		return sqlSession.selectList("mypageMapper.totalSearch", searchMap);
	}

	public List<Product> totalSearchRecruit(Map<String, Object> searchMap) {
		List<Recruitment> temp = sqlSession.selectList("recruitmentMapper.totalSearchRecruit", searchMap);
		System.out.println(temp);
		List<Product> products = new ArrayList<Product>();
		for (Recruitment r : temp) {
			Product p = new Product();
			p.setBoardNo(r.getBoardNo());
			p.setBoardTitle(r.getProductName());
			p.setBoardContent(r.getBoardContent());
			p.setPrice(r.getProductPrice());
			p.setImgPath(r.getThumbnail());
			p.setReviewNo(r.getMaxParticipants());
			p.setReviewScore(r.getCurrentParticipants());
			
			products.add(p);
		}
		System.out.println(products);
		return products;
	}
}
