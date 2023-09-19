package com.ikeo.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.qna.mapper.QnaMapper;
import com.ikeo.qna.vo.QnaVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("qnaServiceImpl")
@Data
public class QnaServiceImpl implements QnaService {
	
	@Inject
	private QnaMapper mapper;
    @Override
	public List<QnaVO> list(PageObject pageObject, String item_no) {
		// TODO Auto-generated method stub
		System.out.println("QnaService.list()");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject,item_no));
		
		return mapper.list(pageObject,item_no);
	}
	@Override
	public QnaVO view(Long no) {
		// TODO Auto-generated method stub
		System.out.println("QnaController.service() no = "+ no);
		return mapper.view(no);
	}
	@Override
	public Integer write(QnaVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}
	@Override
	public Integer update(QnaVO vo) {
		// TODO Auto-generated method stub
		System.out.println("QnaServiceImpl.update().vo - " + vo);
		return mapper.update(vo);
	}
	@Override
	public Integer delete(QnaVO vo) {
		// TODO Auto-generated method stub
		System.out.println("z;rfjkeoapjgeopira'jhiotrp;jhieor;w 아이템넘버는? + " + vo);
		return mapper.delete(vo);
	}

}
