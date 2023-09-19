package com.ikeo.review.mapper;

import java.util.List;

import com.ikeo.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	

	public List<ReviewVO> list(PageObject pageObject);
	
	public Long getTotalRow(PageObject pageObject);

	public ReviewVO view(Long no);
	
	public Integer write(ReviewVO vo);
	
	public Integer writeFile(ReviewVO vo);
	
	public Integer update(ReviewVO vo);

	public Integer delete(ReviewVO vo);

	public String checkReview(ReviewVO vo);
	
	
}
