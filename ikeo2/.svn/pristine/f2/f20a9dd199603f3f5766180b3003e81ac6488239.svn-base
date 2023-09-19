package com.ikeo.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.member.mapper.MemberMapper;
import com.ikeo.member.vo.GradeVO;
import com.ikeo.member.vo.LoginVO;
import com.ikeo.member.vo.MemberVO;

import lombok.Data;

@Service
@Qualifier("memberServiceImpl")
@Data
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberMapper mapper;
	
	@Override
	public LoginVO login(LoginVO vo) {
		return mapper.login(vo);
	}
	
	@Override
	public Integer updateConDate(LoginVO vo) {
		return mapper.updateConDate(vo);
	}

	@Override
	public Integer register(MemberVO vo) {
		return mapper.register(vo);
	}

	@Override
	public MemberVO view(String id) {
		return mapper.view(id);
	}

	@Override
	public Integer update(MemberVO vo) {
		return mapper.update(vo);
	}

	@Override
	public Integer changePw(MemberVO vo) {
		return mapper.changePw(vo);
	}

	@Override
	public Integer withdrawals(String id) {
		return mapper.withdrawals(id);
	}

	@Override
	public List<GradeVO> gradeList() {
		return mapper.gradeList();
	}

}
