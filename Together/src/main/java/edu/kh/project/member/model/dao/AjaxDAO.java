package edu.kh.project.member.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.individual.dto.Recruitment;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.Product;

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

	// 통합 검색 ajax(브랜드 상품)
	public List<Product> totalSearchCompany(Map<String, Object> searchMap) {
		return sqlSession.selectList("mypageMapper.totalSearch", searchMap);
	}

	// 통합 검색 ajax(공동 구매)
	public List<Product> totalSearchRecruit(Map<String, Object> searchMap) {
	    List<Recruitment> temp = sqlSession.selectList("recruitmentMapper.totalSearchRecruit", searchMap);

	    List<Product> products = new ArrayList<>();

	    for (Recruitment r : temp) {
	        Product p = new Product();
	        
	        // 공동구매 상품 정보 세팅
	        p.setProductNo(r.getProductNo());
	        p.setProductTitle(r.getProductTitle());  // 상품명
	        p.setProductContent(r.getProductContent());  // 상품 설명
	        p.setPrice(r.getProductPrice());
	        p.setImgPath(r.getThumbnail());
	        p.setReadCount(r.getReadCount());

	        // 추가로 모집 인원 표시 (리뷰 필드가 아니라면 정식 DTO 구조 반영 필요)
	        p.setCurrentParticipants(r.getCurrentParticipants());
	        p.setMaxParticipants(r.getMaxParticipants());

	        products.add(p);
	    }

	    return products;
	}
}
