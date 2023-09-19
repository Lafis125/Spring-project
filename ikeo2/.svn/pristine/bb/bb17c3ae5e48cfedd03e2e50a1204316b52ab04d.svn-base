package com.ikeo.eventReply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.eventReply.mapper.EventReplyMapper;
import com.ikeo.eventReply.vo.EventReplyVO;
import com.webjjang.util.page.ReplyPageObject;

import lombok.Data;

@Service
@Data
@Qualifier("eventReplyServiceImpl")
public class EventReplyServiceImpl implements EventReplyService {
	
	@Inject
	private EventReplyMapper mapper;
	
	@Override
	public List<EventReplyVO> replyList(ReplyPageObject replyPageObject) {
		
		replyPageObject.setTotalRow(mapper.getTotalRow(replyPageObject));
		return mapper.replyList(replyPageObject);
	}

	@Override
	public Integer write(EventReplyVO vo) {
		return mapper.replyWrite(vo);
	}

	@Override
	public Integer update(EventReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.replyUpdate(vo);
	}

	@Override
	public Integer delete(EventReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.replyDelete(vo);
	}

	@Override
	public Integer answer(EventReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.increaseOrdNo(vo);
		return mapper.replyAnswer(vo);
	}

}
