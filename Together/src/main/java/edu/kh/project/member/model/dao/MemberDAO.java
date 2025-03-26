package edu.kh.project.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.member.model.dto.Company;
import edu.kh.project.member.model.dto.Member;


@Repository
public class MemberDAO {
	
	
	@Autowired 
	private SqlSessionTemplate sqlSession;

	public Member login(Member inputMember) {
		return sqlSession.selectOne("memberMapper.login", inputMember);
	}
	
	public int signUp(Member inputMember) {
		return sqlSession.insert("memberMapper.signUp", inputMember);
	}

	public int signUpCompany(Company inputCompany) {
		return sqlSession.insert("memberMapper.inputCompany", inputCompany);
	}
	
	public Member findId(Member inputMember) {
		return sqlSession.selectOne("memberMapper.findId", inputMember);
	}

	public Member findPw(Member inputMember) {
		return sqlSession.selectOne("memberMapper.findPw", inputMember);
	}

	public int changePw(Member inputMember) {
		return sqlSession.update("memberMapper.changePw", inputMember);
	}

	public Member WriteBoardCheckPw(Map<String, String> paramMap) {
		return sqlSession.selectOne("memberMapper.WriteBoardCheckPw", paramMap);
	}

	public Member snsLogin(String memberEmail) {
		return sqlSession.selectOne("memberMapper.snsLogin", memberEmail);
	}


}
