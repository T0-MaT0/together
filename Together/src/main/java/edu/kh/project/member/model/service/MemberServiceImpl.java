package edu.kh.project.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.kh.project.member.model.dao.MemberDAO;
import edu.kh.project.member.model.dto.Company;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.PointTransaction;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
		 
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired 
	private BCryptPasswordEncoder bcrypt;

	
	@Override
	public Member login(Member inputMember) {
		
		
		log.info("MemberService.login() 실행"); // 정보 출력
		log.debug("memberEmail : " + inputMember.getMemberId());
		log.warn("경고 용도");
		log.error("오류 발생 시");
		


		// dao 메소드 호출
		Member loginMember = dao.login(inputMember);
		
		if(loginMember != null) { 
			

			if(bcrypt.matches(inputMember.getMemberPw(), loginMember.getMemberPw())) {
				loginMember.setMemberPw(null);
			} else { 
				loginMember = null;
				
			}
			
		}
		
		return loginMember;
	}
	
	@Transactional(rollbackFor = {Exception.class})
	// -> 예외가 발생하면 rollback
	// 발생하지 않으면 Service 종료 시 commit
	@Override
	public int signUp(Member inputMember) {
		

		inputMember.setMemberPw(bcrypt.encode(inputMember.getMemberPw()));
		
		int result = dao.signUp(inputMember);

		
		return result;
	}
	
	@Override
	public Member findId(Member inputMember) {

		Member findMember = dao.findId(inputMember);
		
		return findMember;
	}
	
	@Override
	public Member findPw(Member inputMember) {

		Member findMember = dao.findPw(inputMember);
		
		return findMember;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int changePw(Member inputMember) {

		inputMember.setMemberPw(bcrypt.encode(inputMember.getMemberPw()));
		
		int result = dao.changePw(inputMember);
		
		return result;


	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int signUpCompany(Company inputCompany) {
		
		
		// 계좌번호 보통 암호화 예정
		
		
		return dao.signUpCompany(inputCompany);
	}

	@Override
	public int WriteBoardCheckPw(Map<String, String> paramMap) {
		
		//paramMap.put("memberPw", bcrypt.encode(paramMap.get("memberPw")));
		
		Member loginMember = dao.WriteBoardCheckPw(paramMap);
		
		System.out.println(paramMap.get("memberPw"));
		System.out.println(loginMember.getMemberPw());
		
		int result = 0;
		
		if(bcrypt.matches(paramMap.get("memberPw"), loginMember.getMemberPw())) {
			result = 1;
		} 
		
		
		return result;
	}

	@Override
	public Member snsLogin(String memberEmail) {
		return dao.snsLogin(memberEmail);
	}

	@Override
	public int insertPointTransaction(PointTransaction transaction) {
		
		
		
		return dao.insertPointTransaction(transaction);
	}

	@Override
	public void updateMemberPoint(Map<String, Object> paramMap) {
		int result = dao.updateMemberPoint(paramMap);
		
		System.out.println(result + "이건 포인트 멤버에 업데이트되었는지 1 이면 된거임");
		
	}

	@Override
	public Member selectMemberByNo(int memberNo) {
		return dao.selectMemberByNo(memberNo);
	}

	@Override
	public Member findCompanyMember(Map<String, Object> paramMap) {
		return dao.findCompanyMember(paramMap);
	}

	/*@Override
	public int changePw2(Member inputMember) {
		inputMember.setMemberPw(bcrypt.encode(inputMember.getMemberPw()));
		
		int result = dao.changePw2(inputMember);
		
		return result;
	}*/
	
	
	

}
