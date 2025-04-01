package edu.kh.project.member.model.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.member.model.dto.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.kh.project.member.model.dao.AjaxDAO;
import edu.kh.project.member.model.dto.Member;

@Service 
public class AjaxServiceImpl implements AjaxService{
	
	@Autowired
	private AjaxDAO dao;
	
	@Autowired 
	private BCryptPasswordEncoder bcrypt;
	
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

	@Override
	public List<Product> totalSearch(Map<String, Object> searchMap) {
		if ((int) searchMap.get("boardCd") == 1) {
			return dao.totalSearchRecruit(searchMap);
		} else if ((int) searchMap.get("boardCd") == 2) {
			return dao.totalSearchCompany(searchMap);
		}
		return null;

	}


}
