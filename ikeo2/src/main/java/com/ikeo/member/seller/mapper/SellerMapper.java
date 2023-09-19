package com.ikeo.member.seller.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ikeo.member.seller.vo.SellerVO;

public interface SellerMapper {
	
	public Integer apply(SellerVO vo);
	
	public Integer changeSeller(String id);
	
	public SellerVO view(String id);
	
	public List<SellerVO> list(@Param("grade_no") Integer grade_no);
	
	public Integer update(SellerVO vo);
	
	public Integer delete(String id);
	
	public Integer deleteGrade(String id);
}
