package com.ikeo.qna.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ikeo.qna.vo.QnaVO;
import com.webjjang.util.page.PageObject;

public interface QnaMapper {

	public List<QnaVO> list(@Param("pageObject") PageObject pageObject,@Param("item_No") String item_no);
	
	public Long getTotalRow(PageObject pageObject, @Param("item_No") String item_no);
	
	public QnaVO view(Long no);
	
	public Integer write(QnaVO vo);

	public Integer update(QnaVO vo);

	public Integer delete(QnaVO vo);
}
