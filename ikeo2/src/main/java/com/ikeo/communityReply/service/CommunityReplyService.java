package com.ikeo.communityReply.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ikeo.communityReply.vo.CommunityReplyVO;
import com.webjjang.util.page.ReplyPageObject;

@Service
public interface CommunityReplyService {
	public List<CommunityReplyVO> replyList(ReplyPageObject replyPageObject);
	public Integer write(CommunityReplyVO vo);
	public Integer update(CommunityReplyVO vo);
	public Integer delete(CommunityReplyVO vo);
	public Integer answer(CommunityReplyVO vo);
	
}
