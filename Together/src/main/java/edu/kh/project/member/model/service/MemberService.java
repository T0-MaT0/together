package edu.kh.project.member.model.service;

import edu.kh.project.member.model.dto.Company;
import edu.kh.project.member.model.dto.Member;

public interface MemberService {

	/** 로그인 서비스
	 * @param inputMember (email, pw)
	 * @return email, pw가 일치하는 회원 정보 또는 null
	 */
	Member login(Member inputMember);


	/** 회원 가입 서비스(암호화 작업 필요)(개인/기업 모두)
	 * @param inputMember
	 * @return result(null:실패, memberNo:성공)
	 */
	int signUp(Member inputMember);


	/** 회원 가입 서비스(기업만 계좌번호관련)
	 * @param inputCompany
	 * @return result(0:실패, 1:성공)
	 */
	int signUpCompany(Company inputCompany);
	

}
