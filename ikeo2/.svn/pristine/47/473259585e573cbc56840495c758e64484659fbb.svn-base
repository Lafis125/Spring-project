package com.ikeo.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.qna.vo.QnaReplyVO;
import com.ikeo.qnareply.mapper.QnaReplyMapper;
import com.webjjang.util.page.PageObject;

import lombok.Data;
import lombok.extern.java.Log;

@Service
@Qualifier("qnaReplyServiceImpl")
@Data
@Log
public class QnaReplyServiceImpl implements QnaReplyService {

	@Inject
	private QnaReplyMapper mapper;

	@Override
	public List<QnaReplyVO> list(Long no, PageObject replyPageObject) {
		// TODO Auto-generated method stub
		log.info("QnaService.list()" + no );
		log.info(" pageobj : " + replyPageObject);

		return mapper.replylist(no);
	}

	@Override
	public QnaReplyVO view(Long no) {
		// TODO Auto-generated method stub
		return mapper.view(no);
	}

	@Override
	public Integer write(QnaReplyVO vo) {
		// TODO Auto-generated method stub
		System.out.println(vo);
		return mapper.write(vo);
	}

	@Override
	public Integer update(QnaReplyVO vo) {
		// TODO Auto-generated method stub
		System.out.println("service.vo " + vo);
		return mapper.update(vo);
	}

	@Override
	public Integer delete(QnaReplyVO vo) {
		// TODO Auto-generated method stub
		System.out.println("service.vo" + vo);
		return mapper.delete(vo);
	}

}
