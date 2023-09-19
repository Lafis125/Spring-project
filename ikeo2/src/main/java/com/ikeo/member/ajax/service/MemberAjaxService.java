package com.ikeo.member.ajax.service;

import java.util.List;

import com.ikeo.member.vo.MemberVO;
import com.ikeo.member.vo.SearchVO;

public interface MemberAjaxService {
	
	// 아이디 중복 체크
	public Integer checkId(String id);
	
	// 닉네임 중복 체크
	public Integer checkNickname(String nickname);
	
	// 회원 리스트
	public List<MemberVO> list(SearchVO search);
	
	// 아이디 찾기
	public String findId(MemberVO vo);
	
	// 비밀번호 찾기
	public Integer findPw(MemberVO vo);
	
	// 관리자 - 등급 변경
	public Integer changeGrade(MemberVO vo);
	
	// 관리자 - 상태 변경
	public Integer changeStatus(MemberVO vo);
	
	// 관리자 - 판매자 신청 승인
	public Integer acceptApply(MemberVO vo);
	
	// 관리자 - 판매자 신청 취소
	public Integer cancelApply(MemberVO vo);
}
