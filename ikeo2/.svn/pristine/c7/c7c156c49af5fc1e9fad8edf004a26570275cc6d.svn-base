package com.ikeo.member.seller.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.member.seller.mapper.SellerMapper;
import com.ikeo.member.seller.vo.SellerVO;

import lombok.Data;

@Service
@Qualifier("sellerServiceImpl")
@Data
public class SellerServiceImpl implements SellerService {
	
	@Inject
	private SellerMapper mapper;
	
	@Override
	public Integer apply(SellerVO vo) {
		// 판매자 신청 시 회원 등급을 6으로 변경합니다(판매자 승인 대기)
		mapper.changeSeller(vo.getId());
		return mapper.apply(vo);
	}

	@Override
	public SellerVO view(String id) {
		return mapper.view(id);
	}

	@Override
	public List<SellerVO> list(Integer grade_no) {
		return mapper.list(grade_no);
	}

	@Override
	public Integer update(SellerVO vo) {
		return mapper.update(vo);
	}

	@Override
	public Integer delete(String id) {
		mapper.deleteGrade(id);
		return mapper.delete(id);
	}

}
