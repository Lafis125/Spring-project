package com.ikeo.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ikeo.member.vo.LoginVO;

import lombok.extern.java.Log;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
@Log
public class AuthorityFilter implements Filter {

	// url = 페이지 접근 권한 번호
	private Map<String, Integer> authMap = new HashMap<>();

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AuthorityFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		// 로그인 정보가 들어 있는 객체
		HttpSession session = req.getSession();

		log.info("권한 처리 .................... ");

		String uri = req.getServletPath();
		String query = req.getQueryString();

		log.info(uri);

		// uri의 페이지 권한이 있는지 본다.
		Integer grade = authMap.get(uri);
		log.info("페이지의 권한 : " + ((grade == null) ? "전체 권한" : grade));

		// 사용자의 권한
		Integer gradeNo = null;
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO != null)
			gradeNo = loginVO.getGrade_no();
		log.info("사용자 권한 : " + ((gradeNo == null) ? "로그인 안함" : gradeNo));

//		 로그인이 필요한 페이지 체크
		if (grade != null && grade >= 1) {
			// 로그인이 되어 있지 않은 경우는 로그인 페이지로 이동 시킨다.
			log.info("로그인오류");
			if (loginVO == null) {
				// 요청한 페이지를 저장해 놓는다. 로그인을 하면 요청한 페이지로 이동시킨다.
				session.setAttribute("goBackURL", uri + ((query == null) ? "" : "?" + query));
				res.sendRedirect("/member/login.do");
				// 더 이상 진행되지 않도록 return이 필요하다.
				return;
			}
			// 관리자 권한(페이지 권한 grade > 사용자 권한 gradeNo)
			if (grade > gradeNo) {
				res.sendRedirect("/error/error_auth.do");
				// 더 이상 진행되지 않도록 return이 필요하다.
				return;
			}
		}

		// pass the request along the filter chain
		// 실행해야할 Servlet으로 가게되는 메서드
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("AuthorityFilter.init() - 권한 정보 세팅");

		// member 회원관리 리스트
		authMap.put("/member/list.do", 8);
		authMap.put("/member/seller/list.do", 8);
		
		// member 게시판 - 로그인 후 사용
		authMap.put("/member/mypage.do", 1);
		authMap.put("/member/changePw.do", 1);
		authMap.put("/member/withdrawals.do", 1);
		authMap.put("/member/seller/apply.do", 1);
		authMap.put("/member/seller/mypage.do", 1);
		
		// product 상품 관리 - 판매자 이상만
		authMap.put("/product/update.do", 7);
		authMap.put("/product/write.do", 7);
		authMap.put("/product/delete.do", 7);
		
		// 장바구니 - 로그인 후에 사용
		authMap.put("/cart/list.do", 1);
		
		// 이벤트 게시판 - 글 작성, 수정, 삭제 - 운영자 이상
		authMap.put("/event/write.do", 8);
		authMap.put("/event/update.do", 8);
		authMap.put("/event/delete.do", 8);
		
		// 이벤트 게시판 - 댓글 작성 - 로그인 후 이용
		authMap.put("/eventAjax/write.do", 1);
		authMap.put("/eventAjax/update.do", 1);
		authMap.put("/eventAjax/delete.do", 1);
		authMap.put("/eventAjax/answerWrite.do", 1);
		
		// 커뮤니티 게시판 - 글 작성, 수정, 삭제 - 로그인 후 이용
		authMap.put("/community/write.do", 1);
		authMap.put("/community/update.do", 1);
		authMap.put("/community/delete.do", 1);
		
		// 커뮤니티 게시판 - 댓글 작성 - 로그인 후 이용
		authMap.put("/communityAjax/write.do", 1);
		authMap.put("/communityAjax/update.do", 1);
		authMap.put("/communityAjax/delete.do", 1);
		authMap.put("/communityAjax/answerWrite.do", 1);
		
		// 커뮤니티 게시판 - 좋아요 버튼 - 로그인 후 이용
		authMap.put("/communityAjax/like.do", 1);
		authMap.put("/communityAjax/disLike.do", 1);
		
		// 리뷰 게시판 - 로그인 후 이용
		authMap.put("/review/write.do", 1);
		authMap.put("/review/update.do", 1);
		authMap.put("/review/delete.do", 1);
		
		// 문의사항 게시판 - 로그인 후 이용
		authMap.put("/qna/write.do", 1);
		authMap.put("/qna/update.do", 1);
		authMap.put("/qna/delete.do", 1);

	}

}
