package com.ikeo.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.review.mapper.ReviewMapper;
import com.ikeo.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;


@Service
@Qualifier("reviewServiceImpl")
@Data
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewMapper mapper;
	
	@Override
	public List<ReviewVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		System.out.println("ReviewService.list()");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		System.out.println("ReviewService.list().pageObject - " + pageObject);
		
		return mapper.list(pageObject);
	}

	@Override
	public ReviewVO view(Long no) {
		// TODO Auto-generated method stub
		return mapper.view(no);
	}


	@Override
	public Integer write(ReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(ReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewService.vo = " + vo);
		return mapper.delete(vo);
	}

	@Override
	public String checkReview(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("lkasdjlksfdj;lksdajflkasdjflk;asdjfl;kjasdl;fkjasdfl;ksjafl;kasj;fkjfsd;alkj"+vo);
		return mapper.checkReview(vo);
	}


}
