package edu.kh.project.member.model.service;

import java.util.Map;

import edu.kh.project.member.model.dto.Company;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.PointTransaction;

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


	
	
	/** 아이디 찾기 서비스
	 * @param inputMember (email)
	 * @return email 일치하는 회원 정보 또는 null
	 */
	Member findId(Member inputMember);

	/** 비밀번호 바꾸기 전 확인 서비스
	 * @param inputMember (email)
	 * @return 일치하는 회원 정보 또는 null
	 */
	Member findPw(Member inputMember);
	
	/** 비밀번호 변경 서비스
	 * @param inputMember
	 * @return result(0:실패, 1:성공)
	 */
	int changePw(Member inputMember);


	/** 글 쓰기 전에 패스워드 확인
	 * @param paramMap
	 * @return
	 */
	int WriteBoardCheckPw(Map<String, String> paramMap);


	/** 카카오 로그인시 회원 조회
	 * @param memberEmail
	 * @return
	 */
	Member snsLogin(String memberEmail);


	int insertPointTransaction(PointTransaction transaction);


	void updateMemberPoint(Map<String, Object> paramMap);


	Member selectMemberByNo(int memberNo);


	Member findCompanyMember(Map<String, Object> paramMap);


	//int changePw2(Member inputMember);
	

}
