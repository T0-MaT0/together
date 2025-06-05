package edu.kh.project.member.model.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.member.model.dto.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.member.model.dao.AjaxDAO;
import edu.kh.project.member.model.dto.Member;

@Service 
public class AjaxServiceImpl implements AjaxService{
	
	@Autowired
	private AjaxDAO dao;
	
	@Override
	public String dupCheckId(String id) {
		return dao.dupCheckId(id);
	}


	@Override
	public String dupCheckEmail(String email) {
		return dao.dupCheckEmail(email);
	}

	@Override
	public String dupCheckNickname(String nickname) {
		return dao.dupCheckNickname(nickname);
	}


	@Override
	public Member selectMember(String email) {
		return dao.selectMember(email);
	}

	@Override
	public List<Member> selectMemberList(String email) {
		return dao.selectMemberList(email);
	}

	@Override
	public List<Map<String, Object>> searchQueryList(String query) {
		return dao.searchQueryList(query);
	}

    @Override
    public List<Category> getCategory(int categoryNo) {
        return dao.getCategory(categoryNo);
    }

    // 통합 검색 ajax
    @Override
    public List<Product> totalSearch(Map<String, Object> searchMap) {

        String type = (String) searchMap.get("type");

        if ("personal".equals(type)) {
            return dao.totalSearchRecruit(searchMap); // 공동구매
        } else if ("company".equals(type)) {
            return dao.totalSearchCompany(searchMap); // 브랜드 상품
        }

        return null; 
    }


}
