package edu.kh.project.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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


}
