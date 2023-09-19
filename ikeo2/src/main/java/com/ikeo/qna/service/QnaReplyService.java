package com.ikeo.qna.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ikeo.qna.vo.QnaReplyVO;
import com.ikeo.qna.vo.QnaVO;
import com.ikeo.util.page.ReplyPageObject;
import com.webjjang.util.page.PageObject;

@Service
public interface QnaReplyService {

	public List<QnaReplyVO> list(Long no, PageObject replyPageObject);

	public QnaReplyVO view(Long no);

	public Integer write(QnaReplyVO vo);

	public Integer update(QnaReplyVO vo);

	public Integer delete(QnaReplyVO vo);

}
