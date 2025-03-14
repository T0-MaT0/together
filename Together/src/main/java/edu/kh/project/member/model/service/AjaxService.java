package edu.kh.project.member.model.service;

import java.util.List;
import java.util.Map;


import edu.kh.project.member.model.dto.Member;

public interface AjaxService {
	
	
	/** 아이디 중복 체크
	 * @param id
	 * @return
	 */
	String dupCheckId(String id);

	
	/** 이메일 중복 체크
	 * @param email
	 * @return
	 */
	String dupCheckEmail(String email);

	/** 닉네임 중복 체크
	 * @param nickname
	 * @return
	 */
	String dupCheckNickname(String nickname);

	/**
	 * @param email
	 * @return
	 */
	Member selectMember(String email);

	/**
	 * @param email
	 * @return
	 */
	List<Member> selectMemberList(String email);

	/**
	 * @param query
	 * @return
	 */
	List<Map<String, Object>> searchQueryList(String query);

	

}
