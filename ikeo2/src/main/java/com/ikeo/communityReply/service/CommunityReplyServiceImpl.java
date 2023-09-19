package com.ikeo.communityReply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.communityReply.mapper.CommunityReplyMapper;
import com.ikeo.communityReply.vo.CommunityReplyVO;
import com.webjjang.util.page.ReplyPageObject;

import lombok.Data;

@Service
@Data
@Qualifier("communityReplyServiceImpl")
public class CommunityReplyServiceImpl implements CommunityReplyService {
	
	@Inject
	private CommunityReplyMapper mapper;
	
	@Override
	public List<CommunityReplyVO> replyList(ReplyPageObject replyPageObject) {
		
		replyPageObject.setTotalRow(mapper.getTotalRow(replyPageObject));
		return mapper.replyList(replyPageObject);
	}

	@Override
	public Integer write(CommunityReplyVO vo) {
		return mapper.replyWrite(vo);
	}

	@Override
	public Integer update(CommunityReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.replyUpdate(vo);
	}

	@Override
	public Integer delete(CommunityReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.replyDelete(vo);
	}

	@Override
	public Integer answer(CommunityReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.increaseOrdNo(vo);
		return mapper.replyAnswer(vo);
	}
}
