package edu.kh.project.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kh.project.member.model.dto.Member;

// Filter : 클라이언트의 요청/응답을 걸러내거나 첨가하는 클래스

// 클라이언트 -> Filter -> Dispatcher Servlet

// @WebFilter : 해당 클래스를 필터로 등록하고 지정된 주소로 요청이 올 때 마다 동작
@WebFilter(filterName="loginFilter",
			urlPatterns={"/mypage/*"})
@SessionAttributes("loginMember")
public class LoginFilter implements Filter {

	public void init(FilterConfig fConfig) throws ServletException {
		// 서버가 켜질 때, 필터 코드가 변경되었을 때 필터 생성
		System.out.println("*** 로그인 필터 생성 ***");
	}
    
	public void destroy() {
		// 필터 코드가 변경 되었을 때 이전 필터를 파괴하는 메소드
		System.out.println("*** 이전 로그인 필터 파괴 ***");
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		// 필터링 코드를 작성하는 메소드
		
		// 1. ServletRequest, ServletResponse 다운캐스팅
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        
        
        // 2. HttpServletRequest를 이용해서 HttpSession 얻어오기
        HttpSession session = req.getSession(false);

	
        // 로그인을 하지 않은 경우( == session에서 key가 "loginMember"를 얻어와 null인 경우)
        // 메인페이지로 재요청
        Member loginMember = (Member)session.getAttribute("loginMember");
        // if(loginMember.getAuthority() != 2){} // 관리자가 아니라면 메인페이지로
		if(loginMember == null) {
			resp.sendRedirect("/");
		} else {
			// 4. 로그인 상태인 경우 다음 필터 또는 DispatcherServlet으로 전달
			chain.doFilter(request, response);
		}
		
		
		
		
	}

	

}
