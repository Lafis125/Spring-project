package com.ikeo.member.ajax.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.member.ajax.mapper.MemberAjaxMapper;
import com.ikeo.member.vo.MemberVO;
import com.ikeo.member.vo.SearchVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("memberAjaxServiceImpl")
@Data
public class MemberAjaxServiceImpl implements MemberAjaxService {

	@Inject
	private MemberAjaxMapper mapper;
	
	@Override
	public Integer checkId(String id) {
		return mapper.checkId(id);
	}

	@Override
	public Integer checkNickname(String nickname) {
		return mapper.checkNickname(nickname);
	}

	@Override
	public List<MemberVO> list(SearchVO search) {
		search.setEndRno();
		return mapper.list(search);
	}

	@Override
	public String findId(MemberVO vo) {
		return mapper.findId(vo);
	}

	@Override
	public Integer findPw(MemberVO vo) {
		return mapper.findPw(vo);
	}

	@Override
	public Integer changeGrade(MemberVO vo) {
		if(vo.getGrade_no() < 6) {
			mapper.cancelApplyDelete(vo);
		}
		return mapper.changeGrade(vo);
	}

	@Override
	public Integer changeStatus(MemberVO vo) {
		return mapper.changeStatus(vo);
	}

	@Override
	public Integer acceptApply(MemberVO vo) {
		return mapper.acceptApply(vo);
	}

	@Override
	public Integer cancelApply(MemberVO vo) {
		// 판매자 신청 취소 시 판매자 정보도 같이 삭제
		mapper.cancelApplyDelete(vo);
		return mapper.cancelApply(vo);
	}


}
