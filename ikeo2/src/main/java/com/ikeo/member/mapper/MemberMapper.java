package com.ikeo.member.mapper;

import java.util.List;

import com.ikeo.member.vo.GradeVO;
import com.ikeo.member.vo.LoginVO;
import com.ikeo.member.vo.MemberVO;

public interface MemberMapper {

	// 로그인
	public LoginVO login(LoginVO vo);
	
	// 접속일 갱신
	public Integer updateConDate(LoginVO vo);
	
	// 회원가입
	public Integer register(MemberVO vo);
	
	// 내 정보 보기
	public MemberVO view(String id);
	
	// 내 정보 수정
	public Integer update(MemberVO vo);
	
	// 비밀번호 변경
	public Integer changePw(MemberVO vo);
	
	// 회원탈퇴
	public Integer withdrawals(String id);
	
	// 회원 테이블 리스트
	public List<GradeVO> gradeList();
}
