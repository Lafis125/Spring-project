package com.ikeo.member.seller.service;

import java.util.List;

import com.ikeo.member.seller.vo.SellerVO;

public interface SellerService {
	
	// 판매자 신청
	public Integer apply(SellerVO vo);
	
	// 판매자 마이페이지
	public SellerVO view(String id);
	
	// 판매자 리스트
	public List<SellerVO> list(Integer grade_no);
	
	// 판매자 신청 데이터 수정
	public Integer update(SellerVO vo);
	
	// 판매자 취소
	public Integer delete(String id);
	
}
