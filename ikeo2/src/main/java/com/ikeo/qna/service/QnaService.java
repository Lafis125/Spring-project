package com.ikeo.qna.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ikeo.qna.vo.QnaVO;
import com.webjjang.util.page.PageObject;

@Service
public interface QnaService {

	public List<QnaVO> list(PageObject pageObject, String item_no);
	
	public QnaVO view(Long no);
	
	public Integer write(QnaVO vo);

	public Integer update(QnaVO vo);
	
	public Integer delete(QnaVO vo);
}
