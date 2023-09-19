package com.ikeo.reviewreply.mapper;

import java.util.List;

import com.ikeo.review.vo.ReviewReplyVO;
import com.webjjang.util.page.ReplyPageObject;

public interface ReviewReplyMapper {

	public List<ReviewReplyVO> replylist(Long no);

	public Long getTotalRow(ReplyPageObject replyPageObject);

	public ReviewReplyVO view(Long no);

	public Integer write(ReviewReplyVO vo);

	public Integer update(ReviewReplyVO vo);

	public Integer delete(ReviewReplyVO vo);

}
