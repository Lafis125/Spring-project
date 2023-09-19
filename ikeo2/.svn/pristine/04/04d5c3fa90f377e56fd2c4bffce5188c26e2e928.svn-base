package com.ikeo.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.ikeo.review.vo.ReviewReplyVO;
import com.ikeo.reviewreply.mapper.ReviewReplyMapper;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("reviewReplyServiceImpl")
@Data
public class ReviewReplyServiceImpl implements ReviewReplyService {

	@Inject
	private ReviewReplyMapper mapper;

	@Override
	public List<ReviewReplyVO> list(Long no, PageObject replyPageObject) {
		// TODO Auto-generated method stub
		System.out.println("RRplyService.list()");
		return mapper.replylist(no);
	}

	@Override
	public ReviewReplyVO view(Long no) {
		// TODO Auto-generated method stub
		return mapper.view(no);
	}

	@Override
	public Integer write(ReviewReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(ReviewReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(ReviewReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}



}
